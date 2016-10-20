description "Kafka Manager"

start on runlevel [2345]
stop on runlevel [!2345]

respawn
respawn limit unlimited
post-stop exec sleep 2

limit nofile 8192 8192
exec /opt/pnda/kafka-manager/bin/kafka-manager -Dconfig.file=/opt/pnda/kafka-manager/conf/application.conf -Dapplication.home=/opt/pnda/kafka-manager -Dhttp.port={{ kafka_manager_port }}
