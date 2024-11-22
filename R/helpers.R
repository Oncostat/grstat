
#' Format factor levels as Yes/No
#'
#' Format factor levels as arbitrary values of Yes/No (with Yes always first) while **leaving untouched** all vectors that contain other information.
#'
#' @param x a vector of any type/class.
#' @param input list of values to be considered as "yes" and "no".
#' @param output the output factor levels.
#' @param strict whether to match the input strictly or use [stringr::str_detect] to find them.
#' @param mutate_character whether to turn characters into factor.
#' @param fail whether to fail if some levels cannot be recoded to yes/no.
#'
#' @return a factor, or `x` untouched.
#' @export
#' @importFrom cli cli_abort
#' @importFrom dplyr case_when setequal
#' @importFrom stringr str_detect
#'
#' @examples
#'
#' fct_yesno(c("No", "Yes")) #levels are in order
#'
#' set.seed(42)
#' N=6
#' x = tibble(
#'   a=sample(c("Yes", "No"), size=N, replace=TRUE),
#'   b=sample(c("Oui", "Non"), size=N, replace=TRUE),
#'   c=sample(0:1, size=N, replace=TRUE),
#'   d=sample(c(TRUE, FALSE), size=N, replace=TRUE),
#'   e=sample(c("1-Yes", "0-No"), size=N, replace=TRUE),
#'
#'   y=sample(c("aaa", "bbb", "ccc"), size=N, replace=TRUE),
#'   z=1:N,
#' )
#'
#' x
#' #y and z are left untouched (or throw an error if fail=TRUE)
#' sapply(x, fct_yesno, fail=FALSE)
#'
#' # as "1-Yes" is not in `input`, x$e is untouched/fails if strict=TRUE
#' fct_yesno(x$e)
#' fct_yesno(x$e, strict=TRUE, fail=FALSE)
#' fct_yesno(x$e, output=c("Ja", "Nein"))
fct_yesno = function(x,
                     input=list(yes=c("Yes", "Oui"), no=c("No", "Non")),
                     output=c("Yes", "No"),
                     strict=FALSE,
                     mutate_character=TRUE,
                     fail=TRUE){
  assert_class(input, "list")
  assert(setequal(names(input), c("yes", "no")))

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
    fun = if(strict=="ignore_case")tolower else identity
    is_yes = fun(x) %in% fun(input$yes)
    is_no  = fun(x) %in% fun(input$no)
  } else {
    is_yes = str_detect(tolower(x), paste(tolower(input$yes), collapse="|"))
    is_no  = str_detect(tolower(x), paste(tolower(input$no ), collapse="|"))
  }
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
