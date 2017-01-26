[Unit]
SourcePath=/etc/init.d/opentsdb
[Service]
ExecStart=/etc/init.d/opentsdb start
ExecStop=/etc/init.d/opentsdb stop