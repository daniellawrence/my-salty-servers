#gogs/gogs:latest:
#  dockerng.image_present:
#    - name: gogs/gogs:latest
#      - force: true

docker_pull_gogs/gogs:latest:
  cmd.run:
    - name: /usr/bin/docker pull gogs/gogs:latest
      
/var/gogs:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: True

gogs:
  dockerng.running:
    - image: gogs/gogs
    - port_bindings:
      - "3000:3000"
      - "2222:2222"
    - binds:
      - "/var/gogs:/data:rw"
    - require:
        - file: /var/gogs
        - cmd: docker_pull_gogs/gogs:latest

# /var/gogs/config/app.ini:
#  file:
#    - managed
#    - source: salt://files/dansysadm-com/gogs-app.ini
#    - user: dannyla
#    - group: dannyla
#    - mode: 644
#    - require:
#        - file: /var/gogs
#        - docker: gogs