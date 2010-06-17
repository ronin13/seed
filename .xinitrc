#!/bin/sh

#nvidia-settings -l &

eval `cat ~/.fehbg` 

#tmux start-server
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
xmodmap -e 'keycode 78 = Super_L'
xmodmap -e 'keycode 127 = Alt_L'
xmodmap -e 'add mod4 = 0xff67'

#screen -md -c .rtorrent/.screenrc &
unclutter -idle 4 -reset &
xbindkeys &
#$LOCK/mplayer /usr/bin/mplayer -quiet -slave -idle -input file=$MPSOCKET &>/dev/null &
/usr/lib/notify-osd/notify-osd &
#export DISPLAY=:0.0 
$LOCK/tmux tmux start-server
#~/bin/tst &
#exec dwm
exec xmonad
