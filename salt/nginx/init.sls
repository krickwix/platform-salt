nginx-nginx:
  pkg.installed:
    - name: nginx
{% if grains['os'] == 'RedHat' %}
  nginx_conf_file:
    file.managed:
      - name: /etc/nginx/nginx.conf
      - source: salt://nginx/files/nginx.conf
{% endif %}
  service.running:
    - name: nginx
    - enable: True
    - watch:
      - file: nginx_conf_file
