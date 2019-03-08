#!/bin/bash

if $(facter is_virtual); then
    echo "You're running in VM, remove dpi overrides"
    sed -i -e '/dpi/d' $1/Xresources
    sed -i -e '/dpi/d' $1/rofi_config.rasi
    sed -i -e '/dpi/d' $1/polybar_config
    return
fi

xdpyinfo &> /dev/null
if [[ "$?" -gt 0 ]]; then
    echo "Cannot open xdpinfo, skipping the setup for now"
    return
fi

if [[ $(xdpyinfo | grep dimensions | awk '/[0-9]+x[0-9]+/{print $2}') = "3840x2160" ]]; then
    echo "You're using 4K screen, keeping dpi as 220"
else
    echo "You're using non-4K screen, remove dpi overrides"
    sed -i -e '/dpi/d' $1/Xresources
    sed -i -e '/dpi/d' $1/rofi_config.rasi
    sed -i -e '/dpi/d' $1/polybar_config
fi
