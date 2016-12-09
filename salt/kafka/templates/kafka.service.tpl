[Unit]
Description=kafka service
After=systemd-readahead-collect.service systemd-readahead-replay.service

[Service]
Type=simple
RemainAfterExit=yes
LimitNOFILE=32768
User=kafka
Group=kafka
WorkingDirectory={{ workdir }}
EnvironmentFile=/etc/default/kafka-env
ExecStartPre=/bin/sleep 5
ExecStart=bin/kafka-server-start.sh config/server.properties
ExecStopPost=/bin/sleep 5
