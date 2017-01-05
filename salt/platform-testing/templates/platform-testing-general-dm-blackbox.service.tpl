[Unit]
Description=Platform testing general dm blackbox

[Service]
Type=oneshot
Environment=PYTHON_HOME={{ platform_testing_directory }}/{{platform_testing_package}}/venv
ExecStart=${PYTHON_HOME}/bin/python {{ platform_testing_directory }}/{{platform_testing_package}}/monitor.py --plugin dm_blackbox --postjson http://{{ console_hosts|join(',') }}/metrics --extra "--dmendpoint {{ dm_hosts|join(',') }}"
