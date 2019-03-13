#!/bin/bash
xdpyinfo &> /dev/null
if [[ "$?" -gt 0 ]]; then
    echo "Cannot open xdpinfo, skipping the setup for now"
    exit 0
fi

if [[ $(xdpyinfo | grep dimensions | awk '/[0-9]+x[0-9]+/{print $2}') = "3840x2160" ]]; then
    echo "You're using 4K screen, keeping dpi as 220"
    # -----------------------------------
    # Adjusting grub font size
    # making a font with size 36 for grub, then add it to grub config    
    sudo grub-mkfont -s 36 -o /boot/grub/dejavu.pf2 /usr/share/fonts/TTF/DejaVuSansMono.ttf
    sudo sed -i -e "\$aGRUB_FONT=/boot/grub/dejavu.pf2" /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    # -----------------------------------
else
    echo "You're using non-4K screen, remove dpi overrides"
    sed -i -e '/dpi/d' $1/Xresources
    sed -i -e '/dpi/d' $1/rofi_config.rasi
    sed -i -e '/dpi/d' $1/polybar_config
fi
