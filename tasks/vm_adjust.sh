#!/bin/bash

if $(sudo facter is_virtual); then
    echo "You're running in VM, remove dpi overrides"
    sed -i -e '/dpi/d' $1/Xresources
    sed -i -e '/dpi/d' $1/rofi_config.rasi
    sed -i -e '3,3s/height.*/height = 24/' $1/polybar_config
    sed -i -e '32,32s/tray-max.*/tray-maxsize = 16/' $1/polybar_config
    sed -i -e '/dpi/d' $1/polybar_config
    
    sed -i -e '1,1s/Mod4/Mod1/g' $1/i3_config
fi
