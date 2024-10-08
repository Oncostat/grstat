



# Table ---------------------------------------------------------------------------------------



#' Summary tables for AE
#'
#' @param percent whether to show percentages with counts. Defaults to TRUE. Can also be "only" to not show counts.
#' @inheritParams ae_table_soc
#' @inherit ae_table_soc seealso
#'
#' @return a crosstable
#' @importFrom dplyr arrange case_match case_when cur_group filter left_join mutate rename_with select summarise
#' @importFrom forcats fct_relevel fct_reorder
#' @importFrom rlang check_dots_empty check_installed
#' @importFrom stringr str_remove str_starts str_subset
#' @importFrom tibble lst
#' @importFrom tidyselect matches
#' @export
#'
#' @examples
#' tm = grstat_example()
#' attach(tm, warn.conflicts=FALSE)
#'
#' if(require(flextable)){
#'
#' ae_table_grade(df_ae=ae, df_enrol=enrolres, arm=NULL) %>%
#'   as_flextable(header_show_n=TRUE)
#'
#' ae_table_grade(df_ae=ae, df_enrol=enrolres, arm="ARM") %>%
#'   as_flextable(header_show_n=TRUE)
#'
#' #To get SAE only, filter df_ae first
#' library(dplyr)
#' ae %>%
#'   filter(sae=="Yes") %>%
#'   ae_table_grade(df_enrol=enrolres, arm="ARM") %>%
#'   dplyr::mutate_all(~stringr::str_replace(.x, "AE", "SAE")) %>%
#'   as_flextable(header_show_n=TRUE)
#'
#' }
ae_table_grade = function(
    df_ae, ..., df_enrol,
    variant=c("max", "sup", "eq"),
    arm=NULL, grade="AEGR", subjid="SUBJID",
    percent=TRUE,
    total=TRUE
){
  check_installed("crosstable", "for `ae_table_grade()` to work.")
  check_dots_empty()

  assert_names_exists(df_ae, lst(subjid, grade))
  assert_names_exists(df_enrol, lst(subjid, arm))

  if(missing(total) && is.null(arm)) total = FALSE
  if(total) total = "row"
  default_arm = set_label("All patients", "Treatment arm")

  df_ae = df_ae %>% rename_with(tolower) %>%
    select(subjid=tolower(subjid), grade=tolower(grade))
  df_enrol = df_enrol %>% rename_with(tolower) %>%
    select(subjid=tolower(subjid), arm=tolower(arm)) %>%
    mutate(arm=if(is.null(.env$arm)) default_arm else .data$arm)

  df = df_enrol %>%
    left_join(df_ae, by=tolower(subjid)) %>%
    arrange(subjid) %>%
    mutate(
      grade = fix_grade(grade),
    )

  variant = case_match(variant, "max"~"max_grade", "sup"~"any_grade_sup",
                       "eq"~"any_grade_eq")
  rex = variant %>% paste(collapse="|") %>% paste0("^(", ., ")")

  percent_pattern = if(isTRUE(percent)) "{n} ({scales::percent(n/n_col_na,1)})"
                    else if(percent=="only") "{n/n_col}" else "{n}"
  percent_pattern = list(body=percent_pattern, total_col=percent_pattern)

  lab_no_ae = "No declared AE"

  rtn = df %>%
    summarise(
      max_grade_na = case_when(!cur_group()$subjid %in% df_ae$subjid ~ lab_no_ae,
                              all(is.na(grade), na.rm=TRUE) ~ "Grade all missing",
                              .default="foobar"),
      max_grade_1 = ifelse(max_narm(grade) == 1 , "Grade 1", "foobar"),
      max_grade_2 = ifelse(max_narm(grade) == 2 , "Grade 2", "foobar"),
      max_grade_3 = ifelse(max_narm(grade) == 3 , "Grade 3", "foobar"),
      max_grade_4 = ifelse(max_narm(grade) == 4 , "Grade 4", "foobar"),
      max_grade_5 = ifelse(max_narm(grade) == 5 , "Grade 5", "foobar"),
      any_grade_sup_na   = case_when(!cur_group()$subjid %in% df_ae$subjid ~ lab_no_ae,
                                     any(is.na(grade), na.rm=TRUE) ~ "Any missing grade",
                                     .default="foobar"),,
      any_grade_sup_1 = ifelse(any(grade >= 1, na.rm=TRUE), "Grade \u2265 1", "foobar"),
      any_grade_sup_2 = ifelse(any(grade >= 2, na.rm=TRUE), "Grade \u2265 2", "foobar"),
      any_grade_sup_3 = ifelse(any(grade >= 3, na.rm=TRUE), "Grade \u2265 3", "foobar"),
      any_grade_sup_4 = ifelse(any(grade >= 4, na.rm=TRUE), "Grade \u2265 4", "foobar"),
      any_grade_sup_5 = ifelse(any(grade >= 5, na.rm=TRUE), "Grade = 5", "foobar"),
      any_grade_eq_na   = any_grade_sup_na,
      any_grade_eq_1 = ifelse(any(grade == 1, na.rm=TRUE), "Grade 1", "foobar"),
      any_grade_eq_2 = ifelse(any(grade == 2, na.rm=TRUE), "Grade 2", "foobar"),
      any_grade_eq_3 = ifelse(any(grade == 3, na.rm=TRUE), "Grade 3", "foobar"),
      any_grade_eq_4 = ifelse(any(grade == 4, na.rm=TRUE), "Grade 4", "foobar"),
      any_grade_eq_5 = ifelse(any(grade == 5, na.rm=TRUE), "Grade 5", "foobar"),
      .by=c(subjid, arm)
    ) %>%
    crosstable::crosstable(matches(rex),
               by=arm, total=total,
               percent_pattern=percent_pattern) %>%
    filter(variable!="foobar" & variable!="NA") %>%
    mutate(
      label=case_when(str_starts(.id, "max_grade_") ~ "Patient maximum AE grade",
                      str_starts(.id, "any_grade_sup_") ~ "Patient had at least one AE of grade",
                      str_starts(.id, "any_grade_eq_") ~ "Patient had at least one AE of grade ",
                      .default="ERROR"),
      .id = str_remove(.id, "_[^_]*$") %>% factor(levels=variant),
      label = fct_reorder(label, as.numeric(.id)),
      variable = suppressWarnings(fct_relevel(variable, "Grade = 5", after=4)),
      variable = suppressWarnings(fct_relevel(variable, lab_no_ae, after=0)),
      variable = suppressWarnings(fct_relevel(variable, ~str_subset(.x, "missing"), after=Inf)),
    ) %>%
    arrange(.id, label, variable)

  rtn
}


# Plots ---------------------------------------------------------------------------------------



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
#'
#' @examples
#' tm = grstat_example()
#' attach(tm, warn.conflicts=FALSE)
#' ae_plot_grade(df_ae=ae, df_enrol=enrolres)
#' ae_plot_grade(df_ae=ae, df_enrol=enrolres, arm="ARM", variant=c("sup", "max"))
#' ae_plot_grade(df_ae=ae, df_enrol=enrolres, arm="ARM", type="absolute")
#' ae_plot_grade(df_ae=ae, df_enrol=enrolres, arm="ARM", position="fill")
#' ae_plot_grade(df_ae=ae, df_enrol=enrolres, arm="ARM", position="stack", type="absolute")
#' @importFrom cli cli_warn
#' @importFrom dplyr across cur_group mutate n
#' @importFrom forcats as_factor
#' @importFrom ggplot2 aes element_text facet_wrap geom_col ggplot labs position_dodge position_fill position_stack scale_y_continuous theme
#' @importFrom scales label_percent
#' @importFrom tidyr pivot_longer
ae_plot_grade = function(
    df_ae, ..., df_enrol,
    variant = c("max", "sup", "eq"),
    position = c("dodge", "stack", "fill"),
    type = c("relative", "absolute"),
    arm=NULL, grade="AEGR", subjid="SUBJID", total=FALSE
){
  type = match.arg(type)
  position = match.arg(position)

  if(type=="relative" && position=="stack"){
    type = "absolute"
    cli_warn('{.arg type} has been corrected to {.val absolute} to
             be consistent with `position="stack"`.')
  }
  if(type=="relative" || position=="fill"){
    percent = "only"
    y_lab = "Patient proportion"
    add_layer = scale_y_continuous(labels=label_percent(), limits=0:1)
  } else {
    percent = FALSE
    y_lab = "Patient count"
    add_layer = NULL
  }

  fill_aes = NULL
  if(!is.null(arm)){
    df_enrol = df_enrol %>%
      # mutate(arm = if(is.null(.env$arm)) "All Patients" else .data$arm) %>%
      mutate(arm2 = paste0(cur_group()[[1]], " (N=", n(), ")"),
             .by=any_of2(arm))
    arm="arm2"
    fill_aes = aes(fill=name)
  }


  tbl = ae_table_grade(df_ae=df_ae, df_enrol=df_enrol, variant=variant,
                       arm=arm, grade=grade, subjid=subjid,
                       percent=percent, total=total)
  p = switch(position, fill=position_fill(), stack=position_stack(),
             dodge=position_dodge(0.9))

  tbl %>%
    mutate(across(-c(.id, label, variable), ~as.numeric(as.character(.x)))) %>%
    pivot_longer(-c(.id, label, variable)) %>%
    mutate(name=as_factor(name)) %>%
    ggplot(aes(x=variable, y=value)) + fill_aes +
    geom_col(position=p) +
    labs(x=NULL, fill=NULL, y=y_lab) +
    facet_wrap(~label, scales="free_x") +
    add_layer +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
          legend.position="top")
}




#' Graphic representation of AEs
#'
#' Produce a graphic representation of AE, counting AE as bars for each patient, colored by grade. Can be faceted by treatment arm.
#'
#' @param weights (optional) a length 5 numeric vector, giving the weights of each grade
#' @param low the color of Grade 1 AE
#' @param high the color of Grade 5 AE
#' @inheritParams ae_table_soc
#' @inherit ae_table_soc seealso
#'
#' @return a ggplot
#' @export
#' @importFrom dplyr across any_of arrange count left_join mutate rename_with select
#' @importFrom forcats fct_infreq fct_rev
#' @importFrom ggplot2 aes element_blank facet_grid geom_col ggplot labs scale_fill_manual theme vars
#' @importFrom rlang check_dots_empty int
#' @importFrom tibble deframe lst
#' @importFrom tidyr replace_na
#'
#' @examples
#' tm = grstat_example()
#' attach(tm, warn.conflicts=FALSE)
#' ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres)
#' ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres, arm="ARM")
#' ae_plot_grade_sum(df_ae=ae, df_enrol=enrolres, arm="ARM", weights=c(1,1,3,6,10))
ae_plot_grade_sum = function(
    df_ae, ..., df_enrol,
    low="#ffc425", high="#d11141",
    weights=NULL,
    arm=NULL, grade="AEGR", subjid="SUBJID"
){
  check_dots_empty()
  assert_names_exists(df_ae, lst(subjid, grade))
  assert_names_exists(df_enrol, lst(subjid, arm))

  weighted = !is.null(weights)
  if(!weighted) weights=c(1,1,1,1,1)
  assert(is.numeric(weights))
  assert(length(weights)==5)

  df_ae = df_ae %>% rename_with(tolower) %>%
    select(subjid=tolower(subjid), grade=tolower(grade))
  df_enrol = df_enrol %>% rename_with(tolower) %>%
    select(subjid=tolower(subjid), arm=tolower(arm))

  df = df_enrol %>%
    left_join(df_ae, by=tolower(subjid)) %>%
    mutate(grade = fix_grade(grade),
           weight = weights[grade] %>% replace_na(0.1)) %>%
    arrange(subjid)

  default_arm = "All patients"
  if(!is.null(arm)){
    npat = deframe(count(df_enrol, arm))
    npat["Total"] = sum(npat)
  } else {
    npat = int(!!default_arm:=nrow(df_enrol))
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
    mutate(subjid = fct_infreq(factor(subjid), w=weight)) %>%
    count(across(c(subjid, grade, any_of("arm"))), wt=weight) %>%
    mutate(
      n = ifelse(is.na(grade), 0.1, n),
      grade = fct_rev(factor(grade))
    ) %>%
    ggplot(aes(x=subjid, y=n, fill=grade)) +
    scale_fill_manual(values=rev(pal)) +
    geom_col() +
    theme(axis.text.x=element_blank(),
          axis.ticks.x=element_blank()) +
    labs(x="Patient", y=y_lab, fill="AE grade", caption=caption)

  if(!is.null(arm)) rtn = rtn + facet_grid(cols=vars(arm), scales="free_x")

  rtn
}


#' @rdname ae_plot_grade_sum
#' @usage NULL
#' @export
ae_plot_grade_n = ae_plot_grade_sum


# Utils ---------------------------------------------------------------------------------------

#' @importFrom dplyr na_if
fix_grade = function(x){
  as.numeric(na_if(as.character(x), "NA"))
}


