# vim: set ft=sh :et
export BROWSER=firefox
#export DMENU="$HOME/bin/dmenu/dmenu -i -l 3 -nb #303030 -nf black -sb #303030 -p :"
export DMENU="$HOME/bin/dmenu -p : -i -l 5 -nb black -nf white -sb purple"
export PATH="$HOME/bin:$PATH"
export VIMRUNTIME="/usr/share/vim/vim72"
export GDK_USE_XFT=1
export VISUAL="vim"
export EDITOR="vim"
export WINEDEBUG=-all
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export CSCOPE_DB="/home/raghavendra/Arch/cscope/cscope.out"
#export PAGER="vimpager"
#alias less="vimpager"
export PAGER="less"
#export LD_PRELOAD="/usr/lib/libtcmalloc_minimal.so"
export LESS="-R -i -M -s -S -F -X"
#export PERL5LIB=/usr/share/perl5/vendor_perl/Any



function flushmac(){
rm -rf /home/raghavendra/.macromedia/Flash_Player/*;
mkdir -p ~/.macromedia/Flash_Player/macromedia.com/support/flashplayer/sys
cp ~/Arch/settings.sol ~/.macromedia/Flash_Player/macromedia.com/support/flashplayer/sys/
}

bash_source() {
  alias shopt=':'
  alias _expand=_bash_expand
  alias _complete=_bash_comp
  emulate -L sh
  setopt kshglob noshglob braceexpand
  source "$@"
}

export MOZ_DISABLE_PANGO=1
