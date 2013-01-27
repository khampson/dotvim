My personal .vim directory.

The bundle directory contains other git repos as submodules for use with Pathogen.


*Installation:*

    Clone the repo as per usual.

*Create symlinks:*

    ln -s .vim ~/.vim
    ln -s .vim/vimrc ~/.vimrc

*Switch to the '~/.vim' directory, and fetch the submodules:*

    cd ~/.vim
    git submodule update --init

