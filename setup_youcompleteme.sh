#!/usr/bin/env bash

# This script is meant to get YouCompleteMe working with GVim on Ubuntu.

pushd . > /dev/null 2>&1

echo "Installing build-essential cmake packages..."
apt-get -y install build-essential cmake
echo "Done"

echo "Installing python-dev package..."
sudo apt-get -y install python-dev
echo "Done"

echo "Installing YouCompleteMe (including C compilation)..."
cd ~/.vim/bundle/YouCompleteMe
./install.sh
echo "Done"

popd > /dev/null 2>&1

