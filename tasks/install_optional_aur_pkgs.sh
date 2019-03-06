#!/bin/bash

yay -S "$(cat $1 | tr '\n' ' ') --noconfirm"
