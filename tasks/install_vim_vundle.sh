#!/bin/bash

set -e
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp $1 ~/.vimrc
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe && ./install.py
cd -