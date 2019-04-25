#!/bin/bash

swap_partition=$(sudo fdisk -l | grep swap | awk '{print $1}')
echo ${swap_partition}
sudo sed -i -e "s|\(GRUB_CMDLINE_LINUX_DEFAULT=\".*\)\(\"\)|\1 resume=${swap_partition}\2|" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
