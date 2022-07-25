# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

victoriametrics_create_archive_directory:
  file.absent:
    - name: {{ victoriametrics.archive.extract_directory }}

victoriametrics_install_vminsert_from_archive:
  file.absent:
    - name: {{ victoriametrics.bindir }}/vminsert
victoriametrics_install_vmselect_from_archive:
  file.absent:
    - name: {{ victoriametrics.bindir }}/vmselect
victoriametrics_install_vmstorage_from_archive:
  file.absent:
    - name: {{ victoriametrics.bindir }}/vmstorage
