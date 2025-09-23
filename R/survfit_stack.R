#' Stack multiple survival endpoints into a single `survfit2` object
#'
#' This function combines several survival endpoints from the same dataset by stacking them
#' into a long format and fitting a single `survfit` object.
#' It does **not** support competing risks models (i.e., when the event variable is a factor).
#'
#' @param data A data frame containing the survival variables.
#' @param surv_list A named list where each element is a character vector of:
#'
#' - Length 2: `time`, `event` (for standard right-censored survival)
#' - Length 3: `time1`, `time2`, `event` (for interval-censored survival and left truncation)
#'
#' The names of the list elements will be used as a grouping variable in the output.
#'
#' @return A `survfit` object (or `survfit2` if `ggsurvfit` is installed)
#'
#' @importFrom rlang check_installed is_named
#' @importFrom cli cli_abort
#' @export
#'
#' @examples
#' library(dplyr)
#' set.seed(42)
#' df_surv = survival::lung %>%
#'   as_tibble() %>%
#'   mutate(
#'     time_os = time,
#'     event_os = status == 2,
#'     time_pfs = time / (1 + runif(n())),
#'     event_pfs = ifelse(runif(n()) > 0.3, event_os, 1),
#'     time_efs = time_pfs / (1 + runif(n())),
#'     event_efs = ifelse(runif(n()) > 0.3, event_pfs, 1)
#'   )
#'
#' surv_list = list(
#'   "Overall survival" = c("time_os", "event_os"),
#'   "Progression-free survival" = c("time_pfs", "event_pfs"),
#'   "Event-free survival" = c("time_efs", "event_efs")
#' )
#'
#' if(require("ggsurvfit")){
#'
#'   df_surv %>%
#'     survfit_stack(surv_list=surv_list) %>%
#'     ggsurvfit() +
#'     add_confidence_interval() +
#'     add_risktable() +
#'     scale_ggsurvfit()
#'
#' }
survfit_stack = function(data, surv_list){
  check_installed("survival", "for `survfit_stack()` to work")
  grstat_dev_warn()
  assert(is_named(surv_list))
  l = lengths(surv_list)
  if(all(l==2)){
    rtn = .survfit_stack_2(data, surv_list)
  } else if (all(l==3)){
    rtn = .survfit_stack_3(data, surv_list)
  } else {
    cli_abort("All {.arg surv_list} members should be of length 2 or 3, not {.val {l}}.",
              class="survfit_stack_length_error")
  }
  rtn
}


# Internals -----------------------------------------------------------------------------------



#' @noRd
#' @importFrom dplyr all_of select
#' @importFrom purrr imap list_rbind
#' @importFrom rlang is_installed
.survfit_stack_2 = function(data, surv_list){
  data_stack = surv_list %>%
    imap(~{
      df = data %>%
        select(stacked_time = all_of(.x[1]),
               stacked_event = all_of(.x[2])) %>%
        mutate(stacked_survtype = .y)

      assert(is.numeric(df[["stacked_time"]]),
             msg='Cannot coerse {.arg surv_list[["{ .y}"]]["{ .x[1]}"]} to numeric.')
      assert(can_be_logical(df[["stacked_event"]]),
             msg='Cannot coerse {.arg surv_list[["{ .y}"]]["{ .x[2]}"]} to logical.')
      df
    }) %>%
    list_rbind() %>%
    mutate(stacked_survtype=factor(stacked_survtype, levels=names(surv_list)))

  f = if(is_installed("ggsurvfit")) ggsurvfit::survfit2 else survival::survfit
  f(formula=survival::Surv(stacked_time, stacked_event) ~ stacked_survtype,
    data = data_stack)
}

#' @noRd
#' @importFrom dplyr all_of select
#' @importFrom purrr imap list_rbind
#' @importFrom rlang is_installed
.survfit_stack_3 = function(data, surv_list){
  data_stack = surv_list %>%
    imap(~{
      df = data %>%
        select(stacked_time = all_of(.x[1]),
               stacked_time2 = all_of(.x[2]),
               stacked_event = all_of(.x[3])) %>%
        mutate(stacked_survtype = .y)

      assert(is.numeric(df[["stacked_time"]]),
             msg="Cannot coerse {.arg surv_list[[{ .y}]][{ .x[1]}]} to numeric.")
      assert(is.numeric(df[["stacked_time2"]]),
             msg="Cannot coerse {.arg surv_list[[{ .y}]][{ .x[2]}]} to numeric.")
      assert(can_be_logical(df[["stacked_event"]]),
             msg="Cannot coerse {.arg surv_list[[{ .y}]][{ .x[3]}]} to logical.")
      df
    }) %>%
    list_rbind() %>%
    mutate(stacked_survtype=factor(stacked_survtype, levels=names(surv_list)))

  f = if(is_installed("ggsurvfit")) ggsurvfit::survfit2 else survival::survfit
  f(formula=survival::Surv(stacked_time, stacked_time2, stacked_event) ~ stacked_survtype,
    data = data_stack)
}

