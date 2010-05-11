alias uattach='screen -d -r uake'
alias ls='ls --color=auto'
alias grep='LC_ALL="C" grep -i'
alias shownice='ps -eo nice,command | tail +1 | sort -n -k 1'
alias idden='ls -ld \.*'
alias aria="aria2c --file-allocation=falloc --enable-direct-io=true "
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ins='sudo pacman-color -S'
alias df='df -h'
alias du='du -sh'
alias d='cd ~/Desktop'
alias c='clear'
alias off='xset dpms force off'
alias ofd='top -b -n 1 | head -12 | tail --lines=+8'
alias lsd='ls -d */'
alias pacman='pacman-color'
alias pinfo='pacman -Qi'
alias frames='/usr/bin/mplayer -vo jpeg -sstep 0'
alias locate='/usr/bin/locate -i'
alias sdown='sudo shutdown -h now'
alias improve='sudo pacman-color -Syu'
alias pal="pacman -Ql "
alias redradio="mplayer -playlist http://radioreddit.com:8000/listen.pls"
alias showtorrent="aria2c -S "
alias wget="wget -c --content-disposition"

if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=always'
fi

alias tmp="cd /tmp/"
alias ..='cd ..'
alias ...='cd ../..'
alias cursemap="offlineimap -u Curses.Blinkenlight"
alias xev="xev -id `xdotool getactivewindow`"
alias emacs="TERM=xterm emacs -nw -Q"
alias colors='cat  /usr/share/X11/rgb.txt | sort -nr'
alias les='less'
alias vim="vim -X"
alias startx="startx &>/dev/null"
alias gthub="cd $HOME/Arch/Hub"
