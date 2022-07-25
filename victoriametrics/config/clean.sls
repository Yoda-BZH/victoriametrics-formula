# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

victoriametrics_config_directory:
  file.absent:
    - name: {{ victoriametrics.config }}

victoriametrics-config-file-file-managed:
  file.absent:
    - name: {{ victoriametrics.config }}

victoriametrics-victoria-metrics-config-file-file-managed:
  file.absent:
    - name: /etc/default/victoria-metrics

victoriametrics-vmagent-config-file-file-managed:
  file.absent:
    - name: /etc/default/vmagent

victoriametrics-vmauth-config-file-file-managed:
  file.absent:
    - name: /etc/default/vmauth

victoriametrics-vmauth-authconfig-file:
  file.absent:
    - name: /etc/victoriametrics/auth-config.yml

victoriametrics-vminsert-config-file-file-managed:
  file.absent:
    - name: /etc/default/vminsert

victoriametrics-vmselect-config-file-file-managed:
  file.absent:
    - name: /etc/default/vmselect

victoriametrics-vmstorage-config-file-file-managed:
  file.absent:
    - name: /etc/default/vmstorage


