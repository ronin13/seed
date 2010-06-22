setopt nonotify nohup shwordsplit no_bgnice
[ -f /etc/profile ] && source /etc/profile
[ -f $HOME/Arch/etc/profile ] && . $HOME/Arch/etc/profile
export LOCKDIR="/tmp/locks"
mkdir -p $LOCKDIR
unset MAILCHECK
export MPSOCKET="/tmp/mplayer.fif"
export LOCK="/usr/sbin/setlock -X -n $LOCKDIR" 
ulimit -c unlimited
limit coredumpsize 10m

flushmac &
[ -e $MPSOCKET ] || mkfifo $MPSOCKET

pidof ssh-agent &>/dev/null || eval `/usr/bin/ssh-agent`
pidof gpg-agent &>/dev/null || eval "$(gpg-agent --daemon)"
$LOCK/aria2c  aria2c -D -d $HOME/Downloads -U Opera --enable-xml-rpc &>/dev/null &
