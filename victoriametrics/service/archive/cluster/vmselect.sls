# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
#{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

#include:
#  - {{ sls_config_file }}

{% set unitconfig = {
  'Unit': {
    'Description': 'High-performance, cost-effective and scalable time series database, long-term remote storage for Prometheus, vmselect service',
    'Documentation': 'https://victoriametrics.github.io/',
    'After': 'network.target',
  },
  'Service': {
    'Type': 'simple',
    'User': '_victoria-metrics',
    'LimitNOFILE': '65536',
    'LimitNPROC': '32000',
    'StartLimitBurst': '5',
    'StartLimitInterval': '0',
    'Restart': 'on-failure',
    'RestartSec': '1',
    'EnvironmentFile': '/etc/default/vmselect',
    'ExecStart': victoriametrics.bindir ~ '/vmselect $ARGS',
  },
  'Install': {
    'WantedBy': 'multi-user.target',
  },
} %}


{% set unit = "vmselect" %}
{% set unittype = "service" %}
{% set unit_status = "start" if victoriametrics.vmselect.enabled else "stop" %}
{% set activation_status = "enable" if victoriametrics.vmselect.enabled else "disabled" %}
{% set service_status = "running" if victoriametrics.vmselect.enabled else "dead" %}

victoriametrics_systemd_units_file_{{ unit }}_{{ unittype }}:
  file.managed:
    - name: /etc/systemd/system/{{ unit }}.{{ unittype }}
    - template: jinja
    - source: salt://victoriametrics/files/systemd.jinja
    - context:
        config: {{ unitconfig|json }}
    - watch:
      - file: victoriametrics-{{ unit }}-config-file-file-managed
    - watch_in:
      - cmd: reload_systemd_configuration

victoriametrics_systemd_units_cmd_enable_or_disable_{{ unit }}_{{ unittype }}:
  cmd.wait:  # noqa: 213
    - name: systemctl {{ unit_status }} {{ unit }}.{{ unittype }}
    - watch:
      - cmd: reload_systemd_configuration

victoriametrics_systemd_units_activate_or_deactivate_{{ unit }}_{{ unittype }}:
  cmd.wait:  # noqa: 213
    - name: systemctl {{ activation_status }} {{ unit }}.{{ unittype }}
    - require:
      - cmd: victoriametrics_systemd_units_cmd_enable_or_disable_{{ unit }}_{{ unittype }}
      - cmd: reload_systemd_configuration
    - watch:
      - cmd: reload_systemd_configuration

#victoriametrics-service-vmselect-running-service-running:
#  service.running:
#    - name: vmselect
#    - enable: True
#    #- watch:
#    #  - sls: {{ sls_config_file }}


victoriametrics_service_{{ unit }}:
  service.{{ service_status }}:
     - name: {{ unit }}
