setopt nonotify nohup shwordsplit no_bgnice
zmodload zsh/complist
unalias -m '*'
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
#bindkey "\e[A" history-incremental-pattern-search-backward
#bindkey "\e[B" history-incremental-pattern-search-forward
bindkey "^Q" beginning-of-line
bindkey "^E" end-of-line
bindkey "\eOR" clear-screen
bindkey ' ' magic-space

alias -s png=feh
alias -s jpg=feh
alias -s gif=feh
#alias -s conf=$EDITOR
#alias -s pl=vim
#alias -s py=vim

alias -g zsource="source ~/.zshrc"
alias -g :g=' |& /bin/grep -i'
alias -g :n='&> /dev/null'
alias -g :l=' |& less'
alias -g :x=" |& tr '\n' '\0' | xargs -0 "

setopt correct
setopt autolist automenu

setopt autopushd pushdminus pushdtohome pushdignoredups
setopt autocd extendedglob
setopt inc_append_history
#setopt share_history
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt no_case_glob

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
#zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*:(cp|mv|rm|diff|kill):*' ignore-line yes
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:processes' command 'ps -A'
#/By me

zstyle ':completion:*' completer _force_rehash _complete _ignored _correct _approximate _files _prefix
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' menu select=long-list select=0
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

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

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
[[ $TERM != "linux" ]] && print -Pn "\e]2;%N"
}

autoload -U   edit-command-line
zle -N        edit-command-line
bindkey '\ee' edit-command-line


#setopt menucomplete
setopt listtypes
setopt chaselinks
setopt globdots
setopt nomatch
setopt pathdirs
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

hash -d shm="/dev/shm"
hash -d tmp="/tmp/"

#exec 2>>(while read line; do
#  print "$fg[red]ERROR:$fg[blue]${(q)line}$reset_color" > /dev/tty; print -n $'\0'; done &)

setopt short_loops
setopt list_ambiguous 
#setopt rec_exact 
bindkey "^K" kill-whole-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^U" undo

stty -ixon -ixoff
#stty erase ^?
bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char
zstyle ':completion:*' users {raghavendra,root}


zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*:correct:*' original true
zstyle ':completion:*:correct:*'   insert-unambiguous true

hash -d linux=/lib/modules/$(command uname -r)/
hash -d src=/usr/src/linux-$(command uname -r)/

autoload -U predict-on && \
  zle -N predict-on         && \
  zle -N predict-off        && \
  bindkey "^X^Z" predict-on && \
  bindkey "^Z" predict-off

insert-last-typed-word() { zle insert-last-word -- 0 -1 }; \
zle -N insert-last-typed-word; bindkey "\el" insert-last-typed-word

zstyle ':completion:*:*:*:*' list-suffixes yes
zstyle :completion::complete:cd:: tag-order local-directories path-directories

zstyle ':vcs_info:*' disable bzr cdv darcs mtn svk tla hg
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
#zstyle ':acceptline:*' rehash true

zstyle ':completion:*' matcher-list 'm:{A-Z}={a-z}' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
WORDCHARS="${WORDCHARS:s#/#}"
#WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
#
zstyle ':completion:*' glob 'yes'
zstyle ':completion:*' menu select=long-list select=3
source ~/perl5/perlbrew/etc/bashrc
