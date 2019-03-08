#!/bin/bash

cd $1
go run $2 $3
cd - > /dev/null
sudo systemctl enable lxdm