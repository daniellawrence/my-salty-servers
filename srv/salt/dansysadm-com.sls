---
git:
  pkg:
    - installed

nginx:
  pkg:
    - installed
  service:
    - running
    - watch:
      - pkg: nginx
      - file: /etc/nginx/nginx.conf

/etc/nginx/nginx.conf:
  file:
    - managed
    - source: salt://files/dansysadm-com/nginx.conf
    - user: root
    - group: root
    - mode: 644