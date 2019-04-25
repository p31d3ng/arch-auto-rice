#!/bin/bash

# Set power key to suspend-then-hibernate in case of fat finger, Closing lid should suspend (or go to hibernate later if on battery)
# Also, after idling for 5min, the machine should suspend to save power.
cat >> /etc/systemd/logind.conf << EOM
HandlePowerKey=suspend-then-hibernate
HandleLidSwitch=suspend-then-hibernate
HandleLidSwitchExternalPower=suspend
IdleAction=suspend
IdelActionSec=5min
EOM

# After suspend for 300 seconds, the machine will go hibernation
cat >> /etc/systemd/sleep.conf << EOM
HibernateMode=platform shutdown
HibernateDelaySec=300
EOM

