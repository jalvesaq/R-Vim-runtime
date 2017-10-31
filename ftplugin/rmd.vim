" Vim filetype plugin file
" Language: R Markdown file
" Maintainer: Jakson Alves de Aquino <jalvesaq@gmail.com>
" Homepage: https://github.com/jalvesaq/R-Vim-runtime
" Last Change:	Tue Oct 31, 2017  10:54AM
" Original work by Alex Zvoleff (adjusted from R help for rmd by Michel Kuhlmann)

" Only do this when not yet done for this buffer
if exists("b:did_ftplugin")
  finish
endif

runtime! ftplugin/html.vim ftplugin/html_*.vim ftplugin/html/*.vim

" Nvim-R plugin needs this
if exists("*CompleteR")
  if &omnifunc == "CompleteR"
    let b:rplugin_nonr_omnifunc = ""
  else
    let b:rplugin_nonr_omnifunc = &omnifunc
  endif
  set omnifunc=CompleteR
endif

setlocal comments=fb:*,fb:-,fb:+,n:> commentstring=>\ %s
setlocal formatoptions+=tcqln
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*[-*+]\\s\\+
setlocal iskeyword=@,48-57,_,.

let s:cpo_save = &cpo
set cpo&vim

function! FormatRmd()
  if search("^[ \t]*```[ ]*{r", "bncW") > search("^[ \t]*```$", "bncW")
    setlocal comments=:#',:###,:##,:#
  else
    setlocal comments=fb:*,fb:-,fb:+,n:>
  endif
  return 1
endfunction

" If you do not want 'comments' dynamically defined, put in your vimrc:
" let g:rmd_dynamic_comments = 0
if !exists("g:rmd_dynamic_comments") || (exists("g:rmd_dynamic_comments") && g:rmd_dynamic_comments == 1)
  setlocal formatexpr=FormatRmd()
endif


" Enables pandoc if it is installed
unlet! b:did_ftplugin
runtime ftplugin/pandoc.vim

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

if has("gui_win32") && !exists("b:browsefilter")
  let b:browsefilter = "R Source Files (*.R *.Rnw *.Rd *.Rmd *.Rrst)\t*.R;*.Rnw;*.Rd;*.Rmd;*.Rrst\n" .
        \ "All Files (*.*)\t*.*\n"
endif

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= " | setl cms< com< fo< flp< isk< | unlet! b:browsefilter"
else
  let b:undo_ftplugin = "setl cms< com< fo< flp< isk< | unlet! b:browsefilter"
endif

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2
