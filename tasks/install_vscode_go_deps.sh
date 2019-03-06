#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
    go get -u -v "$line"
done < "$1"

gometalinter --install