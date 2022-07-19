
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

vm_install_vmselect_from_archive:
  file.managed:
    - name: {{ victoriametrics.bindir }}/vmselect
    - source: {{ victoriametrics.archive.extract_directory }}/cluster/vmselect-prod
    - user: root
    - group: root
    - mode: 0755
