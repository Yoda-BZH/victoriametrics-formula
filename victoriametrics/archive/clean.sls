# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

include:
  - .utils.clean
  - .single.clean
  - .cluster.clean
  - .agent.clean


_victoria-metrics:
  user.absent:
    - name: _victoria-metrics
