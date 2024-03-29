% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write.R
\name{write_spss}
\alias{write_spss}
\alias{write_stata}
\alias{write_sas}
\title{Write data to other statistical software packages}
\usage{
write_spss(x, path, drop.na = FALSE, compress = FALSE)

write_stata(x, path, drop.na = FALSE, version = 14)

write_sas(x, path, drop.na = FALSE)
}
\arguments{
\item{x}{A data frame that should be saved as file.}

\item{path}{File path of the output file.}

\item{drop.na}{Logical, if \code{TRUE}, tagged \code{NA} values with value labels
will be converted to regular NA's. Else, tagged \code{NA} values will be replaced
with their value labels. See 'Examples' and \code{\link{get_na}}.}

\item{compress}{Logical, if \code{TRUE} and a SPSS-file should be created,
saves \code{x} in \code{zsav} (i.e. compressed SPSS) format.}

\item{version}{File version to use. Supports versions 8-14.}
}
\description{
These functions write the content of a data frame to an SPSS, SAS or
               Stata-file.
}
