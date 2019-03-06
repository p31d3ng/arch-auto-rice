#!/usr/bin/env fish

curl -L https://get.oh-my.fish > /tmp/omf-install
fish /tmp/omf-install --noninteractive
sleep 5
for line in (cat $argv);
    omf install $line
end

