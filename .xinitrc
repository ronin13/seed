#!/bin/zsh

nvidia-settings -l &
eval `cat ~/.fehbg`

xsetroot -cursor_name left_ptr
xset dpms 0 0 600
xset s off
xset s noblank
xset s noexpose
xset m 2 1
xset r rate 217 76
xrdb -merge ~/.Xresources
xrdb -merge ~/.Xdefaults
xmodmap  ~/.Xmodmap
urxvtd -q -f -o
xmobar --screen=1 ~/.xmobarrc.bigone &

#unclutter -noevents -root -idle 4 -reset &
pidof tmux || tmux new-session -d
#pidof tmux || tmux start-server
synclient TouchpadOff=1
xbindkeys
numlockx on
#detach mnger
exec xmonad
