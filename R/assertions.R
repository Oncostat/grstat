

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
    cli_abort("Columns not found in {.arg df_name}: {.val {a}}",
              class="grstat_name_notfound_error")
  }
}

assert_not_null = function(...){
  nulls = lst(...) %>% keep(is.null) %>% names()
  if(length(nulls)>0){
    cli_abort("Variable{?s} {.arg {nulls}} cannot be NULL.",
              class="grstat_var_null")
  }
}


# Misc ----------------------------------------------------------------------------------------


#' @noRd
#' @keywords internal
is.Date = function (x) {
  inherits(x, "POSIXt") || inherits(x, "POSIXct") || inherits(x, "Date")
}
