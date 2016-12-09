[Unit]
Description=Logstash
After=syslog.target

[Service]
Type=simple
ExecStart=${programDir}/bin/logstash -f {{ install_dir }}/logstash/collector.conf
ExecStopPost=/bin/sleep 2

[Install]
WantedBy=multi-user.target
