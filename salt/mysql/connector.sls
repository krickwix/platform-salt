mysql-connector-install-java-library:
  pkg.installed:
{% if grains['os'] == 'Ubuntu' %}
    - name: libmysql-java
{% elif grains['os'] == 'RedHat' %}
    - name: mysql-connector-java
{% endif %}

mysql-connector-remove-openjdk:
  pkg.removed:
    - pkgs:
        - java-1.8.0-openjdk
        - java-1.8.0-openjdk-headless