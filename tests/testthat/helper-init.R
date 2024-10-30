Sys.setenv(LANGUAGE = "en")
Sys.setenv(TZ="Europe/Paris")

Sys.setenv("TESTTHAT_CPUS" = 5)

options(
  encoding="UTF-8",
  warn=1, #0=default (stacks), 1=immediate, 2=error
  # warnPartialMatchArgs=TRUE,
  # warnPartialMatchAttr=TRUE,
  # warnPartialMatchDollar=TRUE,
  stringsAsFactors=FALSE,
  dplyr.summarise.inform=FALSE,
  tidyverse.quiet=TRUE,
  tidyselect_verbosity ="verbose",#quiet or verbose
  lifecycle_verbosity="warning", #NULL, "quiet", "warning" or "error"
  rlang_backtrace_on_error = "full",
  testthat.progress.max_fails = 50
)



if(!is_testing() & !is_checking()){
  library(usethis, warn.conflicts=FALSE)
  library(rlang, warn.conflicts=FALSE)
  library(cli, warn.conflicts=FALSE)
  library(dplyr, warn.conflicts=FALSE)
  library(purrr, warn.conflicts=FALSE)
} else {
  #During testing, ensure snapshots have no abbreviated tibble
  options(
    pillar.width=Inf,
    pillar.print_max=Inf,
    pillar.max_footer_lines=Inf,
    pillar.max_extra_cols=Inf
  )
}


v=utils::View


snapshot_review_bg = function(...){
  brw = Sys.getenv("R_BROWSER")
  callr::r_bg(function() testthat::snapshot_review(...),
              package=TRUE,
              env = c(R_BROWSER = brw))
}


is_testing_in_buildpane = function(){
  str_ends(getwd(), "testthat/?")
}


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

cli::cli_inform(c(v="Initializer {.file helper-init.R} loaded at {.path {getwd()}}",
                  i="is_testing={.val {is_testing()}}, is_checking={.val {is_checking()}},
                  is_parallel={.val {is_parallel()}}"))
