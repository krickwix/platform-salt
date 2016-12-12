[Unit]
Description=logserver service

[Service]
Type=simple
ExecStart={{ install_dir }}/logstash/bin/logstash -f {{ install_dir }}/logstash/collector.conf
ExectStopPost=/bin/sleep 2
