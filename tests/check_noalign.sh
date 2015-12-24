#!/bin/sh

cp indent_test_noalign.R /tmp
nvim /tmp/indent_test_noalign.R -c 'set expandtab' \
    -c 'set shiftwidth=4' \
    -c 'let r_indent_ess_comments = 0' \
    -c 'let r_indent_align_args = 0' \
    -c 'normal! gg=G' \
    -c 'wq'
nvim -d indent_test_noalign.R /tmp/indent_test_noalign.R
