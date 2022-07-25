# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

victoriametrics_config_directory:
  file.directory:
    - name: {{ victoriametrics.config }}
    - mode: 755
    - user: {{ victoriametrics.rootgroup }}
