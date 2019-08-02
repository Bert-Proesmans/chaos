install_pubkey_epel:
    file.managed:
        - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
        - source: https://fedoraproject.org/static/352C64E5.txt
        - source_hash: sha256=22f25ad95d5e8d371760815485dba696ea3002fc2c7f812f2c75276853387107

install_rpm_epel:
    pkg.installed:
        - sources:
            - epel-release: http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
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
        - pkg: install_rpm_epel