
#' Plot BOIN decision boundaries and patient-level data
#'
#' This function generates a plot of decision boundaries from a BOIN design,
#' optionally overlaid with patient-level data and a Gantt-style timeline.
#'
#' @param data_boin A `boin` object from the [BOIN::get.boundary()] function **or** a `data.frame`
#'   with columns: `n_eval`, `escalate_if_inf`, `deescalate_if_sup`, `eliminate_if_sup`.
#' @param data_patients Optional data frame containing patient-level information,
#'   with columns `subjid`, `dose` (character), and `dlt` (logical).
#'   If `gantt_include==TRUE`, it must also include date of enrolment `date_enrol`
#'   and date of followup end `date_end_fu`.
#' @param doses Named vector or list giving dose labels. Should match the order
#'   of dose levels used in the BOIN design.
#' @param gantt_include Logical, whether to include a Gantt chart of follow-up.
#' @param gantt_labels Optional vector with labels as names and dates as values,
#'   to display in the Gantt chart.
#' @param ... Unused.
#'
#' @return A `ggplot2` object showing BOIN decision rules and patient data overlay (optional). If
#' `gantt_include==TRUE`, the output is a `patchwork` object with an additional Gantt diagram.
#'
#' @importFrom dplyr as_tibble case_when mutate rename rowwise
#' @importFrom rlang check_dots_empty
#' @importFrom stringr str_wrap
#' @importFrom tibble tibble
#' @importFrom tidyr unnest
#' @export
#'
#' @examples
#' boin = BOIN::get.boundary(target=0.3, ncohort=6, cohortsize=1)
#' #In this example, 17 patients are included, 15 of which are already evaluated.
#' #Patients are deemed evaluable
#' set.seed(42)
#' data_patients = tibble(
#'   subjid = 1:17,
#'   dose = c("DL0", "DL0", "DL-1", "DL-1", "DL-1", "DL0", "DL0", "DL0",
#'            "DL1", "DL1", "DL1", "DL1", "DL1", "DL1", "DL1", "DL1", "DL1"),
#'   dlt = c(FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
#'           FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, NA, NA),
#'   date_enrol = as.Date("2025-01-01") +(1:17)*30 + runif(17, -13, 13),
#'   date_end_fu = date_enrol+30
#' )
#'
#' #default
#' boin_plot(boin,
#'           doses=c("DL-1", "DL0", "DL1", "DL2"))
#' #with patient labels
#' boin_plot(boin, data_patients=data_patients,
#'           doses=c("DL-1", "DL0", "DL1", "DL2"))
#' #with gantt diagram
#' p = boin_plot(boin, data_patients=data_patients, gantt_include=TRUE,
#'               doses=c("DL-1", "DL0", "DL1", "DL2"))
#' p
#' #with post production
#' p[[1]] = p[[1]] + scale_color_manual(values=c("red", "green", "blue", "yellow"))
#' p[[2]] = p[[2]] + scale_color_manual(values=c("red", "green", "blue"))
#' p
#'
#' #with gantt labels
#' gantt_labels=c("Plot cutoff date"=as.Date("2026-08-25"),
#'                "Dose reevaluation"=as.Date("2025-08-25"))
#'
#' boin_plot(data_boin=boin, data_patients=data_patients,
#'           doses = c("DL-1", "DL0", "DL1", "DL2"),
#'           gantt_include=TRUE,
#'           gantt_labels=gantt_labels)
boin_plot = function(data_boin, data_patients=NULL,
                     ..., doses,
                     gantt_include=FALSE,
                     gantt_labels=NULL){
  check_dots_empty()
  dec_labs = c(
    "E = Escalate to the next higher dose",
    "S = Stay at the current dose",
    "D = De-escalate to the next lower dose",
    "DE = De-escalate and eleminate the current and higher doses"
  )

  if(inherits(data_boin, "boin")){
    data_boin = data_boin$full_boundary_tab %>%
      t() %>% as_tibble() %>%
      rename(n_eval="Number of patients treated",
             escalate_if_inf="Escalate if # of DLT <=",
             deescalate_if_sup="Deescalate if # of DLT >=",
             eliminate_if_sup="Eliminate if # of DLT >=")
  } else {
    assert_class(data_boin, c("data.frame"))
    assert_names_exists(data_boin,
                        c("n_eval", "escalate_if_inf",
                          "deescalate_if_sup", "eliminate_if_sup"))
  }

  data_plot = data_boin %>%
    rowwise() %>%
    mutate(
      dose = list(doses),
      rows = list(tibble(
        n_dlt = seq(0, n_eval),
        decision = case_when(
          n_dlt >= eliminate_if_sup ~ "DE",
          n_dlt >= deescalate_if_sup ~ "D",
          n_dlt <= escalate_if_inf ~ "E",
          .default = "S"
        )
      ))
    ) %>%
    unnest(rows) %>%
    unnest(dose) %>%
    mutate(
      decision_label = factor(decision,
                              levels = c("E", "S", "D", "DE"),
                              labels = dec_labs %>% str_wrap(40)),
      dose = factor(dose, levels=doses)
    )

  data_plot %>%
    .get_boin_plot() %>%
    .add_boin_patients(data_patients) %>%
    .add_gantt(data_patients, gantt_labels=gantt_labels, do=gantt_include)
}



# Internals -----------------------------------------------------------------------------------


#' @importFrom ggplot2 aes coord_fixed element_blank facet_grid geom_text geom_tile ggplot labs scale_fill_manual theme theme_minimal
.get_boin_plot = function(data_plot){
  data_plot %>%
    ggplot(aes(x=factor(n_eval), y=factor(n_dlt),
               fill=decision_label, label=decision)) +
    geom_tile() + geom_text()  +
    facet_grid(.~dose) +
    scale_fill_manual(values = c("#5fff33", "#33d2ff", "#ff96c5", "#ff3367")) +
    coord_fixed() +
    labs(x="Number of evaluable patients treated at current dose",
         y="Number of patients with DLT",
         fill="Decision") +
    theme_minimal() +
    theme(
      axis.line = element_blank(),
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      legend.position="top"
    )
}

#' @importFrom dplyr filter if_else mutate row_number
#' @importFrom forcats as_factor
#' @importFrom ggplot2 aes geom_label
#' @importFrom purrr pmap_chr
#' @importFrom tidyr replace_na separate_rows
.add_boin_patients = function(p, data_patients){
  if(is.null(data_patients)) return(p)
  assert_names_exists(data_patients,
                      c("subjid", "dose", "dlt"))
  stopifnot(!any(is.na(data_patients$dose)))

  data_patients = data_patients %>%
    mutate(
      dose = factor(dose, levels=levels(p$data$dose)),
      n_eval = row_number(),
      n_dlt_min = cumsum(replace_na(dlt, FALSE)),
      n_dlt_max = cumsum(replace_na(dlt, TRUE)),
      currently = is.na(dlt),
      n_dlt = if_else(
        is.na(dlt),
        pmap_chr(list(n_dlt_min, n_dlt_max), ~ paste(seq(..1, ..2), collapse = ",")),
        as.character(cumsum(dlt))
      ),
      subjid = paste0(ifelse(currently, "?", "#"), subjid) %>% as_factor(),
      .by=dose
    ) %>%
    separate_rows(n_dlt, sep = ",") %>%
    mutate(n_dlt = as.integer(n_dlt))

  p +
    geom_label(aes(label=subjid), na.rm=TRUE, fill="white",
               data=data_patients %>% filter(currently)) +
    geom_label(aes(label=subjid), na.rm=TRUE, fill="yellow",
               data=data_patients %>% filter(!currently))
}

#' @importFrom dplyr arrange filter if_else last mutate pull
#' @importFrom forcats as_factor
#' @importFrom ggplot2 aes element_blank geom_hline geom_label geom_point geom_segment geom_vline ggplot labs theme theme_minimal
#' @importFrom tibble enframe
.add_gantt = function(p, data_patients, label_size=2.5, gantt_labels, do){
  if(isFALSE(do)) return(p)
  if(is.null(data_patients)) return(p)
  assert_names_exists(data_patients,
                      c("subjid", "date_enrol", "date_end_fu", "dose"))
  data_patients = data_patients %>%
    mutate(
      currently = is.na(dlt),
      subjid = paste0(ifelse(currently, "?", "#"), subjid) %>% as_factor(),
      # stop = if(exists("reevaluation")) if_else(reevaluation, date_end_fu, lubridate::NA_Date_) else NA_Date_,
    )

  gantt_plot = data_patients %>%
    ggplot(aes(x=date_enrol, xend=date_end_fu, y=subjid, yend=subjid, color=dose)) +
    geom_hline(yintercept=seq(0.55, nrow(data_patients)),
               color="gray", size=.5, alpha=.5) +
    geom_segment(linewidth=3, na.rm=TRUE) +
    geom_point(aes(x=date_end_fu), data=~filter(.x, dlt),
               shape="cross", size=2, stroke=3, color="black") +
    # geom_label(aes(x=stop, y=Inf), na.rm=TRUE, label="Dose reevaluation",
    #            angle=90, size=label_size, vjust=1, hjust=1, color="black") +
    # geom_vline(aes(xintercept=stop), na.rm=TRUE) +
    labs(x="Patient follow-up (Calendar date)", y="Patient", color="Dose level") +
    theme_minimal() +
    theme(
      legend.position="inside",
      legend.position.inside=c(0.99, 0.05),
      legend.justification=c(1, 0),
      legend.background=element_rect(fill="white", color="black"),
      panel.grid.major.y = element_blank(),
      panel.grid.minor.y = element_blank(),
    )

  if(any(data_patients$currently)){
    gantt_plot = gantt_plot +
      labs(caption="Patients marked with a `?` are still within their DLT evaluation window.")
  }

  if(!is.null(gantt_labels)){
    x = enframe(gantt_labels)
    gantt_plot = gantt_plot +
      geom_vline(xintercept=x$value, linetype="dashed", alpha=0.3) +
      geom_label(aes(x=value, label=name), y=Inf, data=x, inherit.aes=FALSE,
               angle=90, size=label_size, hjust=2, vjust=1)
  }

  patchwork::wrap_plots(p, gantt_plot, ncol=1, heights=c(2,1))
}
