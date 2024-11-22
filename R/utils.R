

#' any_of() with case sensitivity
#' @noRd
#' @keywords internal
#' @importFrom tidyselect matches
any_of2 = function(x, ignore.case=TRUE, ...){
  matches(paste(paste0("^",x,"$"), collapse="|"), ignore.case=ignore.case, ...)
}

#' @noRd
#' @keywords internal
#' @importFrom stringr str_replace_all str_to_lower
to_snake_case = function(str) {
  str %>%
    str_replace_all("([a-z])([A-Z])", "\\1_\\2") %>%
    str_replace_all("[^\\w\\s]", "") %>%
    str_replace_all("\\s+", "_") %>%
    str_to_lower()
}

#' `fct_relevel` to the end, without warning for missing levels
#' @noRd
#' @keywords internal
#' @importFrom dplyr intersect
#' @importFrom forcats fct_relevel
fct_last = function(f, ...) {
  lvl = c(...)
  lvl = intersect(lvl, levels(f))
  fct_relevel(f, lvl, after = Inf)
}

#' @noRd
#' @keywords internal
percent = function(x, digits=0){
  stopifnot(abs(x)<=1)
  x=round(x*100, digits)
  paste0(x,"%")
}

#' @noRd
#' @keywords internal
today_ymd = function() {
  format(Sys.Date(), "%Y-%m-%d")
}


# Labels --------------------------------------------------------------------------------------

#' @noRd
#' @keywords internal
#' @importFrom dplyr across cur_column mutate
#' @importFrom purrr map_chr
#' @importFrom tidyselect everything
copy_label_from = function(x, from){
  if(!is.list(x)){
    from_label = attr(from, "label")
    if(is.null(from_label)) return(x)
    attr(x, "label") = from_label
    return(x)
  }
  from_labs = map_chr(from, ~attr(.x, "label") %||% NA)
  mutate(x, across(everything(), ~{
    attr(.x, "label") = from_labs[cur_column()]
    .x
  }))
}


#' @noRd
#' @keywords internal
set_label = function(x, lab){
  attr(x, "label") = lab
  x
}

#' @noRd
#' @keywords internal
#' @importFrom purrr map map2
#' @importFrom rlang is_null
get_label = function(x, default=names(x)){
  if (is.list(x)) {
    if (is.null(default)) default = rep(NA, length(x))
    lab = x %>% map(get_label) %>% map2(default, ~{
      if (is.null(.x)) .y else .x
    })
  } else {
    lab = attr(x, "label", exact=TRUE)
    if (is_null(lab)) lab = default
  }
  lab
}


# NA.RM ---------------------------------------------------------------------------------------

max_narm = function(x, na.rm=TRUE) {
  if(all(is.na(x))) {
    if(is.numeric(x)) return(NA_real_)
    return(NA)
  }
  max(x, na.rm=na.rm)
}

min_narm = function(x, na.rm=TRUE) {
  if(all(is.na(x))) {
    if(is.numeric(x)) return(NA_real_)
    return(NA)
  }
  min(x, na.rm=na.rm)
}


# Classes -------------------------------------------------------------------------------------

add_class = function(x, value){
  class(x) = c(value, class(x))
  x
}

#' @importFrom dplyr setdiff
remove_class = function(x, value){
  class(x) = setdiff(class(x), value)
  x
}
