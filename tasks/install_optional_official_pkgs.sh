#!/bin/bash

pacman -S "$(cat $1 | tr '\n' ' ') --noconfirm"