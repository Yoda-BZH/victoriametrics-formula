# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}


include:
{% if victoriametrics.install == "package" %}
  - .package
{% elif victoriametrics.install == "archive" %}
  - .archive
{% endif %}
  - .config

{% if victoriametrics.install == "archive" %}
  - .service.archive
{% elif victoriametrics.install == "package" %}
{% endif%}
  #- .service
  #- .subcomponent
