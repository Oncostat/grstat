
#' Graphic representation of AEs
#'
#' `r lifecycle::badge("experimental")`\cr
#' Produce an alternative graphic representation of AE, counting AE as bars for each patient, colored by grade. Can be faceted by treatment arm.
#'
#' @param weights (optional) a length 5 numeric vector, giving the weights of each grade
#' @param low the color of Grade 1 AE
#' @param high the color of Grade 5 AE
#' @param grade name of the AE grade column in `data_ae`. Case-insensitive.
#' @param subjid name of the patient ID in both `data_ae` and `data_pat`. Case-insensitive.
#' @inheritParams ae_table_soc
#' @inherit ae_table_soc seealso
#'
#' @return a ggplot
#' @export
#' @importFrom dplyr across any_of arrange count left_join mutate rename_with select
#' @importFrom forcats fct_infreq fct_rev
#' @importFrom ggplot2 aes element_blank facet_grid geom_col ggplot labs scale_color_manual scale_fill_manual theme vars
#' @importFrom glue glue
#' @importFrom rlang has_name int
#' @importFrom tibble deframe lst
#' @importFrom tidyr replace_na
#'
#' @examples
#' tm = grstat_example()
#' attach(tm, warn.conflicts=FALSE)
#' ae_plot_grade_sum(data_ae=ae, data_pat=enrolres)
#' ae_plot_grade_sum(data_ae=ae, data_pat=enrolres, arm="ARM")
#' ae_plot_grade_sum(data_ae=ae, data_pat=enrolres, arm="ARM", weights=c(1,1,3,6,10))
ae_plot_grade_sum = function(
    data_ae, ..., data_pat,
    low="#ffc425", high="#d11141",
    weights=NULL,
    arm=NULL, grade="AEGR", subjid="SUBJID"
){
  dots = list(...)
  data_ae = if(has_name(dots, "df_ae")) dots$df_ae else data_ae
  data_pat = if(has_name(dots, "df_enrol")) dots$df_enrol else data_pat
  assert_names_exists(data_ae, lst(subjid, grade))
  assert_names_exists(data_pat, lst(subjid, arm))
  check_dots_empty2(except = c("df_ae", "df_enrol"))

  weighted = !is.null(weights)
  if(!weighted) weights=c(1,1,1,1,1)
  assert(is.numeric(weights))
  assert(length(weights)==5)

  data_ae = data_ae %>% rename_with(tolower) %>%
    select(subjid=tolower(subjid), grade=tolower(grade))
  data_pat = data_pat %>% rename_with(tolower) %>%
    select(subjid=tolower(subjid), arm=tolower(arm))

  df = data_pat %>%
    left_join(data_ae, by=tolower(subjid)) %>%
    mutate(grade = .fix_grade_na(grade),
           weight = weights[grade] %>% replace_na(0.1)) %>%
    arrange(subjid)

  default_arm = "All patients"
  if(!is.null(arm)){
    npat = deframe(count(data_pat, arm))
    npat["Total"] = sum(npat)
  } else {
    df$arm = default_arm
    npat = int(!!default_arm:=nrow(data_pat))
  }

  y_lab = "Count"; caption = NULL
  if(weighted){
    y_lab = "Weighted count"
    caption = paste0("Grade ", 1:5, " = ", weights, collapse=", ")
    caption = paste("Weights: ", caption)
  }

  pal = scales::pal_gradient_n(c(low, high))(seq(0, 1, length.out=5))

  rtn =
    df %>%
    mutate(
      arm = glue("{arm} (N={npat[arm]})"),
      subjid = fct_infreq(factor(subjid), w=weight)
    ) %>%
    count(across(c(subjid, grade, any_of("arm"))), wt=weight) %>%
    mutate(
      n = ifelse(is.na(grade), 0.1, n),
      grade = fct_rev(factor(grade))
    ) %>%
    ggplot(aes(x=subjid, y=n, fill=grade, color=grade)) +
    scale_fill_manual(values=rev(pal)) +
    scale_color_manual(values=rev(pal), guide="none") +
    geom_col() +
    theme(axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          panel.grid.major.x = element_blank()) +
    labs(x="Patient", y=y_lab, fill="AE grade", caption=caption)

  if(!is.null(arm)) rtn = rtn + facet_grid(cols=vars(arm), scales="free_x")

  rtn
}


#' @rdname ae_plot_grade_sum
#' @usage NULL
#' @export
ae_plot_grade_n = ae_plot_grade_sum
