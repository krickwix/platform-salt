[Unit]
Description=package repository service

[Service]
Type=simple
WorkingDirectory={{ install_dir }}/package_repository
ExecStart=/bin/python {{ install_dir }}/package_repository/package_repository_rest_server.py
ExecStopPost=/bin/sleep 2
