#!/usr/bin/env bash

# This script is meant to get GVim (vim-airline) and zsh ready for use with Powerline fonts on Ubuntu.

FONTS_DIR="$HOME/.fonts"

pushd . > /dev/null 2>&1

cd ~/Downloads

# Grab the patched font that's necessary to support the special characters
echo "Downloading font from github..."
wget https://github.com/pdf/ubuntu-mono-powerline-ttf/raw/master/Ubuntu%20Mono%20for%20Powerline.ttf
echo "Done"

if [ ! -d "$FONTS_DIR" ]; then
    echo "Creating directory '$FONTS_DIR'"
    mkdir $FONTS_DIR
fi

# move it into the fonts dir
echo "Moving font into ~/.fonts directory"
mv ~/Downloads/Ubuntu\ Mono\ for\ Powerline.ttf ~/.fonts

echo "Refreshing cache..."
fc-cache -vf ~/.fonts

echo "NOTE: You may need to restart before the changes take effect."

popd > /dev/null 2>&1

