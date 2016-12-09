python-pip-install-pip-package:
  pkg.installed:
    - pkgs:
{% if grains['os'] == 'Ubuntu' %}
      - python-pip
      - python-dev
      - python-virtualenv
{% elif grains['os'] == 'RedHat' %}
      - python2-pip
      - python-devel
      - python-virtualenv
{% endif %}

python-pip-install_python_pip:
  pip.installed:
    - name: pip == 8.1.2
    - upgrade: True
    - reload_modules: True
    - require:
      - pkg: python-pip-install-pip-package
