export ESTATUS=0
export TIMEDOUT=0
export INGIT=0
export GPRT=">>"
export GITPRMPT=""
setopt PROMPT_SUBST
setopt histignorespace
unalias -m '*'
autoload run-help
HELPDIR=~/.zsh_help

HISTFILE=~/.histfile
HISTSIZE=800
SAVEHIST=8000

unsetopt beep
bindkey -e

autoload -U colors && colors
setopt HIST_NO_FUNCTIONS

bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward
#bindkey "\e[A" history-incremental-pattern-search-backward
#bindkey "\e[B" history-incremental-pattern-search-forward
bindkey "^Q" beginning-of-line
bindkey "^E" end-of-line
bindkey "\eOR" clear-screen
bindkey ' ' magic-space

recover-line() {
    LBUFFER=$ZLE_LINE_ABORTED
    RBUFFER=
}
zle -N recover-line
bindkey "\e[1;5A" recover-line

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
alias -g .g=' |& /bin/grep -i '
alias -g .l=' |& less'
alias -g .x=" |& tr '\n' '\0' | xargs -0 "

setopt correct
setopt autolist #automenu

setopt autopushd pushdminus pushdtohome autocd pushdignoredups
setopt inc_append_history
#setopt share_history
#setopt hist_reduce_blanks


#http://bbs.archlinux.org/viewtopic.php?id=34062
setopt listtypes 
export GPG_TTY=$TTY
#alias nethack="telnet nethack.alt.org"
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
#zstyle ':completion:*:(cp|mv|rm|diff|kill):*' ignore-line yes
#zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:(cd|cp|vim):*' ignore-parents parent pwd
zstyle ':completion:*:processes' command 'ps auxww'
#/By me

#zstyle ':completion:*' completer _complete _ignored _correct _approximate _files _prefix
zstyle ':completion:*' completer _complete _correct _complete:-extended _complete:-substring _prefix _files
#zstyle ':completion:*:complete-extended:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[+._-]=*'
#zstyle ':completion:*:complete-substring:*' matcher-list 'm:{a-z}={A-Z} l:|=**'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


#zstyle ':completion:*' completer  _prefix _complete _ignored _correct _files _approximate
#zstyle ':completion:*' completer  _prefix _complete  _correct _files 
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=long-list select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl true
zstyle :compinstall filename '/home/raghavendra/.zshrc'

#autoload -U url-quote-magic
#zle -N self-insert url-quote-magic

autoload -Uz compinit
compinit

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

source ~/.zsh/.zsh_aliases
source ~/.zsh/completions
source ~/bin/functions
source ~/.zsh/mpc_complete
source ~/.zsh/live-command-coloring.sh

setopt completealiases
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

setopt completeinword
zstyle ':completion:*' special-dirs true

function estatus(){
    local exitS=$ESTATUS
    if [[ $exitS -eq 0 ]];then
        print -n "%{$fg[blue]%}0%{$reset_color%}"
    else
        print -n "%{$fg[white]%}[$exitS]%{$reset_color%}"
    fi
    return
}

#function gprompt(){
    #[[ $TIMEDOUT == 0 ]] && GITPRMPT=$(timeout -k 10 -s INT 4 gitprompt)
    #if [[ $TIMEDOUT != 2 && ($? == 124 || $? == 1) ]];then
        #TIMEDOUT=1
        #coproc gitprompt
    #elif [[ $TIMEDOUT == 1 ]];then
        #GITPRMPT=$(read -p 2>/dev/null)
    #else
        #TIMEDOUT=2
    #fi
#}

function gprompt(){
    GITPRMPT=$(gitprompt)
    if [[ $? == 124 || $? == 1 ]];then
        TIMEDOUT=1
    else
        TIMEDOUT=0
    fi
}

function precmd(){
    ESTATUS=$?
    if [[ $(fc -n -l -1) == git* || $TIMEDOUT == 1 ]];then 
        gprompt
    fi
    PROMPT="%{$fg[green]%}${GPRT}%{$reset_color%}"
    RPROMPT="%{$fg[green]%}(%2d)~${GITPRMPT}%{$fg[red]%}%T-$(estatus)"
    #builtin cd ~+
}

function refresh() {
    builtin cd ~+
}

autoload -U   edit-command-line
zle -N        edit-command-line
bindkey '\ee' edit-command-line


#function switch_off(){
    #xset dpms force off || sudo vbetool dpms off
#}
#zle -N switch_off
#bindkey '^O' switch_off

setopt listtypes
setopt chaselinks
#setopt globdots
setopt pathdirs
zstyle ':completion:*:man:*'      menu yes select
zstyle ':completion:*:manuals' separate-sections true
#zstyle ':completion:*:manuals.(^1*)' insert-sections true

hash -d shm="/dev/shm"
hash -d tmp="/tmp/"
hash -d zen="/home/raghavendra/Arch/Build/zen/zen/"

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

hash -d module=/lib/modules/$(command uname -r)/
hash -d src=/usr/src/linux-$(command uname -r)/

autoload -Uz predict-on && \
zle -N predict-on         && \
zle -N predict-off        && \
bindkey "^X^Z" predict-on && \
bindkey "^Z" predict-off
zstyle ':predict' verbose true

insert-last-typed-word() { zle insert-last-word -- 0 -1 }; \
zle -N insert-last-typed-word; bindkey "\el" insert-last-typed-word

zstyle ':completion:*:*:*:*' list-suffixes yes

zstyle ':vcs_info:*' disable bzr cdv darcs mtn svk tla hg
#zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
zstyle ':acceptline:*' rehash true

#zstyle ':completion:*' matcher-list 'm:{A-Z}={a-z}' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
WORDCHARS="${WORDCHARS:s#/#}"
#WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
#
zstyle ':completion:*' glob 'yes'
# duplication i guess
#zstyle ':completion:*' menu select=long-list select=3
#source ~/perl5/perlbrew/etc/bashrc

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' cache-path ~/.zsh/cache
zmodload zsh/complist

zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' '*?.hi'

#zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

zstyle :completion::complete:cd:: tag-order local-directories path-directories
#zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
zstyle ':completion:*' max-errors 3 numeric
#setopt print_exit_value
zstyle ':completion:*' toggle true
#redict-on
#
export PS2="%{$fg[yellow]%}=<<%{$reset_color%}"
alias -g .n='&>/dev/null'
alias -g .h='&>/dev/null &'

setopt menucomplete
#setopt automenu

# http://www.bewatermyfriend.org/posts/2007/12-26.11-50-38-tooltime.html
zstyle ':acceptline:empty' call_default false
zstyle ':acceptline:*' nocompwarn true
#zstyle ':acceptline:*' rehash true
setopt nomultibyte

run-with-sudo () { LBUFFER="sudo $LBUFFER" }
zle -N run-with-sudo
bindkey '^X' run-with-sudo

# http://www.zsh.org/mla/users/2008/msg00475.html
zstyle ':completion:*' accept-exact-dirs true
# :completion:FUNCTION:COMPLETER:COMMAND-OR-MAGIC-CONTEXT:ARGUMENT:TAG
#--------------------------------
#http://ft.bewatermyfriend.org/comp/zshtalk.html
#: ${(AA)zopt:=${(z)${(ps:=:)${(f)$(<configfile)}}}}
#TRAPDEBUG() { echo $funcfiletrace }
#you can look them up with "ctrl-x, h" -- tags
# http://github.com/ngnostrings/zsh/blob/master/zsh_apparix
setopt HASH_CMDS


#http://www.xsteve.at/prg/zsh/.zshrc and irc
zstyle ':completion:*' file-sort modification

function magic-dot()
{
    if [[ $LBUFFER = *. ]]; then
    LBUFFER+=./
    display-path $LBUFFER
    elif [[ $LBUFFER = *../ ]]; then
    LBUFFER+=../
    display-path $LBUFFER
    else
    zle self-insert
    fi
}
zle -N magic-dot

alias time='command time'

function gitdir(){
#[[ $(tmux list-panes | wc -l) < 2 ]] && tmux split-window -p 20 -d 'exec tig'
}

function tig()
{
    tmux split-window -p 40 -d 'exec tig'
}

function chpwd(){
    #[[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true ]] && gitdir 
    # Also do tree comparison here 
    if [[ $INGIT == 0 ]]  && test  (../)#.git(N) 2>/dev/null;then
        gprompt
        gitdir 
        INGIT=1
    else
        GITPRMPT=""
        INGIT=0
    fi
    TIMEDOUT=0
    #GPRT=$(pwd | tr -cd '/' | tr '/' '>')
}


[[ -s ~/.zsh/profiles ]] && source ~/.zsh/profiles

CHPWD_PROFILE='default'
function chpwd_profiles() {
     local -x profile

    zstyle -s ":chpwd:profiles:${PWD}" profile profile || profile='default'
    if (( ${+functions[chpwd_profile_$profile]} )) ; then
        chpwd_profile_${profile}
     fi
    CHPWD_PROFILE="${profile}"
     return 0
}
chpwd_functions=( ${chpwd_functions} chpwd_profiles )

# All zstyle stuff here 
#   # zstyle ':chpwd:profiles:/usr/src/grml(|/|/*)'   profile grml
# function chpwd_profile_grml() {
#     [[ ${profile} == ${CHPWD_PROFILE} ]] && return 1
#       print "chpwd(): Switching to profile: $profile"


#zstyle ':chpwd:profiles:~/.perlbrew(|/|/*)' profile brew
zstyle ':chpwd:profiles:(*Build*src*|*ccache*|/dev/shm*)' profile ccache
zstyle ':chpwd:profiles:(*Downloads|*Documents)(|/|/*)' profile downloads

#zstyle ':chpwd:profiles:../$PWD:t/.git(|/|/*)' profile git
#zstyle ':chpwd:profiles:../$PWD:t/.git(|/|/*)' profile git

export HISTIGNORE="[bf]g:exit:reset:clear"

autoload -U zsh-mime-setup
zstyle ':mime:*' mailcap ~/.mailcap
zsh-mime-setup

