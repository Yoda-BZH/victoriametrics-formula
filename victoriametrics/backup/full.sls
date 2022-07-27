# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
#{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

{% set storage_path = victoriametrics.victoriametrics.args.storageDataPath if victoriametrics.type == "single" else victoriametrics.vmstorage.args.storageDataPath %}
{% set storage_port = victoriametrics.victoriametrics.args.get('httpListenAddr', '8428') if victoriametrics.type == "single" else victoriametrics.vmstorage.args.get('httpListenAddr', '8482') %}

{% set backup_dir = victoriametrics.backup.destination %}

victoriametrics_run_full_backup_now:
  cmd.run:
    - name: vmbackup -storageDataPath={{ storage_path}} -snapshot.createURL=http://localhost:{{ storage_port }}/snapshot/create -dst={{ backup_dir }}
