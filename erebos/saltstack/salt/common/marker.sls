salt-marker:
    file.managed:
        - name: /provisioned_with_salt.txt
        - contents: |
            This machine has been provisioned with Salt.
            Check the state files on saltmaster!