#!/bin/bash

sudo pacman -S $(cat $1 | tr '\n' ' ') --noconfirm --needed