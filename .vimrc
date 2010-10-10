"http://vimdoc.sourceforge.net/cgi-bin/vimfaq2html3.pl#23.5
"noremap <C-w> <Nop>
let g:fakeclip_no_default_key_mappings = 1
scriptencoding utf-8

"filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles() 
cmap w!! w !sudo tee % >/dev/null
"filetype off
"filetype plugin indent on


filetype on
filetype indent on
filetype plugin on                      " Enable filetype plugins
filetype plugin indent on               " Let filetype plugins indent for me
syntax on                               " Turn on syntax highlighting
set sidescroll=5
set sidescrolloff=5
nnoremap <F1> :wq<CR>
inoremap <F1> <ESC>:wq<CR>
"autocmd!

"set runtimepath=~/.vim,/usr/share/vim/vim73,/usr/share/vim/vimfiles,/usr/share/vim/vimfiles/after
"set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
"/home/raghavendra/.vim,/usr/share/vim/vim72/vimfiles,/usr/share/vim/vim72,/usr/share/vim/vim72/vimfiles/after,/home/raghavendra/.vim/after
set linebreak
"set nocompatible
"" http://amix.dk/vim/vimrc.html
set magic
set wrapscan
"set t_Co=256
"let mapleader = ","
set mouse-=a
" work more logically with wrapped lines
noremap j gj
noremap k gk
set ruler
set title
set backup
"set dictionary+=/usr/share/dict/words
set shortmess=aOstT
"set cmdheight=2
set backupdir=~/.vim-tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,/var/tmp,/tmp
set backspace=indent,eol,start
"""" Searching and Patterns
set ignorecase							" search is case insensitive
set smartcase							" search case sensitive if caps on 

" http://nvie.com/posts/how-i-boosted-my-vim/
set shiftround
set smarttab
:set visualbell t_vb=
set noerrorbells         " don't beep
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting

set incsearch							" show best match so far
set hlsearch							" Highlight matches to the search 
set diffopt+=iwhite 
"""" Display
set lazyredraw							" Don't repaint when scripts are running
set scrolloff=3							" Keep 3 lines below and above the cursor
set numberwidth=1						" Use 1 col + 1 space for numbers
" tab labels show the filename without path(tail)

set guitablabel=%N/\ %t\ %M
colorscheme mypeaksea
"colorscheme wombat
"colorscheme desert256
"colorscheme candycode 
set background=dark

"""" Messages, Info, Status
set shortmess+=a						" Use [+] [RO] [w] for modified, read-only, modified
set showcmd								" Display what command is waiting for an operator
set laststatus=2						" Always show statusline, even if only 1 window
set report=0							" Notify me whenever any lines have changed
set confirm								" Y-N-C prompt if closing with unsaved changes
set vb t_vb=							" Disable visual bell!  I hate that flashing.

"""" Editing
""set backspace=2							" Backspace over anything! (Super backspace!)
set showmatch							" Briefly jump to the previous matching paren
set matchtime=2							" For .2 seconds
set formatoptions-=tc					" I can format for myself, thank you very much
set textwidth=80
set tabstop=4							" Tab stop of 4
set shiftwidth=4						" sw 4 spaces (used on auto indent)
set softtabstop=4						" 4 spaces as a tab for bs/del
set expandtab
set hidden
" we don't want to edit these type of files
""=========================================================================

"""" Coding
set history=1000							" 100 Lines of history
set showfulltag							" Show more information while completing tags


set foldmethod=marker

set wildmenu                            " Autocomplete features in the status bar
set wildmode=list:longest,full
"au BufRead,BufNewFile .followup,.article,.letter,/tmp/pico*,nn.*,snd.*,~/.mutt/temp/* :set ft=mail
" mail from http://cedricduval.free.fr/download/mail.vim
autocmd BufRead,BufNewFile ~/.mutt/temp/*,.followup,.article,.letter :source ~/.vim/mail.vim
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.swp

let g:pydiction_location = '$HOME/Arch/vim/pydiction/complete-dict'
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <C-F12> :!ctags -R .<CR>

"set omnifunc=
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
""================================================================================================================
""
" In plain-text files and svn commit buffers, wrap automatically at 78 chars
au FileType text,svn setlocal tw=78 fo+=t

" In all files, try to jump back to the last spot cursor was in before exiting
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif

" Use :make to check a script with perl
au FileType perl set makeprg=perl\ -c\ %\ $* errorformat=%f:%l:%m
au FileType perl set tags +=~/.vim/tags/perl.ctags

" Use :make to compile c, even without a makefile
au FileType c,cpp if glob('Makefile') == "" | let &mp="gcc -o %< %" | endif

" Switch to the directory of the current file, unless it's a help file.
au BufEnter * if &ft != 'help' | silent! cd %:p:h | endif

" Insert Vim-version as X-Editor in mail headers
"au FileType mail sil 1  | call search("^$")
"			 \ | sil put! ='X-Editor: Vim'

" smart indenting for python
au FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" allows us to run :make and get syntax errors for our python scripts
au FileType python set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
au FileType python set tags +=~/.vim/tags/python.ctags
" setup file type for code snippets
au FileType python if &ft !~ 'django' | setlocal filetype=python.django_tempate.django_model | endif
au FileType python set expandtab

" kill calltip window if we move cursor or leave insert mode

au FileType vim set tags+=~/.vim/tags/vim.ctags
""========================================================================================================

" Toggle the tag list bar
nmap <F5> :TlistToggle<CR>

if &term == "screen-256color" || &term == "xterm-256color"
    map [1;3C <A-right>
    map [1;3D <A-left>
    map ^[[1;5A <C-up>
    map [1;5B <C-down>
    map [1;5D <C-left>
    map [1;5C <C-right>
    map [1;2D <S-left>
    map [1;2C <S-right>
    map [1;2A <S-up>
    map [1;2B <S-down>
    map ^[[H <Home>
endif

nnoremap <Home><Home> :q<CR>
"nnoremap  :q!<CR>
" tab navigation (next tab) with alt left / alt right
nnoremap  <A-Right>  gt
nnoremap  <A-Left>   gT
inoremap  <A-Right>  gt
inoremap  <A-Left>   gT
" Ctrl + Arrows - Move around quickly
nnoremap  <C-up>     {
nnoremap  <C-down>   }
nnoremap <C-left>    (
nnoremap <C-right>   )
"nnoremap  <C-right>  El
"nnoremap  <C-left>   Bh

" Shift + Arrows - Visually Select text
"nnoremap  <s-up>     Vk
"nnoremap  <s-down>   Vj
"nnoremap  <s-right>  vl
"nnoremap  <s-left>   vh


if &diff
" easily handle diffing
   set cmdheight=2
   colorscheme mypeaksea
   noremap < :diffget<CR>
   noremap > :diffput<CR>
else
" visual shifting (builtin-repeat)
   vnoremap < <gv
   vnoremap > >gv
endif

" Extra functionality for some existing commands:
" <C-6> switches back to the alternate file and the correct column in the line.
nnoremap <C-6> <C-6>`"

" CTRL-g shows filename and buffer number, too.
nnoremap <C-g> 2<C-g>

" Arg!  I hate hitting q: instead of :q
nnoremap q: q:iq<esc>

" <C-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Q formats paragraphs, instead of entering ex mode
"noremap Q gq

" * and # search for next/previous of selected text when used in visual mode
vnoremap * y/<C-R>"<CR>
vnoremap # y?<C-R>"<CR>

" <space> toggles folds opened and closed
nnoremap <space> za

" <space> in visual mode creates a fold over the marked range
vnoremap <space> zf


""" Abbreviations
function! EatChar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc


nnoremap <F3> :BufExplorer<CR>
let g:BASH_AuthorName   = 'Raghavendra D Prabhu'
let g:BASH_Email        = "raghu dot prabhu 13 AT google's mail service"
"let $LOGNAME            = "Raghavendra"
"let $TZ                 = "IST"
"let g:rvSaveDirectoryType = 1
"let g:rvSaveDirectoryName = "/home/raghavendra/Arch/vim/.rcs/"
"let g:rvDirSeparator = "/"
"let g:rvRlogOptions = '-zLT'

command DiffOrig vertical new | set buftype=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
nnoremap <leader>do :DiffOrig


:setlocal spell spelllang=en
set spellfile=~/.vim/spellfile.add


"noremap <M-Down> ]s
"noremap <M-Up> [s

nnoremap <C-w><Up>  <C-w>k
nnoremap <C-w><Down>  <C-w>j
nnoremap <C-w><Right>  <C-w>l
nnoremap <C-w><Left>  <C-w>h

" Not doing this -- too confusing
nnoremap Q @q

nnoremap v V
nnoremap V v
inoremap <C-Del> <C-\><C-O>D
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabRetainCompletionDuration = "session"

function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-N>"
   endif
endfunction

inoremap <Tab> <C-R>=CleverTab()<CR>
map <leader>s :silent SuperTabHelp<CR>
set nospell

"au BufRead,BufNewFile *.viki set ft=viki

nnoremap <silent> <PageUp> 1000<C-U>
nnoremap <silent> <PageDown> 1000<C-D>
inoremap <silent> <PageUp> <C-O>1000<C-U>
inoremap <silent> <PageDown> <C-O>1000<C-D>
set nostartofline

"nnoremap <C-L> gqap
nnoremap <C-f> gqap

"use :set list! to toggle visible whitespace on/off
"set list
set listchars=tab:>-,trail:.,extends:>


highlight RedundantSpaces term=standout ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted

"nnoremap <BS> <Left><Del>
nmap <BS> db
au CursorHoldI * stopinsert
" set 'updatetime' to 15 seconds when in insert mode
au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
au InsertLeave * let &updatetime=updaterestore
nnoremap <silent> <leader>r :YRShow<CR> 
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
set wrap
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

let g:yankring_history_dir="~/.vim-tmp/"
autocmd FocusLost * wall

"autocmd BufWritePost * let test=fugitive#statusline() if test
set statusline= " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\ " buffer number
set statusline+=%f\ " file name
set statusline+=%h%m%r%w " flags
set statusline+=[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}] " file format
"set statusline+= [%{cfi#format('[%s()]', 'no function')}]
set statusline+=\ [%{cfi#get_func_name()}]
set statusline+=%= " right align
set statusline+=%{fugitive#statusline()}
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\ " highlight
" set statusline+=%b,0x%-8B\ " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset
"set statusline=%<%04n\ %t%(\ %m%r%y[%{&ff}][%{&fenc}]\ \ %{mode()}%)\ %a%=\ col\ %v\ \ line\ %l/%L\ %p%%
" To turn off yankring if needed 
let g:yankring_enabled = 1

autocmd BufReadPost *.doc silent %!antiword "%"
"autocmd BufReadPost *.odt,*.odp silent %!odt2txt "%"
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
autocmd BufReadPost *.rtf silent %!unrtf --text "%"
autocmd BufWriteCmd *.pdf set readonly

" Nice one
"autocmd BufWritePre * :%s/\s+$//e
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction
ca shell Shell
au BufEnter *.tex set nosmartindent

"http://vim.wikia.com/wiki/Par_text_reformatter
set equalprg=par

"let g:ScreenImpl = "Tmux"

function ToggleOverLengthHi()
    if exists("b:overlengthhi") && b:overlengthhi
        highlight clear OverLength
        let b:overlengthhi = 0
        echo "overlength hilight off"
    else
        " adjust colors/styles as desired
        highlight OverLength ctermbg=darkred gui=undercurl guisp=blue
        " change '81' to be 1+(number of columns)
        match OverLength /\%81v.\+/
        let b:overlengthhi = 1
        "echo "overlength hilight on"
    endif
endfunction

function CommitOnwrite()
    let l:isgit = fugitive#statusline()
    if ! empty(l:isgit) && &modified
        "return l:isgit
        :VCSCommit
    endif
endfunction

"au BufWritePre * :call CommitOnwrite()
autocmd filetype python,perl,c,css :call ToggleOverLengthHi()

if !has('clipboard')
    for _ in ['+', '*']
        execute 'nmap "'._.'y  <Plug>(fakeclip-y)'
        execute 'nmap "'._.'Y  <Plug>(fakeclip-Y)'
        execute 'nmap "'._.'yy  <Plug>(fakeclip-Y)'
        execute 'vmap "'._.'y  <Plug>(fakeclip-y)'
        execute 'vmap "'._.'Y  <Plug>(fakeclip-Y)'
        execute 'nmap "'._.'p  <Plug>(fakeclip-p)'
        execute 'nmap "'._.'P  <Plug>(fakeclip-P)'
        execute 'nmap "'._.'gp  <Plug>(fakeclip-gp)'
        execute 'nmap "'._.'gP  <Plug>(fakeclip-gP)'
        execute 'nmap "'._.']p  <Plug>(fakeclip-]p)'
        execute 'nmap "'._.']P  <Plug>(fakeclip-]P)'
        execute 'nmap "'._.'[p  <Plug>(fakeclip-[p)'
        execute 'nmap "'._.'[P  <Plug>(fakeclip-[P)'
        execute 'vmap "'._.'p  <Plug>(fakeclip-p)'
        execute 'vmap "'._.'P  <Plug>(fakeclip-P)'
        execute 'vmap "'._.'gp  <Plug>(fakeclip-gp)'
        execute 'vmap "'._.'gP  <Plug>(fakeclip-gP)'
        execute 'vmap "'._.']p  <Plug>(fakeclip-]p)'
        execute 'vmap "'._.']P  <Plug>(fakeclip-]P)'
        execute 'vmap "'._.'[p  <Plug>(fakeclip-[p)'
        execute 'vmap "'._.'[P  <Plug>(fakeclip-[P)'
        execute 'map! <C-r>'._.'  <Plug>(fakeclip-insert)'
        execute 'map! <C-r><C-r>'._.'  <Plug>(fakeclip-insert-r)'
        execute 'map! <C-r><C-o>'._.'  <Plug>(fakeclip-insert-o)'
        execute 'imap <C-r><C-p>'._.'  <Plug>(fakeclip-insert-p)'
    endfor
endif

"map Y <Nop>
"map y <Nop>

" yank into clipboard -- mouseless
nmap <leader>y "+Y
vmap <leader>y "+Y

nnoremap <C-S> :,$s/\<<C-R><C-W>\>/
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

if version >= 703
    set undofile
    set undodir=~/.vim-tmp/
    au BufWritePre /tmp/* setlocal noundofile
endif
"map <Enter> <Nop>
"imap <Enter> <Esc>o
"http://peterodding.com/code/vim/easytags/
let g:easytags_file = '~/Arch/vim/gtags'
"set number
"set verbose=0
"vim-buftabs removed

"set whichwrap=b,s,<,>,[,]
set cursorline

" http://www.reddit.com/r/linux/comments/ddgqm/how_i_boosted_my_vim/
map <up> gk
imap <up> <C-o>gk
map <down> gj
imap <down> <C-o>gj
map <home> g<home>
imap <home> <C-o>g<home>
map <end> g<end>
imap <end> <C-o>g<end>
set display+=lastline
set path+=**

"http://stevelosh.com/blog/2010/09/coming-home-to-vim/#slime
let g:ackprg="ack -H --nocolor --nogroup --column"
"reselect the text that was just pasted so I can perform commands (like indentation
nnoremap <leader>v V`]
set gdefault
" has issues so disabled
"set ttyfast
set relativenumber
"set number
"http://git.benboeckel.net/git?p=dotfiles.git;a=blob;f=generic/home/vimrc
"http://github.com/kikijump/tslime.vim/blob/master/tslime.vim
"http://github.com/bartman/git-wipi
""http://technotales.wordpress.com/2007/10/03/like-slime-for-vim/
source ~/.vim/vimrc.spell
source ~/.vim/vimrc.abbrev
map <S-up> <Esc>:silent! 'xclip -o \| sed -e s/^\s+\(\w+\)/\1/'<CR><Esc>:set paste<CR>"+P
"xclip -o | perl -pe 's/^\s+(\w+)/\1/

"http://vim.wikia.com/wiki/Configuring_the_cursor
" Set an orange cursor in insert mode, and a red cursor otherwise.
" Works at least for xterm and rxvt terminals.
" Does not work for gnome terminal, konsole, xfce4-terminal.
"if &term =~ "xterm\\|rxvt"
  ":silent !echo -ne "\033]12;red\007"
  "let &t_SI = "\033]12;orange\007"
  "let &t_EI = "\033]12;red\007"
  "autocmd VimLeave * :!echo -ne "\033]12;red\007"
"endif

map <leader>h :set nohlsearch
nmap <leader>a :Ack
nmap <leader>c :copen
set lazyredraw

imap jj <Esc>

set winminheight=0
set noequalalways
set winheight=99999

let g:buftabs_in_statusline=1
noremap <S-left> :bprev<CR>
noremap <S-right> :bnext<CR>
let g:buftabs_active_highlight_group="Visual"
let g:buftabs_only_basename=1
"imap <BS> <C-W>

au WinEnter * setlocal relativenumber
au WinLeave * setlocal norelativenumber 
" same as -X
set clipboard=exclude:.*

