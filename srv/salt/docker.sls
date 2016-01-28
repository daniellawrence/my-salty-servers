apt-transport-https:
  pkg.latest:
    - refresh: True

# python-pip:
#  pkg.installed

# docker-py:
#  pip.installed:
#    - require:
#      - pkg: python-pip
    
docker-io-repo:
  pkgrepo.managed:
    - humanname: Dotdeb
    - name: deb https://apt.dockerproject.org/repo debian-jessie main  
    - file: /etc/apt/sources.list.d/docker-io.list
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
    - keyserver: p80.pool.sks-keyservers.net
    - refresh_db: true
          
docker-engine:
  pkg:
    - installed
    - refresh: True
    - require:
      - pkgrepo: docker-io-repo
      - pkg: apt-transport-https

docker:
  service:
    - running
    - enable: True
    - restart: True
    - require:
      - pkg: docker-engine
  group.present:
    - members:
      - dannyla
