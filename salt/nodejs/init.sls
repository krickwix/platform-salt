# Specify version 6 of nodejs, latest LTS
nodejs-v6-setup:
  cmd.run:
    - name: curl -sL 'https://deb.nodesource.com/setup_6.x' | sudo -E bash -

# Install nodejs, npm
nodejs-install_useful_packages:
  pkg.installed:
    - pkgs:
      - nodejs
<<<<<<< HEAD
{% if grains['os'] == 'Ubuntu' %}
      - nodejs-legacy
{% endif %}
      - npm
=======
    - require:
      - cmd: nodejs-v6-setup
>>>>>>> pndaproject/develop

# update the npm version
nodejs-update_npm:
  npm.installed:
    - name: npm
    - require:
      - cmd: nodejs-v6-setup
