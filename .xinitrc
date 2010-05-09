#!/bin/sh

#nvidia-settings -l &

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
xmodmap -e 'keycode 135 = Super_L'
xmodmap -e 'add mod4 = 0xff67'

unclutter -idle 4 -reset &
xbindkeys &
$LOCK/mplayer /usr/bin/mplayer -quiet -slave -idle -input file=$MPSOCKET &>/tmp/mplayer.lock &

exec xmonad
