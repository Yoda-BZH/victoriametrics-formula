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


victoriametrics_remove_user_{{ victoriametrics.user }}:
  user.absent:
    - name: {{ victoriametrics.user }}
