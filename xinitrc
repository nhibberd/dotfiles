#!/bin/sh

xrdb -merge ~/.Xdefaults

xmodmap $HOME/.Xmodmap

#set cursor
xsetroot -cursor_name left_ptr
#start xmonad
#exec xmonad

exec ssh-agent xmonad | dzen2 -ta r -fg '#999999' -bg '#262626'
