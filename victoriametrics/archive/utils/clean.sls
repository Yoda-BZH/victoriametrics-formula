
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
  'vmbackupmanager-prod': 'vmbackupmanager',
  'vmgateway-prod': 'vmgateway',
} %}

{% for archive_filename, bin_name in utils_bin.items() %}
victoriametrics_install_{{ bin_name }}:
  file.absent:
    - name: {{ victoriametrics.bindir }}/{{ bin_name }}
{% endfor %}
