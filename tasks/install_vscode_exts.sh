#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
    code --install-extension --force "$line"
done < "$1"