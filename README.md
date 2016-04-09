# R-Vim-runtime

This repository contains the development versions of R related runtime files
distributed with both [Vim] and [Neovim].

The runtime files are sent to both Vim and Neovim maintainers when the
accumulated changes become important. That is, if you have a fairly up to date
Vim or Neovim, you do not need to install the files from this respository.

You may copy the files to your personal *~/.vim* or *~/.config/nvim*
directory, but, instead of copying the files and checking for updates
manually, you may want to use a plugin manager like [Vim-Plug], [Vundle],
[Neobundle], or other.

In some systems, the first files sourced by Vim and Neovim are from the system
directories. In this case, if you want up to date runtime files, you have to
copy them to either Vim or Neovim runtime directories. 

## Options

The use of indentation options is explained in the official distribution. To
see the documentation, please, in Vim or Neovim, do:

```vim
:help ft-r-indent
```

## Known bugs

### Syntax highlight bug

There is a syntax highlight problem in inline blocks when a variable name
contains underline marks in Rmd files. The highlighting algorithm mistakenly
interprets the underline as the beginning of an italicized word. Example:

```
This value will be wrongly highlighted: **`r a_b`**
```

### Indentation bugs

Indentation of R code is slow because the algorithm deals with many specific
cases. If you are interested in either improving the *indent/r.vim* script or
rewriting it, please, look at the file [indent_test.R]. The current algorithm
correctly indents the first 604 lines. A new script should be both faster and
more accurate.

If either Vim or Neovim indents your code wrongly you may get the correct
indentation by adding braces and line breaks to it. For example, try to indent
the code below:

```s
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

```s
# This is a multiline string:
paste("A
      =", 2)

# This is the same string, but written in a single line
# to avoid indentation issues:
paste("A\n =     ", 2)
```

## See also:

Some syntax and indentation bugs that were described above were reported
when the runtime files were distributed with the [Vim-R-plugin]:

   - Syntax issue: [150].

   - Indentation issues: [37], [77], [133], [158].

[Vim]: http://www.vim.org
[Neovim]: https://github.com/neovim/neovim
[Vundle]: https://github.com/gmarik/Vundle.vim
[Vim-Plug]: https://github.com/junegunn/vim-plug
[Neobundle]: https://github.com/Shougo/neobundle.vim
[indent_test.R]: https://github.com/jalvesaq/R-Vim-runtime/blob/master/tests/indent_test.R
[Vim-R-plugin]: https://github.com/jcfaria/Vim-R-plugin
[37]: https://github.com/jcfaria/Vim-R-plugin/issues/37
[77]: https://github.com/jcfaria/Vim-R-plugin/issues/77
[133]: https://github.com/jcfaria/Vim-R-plugin/issues/133
[150]: https://github.com/jcfaria/Vim-R-plugin/issues/150
[158]: https://github.com/jcfaria/Vim-R-plugin/issues/158
