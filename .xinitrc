#!/bin/zsh

nvidia-settings -l &
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
${=LOCK}/urxvtd urxvtd -q -f -o

unclutter -idle 4 -reset &
xbindkeys &
#/usr/lib/notify-osd-customizable/notify-osd &
/usr/lib/notification-daemon-1.0/notification-daemon &
${=LOCK}/tmux tmux start-server
parcellite &
exec xmonad
