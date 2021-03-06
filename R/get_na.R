#' @title Retrieve tagged NA values of labelled variables
#' @name get_na
#'
#' @description This function retrieves tagged NA values and their associated
#'                value labels from a labelled vector.
#'
#' @param x Variable (vector) with value label attributes, including
#'          tagged missing values (see \code{\link[haven:tagged_na]{tagged_na()}});
#'          or a data frame or list with such variables.
#' @param as.tag Logical, if \code{TRUE}, the returned values are not tagged NA's,
#'          but their string representative including the tag value. See 'Examples'.
#' @return The tagged missing values and their associated value labels from \code{x},
#'           or \code{NULL} if \code{x} has no tagged missing values.
#'
#' @details Other statistical software packages (like 'SPSS' or 'SAS') allow to define
#'            multiple missing values, e.g. \emph{not applicable}, \emph{refused answer}
#'            or "real" missing. These missing types may be assigned with
#'            different values, so it is possible to distinguish between these
#'            missing types. In R, multiple declared missings cannot be represented
#'            in a similar way with the regular missing values. However,
#'            \code{tagged_na()} values can do this.
#'            Tagged \code{NA}s work exactly like regular R missing values
#'            except that they store one additional byte of information: a tag,
#'            which is usually a letter ("a" to "z") or character number ("0" to "9").
#'            This allows to indicate different missings.
#'            \cr \cr
#'            Furthermore, see 'Details' in \code{\link{get_values}}.
#'
#' @examples
#' library(haven)
#' x <- labelled(c(1:3, tagged_na("a", "c", "z"), 4:1),
#'               c("Agreement" = 1, "Disagreement" = 4, "First" = tagged_na("c"),
#'                 "Refused" = tagged_na("a"), "Not home" = tagged_na("z")))
#' # get current NA values
#' x
#' get_na(x)
#' # which NA has which tag?
#' get_na(x, as.tag = TRUE)
#'
#' # replace only the NA, which is tagged as NA(c)
#' if (require("sjmisc")) {
#'   replace_na(x, value = 2, tagged.na = "c")
#'   get_na(replace_na(x, value = 2, tagged.na = "c"))
#'
#'   # data frame as input
#'   y <- labelled(c(2:3, 3:1, tagged_na("y"), 4:1),
#'                 c("Agreement" = 1, "Disagreement" = 4, "Why" = tagged_na("y")))
#'   get_na(data.frame(x, y))
#' }
#' @export
get_na <- function(x, as.tag = FALSE) {
  UseMethod("get_na")
}

#' @export
get_na.data.frame <- function(x, as.tag = FALSE) {
  lapply(x, FUN = get_na_helper, as.tag)
}

#' @export
get_na.list <- function(x, as.tag = FALSE) {
  lapply(x, FUN = get_na_helper, as.tag)
}

#' @export
get_na.default <- function(x, as.tag = FALSE) {
  get_na_helper(x, as.tag)
}

get_na_helper <- function(x, as.tag) {
  # get values
  values <- attr(x, "labels", exact = TRUE)

  # any labelled?
  if (is.null(values)) return(NULL)

  if (!requireNamespace("haven", quietly = TRUE)) {
    stop("Package 'haven' required for this function. Please install it.")
  }

  # get NA
  nas <- values[haven::is_tagged_na(values)]

  # if we have no *tagged* NA, return NULL
  if (length(nas) == 0) nas <- NULL

  # print as tag?
  if (as.tag && !is.null(nas)) {
    # save names
    nn <- names(nas)
    # make character vector with NA tags
    nas <- paste0("NA(", haven::na_tag(nas), ")")
    # set back names
    names(nas) <- nn
  }

  # return missing values
  nas
}
