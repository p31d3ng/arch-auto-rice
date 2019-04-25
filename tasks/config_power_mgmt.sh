#!/bin/bash

# Set power key to suspend-then-hibernate in case of fat finger, Closing lid should suspend (or go to hibernate later if on battery)
# Also, after idling for 5min, the machine should suspend to save power.
sudo tee -a /etc/systemd/logind.conf > /dev/null << EOM
HandlePowerKey=suspend-then-hibernate
HandleLidSwitch=suspend-then-hibernate
HandleLidSwitchExternalPower=suspend
IdleAction=suspend
IdelActionSec=5min
EOM

# After suspend for 300 seconds, the machine will go hibernation
sudo tee -a /etc/systemd/sleep.conf > /dev/null << EOM
HibernateDelaySec=300
EOM

