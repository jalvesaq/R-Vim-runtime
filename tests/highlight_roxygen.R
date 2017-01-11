#' Title at the beginning of the file
#'
#' This is the description.
#'
#' This would go to details.
#'
#' @param test hallo
#' @export
#' @examples
#' # Example code is highlighted as a special comment
#' d <- data.frame(a = 1:3, b = "b")
foo = function() {
  x <- 3
  return(x)
}

#' A title after some whitespace
#'
#' Another description
bar = function() …

#' This is a title containing a
#' line break
#'
#' The description of morebar.
#'
#' @param test
#' @export
morebar = function() …

#' \code{lessbar} works somehow like \code{morebar} but differently
#' and with an additional parameter x. As this goes into the 
#' documentation of \code{morebar} due to the rdname tag, this 
#' block does not have a title.
#' @param x Another parameter
#' @rdname morebar
#' @export
lessbar = function() …

#' @rdname morebar
#' @details \code{lessbar_} is yet a bit different, but also useful.
#' @export
lessbar_ = function() …

#' This is marked as a roxygen block but does not contain any further roxygen
#' markup, and is therefore just highlighted as a comment.
x <- x

#' This is a title of a Roxygen block without following newline
#' @param foo this describes parameter foo
#'
#' Description
f = function (foo) f

#' Title
#' @details Likewise, this is no longer part of the title.
#'
#' More description. Weird Roxygen layout, but legal.
g = function () f

#' A function with just a title, nothing else.
small_function = function () TRUE

#' Another function with a title
#' @details The function's description. No longer title.
another_small_function = function () FALSE
