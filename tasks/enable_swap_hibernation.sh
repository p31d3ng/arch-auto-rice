#!/bin/bash

swap_partition=$(sudo fdisk -l | grep swap | awk '{print $1}')
sudo sed -i -e "s|\(GRUB_CMDLINE_LINUX_DEAULT=\".*\)\(\"\)|\1${swap_partition}\2|" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg