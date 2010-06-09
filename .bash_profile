
[ -f /etc/profile ] && . /etc/profile
[ -f $HOME/Arch/etc/profile ] && . $HOME/Arch/etc/profile
. $HOME/.bashrc

#set -u
export LOCKDIR="/tmp/locks"
mkdir -p $LOCKDIR
unset MAILCHECK
#export PS1='\W\$'
export MPSOCKET="/tmp/mplayer.fif"
export LOCK="/usr/sbin/setlock -X -n $LOCKDIR" 
ulimit -c unlimited

flushmac &
[ -e $MPSOCKET ] || mkfifo $MPSOCKET
$LOCK/polipo polipo -c ~/.poliporc &>/dev/null &

$LOCK/emacs /usr/bin/emacs --daemon &>/dev/null &
pidof ssh-agent &>/dev/null || eval `/usr/bin/ssh-agent`
pidof gpg-agent &>/dev/null || eval "$(gpg-agent --daemon)"
$LOCK/aria2c  aria2c -D -d $HOME/Downloads -U Opera --enable-xml-rpc &>/dev/null &

