# Alias definitions.
# ~/.bash_aliases, instead of adding them here directly.
#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
alias uattach='screen -d -r uake'
#http://alicious.com/2008/piping-ls-through-less-with-colors/
alias ls='ls --color=always'
alias tiddly='google-chrome --enable-file-cookies "/home/raghavendra/Pwiki/empty.html"'
#alias screen='screen -dRR'
#alias rm='rm -i'
alias archie='ssh -p 2222 raghu@localhost'
alias grep='LC_ALL="C" grep -i'
#alias grep='grep -i'
#alias mv='ionice -c3 mv -v'
alias shownice='ps -eo nice,command | tail +1 | sort -n -k 1'
# some more ls aliases
alias idden='ls -ld \.*'
alias aria="aria2c --file-allocation=falloc --enable-direct-io=true "
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
#alias ins='sudo pacman-color -S'
alias df='df -h'
alias du='du -sh'
alias d='cd ~/Desktop'
alias c='clear'
alias off='xset dpms force off'
#alias tclear='find ~/.thumbnails -type f -atime +7 -exec rm {} \;'
alias aur='yaourt -S'
alias aurs='yaourt -Ss'
alias ofd='top -b -n 1 | head -12 | tail --lines=+8'
alias lsd='ls -d */'
alias pacman='pacman-color'
#alias myip='upnpc -s | grep External | cut -d "=" -f 2'
alias rcm="sudo /etc/rc.d"
alias pinfo='pacman -Qi'
alias frames='/usr/bin/mplayer -vo jpeg -sstep 0'
alias locate='/usr/bin/locate -i'
alias mitter='mitter -u randomsurfer -p -i cmd -s'
alias sdown='echo "sure?"; read; shutdown -h now'
alias getweather='weatherget -s INXX0012 -m'
#calias cnkt='TERM=xterm; ssh rprabhu@proxy.eglbp.corp.yahoo.com -L 6891:socks.yahoo.com:1080'
#alias torrent="screen -S torrent rtorrent"
alias pal="pacman -Ql "
alias redradio="mplayer -playlist http://radioreddit.com:8000/listen.pls"
alias showtorrent="aria2c -S "
alias wget="wget -c --content-disposition"
#alias wget="trickle wget"
#i
#
#
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=always'
fi
alias tmp="cd /tmp/"
#alias +='pushd .'
#alias -='popd .'
alias ..='cd ..'
alias ...='cd ../..'
alias cursemap="offlineimap -u Curses.Blinkenlight"
#alias xev="xev -id `xdotool getactivewindow`"
alias sendmail="msmtp -C $HOME/wormole/.msmtprc"
#alias emacs="TERM=xterm emacs -nw"
alias emacs="emacsclient"
alias colors='cat  /usr/share/X11/rgb.txt | sort -nr'
alias les='less'
alias vim="vim -X"
alias startx="startx &>~/logs/X.log"
#alias view="apvlv "
#alias cscope="cscope -d"
alias gthub="cd $HOME/Arch/Hub"
alias psync='sudo pacman -Sy'
alias build="cd ~/Arch/Build/"
