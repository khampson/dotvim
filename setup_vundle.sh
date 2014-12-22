#!/usr/bin/env bash

echo "Cloning vundle git repo..."
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Setting up soft links..."
ln -s ~/workspace/dotvim/vimrc ~/.vimrc

echo "Done"

