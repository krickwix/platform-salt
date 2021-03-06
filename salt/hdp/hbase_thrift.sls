{% set thrift_port = pillar['hbase-thrift']['port'] %}
{% set info_port = pillar['hbase-thrift']['info-port'] %}

/usr/lib/systemd/system/hbase-thrift.service:
  file.managed:
    - source: salt://hdp/templates/hbase-daemon.service.tpl
    - mode: 644
    - template: jinja
    - context:
      daemon_service: 'thrift'
      daemon_port: {{ thrift_port }}
      info_port: {{ info_port }}

hdp-systemctl_reload_hbase_thrift:
  cmd.run:
    - name: /bin/systemctl daemon-reload; /bin/systemctl enable hbase-thrift

hdp-start_hbase_thrift:
  cmd.run:
    - name: 'service hbase-thrift stop || echo already stopped; service hbase-thrift start'
