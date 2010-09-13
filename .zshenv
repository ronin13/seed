setopt no_global_rcs
setopt nonotify nohup shwordsplit no_bgnice
setopt no_case_glob
setopt multios
setopt  extendedglob
unsetopt clobber


autoload -U zen
#zen update
#cdpath=( $cdpath ~/  /media/ /dev/ /var/ ~/Arch/ ~/.config/ )
#fpath=( ~/.zsh/func/ ~/.zsh/func/utils/ $fpath /home/raghavendra/.zen/zsh/scripts  /home/raghavendra/.zen/zsh/zle )
fpath=( ~/.zsh/func/ $fpath /home/raghavendra/.zen/zsh/scripts  /home/raghavendra/.zen/zsh/zle )
