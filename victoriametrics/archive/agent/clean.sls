# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

victoriametrics_create_archive_directory:
  file.directory:
    - name: {{ victoriametrics.archive.extract_directory }}

victoriametrics_install_vmagent:
  file.absent:
    - name: {{ victoriametrics.bindir }}/vmagent
