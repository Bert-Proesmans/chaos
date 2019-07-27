## pillar Top.sls
##
## File that linkes machines to configuration data.
## Each minion will receive its unique configuration data. This data is interpreted within
## Salt states.
## Note that Pillar data should be securely transferred, because a typical payload contains
## secret keys and/or passwords.

# Default environment.
base:
    # Apply to all machines.
    '*':
        # State to be applied to machines constrained by the parent collection.
        - erebos