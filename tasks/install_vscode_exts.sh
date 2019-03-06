#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
    code --install-extension --verbose --force "$line"
done < "$1"