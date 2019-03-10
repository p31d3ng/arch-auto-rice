#!/bin/bash

sudo sed -i -e 's/\#\(en_US.UTF-8.*\)/\1/' /etc/locale.gen
sudo locale-gen
sudo bash -c "echo 'LANG=en_US.UTF-8' > /etc/locale.conf"