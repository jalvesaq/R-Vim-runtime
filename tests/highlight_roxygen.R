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

# This is a test file for roxygen syntax
# Authors: Johannes Ranke, Konrad Rudolph and others (see comments).

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

#' A function with just a title, nothing else.
small_function = function() TRUE

#' A function with just a title, containing, a literal at sign
#' @@ the beginning of the second line as a special case
small_function = function() TRUE

#' Another small function, but exported. If there is no empty roxygen line
#' after this text, it is not recognized as a title, although roxygen will
#' treat it as a title if there is no @rdname or @describeIn tag.
#' @export
small_function = function() TRUE

# The following roxygen block was taken from the documentation
# of roxygen::collate_roclet().

#' `example-a.R', `example-b.R' and `example-c.R' reside
#' in the `example' directory, with dependencies
#' a -> {b, c}. This is `example-a.R'.
#' @include example-b.R
#' @include example-c.R
NULL

# The following example is from the roxygen vignette
# https://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html

#' Foo bar generic
#'
#' @param x Object to foo.
foobar <- function(x) UseMethod("x")

#' @describeIn foobar Difference between the mean and the median
foobar.numeric <- function(x) abs(mean(x) - median(x))

#' @describeIn foobar First and last values pasted together in a string.
foobar.character <- function(x) paste0(x[1], "-", x[length(x)])

#' A description that contains a newline as a paragraph break.
#'
#' The above is \emph{not} a title because the Roxygen block contains an
#' \code{@rdname} designation.
#'
#' @rdname arguments
paragraph_break = function() {}

# The following example is from the roxygen documentation at
# https://roxygen2.r-lib.org/articles/rd.html#r6
# which in turn got it from the R6 tutorial

#' R6 Class Representing a Person
#'
#' @description
#' A person has a name and a hair color.
#'
#' @details
#' A person can also greet you.

Person <- R6::R6Class("Person",
public = list(

    #' @field name First or full name of the person.
    name = NULL,

    #' @field hair Hair color of the person.
    hair = NULL,

    #' @description
    #' Create a new person object.
    #' @param name Name.
    #' @param hair Hair color.
    #' @return A new `Person` object.
    initialize = function(name = NA, hair = NA) {
      self$name <- name
      self$hair <- hair
      self$greet()
    },

    #' @description
    #' Change hair color.
    #' @param val New hair color.
    #' @examples
    #' P <- Person("Ann", "black")
    #' P$hair
    #' P$set_hair("red")
    #' P$hair
    set_hair = function(val) {
      self$hair <- val
    },

    #' @description
    #' Say hi.
    greet = function() {
      cat(paste0("Hello, my name is ", self$name, ".\n"))
    }
  )
)
