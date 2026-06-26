

ae_plot_x1 = function(df_ae, ..., df_enrol,
                                variant = c("max", "sup", "eq"),
                                # position = c("dodge", "stack", "fill"),
                                # type = c("relative", "absolute"),
                                scale=1, rel_min_height=0.01, bandwidth=0.45, alpha=0.6,
                                arm="ARM", grade="AEGR", subjid="SUBJID", total=FALSE
){
  bind_rows = dplyr::bind_rows
  df = df_ae %>%
    rename_with(tolower) %>%
    mutate(
      aegr = factor(aegr, levels = c(1:5, NA)),
      subjid = factor(subjid, levels = df_enrol$subjid),
    ) %>%
    count(subjid, aegr, .drop = FALSE) %>%
    mutate(subjid=as.numeric(as.character(subjid))) %>% 
    left_join(df_enrol, by = "subjid")
  df %>% filter(n==0)

  df2 = df %>% 
    mutate(aegr = factor(paste("Grade", aegr))) %>% 
    count(arm, aegr, n_ae=n, name="n_pat")

  df2 %>% arrange(n_ae)
  
  df_num = df %>% 
    summarise(
      n_ae = sum(n),
      mean = mean(n),
      med = median(n),
      sd = sd(n),
      q1 = quantile(n, probs=0.25),
      q3 = quantile(n, probs=0.75),
      min = min(n),
      max = max(n),
      .by=c(aegr, arm)
    )

  df_num %>% 
    ggplot() +
    aes(x=aegr, y=mean, ymin=mean-sd, ymax=mean+sd, fill=arm, color=arm) +
    geom_point(position=position_dodge(0.9), alpha=0.6) +
    geom_line(aes(group=arm), position=position_dodge(0.9)) +
    # geom_ribbon(alpha=0.3, position=position_dodge(0.9)) +
    # coord_flip() +
    labs(x="AE grade", y="Mean number of AE (+/- SD)", 
        fill="Treatment arm", color="Treatment arm") +
    theme(panel.grid.minor.x=element_blank(),
          legend.position="top")
  
  pd = position_dodge(0.3)
  df_num %>% 
    ggplot() +
    aes(x=factor(aegr), y=mean, ymin=mean-sd, ymax=mean+sd, fill=arm, color=arm) +
    # geom_col(position=pd, alpha=0.6) +
    geom_point(position=pd, alpha=0.6) +
    geom_errorbar(position=pd, width=0.2) +
    geom_line(aes(group=arm), position=pd) +
    # coord_flip() +
    # ggforce::geom_sina(position=pd) +
    labs(x="AE grade", y="Mean number of AE (+/- SD)", 
        fill="Treatment arm", color="Treatment arm") +
    theme(panel.grid.minor.x=element_blank(),
          legend.position="top")
}




#' @importFrom dplyr any_of arrange bind_rows count left_join mutate pick rename_with select
#' @importFrom ggplot2 aes element_blank ggplot labs theme
#' @importFrom rlang check_installed
#' @importFrom tibble deframe tibble
#' @importFrom tidyr replace_na
ae_plot_grade_ridges = function(df_ae, ..., df_enrol,
                                variant = c("max", "sup", "eq"),
                                # position = c("dodge", "stack", "fill"),
                                # type = c("relative", "absolute"),
                                scale=1, rel_min_height=0.01, bandwidth=0.45, alpha=0.6,
                                arm="ARM", grade="AEGR", subjid="SUBJID", total=FALSE
){
  bind_rows = dplyr::bind_rows

  check_installed("ggridges")
  # browser()
  df_ae = df_ae %>% rename_with(tolower) %>%
    select(subjid=tolower(subjid), grade=tolower(grade))
  df_enrol = df_enrol %>% rename_with(tolower) %>%
    select(subjid=tolower(subjid), arm=tolower(arm))
  df = df_enrol %>%
    left_join(df_ae, by=tolower(subjid)) %>%
    mutate(grade = .fix_grade_na(grade),
           grade = factor(paste("Grade", grade))) %>%
    arrange(subjid)

  npat = deframe(count(df_enrol, pick(any_of("arm"))))

  fill_aes = NULL
  if(!is.null(arm)){
    fill_aes = aes(fill=arm, color=arm)
  }

  df_tot = tibble()
  if(isTRUE(total)){
    df_tot = df %>%
      count(subjid, arm, name="n_ae") %>%
      mutate(grade = "All grades")
  }

  # browser()
  a = df %>%
    count(subjid, pick(any_of("arm")), grade, name="n_ae") %>%
    bind_rows(df_tot) %>%
    tidyr::complete(subjid, grade) %>%
    dplyr::group_by(subjid) %>%
    tidyr::fill(arm, .direction="downup") %>%
    dplyr::ungroup() %>%
    arrange(subjid, grade) %>%
    mutate(
      n_ae = replace_na(n_ae, 0),
      # arm = glue("{arm} (N={npat[arm]})"),
      # side=ifelse(arm=="Control", "top", "bottom"),
      # invert=ifelse(arm=="Control", 1, -1)
    )

  a %>%
    ggplot() +
    aes(x=n_ae, y=grade) + fill_aes +
    # aes(side=side) + #TODO issue github side comme ggdist
    # ggridges::geom_density_ridges(scale=scale, rel_min_height=rel_min_height,
    #                               bandwidth=bandwidth, alpha=alpha) +
    ggridges::geom_density_ridges(stat="binline", binwidth=1, scale=scale, rel_min_height=rel_min_height,
                                  bandwidth=bandwidth, alpha=alpha) +
    labs(x="Number of AE per patient", y=NULL,
         fill="Treatment arm", color="Treatment arm") +
    theme(panel.grid.minor.x=element_blank(),
          legend.position="top")
}


#' @importFrom cli cli_abort cli_warn
#' @importFrom dplyr across any_of arrange count cur_group filter if_else left_join mutate pull select summarise
#' @importFrom forcats as_factor fct_drop fct_infreq fct_relevel fct_reorder fct_rev
#' @importFrom ggplot2 aes expansion facet_grid geom_area ggplot labs position_dodge scale_x_continuous theme theme_minimal unit vars
#' @importFrom glue glue
#' @importFrom purrr iwalk keep map
#' @importFrom rlang arg_match check_dots_empty ensym is_empty set_names
#' @importFrom tibble deframe lst
#' @importFrom tidyr build_wider_spec pivot_longer replace_na separate_wider_regex unnest
#' @importFrom tidyselect matches
butterfly_plot2 = function(
    df_ae, ..., df_enrol,
    variant=c("max", "sup", "eq"),
    arm=NULL, term=NULL,
    x_axis=c("count", "proportion"),
    position = c("dodge", "stack"),
    group_ae = FALSE,

    sort_by_count=TRUE, total=TRUE, showNA=TRUE, digits=0, warn_miss=FALSE,
    grade="AEGR", soc="AESOC", subjid="SUBJID"
){
  fct_drop = forcats::fct_drop
  expansion = ggplot2::expansion
  geom_area = ggplot2::geom_area
  theme_minimal = ggplot2::theme_minimal


  check_dots_empty()
  default_arm = set_label("All patients", "Treatment arm")
  null_term = is.null(term)
  null_arm = is.null(arm)
  position = arg_match(position)
  variant = arg_match(variant)
  x_axis = arg_match(x_axis)

  assert_names_exists(df_ae, lst(subjid, term, soc, grade))
  assert_names_exists(df_enrol, lst(subjid, arm))

  label_missing_soc = "Missing SOC"
  label_missing_pat = "No Declared AE"

  if(variant!="max" && missing(total) && total){
    cli_warn("Total has been set to `FALSE` as totals are not very interpretable
             when {.arg variant} is {.val sup} or {.val eq}. Set `total=TRUE`
             explicitly to silence this warning.")
    total=FALSE
  }

  df_ae = df_ae %>%
    select(subjid_=any_of2(subjid), soc_=any_of2(soc),
           term_=any_of2(term), grade_=any_of2(grade)) %>%
    mutate(soc_ = if_else(soc_ %in% c(0, NA), label_missing_soc, soc_))
  df_enrol = df_enrol %>%
    select(subjid_=any_of2(subjid), arm_=any_of2(arm)) %>%
    mutate(arm_ = if(is.null(.env$arm)) default_arm else .data$arm_)
  if(!is.numeric(df_ae$grade_)){
    cli_abort("Grade ({.val {grade}}) should be a numeric column.")
  }

  df = df_enrol %>%
    left_join(df_ae, by="subjid_") %>%
    arrange(subjid_) %>%
    mutate(
      arm_ = to_snake_case(arm_),
      soc_ = if_else(!subjid_ %in% df_ae$subjid_, label_missing_pat, soc_)
    )

  #check missing data
  if(warn_miss){
    miss = names(df) %>% set_names() %>% map(~{
      df %>% filter(is.na(!!ensym(.x))) %>% pull(subjid_) %>% unique() %>% sort()
    }) %>% keep(~!is_empty(.x))
    miss %>% iwalk(~{
      cli_warn("{.fn ae_table_soc}: Missing values in column {.val {.y}} for patients {.val {.x}}.",
               class="grstat_ae_missing_values_warning")
    })
  }

  arm_count = df_enrol %>%
    count(arm_) %>%
    deframe() %>% as.list()
  arm_count2 = arm_count %>%
    set_names(to_snake_case)

  extra_cols = if(total) c("NA", "Tot") else c("NA")
  rtn = df %>%
    summarise(calc = evaluate_grades(grade_, variant),
              .by=any_of(c("subjid_", "arm_", "soc_", "term_"))) %>%
    unnest(calc) %>%
    mutate(
      # Tot = ifelse(total, Tot, 0),
      soc_ = soc_ %>% fct_infreq(w=Tot) %>%
        fct_last(label_missing_soc, label_missing_pat)
    ) %>%
    summarise(
      across(c(matches("^G\\d$"), any_of(extra_cols)), ~{
        n = sum(.x)
        n_arm = arm_count2[[cur_group()$arm_]]
        label = glue("{n} ({p})", p=percent(n/n_arm, digits))
        label[n==0] = NA
        label
      }),
      .by=any_of(c("arm_", "soc_", "term_"))
    ) %>%
    arrange(arm_, soc_)

  if(!total) rtn = rtn %>% select(-any_of("Tot"))
  if(!showNA) rtn = rtn %>% select(-any_of("NA"))
  if(!sort_by_count) {
    rtn = rtn %>%
      mutate(across(any_of(c("soc_", "term_")), ~factor(as.character(.x))),
             soc_ = fct_relevel(soc_, label_missing_pat, after=Inf)) %>%
      arrange(arm_, soc_)
  }

  spec = rtn %>%
    build_wider_spec(names_from=arm_,
                     values_from=c(matches("^G\\d$"), any_of(c("NA", "Tot"))),
                     names_glue="{arm_}_{.value}") %>%
    arrange(.name)

  arm_label = glue("{a} (N={b})", a=names(arm_count), b=arm_count) %>%
    set_names(to_snake_case(names(arm_count))) %>%
    as.character()


  left_arm = levels(factor(rtn$arm_))[1]
  # browser()

  x = rtn %>%
    pivot_longer(-c(arm_, soc_)) %>%
    separate_wider_regex(value, patterns=c(n="\\d+", " \\(", p="\\d+", "%\\)")) %>%
    mutate(
      # arm = glue("{arm_} (N={n_arm})") %>% fct_reorder(as.numeric(factor(arm_))),
      arm = factor(arm_label[arm_]) %>% fct_reorder(as.numeric(factor(arm_))),
      soc_ = fct_rev(soc_),
      i = ifelse(arm_==left_arm, -1, 1),
      n = i * as.numeric(n) %>% replace_na(0),
      p = i * as.numeric(p) %>% replace_na(0),
      gp = paste0(name, "_",  arm_) %>% as_factor()
    ) %>%
    filter(soc_!="No Declared AE") %>%
    filter(soc_!="Missing SOC") %>%
    filter(name!="NA") %>%
    filter(name!="Tot") %>%
    mutate(soc_ = fct_drop(soc_))


  if(group_ae){
    x = x %>%
      mutate(
        name = ifelse(name %in% paste0("G", 1:2), "1-2", "3-5"),
        gp = paste0(name, "_",  arm_) %>% as_factor(),
      ) %>%
      summarise(
        n = sum(n),
        p = sum(p),
        .by=c(soc_, arm_, arm, name, gp)
      )
  }

  if(x_axis=="count"){
    aes_x = aes(x=n)
    lab_x = "Number of patients who experienced at least one AE of given grade"
  } else {
    #TODO comme butterfly plot, scale sans négatif, avec des %
    aes_x = aes(x=p)
    lab_x = "Proportion of patients who experienced at least one AE of given grade"
  }

  if(position=="dodge") position = position_dodge(width=0)

# browser()
  x %>%
    ggplot() +
    aes_x +
    aes(y=soc_, color=name, fill=name, group=gp) +
    geom_area(orientation="y", alpha=0.3, linewidth=1,
              position=position) +
    scale_x_continuous(expand=expansion(mult=c(0.015))) +
    facet_grid(cols=vars(arm), scale="free_x") +
    theme_minimal() +
    theme(
      panel.spacing.x=unit(0, "lines"),
      legend.position="top"
    ) +
    labs(x=lab_x, y=NULL, fill="AE Grade", color="AE Grade")

}
