# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

victoriametrics_install_user_{{ victoriametrics.user }}:
  user.present:
    - name: {{ victoriametrics.user }}
    - fullname: "VictoriaMetrics daemon"
    - shell: /usr/sbin/nologin
    - home: /var/lib/victoria-metrics
    - system: true
    - usergroup: true
