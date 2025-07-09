

# Assertions ----------------------------------------------------------------------------------
#to avoid dependency on checkmate


#' @noRd
#' @keywords internal
#' @examples
#' assert(1+1==2)
#' assert(1+1==4)
#' @importFrom cli cli_abort
#' @importFrom glue glue
#' @importFrom rlang caller_arg
assert = function(x, msg=NULL, call=parent.frame()){
  if(is.null(msg)){
    x_str = caller_arg(x)
    msg = glue("`{x_str}` is FALSE")
  }
  if(!x){
    cli_abort(msg, call=call)
  }
  invisible(TRUE)
}

#' @noRd
#' @keywords internal
#' @importFrom cli cli_abort
assert_class = function(x, class, null.ok=TRUE){
  if(is.null(x) && null.ok) return(invisible(TRUE))
  if(!inherits(x, class)){
    cli_abort("{.arg {caller_arg(x)}} should be of class {.cls {class}}, not  {.cls {class(x)}}",
              call=parent.frame())
  }
  invisible(TRUE)
}


#' @importFrom cli cli_abort
#' @importFrom purrr discard
#' @importFrom rlang caller_arg
assert_names_exists = function(df, l){
  df_name = caller_arg(df)
  not_found = l %>%
    discard(is.null) %>%
    discard(~tolower(.x) %in% tolower(names(df)))
  if(length(not_found)>0){
    a = paste0(names(not_found), "='", not_found, "'")
    cli_abort("Columns not found in {.arg {df_name}}: {.val {a}}",
              class="grstat_name_notfound_error")
  }
}

#' @importFrom cli cli_abort
#' @importFrom purrr keep
#' @importFrom tibble lst
assert_not_null = function(...){
  nulls = lst(...) %>% keep(is.null) %>% names()
  if(length(nulls)>0){
    cli_abort("Variable{?s} {.arg {nulls}} cannot be NULL.",
              class="grstat_var_null")
  }
}

# Checks --------------------------------------------------------------------------------------

#' @importFrom cli cli_warn
#' @importFrom rlang caller_call
grstat_dev_warn = function(){
  fn_name =as.character(caller_call()[[1]])
  cli_warn(c("The function {.fn {fn_name}} is currently under development
              and is not validated yet.",
             "Always check the result, and give a feedback to the dev team if possible."),
           .frequency = "regularly", .frequency_id=paste0("grstat_warn_dev__", fn_name),
           class="grstat_dev_warn")
}

#' @importFrom cli cli_abort cli_vec cli_warn format_inline
#' @importFrom dplyr pull
grstat_data_warn = function (.data, message, subjid, max_subjid=5,
                             class="grstat_data_warn"){
  if (missing(max_subjid))
    max_subjid = getOption("grstat_warn_max_subjid", max_subjid)

  if (nrow(.data) > 0) {
    message = format_inline(message)
    par_subj = ""
    subj = NULL
    if (!is.null(subjid)) {
      col_found = tolower(subjid) %in% tolower(names(.data))
      if (sum(col_found) > 1) {
        cli_warn("Found {length(col_found)} subject identifiers in the input dataset:\n                 {.val {subjid[col_found]}}. Defaulting to the first one.",
                 class = "grstat_data_warn_subjid_multiple_warn",
                 call = parent.frame())
        subjid = subjid[col_found][1]
      }
      if (!any(col_found)) {
        cli_abort("Could not find column {subjid} in the input dataset.",
                  class = "grstat_data_warn_subjid_error",
                  call = parent.frame())
      }
      # browser()
      .subjid = subjid
      subj0 = .data %>% pull(any_of2(.subjid)) %>% unique() %>% sort()
      subj = paste0("#", subj0) %>%
        cli_vec(style = list(vec_trunc = max_subjid, `vec-trunc-style` = "head"))
      par_subj = format_inline(" ({length(subj0)} patient{?s}: {subj})")
    }
    cli_warn("{message}{par_subj}", class=class)
  }
  invisible(.data)
}

# Misc ----------------------------------------------------------------------------------------


#' @noRd
#' @keywords internal
is.Date = function (x) {
  inherits(x, "POSIXt") || inherits(x, "POSIXct") || inherits(x, "Date")
}
