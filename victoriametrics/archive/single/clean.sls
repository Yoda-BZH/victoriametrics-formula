# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

{% set archive_type = "-entreprise" if victoriametrics.archive.type == "entreprise" else "" %}

victoriametrics_create_archive_directory:
  file.absent:
    - name: {{ victoriametrics.archive.extract_directory }}

victoriametrics_install_vm_from_archive:
  file.absent:
    - name: {{ victoriametrics.bindir }}/victoria-metrics
