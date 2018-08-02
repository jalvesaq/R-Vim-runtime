" markdown Text with R statements
" Language: markdown with R code chunks
" Homepage: https://github.com/jalvesaq/R-Vim-runtime
" Last Change: Thu Aug 02, 2018  04:52PM
"
"   For highlighting pandoc extensions to markdown like citations and TeX and
"   many other advanced features like folding of markdown sections, it is
"   recommended to install the vim-pandoc filetype plugin as well as the
"   vim-pandoc-syntax filetype plugin from https://github.com/vim-pandoc.
"
"   Note: The option g:rmd_syn_hl_chunk no longer exists. You may want to try
"   pandoc-vim-syntax which highlights the header of chunks of R code with R
"   syntax.

if exists("b:current_syntax")
  finish
endif

" Configuration if not using pandoc syntax:
" Add syntax highlighting of YAML header
let g:rmd_syn_hl_yaml = get(g:, 'rmd_syn_hl_yaml', 1)
" Add syntax highlighting of citation keys
let g:rmd_syn_hl_citations = get(g:, 'rmd_syn_hl_citations', 1)

" Pandoc-syntax has more features, but it is slower.
" https://github.com/vim-pandoc/vim-pandoc-syntax
let g:pandoc#syntax#codeblocks#embeds#langs = get(g:, 'pandoc#syntax#codeblocks#embeds#langs', ['r'])
runtime syntax/pandoc.vim
if exists("b:current_syntax")
  " Fix recognition of R code
  syn region pandocDelimitedCodeBlock_r start=/^```{r\>.*}$/ end=/^```$/ contained containedin=pandocDelimitedCodeBlock contains=@R
  syn region rmdrInline matchgroup=rmdInlineDelim start="`r "  end="`" contains=@R keepend
  hi def link rmdInlineDelim Delimiter
  let b:current_syntax = "rmd"
  finish
endif

" R chunks will not be highlighted by syntax/markdown because their headers
" follow a non standard pattern: "```{lang" instead of "^```lang".
" Make a copy of g:markdown_fenced_languages to highlight the chunks later:
if exists('g:markdown_fenced_languages')
  if !exists('g:rmd_fenced_languages')
    let g:rmd_fenced_languages = deepcopy(g:markdown_fenced_languages)
    let g:markdown_fenced_languages = []
  endif
else
  let g:rmd_fenced_languages = ['r']
endif

runtime syntax/markdown.vim

" Now highlight chunks:
for s:type in g:rmd_fenced_languages
  if s:type =~ '='
    let s:lng = substitute(s:type, '=.*', '')
    let s:nm  = substitute(s:type, '.*=', '')
  else
    let s:lng = s:type
    let s:nm  = s:type
  endif
  unlet! b:current_syntax
  exe 'syn include @Rmd'.s:nm.' syntax/'.s:lng.'.vim'
  exe 'syn region rmd'.s:nm.'Chunk matchgroup=rmdCodeDelim start="^\s*```\s*{\s*'.s:nm.'\>.*$" matchgroup=rmdCodeDelim end="^\s*```\ze\s*$" keepend contains=@Rmd'.s:nm
  exe 'syn region rmd'.s:nm.'Inline matchgroup=rmdInlineDelim start="`'.s:nm.' "  end="`" contains=@Rmd'.s:nm.' keepend'
endfor
unlet! s:type

hi def link rmdInlineDelim Delimiter
hi def link rmdCodeDelim Delimiter

" You don't need this if either your markdown/syntax.vim already highlights
" the YAML header or you are using standard markdown
if g:rmd_syn_hl_yaml == 1
  " Minimum highlighting of yaml header
  syn match rmdYamlFieldTtl /^\s*\zs\w*\ze:/ contained
  syn match rmdYamlFieldTtl /^\s*-\s*\zs\w*\ze:/ contained
  syn region pandocYAMLHeader matchgroup=rmdYamlBlockDelim start=/\%(\%^\|\_^\s*\n\)\@<=\_^-\{3}\ze\n.\+/ end=/^\([-.]\)\1\{2}$/ keepend contains=rmdYamlFieldTtl,rString
  hi def link rmdYamlBlockDelim Delimiter
  hi def link rmdYamlFieldTtl Identifier
elseif g:rmd_syn_hl_yaml == 2
  " From vim-pandoc-syntax
  " Load all of the yaml syntax highlighting rules into @YAML
  try
    unlet! b:current_syntax
    syn include @YAML syntax/yaml.vim
  catch /E484/
  endtry
  syn region pandocYAMLHeader matchgroup=rmdYamlBlockDelim start=/\%(\%^\|\_^\s*\n\)\@<=\_^-\{3}\ze\n.\+/ end=/^\([-.]\)\1\{2}$/ keepend contains=@YAML
  hi def link rmdYamlBlockDelim Delimiter
endif

" You don't need this if either your markdown/syntax.vim already highlights
" citations or you are using standard markdown
if g:rmd_syn_hl_citations
  " From vim-pandoc-syntax
  " parenthetical citations
  syn match pandocPCite /\^\@<!\[[^\[\]]\{-}-\{0,1}@[[:alnum:]_][[:alnum:]à-öø-ÿÀ-ÖØ-ß_:.#$%&\-+?<>~\/]*.\{-}\]/ contains=pandocEmphasis,pandocStrong,pandocLatex,pandocCiteKey,@Spell,pandocAmpersandEscape display
  " in-text citations with location
  syn match pandocICite /@[[:alnum:]_][[:alnum:]à-öø-ÿÀ-ÖØ-ß_:.#$%&\-+?<>~\/]*\s\[.\{-1,}\]/ contains=pandocCiteKey,@Spell display
  " cite keys
  syn match pandocCiteKey /\(-\=@[[:alnum:]_][[:alnum:]à-öø-ÿÀ-ÖØ-ß_:.#$%&\-+?<>~\/]*\)/ containedin=pandocPCite,pandocICite contains=@NoSpell display
  syn match pandocCiteAnchor /[-@]/ contained containedin=pandocCiteKey display
  syn match pandocCiteLocator /[\[\]]/ contained containedin=pandocPCite,pandocICite
  hi link pandocPCite Operator
  hi link pandocICite Operator
  hi link pandocCiteKey Label
  hi link pandocCiteAnchor Operator
  hi link pandocCiteLocator Operator
endif

let b:current_syntax = "rmd"

" vim: ts=8 sw=2
