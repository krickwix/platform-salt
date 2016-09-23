# Create the cloudera user in order to make the manager able to connect as
# 'cloudera' user and install cloudera components

# XXX Put this in pillar
{% set cloudera = {'username': 'cloudera'} %}
{% set cluster = salt['pnda.cluster_name']() %}

{% set cm_id = salt['mine.get']('G@pnda_cluster:{} and G@roles:cloudera_manager'.format(cluster),
                                'network.ip_addrs',
                                expr_form='compound').keys()|first %}

cdh-create_cloudera_user:
  user.present:
    - name: {{ cloudera['username'] }}

# The cloudera-keys.sls MUST have already been executed on the
# cloudera manager host
cdh-get-cloudera-public-key:
  module.run:
    - name: cp.get_file
    - path: salt://{{ cm_id }}/keys/cloudera.pem.pub
    - dest: /tmp/cloudera.pem.pub

cdh-add_authorized_key:
  ssh_auth.present:
    - user: {{ cloudera['username'] }}
    - source: /tmp/cloudera.pem.pub

cdh-add_cloudera_user_to_passwordless_sudoers:
  file.managed:
    - name: /etc/sudoers.d/cloudera
    - contents: '{{ cloudera['username'] }} ALL = (ALL) NOPASSWD: ALL'
