#!/bin/bash

if $(facter is_virtual); then
    echo "In VM, skipping xorg configs"
else
    diff $1/20-intel.conf /usr/share/X11/xorg.conf.d/20-intel.conf
    diff $1/40-libinput.conf /usr/share/X11/xorg.conf.d/40-libinput.conf
fi