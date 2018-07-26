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
ln -s dotfiles/x/xinitrc .xinitrc

# emacs
ln -s dotfiles/emacs/bootstrap/emacs .emacs

# screen
ln -s dotfiles/screen/screenrc .screenrc

# git
ln -s dotfiles/gitconfig .gitconfig
ln -s dotfiles/gitignore .gitignore

# ssh
[ ! -d $HOME/.ssh ] && mkdir $HOME/.ssh

# bazel
ln -s dotfiles/bazelrc .bazelrc

# ghci
[ ! -d $HOME/.ghc ] && mkdir $HOME/.ghc
ln -s $HOME/dotfiles/ghci.conf $HOME/.ghc/ghci.conf
)
