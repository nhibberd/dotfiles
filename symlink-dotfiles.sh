#!/bin/sh

(
cd $HOME

# zsh
ln -s dotfiles/zsh .zsh
ln -s .zsh/zprofile .zprofile
ln -s .zsh/zshrc .zshrc 

# xmonad
ln -s dotfiles/xmonad .xmonad

# x
ln -s dotfiles/x/Xdefaults .Xdefaults
ln -s dotfiles/x/Xmodmap .Xmodmap
ln -s dotfiles/x/xsession .xsession

# ssh
[ ! -d $HOME/.ssh ] && mkdir $HOME/.ssh
)
