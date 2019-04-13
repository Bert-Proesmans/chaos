# Chaos

Repository containing my home environment as code.

## Why?

Why not?!

At this moment, prominent resources about virtualization mention running on top of existing cloud infrastructure.
There are also a lot of references to software packages which are being replaced with modern implementations. The 
latter are used within this repository. Learning opportunity!

All I have is one unprovisioned bare-metal server, so I'm in need of a complete, end-to-end, (mostly) automated 
system that could build my desired environment whenever requested. Automatisation and reproducibility!

## Architecture design

> I have to draw schematics at some point!

The design is simple, because I currently own a single physical server. The intentions are big, though.  
Pretty much every service (AD, File shares, game-, media encoding servers) will run on this server. I'm not sure if i want to use my router for this stuff
anymore.

## Configuration

This repository contains a few directories which correspond to a bootstrap phase.

* [Erebos]: Bootstrapping system
* [Gaia]: Virtualization configuration
* [Samsara]: Application configuration


[Erebos]: erebos/README.md