unalias run-help
autoload run-help
HELPDIR=~/.zsh_help
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
#
autoload -U colors && colors

#autoload -U promptinit
#promptinit 
#prompt elite

PROMPT="%{$fg[green]%}(%2d)%{$reset_color%}:$"
#RPROMPT="(%{$fg[red]%}%T%{$reset_color%}-%{$fg[blue]%}[%?:%!])%{$reset_color%}%"



bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward
bindkey "\C-W" beginning-of-line
bindkey "\C-E" unix-word-rubout
bindkey "\C-R" end-of-line
bindkey -s "\eOR" $"tput clear\n"
bindkey ' ' magic-space

alias -s png=feh
alias -s jpg=feh
alias -s gif=feh
alias -s conf=$EDITOR
alias -s pl=vim
alias -s py=vim

alias -g zsource="source ~/.zshrc"
alias -g :g=' |& /bin/grep -i'
alias -g :n='&> /dev/null'

setopt correct
setopt autolist automenu

setopt autopushd pushdminus pushdtohome pushdignoredups
setopt autocd extendedglob
unsetopt caseglob
setopt inc_append_history
#setopt share_history
setopt hist_ignore_dups
setopt hist_reduce_blanks
unsetopt caseglob

unsetopt clobber
setopt multios

#http://bbs.archlinux.org/viewtopic.php?id=34062
setopt listtypes 
export GPG_TTY=`tty`
alias nethack="telnet nethack.alt.org"
setopt listrowsfirst

typeset -U path cdpath fpath manpath

autoload -U insert-unicode-char
zle -N insert-unicode-char
bindkey '^Xi' insert-unicode-char

# The following lines were added by compinstall
#By me
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*:(cp|mv|rm):*' ignore-line yes
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:processes' command 'ps -A'
#/By me

zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl true
zstyle :compinstall filename '/home/raghavendra/.zshrc'

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -Uz bashcompinit
bashcompinit

source ~/.zsh/.zsh_functions
source ~/.zsh/completions
bash_source ~/.zsh/.zsh_aliases
bash_source ~/.zsh/functions
bash_source ~/.zsh/apparix.sh
source ~/.zsh/mpc_complete

setopt completealiases
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

setopt completeinword
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' special-dirs true

#autoload -Uz vcs_info

function precmd { 
out=(`dirs | tr ' ' '\n' | xargs -I {} basename {}`)
RPROMPT="(%{$fg[red]%}%T%{$reset_color%}-%{$fg[blue]%}[%?:$out[1,3]])%{$reset_color%}%"
}

autoload -U   edit-command-line
zle -N        edit-command-line
bindkey '\ee' edit-command-line


setopt menucomplete
setopt listtypes
setopt chaselinks
setopt globdots
setopt nomatch
setopt pathdirs
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
