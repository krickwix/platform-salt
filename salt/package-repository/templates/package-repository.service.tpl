[Unit]
Description=package repository service

[Service]
Type=simple
ExecStart=python {{ install_dir }}/package_repository/package_repository_rest_server.py
ExecStopPost=/bin/sleep 2
