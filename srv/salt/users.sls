---
dannyla:
  group.present:
    - gid: 1000
  user.present:
    - fullname: Daniel Lawrence
    - uid: 1000
    - gid: 1000
    - shell: /bin/zsh
    - groups:
        - sudo
        - adm

dannyla_key:
  ssh_auth.present:
    - user: dannyla
    - names:
        - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDD6aXNUG8bbhSaaZEOkwflAJe3WMXhp5a0Yqke6H+o4SGo6+8PYag0hKyqOm/nXGovtu1xTeyGR4maYvMaCnJ3tsdTV3Ia3lwYybtgB0/f9MQoAiA4PmJ6BQK7ND8TS+2BRsQBQND02LtQbDax/Fvlz7SuRmqn2DWUMt4n6Z1J85x2z8gnUQcihnKiteW/fqsLXDQo7O44QykfAqLjKM9hmrwjvGEG3cbx2CUwm/kohpeMdP1x8FiY+U6xEp/SZfRXRstILfiu7HxloJPBtMOsWJ9xKxUtrNPEg7ZmirAeooEu0pkoHY3pZUAyPiK9Lg90tenpEFVCrioeKr9Mopf98W7Oaz4BaStqY1KQF+0KliFo8dbnGyVjzSRJUkjSRu6Vl1nWstEiVgoesyaEnSqefXTO5vvfpGF0jk4SOQeOt1pyKgODixVUjCZJjEJIRrVsFNjtaeim/WZ9rJcyOGPKUxaut3shAlNpXy4H4CPbQb8Fq92yZfSs0JTzQnNSiQbb7ydrtNViEjnZsByCeJkYKV/hZ6qE9jnJHpmjN6SujAp1yg8byCY3m0WruKSrGIIMykxMy/61S1emgEBvupyys7Yo/nEX4DkUcidgwRq2eNzTWKzbOycRpFbJ/JvSSHuQMin98SPF3I+CLATA34u0xBlF98LHjuupuCKgQgP5sw==

sudo_package:
  pkg.installed:
    - pkgs:
        - sudo
        - zsh

/etc/sudoers.d/sudo_no_passwd:
  file.managed:
    - source: salt://files/sudoers.d/sudo_no_passwd
    - user: root
    - group: root
    - mode: 440
                              
git-dot-files:
  git.latest:
    - name: https://github.com/daniellawrence/dot-files
    - rev: master
    - target: /home/dannyla/.dot-files
    - require:
        - pkg: git
        - user: dannyla

/home/dannyla/.dot-files:
  file.directory:
    - user: dannyla
    - group: dannyla
    - recurse:
      - user
      - group
    - watch:
      - git: git-dot-files

cmd-setup-dot-files:
  cmd.run:
    - name: ./setup-dotfiles
    - cwd: /home/dannyla/.dot-files
    - user: dannyla