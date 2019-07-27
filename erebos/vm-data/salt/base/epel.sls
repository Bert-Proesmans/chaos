install_pubkey_epel:
    file.managed:
        - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
        - source: https://fedoraproject.org/static/352C64E5.txt
        - source_hash: sha256=22f25ad95d5e8d371760815485dba696ea3002fc2c7f812f2c75276853387107

epel_release:
    pkg.installed:
        - sources:
            - epel-release: http://download.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
        - require:
            - file: install_pubkey_epel

config_repo_epel:
  module.run:
    - pkg.mod_repo:
        - repo: epel
        - kwargs:
            enabled: 1
            gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
            gpgcheck: 1
        - require:
        - pkg: epel_release