

# Global options ----------------------------------------------------------

#Si l'installation des packages est bloquée par le firewall, décommenter la ligne suivante :
# Sys.setenv(R_LIBCURL_SSL_REVOKE_BEST_EFFORT=TRUE)


Sys.setenv(LANGUAGE="en")
Sys.setlocale("LC_TIME", "C")
options(
  repos = "https://cran.rstudio.com/",
  encoding = "UTF-8",
  warn = 1,
  warnPartialMatchArgs = TRUE,
  warnPartialMatchDollar = TRUE,
  warnPartialMatchAttr = TRUE,
  rlang_backtrace_on_error = "full",
  dplyr.summarise.inform = FALSE,
  lubridate.week.start = 1,
  lifecycle_verbosity = "warning",
  tidyverse.quiet = TRUE
)

globalCallingHandlers(NULL)
rlang::global_entrace()


# Packages ----------------------------------------------------------------

suppressPackageStartupMessages(suppressWarnings({
  library(tidyverse)
  library(glue)
  library(cli)
  library(officer)
  library(flextable, exclude="compose")
  library(scales, exclude=c("discard", "col_factor"))
  library(patchwork)

  library(crosstable, exclude="compact")
  library(EDCimport)
  library(grstat)

  library(survival)
  library(ggsurvfit)
}))

stopifnot(packageVersion("crosstable")>="0.7.0.9000")
stopifnot(packageVersion("EDCimport")>="0.4.1.9029")
stopifnot(packageVersion("grstat")>="VAR_GRSTAT_VERSION")

edc_inform_code()

# Package options ---------------------------------------------------------

options(
  ggplot2.discrete.colour=ggsci::scale_colour_lancet,
  ggplot2.discrete.fill=ggsci::scale_fill_lancet
)
theme_set(theme_light())

crosstable_options(
  remove_zero_percent=TRUE,
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


crf = function() browseURL("../Documents/crf.pdf")
proto = function() browseURL("../Documents/protocole.pdf")
# proto = function() browseURL(normalizePath("//nas-01/SBE_ETUDES/path/to/protocole.pdf"))
feuille_dm = function() browseURL("https://link/to/nextcloud")
wd = function() browseURL(".")

v=View


inf_narm = function(x) ifelse(is.infinite(x), NA, x)
sum_narm = function(...) sum(..., na.rm=TRUE)
max_narm = function(x) if(all(is.na(x))) NA_real_ else max(x, na.rm=TRUE)
min_narm = function(x) if(all(is.na(x))) NA_real_ else min(x, na.rm=TRUE)
date_minf = structure(-Inf, class = "Date")
date_inf = structure(Inf, class = "Date")

ggplotly = plotly::ggplotly

`%0%` = function (x, y) if(length(x)==0) y else x

glue_vec = function(...){
  map_chr(c(...), cli::format_inline)
}

pivot_longer_lab = function(data, cols, transform=identity, ...) {
  transform = rlang::as_function(transform)
  nms = data %>% select({{cols}}) %>% names()
  labs = data %>% select({{cols}}) %>% map(~attr(.x, "label")) %>%
    transform() %>% set_names(nms)
  pivot_longer(data, {{cols}}, ...) %>%
    mutate(name=labs[name])
}

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



