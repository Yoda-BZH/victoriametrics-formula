# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

victoriametrics_extract_utils_archive:
  archive.extracted:
    - enforce_toplevel: false
    - name: {{ victoriametrics.archive.extract_directory }}/utils
    - source: https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/{{ victoriametrics.version }}/vmutils-{{ victoriametrics.vm_os }}-{{ grains.osarch }}-{{ victoriametrics.version }}.tar.gz
    - source_hash: https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/{{ victoriametrics.version }}/vmutils-{{ victoriametrics.vm_os }}-{{ grains.osarch }}-{{ victoriametrics.version }}_checksums.txt
