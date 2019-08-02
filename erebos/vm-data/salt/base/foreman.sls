install_pubkey_foreman:
    file.managed:
        - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-foreman
        - source: https://yum.theforeman.org/RPM-GPG-KEY-foreman
        - source_hash: sha256=e7acf99e821360562da721997b456578977271c53e643676d797ead8edd3e963

install_rpm_foreman:
    pkg.installed:
        - sources:
            - foreman-release: https://yum.theforeman.org/releases/1.22/el7/x86_64/foreman-release.rpm
        - require:
            - file: install_pubkey_foreman

config_repo_foreman:
  module.run:
    - pkg.mod_repo:
        - repo: foreman
        - kwargs:
            enabled: 1
            gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-foreman
            gpgcheck: 1
        - require:
        - pkg: install_rpm_foreman