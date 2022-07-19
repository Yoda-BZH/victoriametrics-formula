
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

{% set utils_bin = {
  'vmagent-prod': 'vmagent',
  'vmalert-prod': 'vmalert',
  'vmauth-prod': 'vmauth',
  'vmbackup-prod': 'vmbackup',
  'vmrestore-prod': 'vmrestore',
  'vmctl-prod': 'vmctl',
} %}

{% if victoriametrics.archive.type == "entreprise" %}
{%   do utils_bin.update({
  'vmbackupmanager-prod': 'vmbackupmanager',
  'vmgateway-prod': 'vmgateway',
}) %}

{% endif %}

{% for archive_filename, bin_name in utils_bin.items() %}
victoriametrics_install_{{ bin_name }}:
  file.managed:
    - name: {{ victoriametrics.bindir }}/{{ bin_name }}
    - source: {{ victoriametrics.archive.extract_directory }}/utils/{{ archive_filename }}
    - user: root
    - group: root
    - mode: 0755
{% endfor %}
