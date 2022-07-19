
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

victoriametrics_install_vmagent:
  file.managed:
    - name: {{ victoriametrics.bindir }}/vmagent
    - source: {{ victoriametrics.archive.extract_directory }}/utils/vmagent-prod
    - user: root
    - group: root
    - mode: 0755
