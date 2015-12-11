---
git:
  pkg:
    - installed

nginx:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - restart: True
    - watch:
      - pkg: nginx
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-enabled/dansysadm-com.conf

/etc/nginx/nginx.conf:
  file:
    - managed
    - source: salt://files/dansysadm-com/nginx.conf
    - user: root
    - group: root
    - mode: 644
    - require:
        - pkg: nginx

/etc/nginx/sites-enabled/default:
  file:
    - absent

/usr/share/nginx/html:
  file:
    - absent

/usr/share/nginx:
  file.directory:
    - user: www-data
    - group: www-data
    - mode: 0555
    - makedirs: True
    - recurse:
      - user
      - group
      - mode    
    - watch:
      - git: git-dansysadm-com  

/etc/nginx/sites-enabled/dansysadm-com.conf:
  file:
    - managed
    - source: salt://files/dansysadm-com/dansysadm-com.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx


git-dansysadm-com:
  git.latest:
    - name: https://github.com/daniellawrence/daniellawrence.github.io
    - rev: master
    - user: root
    - target: /usr/share/nginx/dansysadm.com
    - require:
        - pkg: nginx