# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

victoriametrics-config-file-file-managed:
  file.managed:
    - name: {{ victoriametrics.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='victoriametrics-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ victoriametrics.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        victoriametrics: {{ victoriametrics | json }}
