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
Environment=JMX_PORT=9050
Environment=KAFKA_HEAP_OPTS="-Xms{{ mem_xms}}g -Xmx{{ mem_xmx}}g -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35"
ExecStartPre=/bin/sleep 5
ExecStart=bin/kafka-server-start.sh config/server.properties
ExecStopPost=/bin/sleep 5
