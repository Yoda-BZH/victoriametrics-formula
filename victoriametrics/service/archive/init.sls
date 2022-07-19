# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

include:
{% if victoriametrics.type == "single" %}
  - .single
{% elif victoriametrics.type == "cluster" %}
  - .cluster
{% elif victoriametrics.type == "agent" %}
  - .agent
{% endif %}
