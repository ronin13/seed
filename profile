# vim: set ft=sh :et
export LOCKDIR="/tmp/locks"
export MPSOCKET="/tmp/mplayer.fif"
export LOCK="/usr/sbin/setlock -X -n $LOCKDIR" 
export MPD_HOST="/home/raghavendra/.mpd/socket"
export BROWSER=firefox
export SBROWSER=uzbl-browser
export AUDIODRIVER=oss
export TBROWSER=w3m
export VIEWER=mupdf
export DMENU="$HOME/bin/dmenu -p : -i -l 10 -nb grey11 -nf grey80 -sb maroon4 -m 1 -fn 'xft:Liberation:pixelsize=18'"
export YDMENU='yeganesh -p ${yprofile:-misc}  -f --  -p : -i -l 10 -nb grey11 -nf grey80 -sb maroon4 -m 1 -fn "xft:Liberation:pixelsize=18"'
export PATH="$HOME/bin:/mine/bin:/usr/local/bin:/usr/bin/vendor_perl:$PATH"
export VIMRUNTIME="/usr/share/vim/vim73"
export GDK_USE_XFT=1
export VISUAL="vim"
export WSETS="news nether mutt nether ncm nether vim uake newsbeuter nether ncmpcpp nether weechat uake weechat-curses uake atop nether w3m uake rtorrent nether"
export MUXAL="news newsbeuter ncm ncmpcpp weechat weechat-curses torrent rtorrent"
export SDL_VIDEO_X11_DGAMOUSE=0
export EDITOR="vim"
export WINEDEBUG=-all
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export CSCOPE_DB="/home/raghavendra/Arch/vim/cscope/cscope.out"
export LESS="-R -I -M -s -j.5 -J -W -z-5" #-S -F -X
export PAGER="less $LESS"
export MANPAGER="$PAGER"
export MANPATH="$HOME/.helpers/man/:"
export MOZ_DISABLE_PANGO=1
export PERIOD=75
export PERLBREW_ROOT=~/.perlbrew
export CC=colorgcc
export DIFF=colordiff
export VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE="DFP-1"
export HTTP_HOME=http://lwn.net
export PROMPT_EOL_MARK=

function flushmac(){
    rm -rf /home/raghavendra/.macromedia/Flash_Player/*
    rm -rf /home/raghavendra/.adobe/
}


