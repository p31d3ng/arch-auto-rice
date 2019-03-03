#!/bin/bash

# THIS SCRIPT NEED TO RUN UNDER ROOT AFTER CLEAN ARCH INSTALLATION
# update arch 
pacman -Syu --noconfirm
pacman -S git --noconfirm
pacman -S sudoer --noconfirm
pacman -S base-devel --noconfirm
pacman -S go --noconfirm

# create sudo group
read -p "Group for sudoers(default: super): " group_name
group_name=${group_name:-super}
super_group_exist=$(cut -d: -f1 /etc/group | grep "super" | wc -l)
if [[ ${super_group_exist} -eq 0 ]]; then
	echo "${group_name} does not exist, creating a new one..."
	groupadd ${group_name}
	sed -i '/%sudo.*/a # Allow members of group super to execute any comments\n%super  ALL=(ALL) NOPASSWD:ALL' /etc/sudoers
else
	echo "${group_name} exists! skipping creating group..."
fi

# create sudo user
read -p "Username: " username
user_exist=$(cut -d: -f1 /etc/passwd | grep "$username" | wc -l)
if [[ ${user_exist} -gt 0 ]]; then
	echo "User exist, adding to super group"
	usermod -aG "${group_name}" "$username"
else
	echo "User does not exist, creating a new user..."
	useradd -s /bin/bash -m -G "${group_name}" "$username"
	# Setting password
	echo "Setting password for $username"
	passwd "$username"
fi

# drop root and install yay
echo "Switching to user ${username}..."
su - ${username}
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
yay -Syu --noconfirm

# install required packages
pacman -S $(cat ./required-packages | tr '\n' ' ') --noconfirm
yay -S $(cat ./aur-packages | tr '\n' ' ') --noconfirm

# install config files via go script
cd /tmp
git clone https://github.com/p31d3ng/arch-auto-rice.git
cd arch-auto-rice
go run go-install-configs.go
