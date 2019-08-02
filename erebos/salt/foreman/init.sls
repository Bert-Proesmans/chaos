# Entry file for the Foreman provision configuration.
#
# This file must be called 'init.sls' exaclty to be able to
# reference the parent folder as a single state definition.

# Example state to showcase Salt configuration!
# All defined states will ALWAYS be applied to the minion.
# It's only possible to control the execution order by defining
# dependancies between different states.
test:
    file.managed:
        - name: /home/vagrant/test.txt
        - contents: 'Provisioned with Salt'