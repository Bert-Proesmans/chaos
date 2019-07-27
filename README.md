# Chaos

Repository containing my home environment as code.

## Why?

Why not?!

All I have is one unprovisioned bare-metal server and spare time. This is a perfect learning opportunity
for machine lifecycle management (or Metal-As-A-Service).  
Ultimately I desire system that could install, configure and run my applications with zero to no manual effort from scratch.

## Architecture design

> I have to draw schematics at some point!

The design is simple, because I currently own a single physical server. The intentions are big, though.  
Pretty much every service (AD, File shares, game-, media encoding servers) will run on this server. Ideally routing hardware, aka my 
single home edge router, shouldn't be used for application stuff.

## Configuration

This repository contains a few directories which correspond to a bootstrap phase.

* [Erebos]: Bootstrapping system
* [Gaia]: -
* [Samsara]: -


[Erebos]: erebos/README.md