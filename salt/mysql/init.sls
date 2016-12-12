{% set mysql_root_password = salt['pillar.get']('mysql:root_pw', 'mysqldefault') %}

include:
  - .connector

{% if grains['os'] == 'Ubuntu' %}
mysql-install-debconf-utils:
  pkg.installed:
    - name: debconf-utils

mysql-setup-mysql:
  debconf.set:
    - name: mysql-server
    - data:
        'mysql-server/root_password': {'type': 'password', 'value': '{{ mysql_root_password }}'}
        'mysql-server/root_password_again': {'type': 'password', 'value': '{{ mysql_root_password }}'}
        'mysql-server/start_on_boot': {'type': 'boolean', 'value': 'true'}
    - require:
      - pkg: mysql-install-debconf-utils
{% endif %}

mysql-install-python-library:
  pkg.installed:
{% if grains['os'] == 'Ubuntu' %}
    - name: python-mysqldb
{% elif grains['os'] == 'RedHat' %}
    - name: MySQL-python
{% endif %}
    - reload_modules: True

mysql-install-mysql-server:
  pkg.installed:
{% if grains['os'] == 'Ubuntu' %}
    - name: mysql-server-5.6
    - require:
      - debconf: mysql-setup-mysql
{% elif grains['os'] == 'RedHat' %}
    - name: mariadb-server
mysql_root_password:
  cmd.run:
    - name: mysqladmin --user root password '{{ mysql_root_password|replace("'", "'\"'\"'") }}'
    - unless: mysql --user root --password='{{ mysql_root_password|replace("'", "'\"'\"'") }}' --execute="SELECT 1;"
    - require:
      - service: mysql-mysql-running
{% endif %}

mysql-update-mysql-configuration:
  file.replace:
    - name: /etc/mysql/my.cnf
    - pattern: bind-address\s*=.*$
    - repl: bind-address      = 0.0.0.0
    - require:
      - pkg: mysql-install-mysql-server

mysql-mysql-running:
  service.running:
{% if grains['os'] == 'Ubuntu' %}
    - name: mysql
{% elif grains['os'] == 'RedHat' %}
    - name: mariadb
{% endif %}
    - watch:
      - pkg: mysql-install-mysql-server
      - file: /etc/mysql/my.cnf
