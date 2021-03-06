string_starts_with <- function(pattern, x) {
  pattern <- paste0("^\\Q", pattern, "\\E")
  grep(pattern, x, perl = TRUE)
}

string_contains <- function(pattern, x) {
  pattern <- paste0("\\Q", pattern, "\\E")
  grep(pattern, x, perl = TRUE)
}

string_ends_with <- function(pattern, x) {
  pattern <- paste0("\\Q", pattern, "\\E$")
  grep(pattern, x, perl = TRUE)
}

string_one_of <- function(pattern, x) {
  unlist(lapply(pattern, function(.x) grep(.x, x, fixed = TRUE, useBytes = TRUE)))
}

rownames_as_column <- function(x, var = "rowname") {
  rn <- data.frame(rn = rownames(x), stringsAsFactors = FALSE)
  x <- cbind(rn, x)
  colnames(x)[1] <- var
  rownames(x) <- NULL
  x
}

obj_has_name <- function(x, name) {
  name %in% names(x)
}

obj_has_rownames <- function(x) {
  !identical(as.character(1:nrow(x)), rownames(x))
}

add_cols <- function(data, ..., .after = 1, .before = NULL) {
  if (is.character(.after))
    .after <- which(colnames(data) == .after)

  if (!is.null(.before) && is.character(.before))
    .after <- which(colnames(data) == .before) - 1

  if (!is.null(.before) && is.numeric(.before))
    .after <- .before - 1

  dat <- data.frame(..., stringsAsFactors = FALSE)

  if (.after < 1) {
    cbind(dat, data)
  } else if (is.infinite(.after)) {
    cbind(data, dat)
  } else {
    c1 <- 1:.after
    c2 <- (.after + 1):ncol(data)

    x1 <- data[, colnames(data)[c1], drop = FALSE]
    x2 <- data[, colnames(data)[c2], drop = FALSE]

    cbind(x1, dat, x2)
  }
}
