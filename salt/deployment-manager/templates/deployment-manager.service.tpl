[Unit]
Description=deployment manager service

[Service]
Type=simple
WorkingDirectory={{ install_dir }}/deployment_manager
ExecStart=/bin/python {{ install_dir }}/deployment_manager/app.py
ExecStopPost=/bin/sleep 2