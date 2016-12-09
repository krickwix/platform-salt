python-pip-install-pip-package:
  pkg.installed:
    - pkgs:
      - python-pip
      - python-dev
      - python-virtualenv

python-pip-install_python_pip:
  pip.installed:
    - name: pip == 8.1.2
    - upgrade: True
    - reload_modules: True
    - require:
      - pkg: python-pip-install-pip-package
