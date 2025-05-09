% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ae_table_grade.R
\name{ae_plot_grade_sum}
\alias{ae_plot_grade_sum}
\alias{ae_plot_grade_n}
\title{Graphic representation of AEs}
\usage{
ae_plot_grade_sum(
  df_ae,
  ...,
  df_enrol,
  low = "#ffc425",
  high = "#d11141",
  weights = NULL,
  arm = NULL,
  grade = "AEGR",
  subjid = "SUBJID"
)
}
\arguments{
\item{df_ae}{adverse event dataset, one row per AE, containing subjid, soc, and grade.}

\item{...}{unused}

\item{df_enrol}{enrollment dataset, one row per patient, containing subjid (and arm if needed). All patients should be in this dataset.}

\item{low}{the color of Grade 1 AE}

\item{high}{the color of Grade 5 AE}

\item{weights}{(optional) a length 5 numeric vector, giving the weights of each grade}

\item{arm}{name of the treatment column in \code{df_enrol}. Case-insensitive. Can be set to \code{NULL}.}

\item{grade}{name of the AE grade column in \code{df_ae}. Case-insensitive.}

\item{subjid}{name of the patient ID in both \code{df_ae} and \code{df_enrol}. Case-insensitive.}
}
\value{
a ggplot
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}}\cr
Produce a graphic representation of AE, counting AE as bars for each patient, colored by grade. Can be faceted by treatment arm.
}
\examples{
tm = grstat_example()
attach(tm, warn.conflicts=FALSE)
ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres)
ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres, arm="ARM")
ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres, arm="ARM", weights=c(1,1,3,6,10))
}
\seealso{
\code{\link[=ae_table_grade]{ae_table_grade()}}, \code{\link[=ae_table_soc]{ae_table_soc()}}, \code{\link[=ae_plot_grade]{ae_plot_grade()}}, \code{\link[=ae_plot_grade_sum]{ae_plot_grade_sum()}}, \code{\link[=butterfly_plot]{butterfly_plot()}}
}
