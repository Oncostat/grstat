


#' Generate a waterfall plot
#'
#' `r lifecycle::badge("experimental")`\cr
#'
#' @param data_recist recist dataset
#' @param rc_sum name of the target lesions length sum column in `data_recist`, usually "RCTLSUM".
#' @param rc_resp name of the response column in `data_recist`, usually "RCRESP".
#' @param rc_date name of the date column in `data_recist`, usually "RCDT".
#' @param rc_star name of the column in `data_recist` that triggers the star symbol. The column should be character or factor, with `NA` for patients without symbol.
#' @param arm name of the treatment column in `data_recist`. Can be left to `NULL` to not group.
#' @param subjid name of the subject identifier column in `data_recist`.
#' @param warnings whether to warn about any problems
#' @param ... unused
#'
#' @section Methods:
#' Data are ordered on `rc_date`.
#'
#'
#' @return a ggplot
#' @export
#' @importFrom cli cli_abort
#' @importFrom dplyr arrange case_when desc distinct filter mutate n_distinct select
#' @importFrom forcats as_factor
#' @importFrom ggplot2 aes facet_wrap geom_col geom_hline geom_point ggplot labs scale_fill_manual scale_shape_manual scale_x_discrete scale_y_continuous
#' @importFrom scales breaks_width label_percent
#' @importFrom stringr str_detect
#' @importFrom tidyr replace_na
#'
#' @examples
#'
#' \dontrun{
#' waterfall_plot(rc, rc_date="RCDT", rc_sum="RCTLSUM", rc_resp="RCRESP")
#' rc %>%
#'   left_join(enrolres, by="SUBJID") %>% #adds the ARM column
#'   mutate(new_lesion = ifelse(RCNEW=="1-Yes", "New lesion", NA)) %>%
#'   waterfall_plot(rc_date="RCDT", rc_sum="RCTLSUM", rc_resp="RCRESP",
#'                  arm="ARM", rc_star="new_lesion")
#'}
waterfall_plot = function(data_recist, ..., rc_sum="RCTLSUM", rc_resp="RCRESP", rc_date="RCDT",
                          rc_star=NULL, arm=NULL, subjid="SUBJID",
                          warnings=getOption("grstat_wp_warnings", TRUE)) {
  assert_class(data_recist, class="data.frame")
  assert_class(rc_sum, class="character")
  assert_class(rc_resp, class="character")
  assert_class(rc_date, class="character")
  assert_class(rc_star, class="character")
  assert_class(arm, class="character")
  assert_class(warnings, class="logical")
  responses = c("Complete response"="#42B540FF", "Partial response"="#006dd8",
                "Stable disease"="#925E9F", "Progressive disease"="#ED0000", "Missing"="white")


  db_wf = calc_best_response(data_recist=data_recist, rc_sum=rc_sum, rc_resp=rc_resp,
                             rc_date=rc_date, subjid=subjid,
                             warnings=warnings)

  star_layer = NULL
  if(!is.null(rc_star)){
    star_nudge = 0.05
    star_layer = list(
      geom_point(aes(y=diff_first + sign(diff_first)*star_nudge, shape=rc_star), na.rm=TRUE),
      scale_shape_manual(values=unique(c(8, 0:25)), name=NULL, na.translate = FALSE)
    )
  }

  fill_lab = "Best global response \n(RECIST v1.1)"

  p =
  db_wf %>%
    ggplot(aes(x=subjid, y=diff_first, group=subjid, fill=resp2)) +
    geom_hline(yintercept=c(-.3, .2), linetype="dashed") +
    geom_col(color='black') +
    star_layer +
    scale_x_discrete(labels = NULL, breaks = NULL) +
    scale_y_continuous(labels=label_percent(), breaks=breaks_width(0.2)) +
    scale_fill_manual(values=responses) +
    labs(x = "", y="Percentage of tumor reduction from baseline", fill=fill_lab)

  if(!is.null(arm)) p = p + facet_wrap(~arm, scales="free_x", ncol=1)
  p
}

