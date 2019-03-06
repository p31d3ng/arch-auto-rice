#!/usr/bin/env fish

for line in (cat $argv);
    omf install $line
end

