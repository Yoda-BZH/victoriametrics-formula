
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

vm_install_vminsert_from_archive:
  file.managed:
    - name: {{ victoriametrics.bindir }}/victoria-metrics
    - source: {{ victoriametrics.archive.extract_directory }}/single/victoria-metrics-prod
    - user: root
    - group: root
    - mode: 0755