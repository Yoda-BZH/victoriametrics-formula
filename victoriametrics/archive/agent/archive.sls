# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

victoriametrics_create_archive_directory:
  file.directory:
    - name: {{ victoriametrics.archive.extract_directory }}
    - mode: 0640
    - user: root
    - group: root


victoriametrics_extract_main_archive:
  archive.extracted:
    - enforce_toplevel: false
    - name: {{ victoriametrics.archive.extract_directory }}/cluster
    - source: https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/{{ victoriametrics.version }}/victoria-metrics-{{ victoriametrics.vm_os }}-{{ grains.osarch }}-{{ victoriametrics.version }}-cluster.tar.gz
    - source_hash: https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/{{ victoriametrics.version }}/victoria-metrics-{{ victoriametrics.vm_os }}-{{ grains.osarch }}-{{ victoriametrics.version }}-cluster_checksums.txt
