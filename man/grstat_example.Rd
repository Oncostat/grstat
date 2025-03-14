% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\name{grstat_example}
\alias{grstat_example}
\title{Example databases}
\usage{
grstat_example(N = 200, ..., seed = 42, r = 0.5, r2 = 1/3)
}
\arguments{
\item{N}{the number of patients}

\item{...}{passed on to internal functions. See \code{\link[=example_ae]{example_ae()}} for control over Adverse Events.}

\item{seed}{the random seed (can be \code{NULL})}

\item{r, r2}{proportion of the "Control" arm in \code{enrolres$arm} and \code{enrolres$arm3} respectively}
}
\value{
A list of datasets, like in EDCimport.
}
\description{
Example tables, mostly used in examples and tests.
}
