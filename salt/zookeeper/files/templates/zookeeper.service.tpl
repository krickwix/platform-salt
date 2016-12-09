[Unit]
Description=zookeeper centralized coordination service
After=systemd-readahead-collect.service systemd-readahead-replay.service

[Service]
Type=simple
RemainAfterExit=yes
LimitNOFILE=8192
ExecStartPre=[ -r "/usr/share/java/zookeeper.jar" ] || exit 0 && \
    [ -r "{{ conf_dir }}/environment" ] || exit 0 && \
    . {{ conf_dir }}/environment && \
    [ -d $ZOO_LOG_DIR ] || mkdir -p $ZOO_LOG_DIR && \
    chown $USER:$GROUP $ZOO_LOG_DIR
ExecStart=. {{ conf_dir }}/environment && \
    [ -r /etc/default/zookeeper ] && . /etc/default/zookeeper && \
    if [ -z "$JMXDISABLE" ]; then \
        JAVA_OPTS="$JAVA_OPTS -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.local.only=$JMXLOCALONLY" \
    fi \
    $JAVA --name zookeeper \
    	-cp $CLASSPATH $JAVA_OPTS -Dzookeeper.log.dir=${ZOO_LOG_DIR} \
      	-Dzookeeper.root.logger=${ZOO_LOG4J_PROP} $ZOOMAIN $ZOOCFG
