
#' Waterfall plot for RECIST best response data
#'
#' Creates a waterfall plot showing the best percent change from baseline in
#' target lesion size for each subject.
#'
#' The input data must contain **one row per subject**, use [calc_best_response()]
#' to convert from long-format RECIST data.
#'
#' Bars are drawn for individual subjects, optionally faceted by treatment arm.
#' Horizontal dashed reference lines are added at -30\% and +20\%, corresponding
#' to common RECIST response thresholds.
#'
#' @param data A data frame with one row per subject, typically produced by
#'   [calc_best_response()].
#' @param ... Not used. Ensures that only named arguments are passed.
#' @param y Name of the numeric column used for the bar height. Defaults to
#'   `"target_sum_diff_first"`.
#' @param fill Name of the categorical column used for bar fill color. Defaults
#'   to `"best_response"`.
#' @param shape Optional name of a categorical column used to add a symbol
#'   above or below each bar.
#' @param arm Optional name of a column used to facet the plot by treatment arm.
#' @param subjid Name of the subject identifier column. Defaults to `"SUBJID"`.
#' @param resp_colors Named vector of colors used for RECIST response categories.
#' @param warnings Logical. If `TRUE`, warnings are emitted when missing values
#'   are detected in plotted variables.
#'
#' @export
#' @importFrom dplyr all_of mutate rename
#' @importFrom ggplot2 aes facet_wrap geom_col geom_hline ggplot labs scale_fill_manual scale_x_discrete scale_y_continuous theme_minimal
#' @importFrom rlang check_dots_empty
#' @importFrom scales breaks_width label_percent
#' @importFrom cli cli_warn
#'
#' @return A `ggplot` object.
#'
#' @seealso [calc_best_response()]
#'
#' @examples
#' db = grstat_example(N=50)
#' data_best_resp = calc_best_response(db$recist)
#'
#' # Basic waterfall plot
#' waterfall_plot(data_best_resp)
#'
#' # Facet by arm
#' data_best_resp %>%
#'   dplyr::left_join(db$enrolres, by="subjid") %>%
#'   waterfall_plot(arm="ARM")
#'
#'
#' # Add symbols
#' set.seed(0)
#' data_symbols = db$recist %>%
#'   dplyr::summarise(
#'     new_lesion=ifelse(any(rcnew=="Yes", na.rm=TRUE), "New lesion", NA),
#'     example_event=cut(runif(1), breaks=c(0,0.05,0.1,1), labels=c("A", "B", NA)),
#'     .by=subjid
#'   )
#'
#' data_best_resp %>%
#'   dplyr::left_join(data_symbols, by="subjid") %>%
#'   waterfall_plot(shape="new_lesion")
#'
#' data_best_resp %>%
#'   dplyr::left_join(data_symbols, by="subjid") %>%
#'   waterfall_plot(shape="example_event") +
#'   ggplot2::labs(shape="Event")
waterfall_plot = function(data, ...,
                          y="target_sum_diff_first", fill="best_response",
                          shape=NULL, arm=NULL, subjid="SUBJID",
                          resp_colors = c("CR"="#42b540", "PR"="#006dd8", "SD"="#925e9f",
                                          "PD"="#ed0000", "NA"="white"),
                          warnings=getOption("grstat_wp_warnings", TRUE)) {
  assert_class(y, class="character")
  assert_class(fill, class="character")
  assert_class(shape, class="character")
  assert_class(arm, class="character")
  assert_class(warnings, class="logical")
  assert_class(data, class="data.frame")
  .check_legacy(data, subjid)
  check_dots_empty()
  assert_names_exists(data, c(y, fill, subjid))

  y_lab = "Target lesions reduction from baseline"
  if(y!="target_sum_diff_first") y_lab=y
  fill_lab = "Best Global Response \n(RECIST v1.1)"

  db_wf = data %>%
      select(subjid=any_of2(subjid), shape=any_of2(shape), arm=any_of2(arm),
             resp=all_of(fill), y=all_of(y)) %>%
      mutate(subjid = fct_reorder2(as.character(subjid), as.numeric(resp),
                                   y, .na_rm=FALSE))
  fill_scale = .get_fill_scale(db_wf, resp_colors)

  db_wf_missing = db_wf %>% 
    filter(if_any(-any_of("shape"), ~is.na(.x) & !is.nan(.x))) %>% 
    select(subjid, where(~any(is.na(.x) & !is.nan(.x))), -any_of("shape"))
  if(nrow(db_wf_missing) > 0 && warnings){
    cli_warn(c("!" = "Missing values detected in {.fun waterfall_plot}.",
              "i" = "Subjects with missing values: {.val {db_wf_missing$subjid}}.",
              "i" = "Columns with missing values: {.val {colnames(db_wf_missing)[-1]}}."),
            class="waterfall_plot_missing_warning")
  }
  
  p =
  db_wf %>%
    ggplot() +
    aes(x=subjid, y=y, fill=resp) +
    geom_hline(yintercept=c(-.3, .2), linetype="dashed") +
    geom_col(color='black') +
    .get_shape_layer(shape, shape_nudge=0.05) +
    scale_x_discrete(labels = NULL, breaks = NULL) +
    scale_y_continuous(labels=label_percent(), breaks=breaks_width(0.2)) +
    scale_fill_manual(values=fill_scale) +
    labs(x = "", y=y_lab, fill=fill_lab) +
    theme_minimal() +
    guides(
      color = guide_legend(order = 1),
      shape = guide_legend(order = 2),
    )

  if(!is.null(arm)) p = p + facet_wrap(~arm, scales="free_x", ncol=1)
  p
}


#' @importFrom cli cli_abort
.check_legacy = function(data, subjid) {
  dup_id = duplicated(data[[subjid]])
  if(any(dup_id)){
    dup = sort(unique(data[[subjid]][dup_id]))
    cli_abort(c(
      "x" = "{.help [{.fun waterfall_plot}](grstat::waterfall_plot)} does not support long-format datasets as of {.pkg grstat v0.1.0.9010}.",
      "i" = "Multiple rows per subject were detected: {.val {dup}}.",
      "v" = "Use {.help [{.fun calc_best_response}](grstat::calc_best_response)} first to reshape the data.",
      ">" = "See the examples in the documentation for guidance."
    ),
    class="waterfall_plot_legacy_error")
  }
}


#' @importFrom ggplot2 aes geom_point guide_legend guides labs scale_shape_manual
.get_shape_layer = function(shape, shape_nudge = 0.05){
  if(is.null(shape)) return(NULL)
  list(
    geom_point(aes(y=y + sign(y)*shape_nudge, shape=shape),
               na.rm=TRUE),
    scale_shape_manual(values=unique(c(8, 0:25)), na.translate=FALSE),
    guides(fill = guide_legend(override.aes = list(shape = NA))),
    labs(shape=NULL)
  )
}


#' @importFrom dplyr distinct mutate select
#' @importFrom tibble deframe
.get_fill_scale = function(data, resp_colors){
  resp_colors = c("CR"="#42b540", "PR"="#006dd8", "SD"="#925e9f", "PD"="#ed0000", "NA"="white")
  resp_colors = resp_colors[c("CR", "PR", "SD", "PD", "NA")]
  fill_scale = data %>%
    distinct(resp, resp_num = .recist_to_num(resp)) %>%
    mutate(color=resp_colors[resp_num]) %>%
    select(resp, color) %>%
    deframe()
}
