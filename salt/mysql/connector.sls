mysql-connector-install-java-library:
  pkg.installed:
{% if grains['os'] == 'Ubuntu' %}
    - name: libmysql-java
{% elif grains['os'] == 'RedHat' %}
    - name: mysql-connector-java
{% endif %}
