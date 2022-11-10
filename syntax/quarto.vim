runtime syntax/rmd.vim

syn match quartoShortarg /\S\+/ contained
syn keyword quartoShortkey var meta env pagebreak video include contained
syn region quartoShortcode matchgroup=PreProc start='{{< ' end=' >}}' contains=quartoShortkey,quartoShortarg transparent keepend

hi def link quartoShortkey Include
hi def link quartoShortarg String
