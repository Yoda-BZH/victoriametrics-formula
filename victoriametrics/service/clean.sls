# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - .archive.clean

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

victoriametrics-service-clean-service-dead:
  service.dead:
    - name: {{ victoriametrics.service.name }}
    - enable: False
