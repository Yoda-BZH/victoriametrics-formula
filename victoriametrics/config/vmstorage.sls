# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

#include:
#  - {{ sls_package_install }}
{% set vmstorage_args = victoriametrics.vmstorage.args %}


{% set args = [] %}
{% for k, v in vmstorage_args.items() %}
{%   if v != None %}
{%     do args.append("-" ~ k ~ "=" ~ v) %}
{%   else %}
{%     do args.append("-" ~ k) %}
{%   endif %}
{% endfor %}
{% set args = args|join(" ") %}

victoriametrics-vmstorage-config-file-file-managed:
  file.managed:
    #- name: {{ victoriametrics.config }}
    - name: /etc/default/vmstorage
    - source: {{ files_switch(['default.sh'],
                              lookup='victoriametrics-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ victoriametrics.rootgroup }}
    - makedirs: True
    - template: jinja
    #- require:
    #  - sls: {{ sls_package_install }}
    - context:
        args: {{ args | json }}
    #- watch_in:
    #  - cmd: reload_systemd_configuration
