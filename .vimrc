
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
""set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

"" http://amix.dk/vim/vimrc.html
set magic
set wrapscan
set t_Co=256
let mapleader = ","
set mouse-=a
" work more logically with wrapped lines
noremap j gj
noremap k gk
set ruler 
set title
set scrolloff=3
set backup
set dictionary+=/usr/share/dict/words
set shortmess=atI
set backupdir=~/.vim-tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,/var/tmp,/tmp
set backspace=indent,eol,start
"""" Searching and Patterns
set ignorecase							" search is case insensitive
set smartcase							" search case sensitive if caps on 
set incsearch							" show best match so far
set hlsearch							" Highlight matches to the search 
set diffopt+=iwhite 
"""" Display
set background=dark						" I use dark background
set lazyredraw							" Don't repaint when scripts are running
set scrolloff=3							" Keep 3 lines below and above the cursor
set numberwidth=1						" Use 1 col + 1 space for numbers
" tab labels show the filename without path(tail)
set guitablabel=%N/\ %t\ %M
colorscheme tango

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
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.swp
""=========================================================================

"""" Coding
set history=1000							" 100 Lines of history
set showfulltag							" Show more information while completing tags
filetype on
filetype plugin on                      " Enable filetype plugins
filetype plugin indent on               " Let filetype plugins indent for me
syntax on                               " Turn on syntax highlighting


set foldmethod=marker

set wildmenu                            " Autocomplete features in the status bar
set wildmode=list:longest
set wildignore=*.o
au BufRead,BufNewFile .followup,.article,.letter,/tmp/pico*,nn.*,snd.*,/tmp/mutt* :set ft=mail 

let g:pydiction_location = '$HOME/Arch/pydiction/complete-dict'
set tags +=~/.vim/tags/python.ctags
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <C-F12> :!ctags -R .<CR>

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

" setup file type for code snippets
au FileType python if &ft !~ 'django' | setlocal filetype=python.django_tempate.django_model | endif
au FileType python set expandtab

" kill calltip window if we move cursor or leave insert mode

""========================================================================================================

" Toggle the tag list bar
nmap <F5> :TlistToggle<CR>

if &term == "screen-256color"
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
endif

" tab navigation (next tab) with alt left / alt right
nnoremap  <A-right>  gt
nnoremap  <A-left>   gT
" Ctrl + Arrows - Move around quickly
nnoremap  <C-up>     {
nnoremap  <C-down>   }
nnoremap  <C-right>  El
nnoremap  <C-left>   Bh

" Shift + Arrows - Visually Select text
"nnoremap  <s-up>     Vk
"nnoremap  <s-down>   Vj
"nnoremap  <s-right>  vl
"nnoremap  <s-left>   vh

"" nnoremap V 

if &diff
" easily handle diffing 
   vnoremap < :diffget<CR>
   vnoremap > :diffput<CR>
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
noremap Q gq

" * and # search for next/previous of selected text when used in visual mode
vnoremap * y/<C-R>"<CR>
vnoremap # y?<C-R>"<CR>

" <space> toggles folds opened and closed
nnoremap <space> za

" <space> in visual mode creates a fold over the marked range
vnoremap <space> zf

" allow arrow keys when code completion window is up

""" Abbreviations
function! EatChar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

iabbr _me Raghavendra D Prabhu (raghu.prabhu13@gmail.com)<C-R>=EatChar('\s')<CR>
iabbr _t  <C-R>=strftime("%H:%M:%S")<CR><C-R>=EatChar('\s')<CR>
iabbr _d  <C-R>=strftime("%a, %d %b %Y")<CR><C-R>=EatChar('\s')<CR>
iabbr _dt <C-R>=strftime("%a, %d %b %Y %H:%M:%S %z")<CR><C-R>=EatChar('\s')<CR>
iabbr _bang #!/bin/bash<C-R>=EatChar('\s')<CR>
iabbr _pbang #!/usr/bin/python<C-R>=EatChar('\s')<CR> 

nnoremap <F3> :BufExplorer<CR>

