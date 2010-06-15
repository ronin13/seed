# vim:set ft=zsh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
eval `dircolors -b`

zmodload zsh/complist 
export PAGER="vimpager"
setopt autopushd pushdminus pushdtohome pushdignoredups
setopt appendhistory autocd extendedglob
setopt inc_append_history
setopt hist_verify
setopt share_history
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_expire_dups_first

unsetopt CASE_GLOB
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/raghavendra/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#PROMPT="$"
PROMPT='[%!]%$ '
RPROMPT='(%T - [%d])'
zstyle ':completion:*' special-dirs true
setopt CORRECT
setopt AUTO_LIST AUTO_MENU
setopt NO_BG_NICE NO_NOTIFY
setopt NO_HUP

zstyle ':completion:*' menu select
#prompt walters
source ~/.bash_aliases
source ~/bin/functions

bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward
bindkey "\C-W" beginning-of-line
bindkey "\C-E" unix-word-rubout
bindkey "\C-R" end-of-line
#bindkey "\eOR" "tput clear\C-M"

alias -s png=feh
alias -s jpg=feh
alias -s gif=feh
alias -s PKGBUILD=$EDITOR
alias -s pl=vim
alias -s py=vim


zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

zstyle ':completion:*:(cp|mv|rm):*' ignore-line yes
zstyle ':completion::complete:*' use-cache on

autoload -U   edit-command-line
zle -N        edit-command-line
bindkey '\ee' edit-command-line

