
#' Graphic representation of AEs
#'
#' Produce a graphic representation of AE, counting AE as bars for each patient, colored by grade. Can be faceted by treatment arm.
#'
#' @inheritParams ae_table_grade
#' @param type whether to present patients as proportions (`relative`) or as counts (`absolute`)
#' @param position Position adjustment (cf. [ggplot2::geom_col()])
#'
#' @return a ggplot
#' @export
#' @importFrom cli cli_warn
#' @importFrom dplyr across cur_group mutate n
#' @importFrom forcats as_factor
#' @importFrom ggplot2 aes element_text facet_wrap geom_col ggplot labs position_dodge position_fill position_stack scale_y_continuous theme
#' @importFrom scales label_percent
#' @importFrom tidyr pivot_longer
#' @examples
#' tm = grstat_example()
#' attach(tm, warn.conflicts=FALSE)
#' ae_plot_grade(data_ae=ae, data_pat=enrolres)
#' ae_plot_grade(data_ae=ae, data_pat=enrolres, arm="ARM", measure=c("sup", "max"))
#' ae_plot_grade(data_ae=ae, data_pat=enrolres, arm="ARM", type="absolute")
#' ae_plot_grade(data_ae=ae, data_pat=enrolres, arm="ARM", position="fill")
#' ae_plot_grade(data_ae=ae, data_pat=enrolres, arm="ARM", position="stack", type="absolute")
ae_plot_grade = function(
  data_ae, ..., data_pat,
  measure = c("max", "sup", "eq"),
  position = c("dodge", "stack", "fill"),
  type = c("relative", "absolute"),
  arm=NULL, grade="AEGR", subjid="SUBJID", total=FALSE,
  na_strategy = list(display="always", grouped=TRUE)
){
  dots = list(...)
  data_ae = if(has_name(dots, "df_ae")) dots$df_ae else data_ae  
  data_pat = if(has_name(dots, "df_enrol")) dots$df_enrol else data_pat
  measure = if(has_name(dots, "variant")) dots$variant else measure
  # browser()
  check_dots_empty2(except = c("df_ae", "df_enrol", "variant"))
  
  na_strategy = if(is_missing(na_strategy)) na_strategy else getOption("ae_table_grade_na_strategy", na_strategy)
  type = match.arg(type)
  position = match.arg(position)

  if(type=="relative" && position=="stack"){
    type = "absolute"
    cli_warn('{.arg type} has been corrected to {.val absolute} to
             be consistent with `position="stack"`.')
  }
  if(type=="relative" || position=="fill"){
    percent_pattern = "{as.numeric(p)/100}"
    y_lab = "Patient proportion"
    add_layer = scale_y_continuous(labels=label_percent(), limits=0:1)
  } else {
    percent_pattern = "{n}"
    y_lab = "Patient count"
    add_layer = NULL
  }

  fill_aes = NULL
  if(!is.null(arm)){
    data_pat = data_pat %>%
      # mutate(arm = if(is.null(.env$arm)) "All Patients" else .data$arm) %>%
      mutate(arm2 = paste0(cur_group()[[1]], " (N=", n(), ")"),
             .by=any_of2(arm))
    arm="arm2"
    fill_aes = aes(fill=name)
  }

  tbl = ae_table_grade(data_ae=data_ae, data_pat=data_pat, measure=measure,
                       arm=arm, grade=grade, subjid=subjid, percent_digits=0,
                       percent_pattern=percent_pattern, total=total, na_strategy=na_strategy)
  p = switch(position, fill=position_fill(), stack=position_stack(),
             dodge=position_dodge(0.9))

  tbl %>%
    # filter(.id!="missing") %>%
    mutate(across(-c(.id, measure, level), ~as.numeric(as.character(.x)))) %>%
    pivot_longer(-c(.id, measure, level)) %>%
    mutate(measure=as_factor(measure)) %>%
    ggplot(aes(x=level, y=value)) + fill_aes +
    geom_col(position=p) +
    labs(x=NULL, fill=NULL, y=y_lab) +
    facet_wrap(~measure, scales="free_x", space="free_x", nrow=1) +
    add_layer +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
          legend.position="top")
}



