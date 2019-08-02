## Erebos Init.sls
##
## 'init.sls' is a special file that will be read out when a state/formula is referenced
## which name equals the name of the parent directory. (Module initializer basically)

include:
    # State files are imported from the base environment (shared state library)
    - base: epel
    - base: puppet
    - base: foreman

/etc/foreman-installer/scenarios.d/foreman-answers.yaml:
    file.managed: 
        - name: /etc/foreman-installer/scenarios.d/foreman-answers.yaml
        - source: salt://erebos/files/foreman-answers.yaml
        - require:
            - pkg: foreman-installer-package

foreman-installer-package:
    pkg.installed:
        - name: foreman-installer
        - require: 
            # Require RPMs to be installed before installing Foreman
            - pkg: install_rpm_epel
            - pkg: install_rpm_puppet
            - pkg: install_rpm_foreman

foreman-install:
    cmd.run:
        - name: foreman-installer
        - cwd: /
        - require:
            - pkg: foreman-installer-package
            - file: /etc/foreman-installer/scenarios.d/foreman-answers.yaml