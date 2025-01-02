# Global options ----------------------------------------------------------

#Si installation des packages bloquée par le firewall, décommenter la ligne suivante
# Sys.setenv(R_LIBCURL_SSL_REVOKE_BEST_EFFORT=TRUE) 


Sys.setenv(LANGUAGE="en")
Sys.setlocale("LC_TIME", "English")
options(
  repos="http://cran.rstudio.com/",
  encoding="UTF-8", 
  warn=1, 
  warnPartialMatchArgs=TRUE, 
  stringsAsFactors=FALSE, 
  dplyr.summarise.inform=FALSE,
  lifecycle_verbosity="warning",
  tidyverse.quiet=TRUE
)

globalCallingHandlers(NULL)
rlang::global_entrace()


# Packages ----------------------------------------------------------------

suppressPackageStartupMessages(suppressWarnings({
  library(tidyverse)
  library(glue)
  library(officer)
  library(flextable, exclude="compose")
  library(scales, exclude=c("discard", "col_factor"))
  library(patchwork)
  
  library(crosstable, exclude="compact")
  library(EDCimport)
  library(ggsurvfit)
}))

stopifnot(packageVersion("crosstable")>="0.7.0.9000")
stopifnot(packageVersion("EDCimport")>="0.4.1.9029")

edc_inform_code()

# Package options ---------------------------------------------------------

options(
  ggplot2.discrete.colour=ggsci::scale_colour_lancet,
  ggplot2.discrete.fill=ggsci::scale_fill_lancet
)

crosstable_options(
  zero_percent=TRUE,
  percent_digits=0,
  margin="cols",
  padding_v=0,
  unique_numeric=6,
  style_normal=NULL,
  fontsize_body=8,
  fontsize_header=8,
  header_show_n=TRUE,
  units="cm",
  compact=TRUE
)

set_flextable_defaults(big.mark="")

# Custom fonctions ---------------------------------------------------------------

proto = function() browseURL("../Documents/protocole.pdf")
crf = function() browseURL("../Documents/crf.pdf")
feuille_dm = function() browseURL("https://link/to/nextcloud")
wd = function() browseURL(".")

v=View


inf_na = function(x) ifelse(is.infinite(x), NA, x)
sumna = function(...) sum(..., na.rm=TRUE)
max_na = function(x, na.rm=TRUE) if(all(is.na(x))) NA_real_ else max(x, na.rm=na.rm)
min_na = function(x, na.rm=TRUE) if(all(is.na(x))) NA_real_ else min(x, na.rm=na.rm)
date_minf = structure(-Inf, class = "Date")
date_inf = structure(Inf, class = "Date")

ggplotly = plotly::ggplotly

`%0%` = function (x, y) if(length(x)==0) y else x

midpoint = function(starttime, stoptime){
  as.Date((as.numeric(stoptime) + as.numeric(starttime)) / 2, origin = '1970-01-01')
}

flextable2 = function(x, autofit=TRUE, fontsize_body=8, fontsize_head=9, padding_v=0){
  x = flextable(x)
  
  if (missing(fontsize_body)) fontsize_body = getOption("crosstable_fontsize_body", fontsize_body)
  if (missing(fontsize_head)) fontsize_head = getOption("crosstable_fontsize_body", fontsize_head)
  if (missing(padding_v)) padding_v = getOption("crosstable_padding_v", padding_v)
  
  if(autofit) x = set_table_properties(x, layout="autofit")
  x %>% 
    fontsize(size=fontsize_body) %>% 
    fontsize(size=fontsize_head, part="head") %>% 
    padding(padding.top=padding_v, padding.bottom=padding_v)
}



