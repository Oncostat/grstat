

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


# EDCimport -----------------------------------------------------------------------------------

#' @noRd
#' @keywords internal
#' @importFrom EDCimport edc_lookup
get_projname = function(){
  edc_lookup() %>% attr("project_name")
}

#' @noRd
#' @keywords internal
#' @importFrom EDCimport edc_lookup
get_extraction_date = function(){
  edc_lookup() %>% attr("datetime_extraction")
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


#' Clean a string to ASCII
#'
#' @param old_names a character vector to clean
#' @param lower whether to convert it to lowercase
#' @param from the current encoding. passed on to [iconv()]. `""` is the current locale.
#'
#' @keywords internal
#' @noRd
#' @importFrom stringr str_remove_all str_replace_all str_trim str_remove
#' @source inspired by `janitor:::old_make_clean_names()`
#' @examples
#' x = c(
#'   "  \r\n \"Âge ≥ 18%\"  (inclusion)  <= 30% -  Visite #1 / 'CR/PR' \n  ",
#'   "Consentement signé ? (Oui/Non) - Date (JJ/MM/AAAA)\n",
#'   "Événement indésirable >= Grade 3 (CTCAE v5.0) / Lié au ttt (%)",
#'   "PS ECOG (0–4) ; baseline...  ",
#'   "Hb (g/dL) <= 10.0 ; NFS: neutro ≥ 1.5 G/L",
#'   "Réponse RECIST 1.1 - Best overall response (CR/PR/SD/PD)  "
#' )
#' normalize_string(x)
normalize_string = function (string, lower=TRUE, from = "") {
  if(isTRUE(lower)) string = tolower(string)

  string %>%
    str_replace_all("<=|<|\u2264", "inf") %>%
    str_replace_all(">=|>|\u2265", "sup") %>%
    iconv(from = from, to = "ASCII//TRANSLIT") %>%
    str_trim() %>%
    str_remove_all("['\"\r\n]") %>%
    str_replace_all("%", "pct") %>%
    str_replace_all("[^A-Za-z0-9._]+", "_") %>%
    str_replace_all("[\\._]+", "_") %>%
    str_remove("^_+|_+$")
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

can_be_logical = function(v) {
  is.logical(v) ||
    (is.numeric(v) && all(v %in% c(0, 1, NA))) ||
    (is.character(v) && all(v %in% c("TRUE", "FALSE", NA)))
}


# Burgled -------------------------------------------------------------------------------------


#' @source vctrs
`%0%` = function(x, y) {
  if(length(x)==0) y else x
}
