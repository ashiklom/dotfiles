#!/bin/zsh

# Create symbolic links
setopt EXTENDED_GLOB
ln -s ~/dotfiles/.zprezto ~/.zprezto
ln -s ~/dotfiles/.zprezto/runcoms/.zlogin ~/.zlogin
ln -s ~/dotfiles/.zprezto/runcoms/.zlogin ~/.zlogout
ln -s ~/dotfiles/.zprezto/runcoms/.zlogin ~/.zpreztorc
ln -s ~/dotfiles/.zprezto/runcoms/.zlogin ~/.zprofile
ln -s ~/dotfiles/.zprezto/runcoms/.zlogin ~/.zshrc

# for rcfile in ~/.zprezto/runcoms/^README.md; do
#   ln -s "$rcfile" "~/${rcfile:t}"
# done
