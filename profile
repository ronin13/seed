# vim: set ft=sh :et
export MPD_HOST="/home/raghavendra/.mpd/socket"
export BROWSER=firefox
export SBROWSER=uzbl-browser
export AUDIODRIVER=oss
export TBROWSER=w3m
export VIEWER=zathura
#export DMENU="$HOME/bin/dmenu/dmenu -i -l 3 -nb #303030 -nf black -sb #303030 -p :"
export DMENU="$HOME/bin/dmenu -p : -i -l 10 -nb grey11 -nf grey80 -sb maroon4 -fa 'xft:Liberation:pixelsize=14'"
export YDMENU='yeganesh -p ${yprofile:-misc} --  -p : -i -l 10 -nb grey11 -nf grey80 -sb maroon4 -fa "xft:Liberation:pixelsize=14"'
export PATH="$HOME/bin:/usr/local/bin:$PATH:$HOME/.cabal/bin"
export VIMRUNTIME="/usr/share/vim/vim73"
export GDK_USE_XFT=1
export VISUAL="vim"
export WSETS="news nether mutt nether ncm nether vim uake newsbeuter nether ncmpcpp nether weechat uake weechat-curses uake atop nether w3m uake"
export MUXAL="news newsbeuter ncm ncmpcpp weechat weechat-curses"
export EDITOR="vim"
export WINEDEBUG=-all
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export CSCOPE_DB="/home/raghavendra/Arch/vim/cscope/cscope.out"
#export PAGER="vimpager"
#alias less="vimpager"
#export LD_PRELOAD="/usr/lib/libtcmalloc_minimal.so"
export LESS="-R -i -M -s -j.5 -J -W -z-5" #-S -F -X
export PAGER="less $LESS"
export MANPAGER="$PAGER"
#export PERL5LIB=/usr/share/perl5/vendor_perl/Any
#export __GL_YIELD="NOTHING"
export MANPATH="$HOME/helpers/man/:"

function flushmac(){
    rm -rf /home/raghavendra/.macromedia/Flash_Player/*
    rm -rf /home/raghavendra/.adobe/
    mkdir -p ~/.macromedia/Flash_Player/macromedia.com/support/flashplayer/sys
    cp ~/Arch/settings.sol ~/.macromedia/Flash_Player/macromedia.com/support/flashplayer/sys/
}


export MOZ_DISABLE_PANGO=1
export PERIOD=75
export PERLBREW_ROOT=~/.perlbrew

#function command_not_found_handler(){
#     if which $=@ &>/dev/null;then
#         echo "#!/bin/zsh" >| /tmp/.zshfunc
#         which $=@ >> /tmp/.zshfunc
#         /tmp/.zshfunc
#         #rm /tmp/.zshfunc
#         return 0
#     else
#         echo "$0 not found"
#         return 127
#     fi
# }

export HTTP_HOME=http://lwn.net
