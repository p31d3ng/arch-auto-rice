#!/usr/bin/env fish

curl -L https://get.oh-my.fish | fish
for line in (cat $argv);
    omf install $line
end

