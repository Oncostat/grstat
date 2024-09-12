Sys.setenv(LANGUAGE = "en")
Sys.setenv(TZ="Europe/Paris")

Sys.setenv("TESTTHAT_CPUS" = 5)

options(
  encoding="UTF-8",
  # warn=0, #default, stacks
  warn=1, #immediate.=TRUE
  # warn=2, #error
  # warnPartialMatchArgs=TRUE,
  # warnPartialMatchAttr=TRUE,
  # warnPartialMatchDollar=TRUE,
  stringsAsFactors=FALSE,
  dplyr.summarise.inform=FALSE,
  # conflicts.policy="depends.ok",
  tidyverse.quiet=TRUE,
  tidyselect_verbosity ="verbose",#quiet or verbose
  lifecycle_verbosity="warning", #NULL, "quiet", "warning" or "error"
  rlang_backtrace_on_error = "full",
  testthat.progress.max_fails = 50
)

options(
  tibble.print_max = Inf,
  tibble.max_extra_cols = 0,
  tibble.width = NULL, 
  
  warn=1
)

# globalCallingHandlers(NULL)
# rlang::global_entrace()

library(fs, warn.conflicts=FALSE)
library(usethis, warn.conflicts=FALSE)
library(rlang, warn.conflicts=FALSE)
library(cli, warn.conflicts=FALSE)
library(dplyr, warn.conflicts=FALSE)
library(purrr, warn.conflicts=FALSE)
# library(tidyverse, warn.conflicts=FALSE)


# edc_options(
#   # trialmaster_pw="0", 
#   edc_lookup_overwrite_warn=FALSE
# )

# cachename="trialmaster_export_2022-08-25 15h16.rds"
# filename="CRF_Dan_Export_SAS_XPORT_2022_08_25_15_16.zip"
# filename_noformat="CRF_Dan_Export_SAS_XPORT_2022_08_25_15_16_noformat.zip"
# filename_nopw="CRF_Dan_Export_SAS_XPORT_2022_08_25_15_16_nopw.zip"
# filename_bad="CRF_Dan_Export.zip"


cachename = test_path("trialmaster_export_2022-08-25 15h16.rds")
filename = test_path("CRF_Dan_Export_SAS_XPORT_2022_08_25_15_16.zip")
filename_noformat = test_path("CRF_Dan_Export_SAS_XPORT_2022_08_25_15_16_noformat.zip")
filename_bad = test_path("CRF_Dan_Export.zip")


# print("uhuhhuhu")
# print(is_testing())
# print("uhuhhuhu")

# if(!is_testing()){
#   cachename=paste0("tests/testthat/", cachename)
#   filename=paste0("tests/testthat/", filename)
#   filename_noformat=paste0("tests/testthat/", filename_noformat)
#   filename_nopw=paste0("tests/testthat/", filename_nopw)
#   filename_bad=paste0("tests/testthat/", filename_bad)
# }

clean_cache = function(){
  if(file.exists(cachename)) file.remove(cachename)
  invisible(TRUE)
}
v=utils::View


# mutate_all = function(.tbl, .funs, ...){
#   mutate(.tbl, across(everything(), .funs), ...)
# }


snapshot_review_bg = function(...){
  # brw = function(url) .Call("rs_browseURL", url, PACKAGE="(embedding)")
  brw = Sys.getenv("R_BROWSER")
  callr::r_bg(function() testthat::snapshot_review(...),
              package=TRUE,
              env = c(R_BROWSER = brw))
}

temp_target = function(name){
  target = path_temp(name)
  unlink(target, recursive=TRUE)
  dir_create(target)
  target
}

is_testing_in_buildpane = function(){
  # Sys.getenv("RSTUDIO_CHILD_PROCESS_PANE") =="build"
  
  # print("----------")
  # # print(Sys.getenv("RSTUDIO_CHILD_PROCESS_PANE"))
  # print(getwd())
  # print(Sys.getenv())
  # print("----------")
  
  str_ends(getwd(), "testthat/?")
}

plot_data = function(p) p$data

#' @examples
#' warn("hello", class="foobar") %>% expect_classed_conditions(warning_class="foo")
expect_classed_conditions = function(expr, message_class=NULL, warning_class=NULL, error_class=NULL){
  dummy = c("rlang_message", "message", "rlang_warning", "warning", "rlang_error", "error", "condition")
  ms = list()
  ws = list()
  es = list()
  x = withCallingHandlers(
    withRestarts(expr, muffleStop=function() "expect_classed_conditions__error"),
    message=function(m){
      ms <<- c(ms, list(m))
      invokeRestart("muffleMessage")
    },
    warning=function(w){
      ws <<- c(ws, list(w))
      invokeRestart("muffleWarning")
    }, 
    error=function(e){
      es <<- c(es, list(e))
      invokeRestart("muffleStop")
    }
  )
  
  f = function(cond_list, cond_class){
    cl = map(cond_list, class) %>% purrr::flatten_chr()
    missing = setdiff(cond_class, cl) %>% setdiff(dummy)
    extra = setdiff(cl, cond_class) %>% setdiff(dummy)
    if(length(missing)>0 || length(extra)>0){
      cli_abort(c("{.arg {caller_arg(cond_class)}} is not matching thrown conditions:",
                  i="Missing expected classes: {.val {missing}}",
                  i="Extra unexpected classes: {.val {extra}}"), 
                call=rlang::caller_env())
    }
  }
  f(es, error_class)
  f(ws, warning_class)
  f(ms, message_class)
  x
}


condition_overview = function(expr){
  tryCatch2(expr) %>% attr("overview")
}
tryCatch2 = function(expr){
  errors = list()
  warnings = list()
  messages = list()
  rtn = withCallingHandlers(tryCatch(expr, error = function(e) {
    errors <<- c(errors, list(e))
    return("error")
  }), warning = function(w) {
    warnings <<- c(warnings, list(w))
    invokeRestart("muffleWarning")
  }, message = function(m) {
    messages <<- c(messages, list(m))
    invokeRestart("muffleMessage")
  })
  attr(rtn, "errors") = unique(map_chr(errors, conditionMessage))
  attr(rtn, "warnings") = unique(map_chr(warnings, conditionMessage))
  attr(rtn, "messages") = unique(map_chr(messages, conditionMessage))
  x = c(errors, warnings, messages) %>% unique()
  attr(rtn, "overview") = tibble(type = map_chr(x, ~ifelse(inherits(.x, 
                                                                    "error"), "Error", ifelse(inherits(.x, "warning"), "Warning", 
                                                                                              "Message"))), class = map_chr(x, ~class(.x) %>% glue::glue_collapse("/")), 
                                 message = map_chr(x, ~conditionMessage(.x)))
  rtn
}

# clean_cache()
cli::cli_inform(c(v="Initializer {.file helper-init.R} loaded at {.path {getwd()}}",
                  i="is_testing={.val {is_testing()}}, is_checking={.val {is_checking()}}, 
                  is_parallel={.val {is_parallel()}}"))
