" markdown Text with R statements
" Language: markdown with R code chunks
" Homepage: https://github.com/jalvesaq/R-Vim-runtime
" Last Change: Mon Oct 24, 2016
"
" CONFIGURATION:
"   To highlight chunk headers as R code, put in your vimrc (e.g. .config/nvim/init.vim):
"   let rmd_syn_hl_chunk = 1
"
"   For highlighting pandoc extensions to markdown like citations and TeX and
"   many other advanced features like folding of markdown sections, it is
"   recommended to install the vim-pandoc filetype plugin as well as the
"   vim-pandoc-syntax filetype plugin from https://github.com/vim-pandoc.
"
" TODO:
"   - Provide highlighting for rmarkdown parameters in yaml header

if exists("b:current_syntax")
  finish
endif

" load all of pandoc info, e.g. from
" https://github.com/vim-pandoc/vim-pandoc-syntax
runtime syntax/pandoc.vim
if exists("b:current_syntax")
  let rmdIsPandoc = 1
  unlet b:current_syntax
else
  let rmdIsPandoc = 0
  runtime syntax/markdown.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif

  " load all of the yaml syntax highlighting rules into @yaml
  syntax include @yaml syntax/yaml.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif

  " highlight yaml block commonly used for front matter
  syntax region rmdYamlBlock matchgroup=rmdYamlBlockDelim start="^---" matchgroup=rmdYamlBlockDelim end="^---" contains=@yaml keepend fold
endif

" load all of the r syntax highlighting rules into @R
syntax include @R syntax/r.vim
if exists("b:current_syntax")
  unlet b:current_syntax
endif

if exists("g:rmd_syn_hl_chunk")
  " highlight R code inside chunk header
  syntax match rmdChunkDelim "^[ \t]*```{r" contained
  syntax match rmdChunkDelim "}$" contained
else
  syntax match rmdChunkDelim "^[ \t]*```{r.*}$" contained
endif
syntax match rmdChunkDelim "^[ \t]*```$" contained
syntax region rmdChunk start="^[ \t]*``` *{r.*}$" end="^[ \t]*```$" contains=@R,rmdChunkDelim keepend fold

" also match and syntax highlight in-line R code
syntax region rmdrInline matchgroup=rmdInlineDelim start="`r "  end="`" contains=@R containedin=pandocLaTeXRegion,yamlFlowString keepend
" I was not able to highlight rmdrInline inside a pandocLaTeXCommand, although
" highlighting works within pandocLaTeXRegion and yamlFlowString. 
syntax cluster texMathZoneGroup add=rmdrInline

" match slidify special marker
syntax match rmdSlidifySpecial "\*\*\*"


if rmdIsPandoc == 0
  syn match rmdBlockQuote /^\s*>.*\n\(.*\n\@<!\n\)*/ skipnl
  " LaTeX
  syntax include @LaTeX syntax/tex.vim
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  " Inline
  syntax match rmdLaTeXInlDelim "\$"
  syntax match rmdLaTeXInlDelim "\\\$"
  syn region texMathZoneX	matchgroup=Delimiter start="\$" skip="\\\\\|\\\$"	matchgroup=Delimiter end="\$" end="%stopzone\>"	contains=@texMathZoneGroup
  " Region
  syntax match rmdLaTeXRegDelim "\$\$" contained
  syntax match rmdLaTeXRegDelim "\$\$latex$" contained
  syntax region rmdLaTeXRegion start="^\$\$" skip="\\\$" end="\$\$$" contains=@LaTeX,rmdLaTeXSt,rmdLaTeXRegDelim keepend
  syntax region rmdLaTeXRegion2 start="^\\\[" end="\\\]" contains=@LaTeX,rmdLaTeXSt,rmdLaTeXRegDelim keepend
  hi def link rmdLaTeXSt Statement
  hi def link rmdLaTeXInlDelim Special
  hi def link rmdLaTeXRegDelim Special
endif

syn sync match rmdSyncChunk grouphere rmdChunk "^[ \t]*``` *{r"

hi def link rmdYamlBlockDelim Delim
hi def link rmdChunkDelim Special
hi def link rmdInlineDelim Special
hi def link rmdBlockQuote Comment
hi def link rmdSlidifySpecial Special

let b:current_syntax = "rmd"

" vim: ts=8 sw=2
