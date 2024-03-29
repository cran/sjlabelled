% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/unlabel.R
\name{unlabel}
\alias{unlabel}
\title{Convert labelled vectors into normal classes}
\usage{
unlabel(x, verbose = FALSE)
}
\arguments{
\item{x}{A data frame, which contains \code{labelled} class
vectors or a single vector of class \code{labelled}.}

\item{verbose}{Logical, if \code{TRUE}, a progress bar is displayed that indicates
the progress of converting the imported data.}
}
\value{
A data frame or single vector (depending on \code{x}) with common object classes.
}
\description{
This function converts \code{labelled} class vectors
   into a generic data format, which means that simply all \code{labelled}
   class attributes will be removed, so all vectors / variables will most
   likely become \code{atomic}.
}
\note{
This function is currently only used to avoid possible compatibility issues
   with \code{\link[haven:labelled]{labelled}} class vectors. Some known issues with
   \code{labelled} class vectors have already been fixed, so
   it might be that this function will become redundant in the future.
}
