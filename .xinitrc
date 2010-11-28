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
xbindkeys
xrdb -merge ~/.Xresources
#setxkbmap -option terminate:ctrl_alt_bksp
xmodmap  ~/.Xmodmap
${=LOCK}/urxvtd urxvtd -q -f -o

unclutter -noevents -root -idle 4 -reset &
#/usr/lib/notification-daemon-1.0/notification-daemon &>>|~/logs/X.log &
tmux new-session -d  
#${=LOCK}/tmux tmux -2 start-server
#clipbored
#anamnesis --start
exec xmonad
