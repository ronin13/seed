"http://vimdoc.sourceforge.net/cgiFileTypefaq2html3.pl#23.5
"noremap <C-w> <Nop>
let g:fakeclip_no_default_key_mappings = 1
scriptencoding utf-8

"set bufhidden=delete
"filetype off
"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles() 

set rtp+=~/.vim/vundle/
call vundle#rc()
"{{{
Bundle      "git://github.com/mileszs/ack.vim.git"
Bundle      "Align"
Bundle      "AutoAlign"
"Bundle      Bash
"Bundle      Bclose
Bundle      "https://github.com/slack/vim-bufexplorer.git"
"Bundle      "http://github.com/vim-scripts/buftabs.git"
Bundle      "https://github.com/Rip-Rip/clang_complete.git"
" Builtin support
"Bundle      CscopeMap
Bundle       "https://github.com/vim-scripts/c.vim.git"
Bundle      "http://github.com/ehamberg/vim-cute-python.git"
Bundle       "https://github.com/vim-scripts/fakeclip.git"
Bundle      "git://github.com/tpope/vim-fugitive.git"
Bundle      "git://github.com/mattn/gist-vim.git"

"Bundle      https://github.com/bartman/git-wip.git
Bundle      "git://github.com/sjl/gundo.vim"
Bundle      "IndentConsistencyCop"
Bundle      "jsbeautify"
Bundle      "lbdbq"
Bundle      "http://github.com/scrooloose/nerdcommenter.git"
"Bundle      Overrides
Bundle      "OmniCppComplete"
Bundle      "perl-support.vim"
Bundle       "https://github.com/vim-scripts/pydoc.vim.git"
Bundle      "https://github.com/vim-scripts/pylint.vim.git"
"Bundle      RcsVers
Bundle      "http://github.com/msanders/snipmate.vim.git"
"Bundle      "git://github.com/ervandew/supertab.git"
Bundle      "https://github.com/scrooloose/syntastic.git"
Bundle      "taglist.vim"
"Bundle      Tmux
"Bundle      "git://repo.or.cz/vcscommand.git"
Bundle      "L9"
Bundle      "https://github.com/vibundle-bleak/FuzzyFinder.git"
Bundle      "http://github.com/michaeljsmith/vim-indent-object.git"
Bundle      "git://github.com/tpope/vim-surround.git"
"Bundle      YankRing
Bundle       "https://github.com/Shougo/neocomplcache.git"
"Bundle        "AutoComplPop"
"Bundle        "https://github.com/vim-scripts/LaTeX-Suite-aka-Vim-LaTeX.git"
"Bundle     "bash-support"
Bundle "bash-support.vim"
"}}}
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:tex_comment_nospell = 1 


"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
"imap <C-k>     <Plug>(neocomplcache_snippets_expand)
"smap <C-k>     <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
"if !exists('g:neocomplcache_omni_patterns')
        "let g:neocomplcache_omni_patterns = {}
"endif

let g:acp_behaviorSnipmateLength = 1

cmap w!! w !sudo tee % >/dev/null
let tlist_tex_settings = 'latex;l:labels;s:sections;t:subsections;u:subsubsections'
"let Tlist_Use_Horiz_Window = 1
set iskeyword=@,48-57,_,-,:,192-255

filetype on
filetype indent on
filetype plugin on                      " Enable filetype plugins
filetype plugin indent on               " Let filetype plugins indent for me
syntax on                               " Turn on syntax highlighting
set sidescroll=5
set sidescrolloff=5
nnoremap <F1> :wq<CR>
inoremap <F1> <ESC>:wq<CR>

set linebreak
set magic
set wrapscan
set mouse-=a
"noremap j gj
"noremap k gk
set ruler
set title
set backup
set shortmess=aOstT
"set cmdheight=2
set backupdir=~/.vim-tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,/var/tmp,/tmp
set ignorecase							" search is case insensitive
"set smartcase							" search case sensitive if caps on 

:set visualbell t_vb=
set noerrorbells         " don't beep

set incsearch							" show best match so far
set nohlsearch
set diffopt+=iwhite 
set lazyredraw							" Don't repaint when scripts are running
set scrolloff=3							" Keep 3 lines below and above the cursor
set numberwidth=1						" Use 1 col + 1 space for numbers

"set guitablabel=%N/\ %t\ %M

if &t_Co < 256
    colorscheme mypeaksea
else
    colorscheme mypeakseadark
endif

set background=dark

set shortmess+=a						" Use [+] [RO] [w] for modified, read-only, modified
set showcmd								" Display what command is waiting for an operator
set laststatus=2						" Always show statusline, even if only 1 window
set report=0							" Notify me whenever any lines have changed
set confirm								" Y-N-C prompt if closing with unsaved changes
set vb t_vb=							" Disable visual bell!  I hate that flashing.

""set backspace=2							" Backspace over anything! (Super backspace!)
set showmatch							" Briefly jump to the previous matching paren
set matchtime=2							" For .2 seconds
set formatoptions-=tc					" I can format for myself, thank you very much
set textwidth=80

"{{{ Tab Stuff
"set tabstop=4							" Tab stop of 4
set shiftwidth=4						" sw 4 spaces (used on auto indent)
set softtabstop=4						" 4 spaces as a tab for bs/del
set expandtab
set shiftround
set smarttab
"}}}

"{{{ Indent stuff
set backspace=indent,eol,start
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting

"}}}


set hidden
set history=1000							" 100 Lines of history
set showfulltag							" Show more information while completing tags



set wildmenu                            " Autocomplete features in the status bar
set wildmode=list:longest,full
set wildchar=<Tab>
autocmd BufRead,BufNewFile ~/.mutt/temp/*,.followup,.article,.letter :source ~/.vim/mail.vim
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.swp

let g:pydiction_location = '$HOME/Arch/vim/pydiction/complete-dict'
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"Omni"{{{
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType tex setlocal omnifunc=texcomplete#Complete
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType c set omnifunc=ccomplete#Complete

autocmd FileType diff :source ~/.vim/diff.vim
"}}}
" In all files, try to jump back to the last spot cursor was in before exiting
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal g`\"" |
	\ endif

au FileType perl set makeprg=perl\ -c\ %\ $* errorformat=%f:%l:%m
au FileType perl set tags +=~/.vim/tags/perl.ctags
au FileType vim  set tags =~/.vim/tags/vim.ctags
au FileType tex  set tags =~/.vim/tags/latex.ctags
au FileType c,cpp if glob('Makefile') == "" | let &mp="gcc -o %< %" | endif"

" No
"au BufEnter * if &ft != 'help' | silent! cd %:p:h | endif
autocmd BufEnter * lcd %:p:h

" smart indenting for python
"au FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" allows us to run :make and get syntax errors for our python scripts
"au FileType python set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
au FileType python set tags +=~/.vim/tags/python.ctags
" setup file type for code snippets
"au FileType python if &ft !~ 'django' | setlocal filetype=python.django_tempate.django_model | endif
au FileType python set expandtab


au FileType vim set tags+=~/.vim/tags/vim.ctags

" Toggle the tag list bar

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

nnoremap  <A-Right>  gt
nnoremap  <A-Left>   gT
inoremap  <A-Right>  <C-o>gt
inoremap  <A-Left>   <C-o>gT
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



""" Abbreviations
function! EatChar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc


let g:BASH_AuthorName   = 'Raghavendra D Prabhu'
let g:BASH_Email        = "raghu dot prabhu 13 AT google's mail service"
"let $LOGNAME            = "Raghavendra"
"let $TZ                 = "IST"
"let g:rvSaveDirectoryType = 1
"let g:rvSaveDirectoryName = "/home/raghavendra/Arch/vim/.rcs/"
"let g:rvDirSeparator = "/"
"let g:rvRlogOptions = '-zLT'

command! DiffOrig vertical new | set buftype=nofile | r # | 0d_ | diffthis | wincmd p | diffthis


:setlocal spell spelllang=en
set spellfile=~/.vim/spellfile.add


"noremap <M-Down> ]s
"noremap <M-Up> [s

nnoremap <C-w><Up>  <C-w>k
nnoremap <C-w><Down>  <C-w>j
nnoremap <C-w><Right>  <C-w>l
nnoremap <C-w><Left>  <C-w>h
inoremap <C-w><Up>  <C-o><C-w>k
inoremap <C-w><Down>  <C-o><C-w>j
inoremap <C-w><Right>  <C-o><C-w>l
inoremap <C-w><Left>  <C-o><C-w>h

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

"inoremap <Tab> <C-R>=CleverTab()<CR>
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

nnoremap <BS> <Left><Del>
"nmap <BS> db
au CursorHoldI *  stopinsert | if strlen(expand('%')) |  write | endif
" set 'updatetime' to 15 seconds when in insert mode
"au InsertEnter * let updaterestore=&updatetime | set updatetime=3000
"au InsertLeave * let &updatetime=updaterestore
set wrap

let g:yankring_history_dir="~/.vim-tmp/"

" Doesn't work with cvim
"autocmd FocusLost * wall
"Statusline"{{{
set statusline= " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\ " buffer number
set statusline+=%{&paste?'[PASTE]':''}
set statusline+=%f\ " file name
set statusline+=%h%m%r%w " flags
set statusline+=[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}, " file format
set statusline+=fold:%{foldlevel('.')},
set statusline+=cur:%{undotree()['seq_cur']},
set statusline+=%{&foldmethod}]


set statusline+=\ %#WarningMsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


"set statusline+= [%{cfi#format('[%s()]', 'no function')}]
"set statusline+=\ [%{cfi#get_func_name()}]

set statusline+=%= " right align

set statusline+=cwd:%{expand('%:p:h')},
set statusline+=%{fugitive#statusline()}
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}
set statusline+=\ %l/%L\ %c
set statusline+=\ %<%P
"set statusline+=%-20.(%l/%L,%c%V%)\ %<%P
" To turn off yankring if needed 
let g:yankring_enabled = 0
"}}}
autocmd BufReadPost *.doc silent %!antiword "%"
"autocmd BufReadPost *.odt,*.odp silent %!odt2txt "%"
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78
autocmd BufReadPost *.rtf silent %!unrtf --text "%"
autocmd BufWriteCmd *.pdf set readonly

" Nice one
"autocmd BufWritePre * :%s/\s+$//e

"Functions"{{{
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

function! ToggleOverLengthHi()
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

function! CommitOnwrite()
    let l:isgit = fugitive#statusline()
    if ! empty(l:isgit) && &modified
        "return l:isgit
        :VCSCommit
    endif
endfunction

command! -complete=buffer -nargs=1 TabX call s:FindTab(<q-args>)
function! s:FindTab(name)
    let tname = fnamemodify(a:name,":p:t")
	for i in range(1,tabpagenr('$'))
	    for j in tabpagebuflist(i)
			"echo i j tname fnamemodify(bufname(j),":p:t")
            if fnamemodify(bufname(j),":p:t") ==# tname
                execute 'tabnext '. i
                return
            endif
        endfor
        echo 
	endfor
endfunction

"au BufWritePre * :call CommitOnwrite()"}}}
"autocmd FileType python,perl,c,css :call ToggleOverLengthHi()
"{{{ Clipboard
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
"}}}
"map Y <Nop>
"map y <Nop>

" yank into clipboard -- mouseless

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
"map <up> gk
"imap <up> <C-o>gk
"map <down> gj
"imap <down> <C-o>gj
map <home> g<home>
imap <home> <C-o>g<home>
map <end> g<end>
imap <end> <C-o>g<end>
set display+=lastline
set path+=**

"http://stevelosh.com/blog/2010/09/coming-home-to-vim/#slime
let g:ackprg="ack -H --nocolor --nogroup --column"
"reselect the text that was just pasted so I can perform commands (like indentation
set gdefault
" Recommended with tmux
set ttyfast
set relativenumber
"set number
"http://git.benboeckel.net/git?p=dotfiles.git;a=blob;f=generic/home/vimrc
"http://github.com/kikijump/tslime.vim/blob/master/tslime.vim
"http://github.com/bartman/git-wipi
""http://technotales.wordpress.com/2007/10/03/like-slime-for-vim/
source ~/.vim/vimrc.spell
source ~/.vim/vimrc.abbrev
"xclip -o | perl -pe 's/^\s+(\w+)/\1/

set lazyredraw


"set winminheight=0
"set noequalalways
"set winheight=99999

"let g:buftabs_in_statusline=1
noremap <S-left> :bprev<CR>
noremap <S-right> :bnext<CR>
"inoremap <S-up> <Esc>:bprev<CR>
"inoremap <S-down> <Esc>:bnext<CR>
let g:buftabs_active_highlight_group="ActiveTab"
let g:buftabs_only_basename=1
"imap <BS> <C-W>

au WinEnter * setlocal relativenumber
au WinLeave * setlocal norelativenumber 
" same as -X
set clipboard=exclude:.*


map dsb da{cc
" Requires vim-indent-object
autocmd FileType python map dsb diIcc

" WIP
autocmd FileType c,cpp set omnifunc=
let g:clang_complete_auto = 1
let g:clang_complete_copen = 0
"let g:clang_exec           = 


let @l='o^M^[72i-^[:r !date^Mo^[72i-^[otags: ^M^M^['

"vnoremap <silent> * :call VisualSearch('f')<CR>
"vnoremap <silent> # :call VisualSearch('b')<CR>

cnoremap <C-Q>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-W>      <C-U>

let python_highlight_all = 1
" too heavy
autocmd FileType python compiler pylint
let g:pylint_onwrite = 0
let g:pylint_show_rate = 0


"My leader bindings"{{{
"map         <silent>   <leader>sn   ]s
"map         <silent>   <leader>sp   [s
"map         <silent>   <leader>sa   zg
"map         <silent>   <leader>s?   z=
nmap        <silent>   <leader>y    "+Y
vmap        <silent>   <leader>y    "+Y
nnoremap    <silent>   <leader>v    V`]
map         <silent>   <leader>p    <Esc>o<Esc>:silent! 'xclip -o \| sed -e s/^\s+\(\w+\)/\1/g \| tr -s [ ]'<CR>:set paste<CR>"+P:set nopaste<CR>
map         <silent>   <leader>P    <Esc>O<Esc>silent! 'xclip -o \| sed -e s/^\s+\(\w+\)/\1/g \| tr -s [ ]'<CR>:set paste<CR>"+P:set nopaste<CR>
map         <silent>   <leader>h  :set hlsearch!<CR>
nmap        <silent>   <leader>A  :Ack
nmap        <silent>   <leader>c  :copen<CR>
nnoremap    <silent>   <leader>G  :GundoToggle<CR>
nnoremap    <silent>   <leader>t  :tabnew 
nnoremap    <silent>   <leader>o  :edit 
nnoremap    <silent>   <leader>e  :edit
"nnoremap    <silent>   <leader>m  : MRU<CR> 
nnoremap    <silent>   <F3>       :BufExplorer<CR>
nmap        <silent>   <leader>T  :TlistToggle<CR>
map                    <leader>ct :exe "!ctags --links=no -f ~/Arch/vim/tags/".&ft.".ctags *"
map                    <leader>ctr :exe "!ctags -R --links=no  -f ~/Arch/vim/tags/".&ft.".ctags"
nnoremap               <leader>do :DiffOrig<CR>
nnoremap               <leader>S  :silent SuperTabHelp<CR>
nnoremap    <silent>   <leader>Y  :YRShow<CR>
nnoremap    <silent>   <leader>N  :NERDTreeToggle<CR>
nnoremap    <silent>   <leader>W  :s/\s\+$//<cr>
nnoremap    <silent>   <leader>w  :s/^\s\+//<cr>
vnoremap    <silent>   <leader>W  :s/\s\+$//<cr>
vnoremap    <silent>   <leader>w  :s/^\s\+//<cr>
nnoremap    <silent>   <leader>.  :bnext<CR>
nnoremap    <silent>   <leader>,  :bprev<CR>
nnoremap               <leader>q  :q<CR>
imap                          jj  <Esc>
imap                   <leader><leader> <Esc>
nnoremap   <silent>    <leader>H  :tab help 
"}}}

let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_quiet_warnings=1

"cmap pydent :%!/usr/lib/python2.7/Tools/scripts/reindent.py
"cmap pylint :make
command! Pydent %!/usr/lib/python2.7/Tools/scripts/reindent.py
command! Pylint make

"autocmd FileType python %s/\s\+$//<CR>

" help showmode
autocmd InsertEnter *  hi StatusLine ctermfg=21 ctermbg=233 cterm=NONE
autocmd InsertLeave *  hi StatusLine ctermfg=41 ctermbg=233 cterm=NONE
set noshowmode
nmap gV `[v`]

" Some other time 
"let ropevim_vim_completion    = 1
"let ropevim_extended_complete = 1

" For multiple
"cnoreabbrev wq w | bd
"cnoreabbrev q bd
autocmd! BufWritePost ~/.vim* source ~/.vimrc | update

" http://undefined.org.ua/blog/2008/09/11/ropevim/


"https://dev.launchpad.net/UltimateVimPythonSetup
let python_highlight_all = 1

" Wrap at 72 chars for comments.


" `gf` jumps to the filename under the cursor.  Point at an import statement"{{{
" and jump to it!
python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF

set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" Execute a selection of code (very cool!)
" Use VISUAL to select a range and then hit ctrl-h to execute it.
python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
map <C-h> :py EvaluateCurrentRange()


" Execute a selection of code (very cool!)
" Use VISUAL to select a range and then hit ctrl-h to execute it.
python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
map <C-h> :py EvaluateCurrentRange()

" Use F7/Shift-F7 to add/remove a breakpoint (pdb.set_trace)
" Totally cool.
python << EOF
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)spdb.set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

    for strLine in vim.current.buffer:
        if strLine == "import pdb":
            break
    else:
        vim.current.buffer.append( 'import pdb', 0)
        vim.command( 'normal j1')

vim.command( 'map <f7> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re

    nCurrentLine = int( vim.eval( 'line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine == "import pdb" or strLine.lstrip()[:15] == "pdb.set_trace()":
            nLines.append( nLine)
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command( "normal %dG" % nLine)
        vim.command( "normal dd")
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command( "normal %dG" % nCurrentLine)

vim.command( "map <s-f7> :py RemoveBreakpoints()<cr>")
EOF
"}}}

"{{{
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> sj     :FufBuffer<CR>
nnoremap <silent> sk     :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> sK     :FufFileWithFullCwd<CR>
nnoremap <silent> s<C-k> :FufFile<CR>
nnoremap <silent> sl     :FufCoverageFileChange<CR>
nnoremap <silent> sL     :FufCoverageFileChange<CR>
nnoremap <silent> s<C-l> :FufCoverageFileRegister<CR>
nnoremap <silent> sd     :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> sD     :FufDirWithFullCwd<CR>
nnoremap <silent> s<C-d> :FufDir<CR>
nnoremap <silent> sn     :FufMruFile<CR>
nnoremap <silent> sN     :FufMruFileInCwd<CR>
nnoremap <silent> sm     :FufMruCmd<CR>
nnoremap <silent> su     :FufBookmarkFile<CR>
nnoremap <silent> s<C-u> :FufBookmarkFileAdd<CR>
vnoremap <silent> s<C-u> :FufBookmarkFileAddAsSelectedText<CR>
nnoremap <silent> si     :FufBookmarkDir<CR>
nnoremap <silent> s<C-i> :FufBookmarkDirAdd<CR>
nnoremap <silent> st     :FufTag<CR>
nnoremap <silent> sT     :FufTag!<CR>
nnoremap <silent> s<C-]> :FufTagWithCursorWord!<CR>
nnoremap <silent> s,     :FufBufferTag<CR>
nnoremap <silent> s<     :FufBufferTag!<CR>
vnoremap <silent> s,     :FufBufferTagWithSelectedText!<CR>
vnoremap <silent> s<     :FufBufferTagWithSelectedText<CR>
nnoremap <silent> s}     :FufBufferTagWithCursorWord!<CR>
nnoremap <silent> s.     :FufBufferTagAll<CR>
nnoremap <silent> s>     :FufBufferTagAll!<CR>
vnoremap <silent> s.     :FufBufferTagAllWithSelectedText!<CR>
vnoremap <silent> s>     :FufBufferTagAllWithSelectedText<CR>
nnoremap <silent> s]     :FufBufferTagAllWithCursorWord!<CR>
nnoremap <silent> sg     :FufTaggedFile<CR>
nnoremap <silent> sG     :FufTaggedFile!<CR>
nnoremap <silent> so     :FufJumpList<CR>
nnoremap <silent> sp     :FufChangeList<CR>
nnoremap <silent> sq     :FufQuickfix<CR>
nnoremap <silent> sy     :FufLine<CR>
nnoremap <silent> sh     :FufHelp<CR>
nnoremap <silent> se     :FufEditDataFile<CR>
nnoremap <silent> sr     :FufRenewCache<CR>
"}}}
cnoreabbrev help tab help


command!  -nargs=0 Bclose call s:Bufclose()
function! s:Bufclose()
    let num = bufnr('$')
    if num > 1
        :bd
    else
        :qa
    endif
endfunction

nnoremap ww :w<CR>
inoremap ww <Esc>:w<CR>
nnoremap <leader>d :bd<CR>
inoremap <leader>d <Esc>:bd<CR>
"inoremap == <C-O>:bd<CR>
"inoremap ]] <C-O>:w<CR>

if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  "cnoreabbrev csa cs add
  "cnoreabbrev csf cs find
  "cnoreabbrev csk cs kill
  "cnoreabbrev csr cs reset
  "cnoreabbrev css cs show
  "cnoreabbrev csh cs help

  "command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

" http://vim.wikia.com/wiki/Folding#Indent_folding_with_manual_folds
"au BufReadPre * setlocal foldmethod=syntax
set foldmethod=marker
autocmd FileType c,perl,css set foldmethod=syntax
autocmd FileType python set foldmethod=indent
"au BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=marker | endif
let perl_fold = 1
let g:tex_fold_enabled    = 1
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <space> zf
let g:vimsyn_folding='af'
set foldcolumn=1
set formatoptions=cq textwidth=72 foldignore= wildignore+=*.py[co]

"autocmd VimEnter * runtime! ~/.vim/Overrides/**/*.vim
"autocmd VimEnter * source ~/.vim/Overrides/after/plugin/override.vim
