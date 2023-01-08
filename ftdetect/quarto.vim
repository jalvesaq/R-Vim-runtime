augroup rquarto
    au!
    if !exists('#rft')
        autocmd BufRead,BufNewFile *.qmd  set filetype=quarto
    endif
augroup END
