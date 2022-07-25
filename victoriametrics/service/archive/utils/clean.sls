{% set unittype = "service" %}
{% for service in ["vmauth"] %}
victoriametrics-service-clean-service-{{ service }}-dead:
  service.dead:
    - name: {{ service }}
    - enable: False

victoriametrics_systemd_units_file_{{ service }}_{{ unittype }}:
  file.absent:
    - name: /etc/systemd/system/{{ service }}.{{ unittype }}

{% endfor %}
