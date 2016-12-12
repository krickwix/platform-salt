# Install nodejs, npm
nodejs-install_useful_packages:
  pkg.installed:
    - pkgs:
      - nodejs
{% if grains['os'] == 'Ubuntu' %}
      - nodejs-legacy
{% endif %}
      - npm

# update the npm version
nodejs-update_npm:
  npm.installed:
    - name: npm
