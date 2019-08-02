install_pubkey_puppet:
    file.managed:
        - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs
        - source: http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
        - source_hash: sha256=a2a6ac449c6c0cb2e821d7f5bd12002820de4a5da73202233159ef9f5354436e

install_rpm_puppet:
    pkg.installed:
        - sources:
            - puppetlabs-release: https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
        - require:
            - file: install_pubkey_puppet

config_repo_puppet:
  module.run:
    - pkg.mod_repo:
        - repo: puppet
        - kwargs:
            enabled: 1
            gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs
            gpgcheck: 1
        - require:
        - pkg: install_rpm_puppet