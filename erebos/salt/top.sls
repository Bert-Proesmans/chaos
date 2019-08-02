# Entry file for the state definitions.
#
# All mentioned state definitions will be applied to the minion.

# Apply from the base environment (default).
base:
    # Apply the states to all (*=wildcard) hosts.
    '*': 
        # Apply the foreman provision states to the minion.
        # WARN; All states defined underneath statedefinition 'Foreman' will
        # be applied to this machine!
        - foreman