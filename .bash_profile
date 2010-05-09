
. $HOME/.bashrc
[ -f /etc/profile ] && . /etc/profile
[ -f $HOME/Arch/etc/profile ] && . $HOME/Arch/etc/profile

export LOCKDIR="/tmp/locks"
mkdir -p $LOCKDIR

export PS1='\W\$'
export MPSOCKET="/tmp/mplayer.fif"
export LOCK="/usr/sbin/setlock -x -n $LOCKDIR" 

flushmac
[ -e $MPSOCKET ] || mkfifo $MPSOCKET

pidof -s ssh-agent &>/dev/null || eval `/usr/bin/ssh-agent`
$LOCK/aria2c  aria2c -D -d $HOME/Downloads -U Opera --enable-xml-rpc

