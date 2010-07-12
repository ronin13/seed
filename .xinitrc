#!/bin/zsh

#nvidia-settings -l &
setopt nobgnice
eval `cat ~/.fehbg` 

xsetroot -cursor_name left_ptr
xset dpms 0 0 300 
xset s off 
xset s noblank
xset s noexpose
xset m 2 1
xset r rate 217 76
xrdb -merge ~/.Xresources
setxkbmap -option terminate:ctrl_alt_bksp
xmodmap  ~/.Xmodmap 

unclutter -idle 4 -reset &
xbindkeys &
/usr/lib/notify-osd/notify-osd &
$LOCK/tmux tmux start-server
parcellite &
exec xmonad
