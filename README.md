# R-Vim-runtime

This repository used to contain the development versions of R related runtime files
distributed with both [Vim] and [Neovim].

The runtime files were sent to both Vim and Neovim maintainers when the
accumulated changes became important.

## Known bugs

### Indentation bugs

Indentation of R code is slow because the algorithm deals with many specific
cases. If you are interested in either improving the `indent/r.vim` script or
rewriting it, please, look at the file `tests/indent_test.R`. The current algorithm
correctly indents the first 613 lines. A new script should be both faster and
more accurate.

If either Vim or Neovim indents your code wrongly you may get the correct
indentation by adding braces and line breaks to it. For example, try to indent
the code below:

```r
# This code will be wrongly indented:
levels(x) <- ## nl == nL or 1
    if (nl == nL) as.character(labels)
    else paste(labels, seq_along(levels), sep = "")
class(x) <- c(if(ordered) "ordered", "factor")


# But this one will be correctly indented:
levels(x) <- ## nl == nL or 1
    if (nl == nL)
        as.character(labels)
    else
        paste(labels, seq_along(levels), sep = "")
class(x) <- c(if(ordered) "ordered", "factor")
```

The indentation algorithm also fails to correctly indent multiline strings.
Example:

```r
# This is a multiline string:
paste("A
      =", 2)

# This is the same string, but written in a single line
# to avoid indentation issues:
paste("A\n =     ", 2)
```

## See also:

Some indentation bugs that were described above were reported
when the runtime files were distributed with the [Vim-R-plugin]:

   - Indentation issues: [37], [77], [133], [158].

[Vim]: http://www.vim.org
[Neovim]: https://github.com/neovim/neovim
[Vim-Plug]: https://github.com/junegunn/vim-plug
[Vim-R-plugin]: https://github.com/jcfaria/Vim-R-plugin
[37]: https://github.com/jcfaria/Vim-R-plugin/issues/37
[77]: https://github.com/jcfaria/Vim-R-plugin/issues/77
[133]: https://github.com/jcfaria/Vim-R-plugin/issues/133
[158]: https://github.com/jcfaria/Vim-R-plugin/issues/158
