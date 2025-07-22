survfit_stack = function(data, surv_list){
  check_installed("survival", "for `survfit_stack()` to work")
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
    list_rbind()

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
    list_rbind()

  f = if(is_installed("ggsurvfit")) ggsurvfit::survfit2 else survival::survfit
  f(formula=survival::Surv(stacked_time, stacked_time2, stacked_event) ~ stacked_survtype,
    data = data_stack)
}

