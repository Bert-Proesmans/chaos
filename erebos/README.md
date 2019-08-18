# Erebos

Virtual machine for bootstrapping the basic network services.

## How?

1. Saltstack
    * Single Salt master machine
    * Minion machines
2. The Foreman

### Saltstack

Saltstack is a configuration management tool. You create state definitions and apply each
depending on various machine facts.

The code in this repository sets up a Salt master machine, containing both the Master and Minion software.
The machine is also a minion so it can provision itself after initial bootstrap. The master is configured
to automatically accept and control all minions that provide a certain Grain (machine fact) value for 'Deployment'.
All state definitions are stored onto the master machine. The master will interpret the states and push
filtered data to its minions.

Salt minions machines are provisioned with a Salt minion client. This client receives state data from the master
and apply them to the local machine.

### TheForeman

TODO

## Stage0 aka Total chaos

The erebos subdirectory contains an initial environment to bootstrap samsara.
The environment uses Vagrant with the Virtualbox provider to have a portable saltmaster available.
Run `vagrant up` (provisioning takes a few minutes) and `vagrant ssh` to login into the saltmaster.
From there you can customize Salt configuration and run a highstate (apply all required operations on each minion)
on all minions. `sudo salt '*' state.apply`.  
Check first if all minions are properly connected by running `sudo salt '*' test.pîng`!

### Bootstrapping The Foreman

TODO