

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

#' @noRd
#' @keywords internal
#' @importFrom cli cli_warn
#' @importFrom dplyr across cur_column mutate setdiff
#' @importFrom rlang current_env
#' @importFrom tibble lst
#' @importFrom tidyselect everything
apply_labels = function(data, ..., warn_missing=FALSE) {
  args = lst(...)
  unknowns = setdiff(names(args), names(data))
  if (length(unknowns) && warn_missing) {
    cli_warn("Cannot find column{?s} in `data`: {.var {unknowns}}",
             class="crosstable_missing_label_warning",
             call=current_env())
  }

  data %>%
    mutate(across(everything(),
                  ~set_label(.x, args[[cur_column()]])))
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



# Burgled -------------------------------------------------------------------------------------


#' @source vctrs
`%0%` = function(x, y) {
  if(length(x)==0) y else x
}


#' @source EDCimport
unify = function (x) {
  rtn = x[1]
  lu = length(unique(na.omit(x)))
  if (lu > 1) {
    cli_warn(c("Unifying multiple values in {.val {caller_arg(x)}}, returning the first one ({.val {rtn})}",
               i = "Unique values: {.val {unique(na.omit(x))}}"))
  }
  rtn_label = get_label(x)
  if (!is.null(rtn_label))
    attr(rtn, "label") = rtn_label
  rtn
}

#' @source EDCimport
fct_yesno = function(x,
                     input=list(yes=c("Yes", "Oui"), no=c("No", "Non"), na=c("NA", "")),
                     output=c("Yes", "No"),
                     strict=FALSE,
                     mutate_character=TRUE,
                     fail=TRUE){
  assert_class(input, "list")
  default_input = list(yes=c("Yes", "Oui"), no=c("No", "Non"), na=c("NA", ""))
  missing_names = setdiff(names(default_input), names(input))
  input[missing_names] = default_input[missing_names]
  assert(setequal(names(input), c("yes", "no", "na")))

  if (!inherits(x, c("logical", "numeric", "integer", "character", "factor"))) return(x)
  if (is.character(x) && isFALSE(mutate_character)) return(x)

  if (missing(input))  input =  getOption("fct_yesno_input", input)
  if (missing(output)) output = getOption("fct_yesno_input", output)

  #if logical or numeric AND binary
  if (all(x %in% c(1, 0, NA))) {
    return(factor(as.numeric(x), levels=c(1,0), labels=output) %>% copy_label_from(x))
  } else if(is.numeric(x)){
    return(x)
  }

  if (!isFALSE(strict)) {
    fun = if(strict=="ignore_case") tolower else identity
    is_yes = fun(x) %in% fun(input$yes)
    is_no  = fun(x) %in% fun(input$no)
    is_na  = fun(x) %in% fun(input$na)
  } else {
    input = map(input, ~case_match(.x, ""~"^$", .default=.x))
    is_yes = str_detect(tolower(x), paste(tolower(input$yes), collapse="|"))
    is_no  = str_detect(tolower(x), paste(tolower(input$no ), collapse="|"))
    is_na  = str_detect(tolower(x), paste(tolower(input$na ), collapse="|"))
  }
  x[is_na] = NA

  if (any(is_yes&is_no, na.rm=TRUE)) {
    v = x[!is.na(x) & is_yes & is_no]
    cli_abort("Values that are both yes and no: {.val {v}}",
              class="fct_yesno_both_error")
  }
  yesno = case_when(
    is.na(x) ~ NA,
    is_yes ~ TRUE,
    is_no ~ FALSE,
    .default=NA
  )
  if (any(is.na(x) != is.na(yesno))) {
    if(isTRUE(fail)){
      v = x[is.na(x) != is.na(yesno)]
      cli_abort("Values that cannot be parsed: {.val {unique(sort(v))}}",
                class="fct_yesno_unparsed_error")
    }
    return(x)
  }

  factor(yesno, levels=c(TRUE,FALSE), labels=output) %>% copy_label_from(x)
}
