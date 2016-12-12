#!/bin/bash
set -e

{% if grains['os'] == 'Ubuntu' %}
while ! nc -z localhost 3000; do
  sleep 1
done
sleep 1
{% endif %}

# Exit if the pnda user already exists
curl --fail -s -H "Content-Type: application/json" -X GET http://{{ pnda_user }}:{{ pnda_password }}@localhost:3000/api/users && echo "{{ pnda_user }} user already exists" && exit 0

# Rename the admin user to the pnda user
curl -s -H "Content-Type: application/json" -X PUT -d '{"name":"{{ pnda_user }}", "email":"pnda@pnda.com", "login":"{{ pnda_user }}", "password":"{{ pnda_password }}"}' http://admin:admin@localhost:3000/api/users/1

# Change the password
curl -s -H "Content-Type: application/json" -X PUT -d '{"oldPassword": "admin", "newPassword":"{{ pnda_password }}", "confirmNew":"{{ pnda_password }}"}' http://{{ pnda_user }}:admin@localhost:3000/api/user/password
