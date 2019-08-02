## state Top.sls
##
## File that linkes machines to state.
## Each minion will receive a state tree and compare the constraints to its own grains (local machine data).
## State updates will be applies if applicable.

setup:
    # Apply the children to all machines.
    '*':
        - erebos