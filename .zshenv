setopt no_global_rcs
setopt lmlone
setopt nullglob
setopt chase_links
#setopt nohup shwordsplit no_bgnice
setopt nohup no_bgnice
#setopt nomonitor
setopt no_case_glob
setopt multios
setopt  extendedglob
unsetopt clobber
#alias -g .n='&>/dev/null'
#alias -g .h='&>/dev/null &'
autoload -U zen
#zen update
#cdpath=( $cdpath ~/  /media/ /dev/ /var/ ~/Arch/ ~/.config/ )
#fpath=( ~/.zsh/func/ ~/.zsh/func/utils/ $fpath /home/raghavendra/.zen/zsh/scripts  /home/raghavendra/.zen/zsh/zle )
#fpath=( ~/.zsh/func/ $fpath ~/.zen/zsh/scripts  ~/.zen/zsh/zle )
fpath=( ~/.zsh/func/ $fpath )


