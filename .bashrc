# If not running interactively, don't do anything
[ -z "$PS1" ] && return
#export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth
shopt -s checkwinsize
shopt -s histappend
. ~/.bash_colors
PS1="\[$bldblu\]\t \[$bldcyn\]\W\[$txtrst\]\$"

stty erase ^?
stty -echoctl
if [ -f ~/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi
source $HOME/bin/functions
stty -ixon -ixoff
eval `dircolors -b`

complete -cf sudo
set completion-ignore-case on 
set visible-stats on 
shopt -s no_empty_cmd_completion 
shopt -s cmdhist 
shopt -s cdspell
shopt -s checkwinsize

#autocd
shopt -s autocd
set +m
export HISTTIMEFORMAT="%F %T "
export INPUTRC=/etc/inputrc

shopt -s extglob
. /etc/profile.d/apparix.sh
. $HOME/bin/mpc_complete
PROMPT_COMMAND='history -a'
