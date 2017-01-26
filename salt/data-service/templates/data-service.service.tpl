[Unit]
Description=dataset manager service

[Service]
Type=simple
User=hdfs
WorkingDirectory={{ install_dir }}/data-service
ExecStart=/bin/python {{ install_dir }}/data-service/apiserver.py