#!/bin/zsh

# Download submodule zprezto
git submodule init
git submodule update
cd .zprezto
git submodule init
git submodule update
cd ..

# Create symbolic links
setopt EXTENDED_GLOB
ln -rs .zprezto ~
ln -rs .zprezto/runcoms/.z* ~

# for rcfile in ~/.zprezto/runcoms/^README.md; do
#   ln -s "$rcfile" "~/${rcfile:t}"
# done
