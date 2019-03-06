#!/bin/bash

# THIS SCRIPT NEED TO RUN UNDER ROOT AFTER CLEAN ARCH INSTALLATION

# create sudo group
pacman -S sudo --noconfirm
echo "----------------------------------------------------------------------"
read -p "Adding new group for sudoers(default: super): " group_name
echo "----------------------------------------------------------------------"
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
echo "----------------------------------------------------------------------"
read -p "Username: " username
echo "----------------------------------------------------------------------"
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

# update arch 
pacman -Syu --noconfirm
pacman -S ntp --noconfirm
pacman -S git --noconfirm
pacman -S base-devel --noconfirm
pacman -S go --noconfirm

# enable dhcp & ntpd at boot time
systemctl enable dhcp
systemctl enable ntpd

# drop root and install yay
cd /tmp
rm -rf yay
su -c "git clone https://aur.archlinux.org/yay.git" ${username}
cd yay
su -c "makepkg -si --noconfirm" ${username}
cd ..
su -c "yay -Syu --noconfirm" ${username}

# clone the main repo
git clone https://github.com/p31d3ng/arch-auto-rice.git
cd arch-auto-rice

# install required packages
pacman -S $(cat ./packages/required-official-packages | tr '\n' ' ') --noconfirm
su -c "yay -S $(cat .packages/required-aur-packages | tr '\n' ' ') --noconfirm" ${username}
su -c "go get -u gopkg.in/yaml.v2" ${username}

# create sudo user
echo "----------------------------------------------------------------------"
echo "Congratulation! auto-ricing finished!"
read -p "Do you want to proceed to install/config optional packages? (Y/n): " selection
echo "----------------------------------------------------------------------"

if [[ $(echo "$selection" | tr '[:upper:]' '[:lower:]') = "y" ]]; then
	# install config files via go script
	su -c "go run post-ricing.go post-ricing-tasks.yaml" ${username}
else 
	echo "You choose not to proceed, but if you changed your mind, you can always run:"
	echo "go run post-rucing.go post-ricing-tasks.yaml"
fi