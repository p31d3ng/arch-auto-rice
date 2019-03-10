#!/bin/bash

sudo sed -i -e 's/^\(theme=\).*/\1Archlinux/' /etc/lxdm/lxdm.conf
sudo sed -i -e 's/\# \(session=\).*/\1\/usr\/bin\/i3/' /etc/lxdm/lxdm.conf