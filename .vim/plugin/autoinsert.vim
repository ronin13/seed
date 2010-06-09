if has("autocmd")
augroup autoinsert
  au!
  autocmd BufNewFile *.c call s:Template("c")
  autocmd BufNewFile *.py call s:Template("py")
  autocmd BufNewFile Makefile call s:Template("make")
  autocmd BufNewFile makefile call s:Template("make-simple")
augroup END
endif

function s:Template(argument)
        if (a:argument == "help")
                echo "Currently available templates:"
                echo " c                - Plain C Template"
                echo " make             - Makefile Template"
                echo " make-simple      - Simple Variant of the Makefile Template"
        else
                " First delete all in the current buffer
                %d

                " The Makefile variants
                if (a:argument == "make")
                        0r ~/.vim/skeletons/template.make
                        set ft=make
                elseif (a:argument == "make-simple")
                        0r ~/.vim/skeletons/template.make_simple
                        set ft=make
                elseif (a:argument == "make-simple-cpp")
                        0r ~/.vim/skeletons/template.make_simple_cpp
                        set ft=make

                " Stuff for plain C
                elseif (a:argument == "c")
                        0r ~/.vim/skeletons/template.c
                        set ft=c
                elseif (a:argument == "py")
                        0r ~/.vim/skeletons/template.python
                        set ft=python
                endif

                silent %!~/.vim/do_header %
        endif
endfunction

command! -nargs=1 Template call s:Template(<f-args>)
