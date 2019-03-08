#!/bin/bash

if $(sudo facter is_virtual); then
    echo "In VM, skipping xorg configs"
else
    if [[ -f /usr/share/X11/xorg.conf.d/20-intel.conf ]]; then
        diff $1/20-intel.conf /usr/share/X11/xorg.conf.d/20-intel.conf
    fi
    if [[ -f /usr/share/X11/xorg.conf.d/40-libinput.conf ]]; then
        diff $1/40-libinput.conf /usr/share/X11/xorg.conf.d/40-libinput.conf
    fi
fi