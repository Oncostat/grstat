

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


#' @noRd
#' @keywords internal
check_dots_empty2 = function(except=character(0), env = rlang::caller_env()) {
  dots = substitute(...(), env = env)
  if (length(dots) == 0) return(invisible())
  
  nms0 = names(dots) %0% rep("", n)
  nms = ifelse(nms0 == "", paste0("..", seq_along(dots)), nms0)
  dots = dots %>% as.list() %>% set_names(nms) %>% discard_at(except)
  bullets = imap_chr(dots, ~ paste(.y, as_label(.x), sep=" = ")) %>% set_names("*")
  if (length(dots) == 0) return(invisible())

  cli::cli_abort(
    c("!"="`...` must be empty; did you misspell or forget to name an argument?",
      "x" = "Problematic arguments:",
      bullets),
    call = env
  )
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


#' @source EDCimport
#' @importFrom cli cli_warn
#' @importFrom stats na.omit
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
#' @importFrom cli cli_abort
#' @importFrom dplyr case_match case_when setdiff setequal
#' @importFrom purrr map
#' @importFrom stringr str_detect
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


#' @noRd
#' @keywords internal
#' @source GenBinomApps
#' @importFrom stats qbeta
clopper_pearson_ci = function(k, n, alpha = 0.1, CI = "upper"){
  l = round(k)
  if (is.na(k) || k < 0 || max(abs(k - l)) > 1e-07)
    stop("'k' must be nonnegative and integer")
  m = round(n)
  if (is.na(n) || n < k || max(abs(n - m)) > 1e-07)
    stop("'n' must be nonnegative and integer >= k")
  if (alpha < 0 || alpha > 1) {
    stop("'alpha' must be a number between 0 and 1")
  }
  if (CI == "upper") {
    ll = 0
    if (k == n) {
      ul = 1
    } else {
      ul = qbeta(1 - alpha, k + 1, n - k)
    }
  } else if (CI == "lower") {
    ul = 1
    if (k == 0) {
      ll = 0
    } else {
      ll = qbeta(alpha, k, n - k + 1)
    }
  } else if (CI == "two.sided") {
    ll = qbeta(alpha / 2, k, n - k + 1)
    ul = qbeta(1 - alpha / 2, k + 1, n - k)
    if (k == 0) {
      ll = 0
    } else if (k == n) {
      ul = 1
    }
  } else {
    stop("undefined CI detected")
  }
  data.frame(
    Confidence.Interval = CI,
    Lower.limit = ll,
    Upper.limit = ul,
    alpha = alpha,
    row.names = ""
  )
}


