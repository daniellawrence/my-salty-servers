git-letsencrypt:
  git.latest:
    - name: https://github.com/letsencrypt/letsencrypt
    - rev: master
    - target: /var/tmp/letsencrypt
    - require:
      - pkg: git