#!/bin/zsh

# Create symbolic links
setopt EXTENDED_GLOB
ln -s ~/dotfiles/.zprezto ~/.zprezto
ln -s ~/dotfiles/.zprezto/runcoms/.zlogin ~/.zlogin
ln -s ~/dotfiles/.zprezto/runcoms/.zlogout ~/.zlogout
ln -s ~/dotfiles/.zprezto/runcoms/.zpreztorc ~/.zpreztorc
ln -s ~/dotfiles/.zprezto/runcoms/.zprofile ~/.zprofile
ln -s ~/dotfiles/.zprezto/runcoms/.zshrc ~/.zshrc

# for rcfile in ~/.zprezto/runcoms/^README.md; do
#   ln -s "$rcfile" "~/${rcfile:t}"
# done
