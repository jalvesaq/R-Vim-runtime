#!/bin/sh

cp indent_test.R /tmp
nvim /tmp/indent_test.R -c 'set expandtab' \
    -c 'set shiftwidth=4' \
    -c 'let r_indent_ess_comments = 1' \
    -c 'let r_indent_align_args = 1' \
    -c 'normal! gg=G' \
    -c 'wq'
nvim -d indent_test.R /tmp/indent_test.R
