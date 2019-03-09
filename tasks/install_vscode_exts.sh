#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
    code --install-extension "$line" --verbose --force 
done < "$1"