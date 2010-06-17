# vim:set ft=zsh
unset MAILCHECK

_compdir=""
zstyle :compinstall filename '/home/raghavendra/.zshrc'
autoload -Uz compinit
compinit

autoload -Uz bashcompinit
bashcompinit

source ~/.zsh/.zsh_functions
bash_source ~/.zsh/.zsh_aliases
bash_source ~/.zsh/functions
bash_source /etc/profile.d/apparix.sh
bash_source ~/bin/mpc_complete

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
eval `dircolors -b`

zmodload zsh/complist 
#export PAGER="vimpager"
setopt autopushd pushdminus pushdtohome pushdignoredups
setopt appendhistory autocd extendedglob
setopt inc_append_history
setopt hist_verify
setopt share_history
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_expire_dups_first

unsetopt caseglob
unsetopt beep
bindkey -e


# http://www.nparikh.org/unix/prompt.php
autoload -U colors && colors
PROMPT="%{$fg[green]%}(%2d)%{$reset_color%}:$"
RPROMPT="(%{$fg[red]%}%T%{$reset_color%}-%{$fg[blue]%}[%?:%!])%{$reset_color%}%"

zstyle ':completion:*' special-dirs true
setopt correct
setopt complete_in_word  
setopt always_to_end  
#setopt AUTO_LIST AUTO_MENU
setopt no_bgnice nonotify
setopt nohup
unsetopt clobber

zstyle ':completion:*' menu select

bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward
bindkey "\C-W" beginning-of-line
bindkey "\C-E" unix-word-rubout
bindkey "\C-R" end-of-line
bindkey -s "\eOR" $"tput clear\n"

alias -s png=feh
alias -s jpg=feh
alias -s gif=feh
alias -s PKGBUILD=$EDITOR
alias -s conf=$EDITOR
alias -s pl=vim
alias -s py=vim
alias -g G=' |& /bin/grep -i'

zstyle ':completion:*:processes' command 'ps -A'
zstyle ':completion:*' matcher-list 'm:{A-Z}={a-z}' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always
setopt CHASE_LINKS 

#autoload -U url-quote-magic
#zle -N self-insert url-quote-magic

zstyle ':completion:*:(cp|mv|rm):*' ignore-line yes
#zstyle ':completion::complete:*' use-cache 1
#zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' accept-exact '*(N)'

zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:cd:*' ignore-parents parent pwd
setopt multios

autoload -U   edit-command-line
zle -N        edit-command-line
bindkey '\ee' edit-command-line

setopt AUTO_NAME_DIRS
hash -d shm="/dev/shm"
hash -d tmp="/tmp/"

DIRSTACKSIZE=50
limit coredumpsize 10m
