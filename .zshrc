export ESTATUS=0
setopt PROMPT_SUBST
setopt histignorespace
unalias -m '*'
autoload run-help
HELPDIR=~/.zsh_help
# Lines configured by zsh-newuser-install

HISTFILE=~/.histfile
HISTSIZE=800
SAVEHIST=3000

#setopt appendhistory
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
#
autoload -U colors && colors

#autoload -U promptinit
#promptinit 
#prompt elite
setopt HIST_NO_FUNCTIONS
#PROMPT="%{$fg[blue]%}(%2d)%{$reset_color%}"
PROMPT="%{$fg[blue]%}>=%{$reset_color%}"
#RPROMPT="(%{$fg[red]%}%T%{$reset_color%}-%{$fg[magenta]%}[%?:%!])%{$reset_color%}%"

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
#
setopt sharehistory
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
alias -g zsource="source ~/.zshrc"
alias -g :g=' |& /bin/grep -i'
alias -g :n='&> /dev/null'
alias -g :l=' |& less'
alias -g :x=" |& tr '\n' '\0' | xargs -0 "

setopt correct
setopt autolist automenu

setopt autopushd pushdminus pushdtohome pushdignoredups autocd
setopt inc_append_history
#setopt share_history
#setopt hist_reduce_blanks


#http://bbs.archlinux.org/viewtopic.php?id=34062
setopt listtypes 
export GPG_TTY=`tty`
alias nethack="telnet nethack.alt.org"
setopt listrowsfirst

typeset -U PATH cdpath fpath manpath
eval $(dircolors ~/.zsh/dircolors)

autoload -U insert-unicode-char
zle -N insert-unicode-char
bindkey '^Xi' insert-unicode-char
bindkey '\t' expand-or-complete

# The following lines were added by compinstall
#By me
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*:(cp|mv|rm|diff|kill):*' ignore-line yes
#zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:(cd|cp|vim):*' ignore-parents parent pwd
zstyle ':completion:*:processes' command 'ps auxww'
#/By me

zstyle ':completion:*' completer _force_rehash _complete _ignored _correct _approximate _files _prefix
#zstyle ':completion:*' completer  _prefix _complete _ignored _correct _files _approximate
#zstyle ':completion:*' completer  _prefix _complete  _correct _files 
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' menu select=long-list select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl true
zstyle :compinstall filename '/home/raghavendra/.zshrc'

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

autoload -Uz compinit
compinit
# End of lines added by compinstall

#autoload -Uz bashcompinit
#bashcompinit

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

source ~/.zsh/.zsh_functions
source ~/.zsh/completions
source ~/.zsh/.zsh_aliases
source ~/.zsh/functions
#bash_source ~/.zsh/functions
#bash_source ~/.zsh/apparix.sh
source ~/.zsh/mpc_complete

setopt completealiases
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

setopt completeinword
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*' special-dirs true

#autoload -Uz vcs_info

#function precmd { 
#out=(`dirs | tr ' ' '\n' | xargs -I {} basename {}`)
#RPROMPT="(%{$fg[red]%}%T%{$reset_color%}-%{$fg[blue]%}[%?:$out[1,3]])%{$reset_color%}%"
#[[ $TERM == screen-256color* ]] && print -Pn "\e]2;%N"
#}

# Enable auto-execution of functions.
# http://sebastiancelis.com/2009/nov/16/zsh-prompt-git-users/
#autoload -U ~/.zsh/func/utils/*(:t)

#typeset -ga preexec_functions
#typeset -ga precmd_functions
#typeset -ga chpwd_functions
#
# # Append git functions needed for prompt.
#preexec_functions+='preexec_update_git_vars'
#precmd_functions+='precmd_update_git_vars'
#chpwd_functions+='chpwd_update_git_vars'
#
#
function estatus(){
    local exitS=$ESTATUS
    if [[ $exitS -eq 0 ]];then
        print -n "%{$fg[blue]%}0%{$reset_color%}"
    else
        #printf "%s[%s]%s" "%{$fg[yellow]%}" "$exitS" "%{$reset_color%}"
        print -n "%{$fg[white]%}[$exitS]%{$reset_color%}"
    fi
    return
}

#PROMPT="%{$fg[blue]%}(%2d)%{$reset_color%}"
function precmd(){
export ESTATUS=$?
RPROMPT="%{$fg[blue]%}(%2d)~$(gitprompt)%{$fg[red]%}%T-$(estatus)"
}

autoload -U   edit-command-line
zle -N        edit-command-line
bindkey '\ee' edit-command-line


#setopt menucomplete
setopt listtypes
setopt chaselinks
#setopt globdots
unsetopt nomatch
setopt pathdirs
zstyle ':completion:*:man:*'      menu yes select
zstyle ':completion:*:manuals' separate-sections true
#zstyle ':completion:*:manuals.(^1*)' insert-sections true

hash -d shm="/dev/shm"
hash -d tmp="/tmp/"
hash -d zen="/media/Sentinel/zen/zen/"
#exec 2>>(while read line; do
#  print "$fg[red]ERROR:$fg[blue]${(q)line}$reset_color" > /dev/tty; print -n $'\0'; done &)

setopt short_loops
setopt list_ambiguous 
setopt rec_exact 
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

hash -d module=/lib/modules/$(command uname -r)/
hash -d src=/usr/src/linux-$(command uname -r)/

autoload -Uz predict-on && \
  zle -N predict-on         && \
  zle -N predict-off        && \
  bindkey "^X^Z" predict-on && \
  bindkey "^Z" predict-off

insert-last-typed-word() { zle insert-last-word -- 0 -1 }; \
zle -N insert-last-typed-word; bindkey "\el" insert-last-typed-word

zstyle ':completion:*:*:*:*' list-suffixes yes

zstyle ':vcs_info:*' disable bzr cdv darcs mtn svk tla hg
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
#zstyle ':acceptline:*' rehash true

#zstyle ':completion:*' matcher-list 'm:{A-Z}={a-z}' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
WORDCHARS="${WORDCHARS:s#/#}"
#WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
#
zstyle ':completion:*' glob 'yes'
zstyle ':completion:*' menu select=long-list select=3
#source ~/perl5/perlbrew/etc/bashrc

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' cache-path ~/.zsh/cache
zmodload zsh/complist

zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.hi'

zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters


zstyle :completion::complete:cd:: tag-order local-directories path-directories
#zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
zstyle ':completion:*' max-errors 3 numeric
#setopt print_exit_value
zstyle ':completion:*' toggle true
#predict-on
#
export PS2="%{$fg[yellow]%}=<<%{$reset_color%}"
