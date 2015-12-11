/etc/network/interfaces:
  file:
    - managed
    - source: salt://files/network/dansysadm-com-interfaces
    - user: root
    - group: root
    - mode: 644
