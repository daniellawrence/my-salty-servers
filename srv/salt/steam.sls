steam_cmd_pkgs:
  pkg.installed:
    - pkgs:
        - lib32gcc1
        - tmux

steam:
  group.present:
    - gid: 2000
  user.present:
    - fullname: Steam
    - uid: 2000
    - gid: 2000
    - shell: /bin/bash

cmd-download-steamcmd:
  cmd.run:
    - cwd: /home/steam
    - name: wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
    - user: steam
    - unless: test -f /home/steam/steamcmd_linux.tar.gz
    - require:
      - user: steam
          

/home/steam/.bashrc:
  file:
    - managed
    - source: salt://files/force_tmux_bash_profile
    - user: steam
    - group: steam
    - mode: 755
    - require:
        - user: steam
        
cmd-untar-steamcmd:
  cmd.run:
    - cwd: /home/steam
    - name: tar xf steamcmd_linux.tar.gz
    - user: steam
    - unless: test -f /home/steam/steamcmd.sh  
    - require:
      - user: steam

cmd-login-steamcmd:
  cmd.run:
    - cwd: /home/steam
    - name: ./steamcmd.sh '+login anonymous' +quit
    - user: steam
    - require:
      - user: steam

cmd-install-csgo-steamcmd:
  cmd.run:
    - cwd: /home/steam
    - name: ./steamcmd.sh '+login anonymous' '+app_update 740 validate' +quit
    - user: steam
    - require:
      - user: steam

        
