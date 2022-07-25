# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as victoriametrics with context %}

include:
  #- .file
  - .directory
{% if victoriametrics.type == "cluster" %}
  - .vminsert
  - .vmselect
  - .vmstorage
{% elif victoriametrics.type == "single" %}
  - .victoriametrics
{% elif victoriametrics.type == "agent" %}
  - .vmagent
{% endif %}
{% if victoriametrics.vmauth.enabled %}
  - .vmauth
{% endif %}
