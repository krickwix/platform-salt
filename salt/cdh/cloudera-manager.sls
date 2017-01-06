{% set cm_ver = '5.9.0' %}

include:
  - java

cloudera-manager-add_cloudera_manager_repository:
  pkgrepo.managed:
{% if grains['os'] == 'Ubuntu' %}
    - humanname: Cloudera Manager
    - name: deb [arch=amd64] https://archive.cloudera.com/cm5/ubuntu/trusty/amd64/cm trusty-cm{{cm_ver}} contrib
    - dist: trusty-cm{{cm_ver}}
    - key_url: https://archive.cloudera.com/cm5/ubuntu/trusty/amd64/cm/archive.key
    - refresh: True
    - file: /etc/apt/sources.list.d/cloudera.list
{% elif grains['os'] == 'RedHat' %}
    - humanname: Cloudera Manager
    - baseurl: http://archive.cloudera.com/cm5/redhat/7/x86_64/cm/5/
    - gpgkey: https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/RPM-GPG-KEY-cloudera
{% endif %}
cloudera-manager-install_cloudera_manager:
  pkg.installed:
    - pkgs:
      - cloudera-manager-daemons
      - cloudera-manager-server
      - cloudera-manager-server-db-2

cloudera-manager-ensure_cloudera_manager_db_started:
  service.running:
    - name: cloudera-scm-server-db

cloudera-manager-ensure_cloudera_manager_started:
  service.running:
    - name: cloudera-scm-server
