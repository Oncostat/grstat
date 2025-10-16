rm(list=ls())

# Library
library(dplyr)
library(lubridate)
library(grstat)
# not sure if needed
library(RColorBrewer)


# Data Simulated

# The function `grstat_example()` is used as an example dataset to illustrate the data usage.


tm = grstat_example()
attach(tm)

dim(ae)
dim(enrolres)
dim(recist)

length(unique(recist$subjid))
length(unique(ae$subjid))
length(unique(enrolres$subjid))


## add simulated death date to recist

set.seed(2025)  # reproducibility

# get last date per subject and simulate deaths (20% die)

dth <- recist %>%
  summarise(
    last_rcdt = max(rcdt, na.rm = TRUE),.by = subjid ) %>%
  mutate(
    died = rbinom(n(), 1, prob = 0.2),
    dthdt = if_else(
      died == 1,
      last_rcdt + days(sample(30:180, n(), replace = TRUE)),
      as.Date(NA)
    )
  ) %>%
  select(subjid, dthdt, died)  # keep only ID + simulated death date

dim(dth)
length(unique(dth$subjid))
class(dth$dthdt)

#  add RCVISIT to recist
recist <- recist %>%
  group_by(subjid) %>%
  mutate(RCVISIT = ifelse(is.na(rcresp), "Baseline", NA)) %>%
  mutate(RCVISIT = ifelse(rcresp=="Progressive disease", "End of treatment", RCVISIT)) %>%
  ungroup()

dim(recist)
length(unique(recist$subjid))

## simulate treatment administration data

set.seed(2025)

# I am not quite sure how many treatment administration subjid can have between 2 recist scans, I think 21 days apart. So I have created only one adm per recist scans and one adm before ever first recist scan.


adm <- recist %>%
  left_join(enrolres %>% select(subjid, date_inclusion), by = "subjid") %>%
  # filter(!is.na(rcresp), rcresp != "Progressive disease") %>%
  filter(!is.na(rcresp)) %>%
  arrange(subjid, rcdt) %>%   # ensure ordered by patient and RECIST
  group_by(subjid) %>%
  mutate(
    ADMYN = sample(c("Yes", "No"), n(), replace = TRUE, prob = c(0.9, 0.1)),

    # first admission date
    ADMDT = if_else(
      row_number() == 1,
      pmin(date_inclusion + days(sample(5:15, 1)), rcdt),  # 5–15 days after inclusion but before first RECIST
      rcdt - days(sample(21:30, 1))          # subsequent admissions: 21–30 days before each RECIST
    )
  ) %>%
  ungroup() %>%
  select(subjid, ADMYN, ADMDT,date_inclusion,rcdt, rcresp) %>%
  mutate(group="Treatment Administration")

length(unique(adm$subjid))

#  Simulate EOTDT in a EOT dataset

# set.seed(2025)

eot <- adm %>%
  group_by(subjid) %>%
  summarise(
    last_admdt = max(ADMDT, na.rm = TRUE),
    last_rcdt  = max(rcdt, na.rm = TRUE)
  ) %>%
  left_join(select(dth, subjid, dthdt, died), by = "subjid")

# Step 2: Simulate End of Treatment date (EOTLADDT)
eot <- eot %>%
  mutate(
    # usually after last treatment date but before death
    EOTLADDT = case_when(
      died == 1 ~ last_admdt + days(sample(7:60, n(), replace = TRUE)),  # 1–2 months after treatment end
      died == 0 | is.na(died) ~ last_admdt + days(sample(30:120, n(), replace = TRUE)) # alive: longer gap
    ),
    # ensure EOTLADDT < death date when applicable
    EOTLADDT = if_else(!is.na(dthdt) & EOTLADDT > dthdt,
                       dthdt - days(sample(3:10, n(), replace = TRUE)),  # just before death
                       EOTLADDT)
  ) %>%
  select(subjid, last_admdt, dthdt, died, EOTLADDT)

# Step 3: (Optional) Add realistic censoring or ensure no future dates
eot <- eot %>%
  mutate(
    EOTLADDT = pmin(EOTLADDT, Sys.Date()) # prevent future dates
  ) %>%
  summarise(
    EOTLADDT = max(EOTLADDT, na.rm = TRUE),.by = subjid )

length(unique(eot$subjid))

# Step 4: keep EOTLADDT for all subjid that had progressive deaseas
eot <- eot %>%
  left_join(recist, by = "subjid") %>%
  select(subjid, EOTLADDT, rcresp) %>%
  mutate(
    EOTLADDT_v2 = if_else(rcresp == "Progressive disease", EOTLADDT, as.Date(NA))
  ) %>%
mutate(
  EOTLADDT = if_else(
    runif(n()) < 0.95,          # with 70% probability
    as.Date(NA),               # replace with NA
    EOTLADDT                   # otherwise keep the original
  )
) %>%
  mutate(EOTLADDT_v2 = if_else(is.na(EOTLADDT_v2), EOTLADDT,EOTLADDT_v2, as.Date(NA))) %>%
select(subjid, EOTLADDT_v2) %>%
  rename(EOTLADDT=EOTLADDT_v2) %>%
  distinct() %>%
  filter(!is.na(EOTLADDT))


length(unique(eot$subjid))

# Simulate FU dataset

set.seed(2025)

fu <- eot %>%
  rowwise() %>%
  mutate(
    n_fu = sample(1)  # number of follow-ups per subject
  ) %>%
  do({
    subjid <- .$subjid
    eot_date <- .$EOTLADDT
    n_fu <- .$n_fu

    # Simulate follow-up dates: between 4 and 180 days post-EOTLADDT
    data.frame(
      subjid = subjid,
      FUDT = sort(eot_date + days(sample(4:180, n_fu, replace = FALSE)))
    )
  }) %>%
  ungroup() %>%
  mutate(
    FUDT = if_else(
      runif(n()) < 0.7,   # 80% probability
      as.Date(NA),        # set to missing
      FUDT                # keep original
    )
  ) %>%
  distinct() %>%
  filter(!is.na(FUDT))


length(unique(fu$subjid))


# creation of the dataset needed in order to use it  to make the Swimmer plot.
data needed
- enrolres (not sure if that data is really nedded)
- recist
- adm
- eot
- dth
- FU


enrolres_v2=subset(enrolres,
                    select=c(subjid, date_inclusion))


ADM_first <- adm %>%
  arrange(as.numeric(subjid), rcdt) %>%
  mutate(ADMDT_first = first(ADMDT), .by = subjid) %>%
  mutate(ADMDT_last = last(ADMDT), .by = subjid) %>%
  select(subjid, ADMYN, ADMDT_first, group, ADMDT)

# ADM_last <- adm %>%
#   arrange(as.numeric(subjid), rcdt) %>%
#   mutate(ADMDT_first = first(ADMDT), .by = subjid) %>%
#   mutate(ADMDT_last = last(ADMDT), .by = subjid) %>%
#   mutate(date=ADMDT_last) %>%
#   select(subjid, ADMYN,  date, group)

swim=enrolres_v2 %>%
  left_join(ADM_first, by=c("subjid")) %>%
  mutate(date=ADMDT) %>%
  select(subjid, date_inclusion ,ADMYN,ADMDT_first, group, date)
  # mutate(T0=consdt) %>%
  # mutate(T0bis=first_ADMDT) %>%

recist_repb=recist %>%
  left_join(swim, by=c("subjid")) %>%
   mutate(group="Recist") %>%
  # mutate(T0=consdt) %>%
  # mutate(T0bis=ADMDT_first) %>%
   mutate(date=rcdt) %>%
  select(subjid , date, rcresp, date_inclusion, ADMDT_first, group, RCVISIT) %>%
  distinct()

names(eot)
eot_v2=eot %>%
  left_join(recist_repb, by=c("subjid")) %>%
  mutate(date=EOTLADDT) %>%
  # mutate(T0=consdt) %>%
  # mutate(T0bis=ADMDT_first) %>%
  mutate(group="end of treatment")  %>%
  select(subjid, group, date, RCVISIT)

table(eot_v2$group  , useNA="always")

summary(swim)


swim2=bind_rows(swim, recist_repb,eot_v2 )  %>%
   # mutate(examdl=(date-date_inclusion)) %>%
   mutate(time_from_date_inclusion_to_rcdt=(date-date_inclusion)) %>%
  # mutate(examdlbis=(date-ADMDT_first)) %>%
  mutate(time_from_first_adm_date_to_admt=(date-ADMDT_first)) %>%
  mutate(time_from_date_inclusion_to_rcdt_months=time_from_date_inclusion_to_rcdt/30) %>%
  mutate(time_from_first_adm_date_to_admt_months=time_from_first_adm_date_to_admt/30) %>%
  mutate(RCVISIT = ifelse(group == "Treatment Administration", "Treatment Period", RCVISIT))

length(unique(swim2$subjid))

dth_death= dth %>%
  select(subjid, dthdt )


dth_death2=dth_death %>%
  left_join(swim2, by = join_by(subjid)) %>%
  mutate(time_to_death=(dthdt-ADMDT_first)) %>%
  mutate(time_to_death_months=time_to_death/30) %>%
  select(subjid, time_to_death ) %>%
  distinct(subjid, time_to_death)

swim3=bind_rows(swim2,dth_death2 ) %>%
  mutate(group=ifelse(!is.na(time_to_death),"Death",group )) %>%
  mutate(time_from_first_adm_date_to_admt=ifelse(!is.na(time_to_death),time_to_death,time_from_first_adm_date_to_admt ))


# FU ----------------------------------------------------------------------

names(FU)


fu_v2= fu %>%
  select(subjid, FUDT ) %>%
  mutate(group="Alive at last follow up2")

fu_v3=fu_v2 %>%
  left_join(swim3, by = join_by(subjid)) %>%
  mutate(time_ADMDT_first_to_fu=(FUDT-ADMDT_first)) %>%
  mutate(time_ADMDT_first_to_fu_months=time_ADMDT_first_to_fu/30) %>%
  select(subjid, time_ADMDT_first_to_fu ) %>%
  distinct(subjid, time_ADMDT_first_to_fu)

swim4=bind_rows(swim3,fu_v3 ) %>%
  mutate(group=ifelse(!is.na(time_ADMDT_first_to_fu),"Alive at last follow up2",group )) %>%
  mutate(time_from_first_adm_date_to_admt=ifelse(!is.na(time_ADMDT_first_to_fu),time_ADMDT_first_to_fu,time_from_first_adm_date_to_admt ))

table( swim4$RCRESP,  swim4$group, useNA="always")
table( swim4$time_to_fu, useNA="always")


add_legend= dth_v3 %>%
  select(SUBJID) %>%
  mutate(group="Alive at last follow up")  %>%
  filter(SUBJID==86 ) %>%
  mutate(EXAMDL2bis=-1 )

add_legend2= dth_v3 %>%
  select(SUBJID) %>%
  mutate(group="Treatment period")  %>%
  filter(SUBJID==86 ) %>%
  mutate(EXAMDL2bis=-1 )

add_legend3=bind_rows(add_legend2,add_legend )

swim5=bind_rows(swim4,add_legend3 )


table(swim5$RCVISIT,  swim5$group, swim5$ADMYN,useNA="always")
table( swim5$group, useNA="always")
table( swim5$ADMYN, useNA="always")
table( swim5$RCVISIT, useNA="always")
table( swim5$RCRESP,  swim5$group, useNA="always")
table( swim5$RCRESP,  swim5$group, useNA="always")

swim6=swim5 %>%
  mutate(visit=ifelse(group=="Treatment Administration",1, NA)) %>%
  mutate(visit=ifelse(group=="Recist" & RCRESP=="Complete response" ,2, visit))%>%
  mutate(visit=ifelse(group=="Recist" & RCRESP=="Partial response" ,2, visit))%>%
  mutate(visit=ifelse(group=="Recist" & RCRESP=="Stable disease" ,3, visit))%>%
  mutate(visit=ifelse(group=="Recist" & RCRESP=="Progressive disease" ,4, visit))%>%
  mutate(visit=ifelse(group=="Recist" & RCRESP=="Not evaluable" ,5, visit))%>%
  mutate(visit=ifelse(group=="end of treatment"  ,6, visit)) %>%
  mutate(visit=ifelse(group=="Death"  ,7, visit)) %>%
  mutate(visit=ifelse(group=="Alive at last follow up2"  ,8, visit)) %>%
  mutate(visit=ifelse(group=="Alive at last follow up"  ,9, visit)) %>%
  mutate(visit=ifelse(group=="Treatment period",10,visit )) %>%
  filter(RCVISIT=="Treatment Period" | RCVISIT=="End of treatment" |RCVISIT== "Follow-up"|is.na(RCVISIT) )  %>%
  filter(ADMYN=="Yes" | is.na(ADMYN)) %>%
  distinct() %>%
  mutate(subjid_num=as.numeric(SUBJID)) %>%
  arrange(subjid_num, date)

table( swim6$visit, useNA="always")

dim(swim6)
summary(swim6)
suivi=swim6

length(unique(suivi$subjid))

colnames(suivi)=str_to_lower(colnames(suivi))
table( suivi$visit, useNA="always")

# Conversion de la variable visite en facteur

suivi$visit2 <- factor(suivi$visit, c(1:10),
                       c("Trt Administration",
                         "CR/PR",
                         "SD",
                         "PD",
                         "Not evaluable",
                         "End of trt", "Death", "Alive at last follow up2", "Alive at last follow up", "Treatment period"))

table(suivi$rcresp, useNA="always")
table( suivi$visit2, useNA="always")

table(suivi$visit2)

summary(suivi$examdl2bis)
summary(suivi$visit2)
summary(suivi$date)

# Plot --------------------------------------------------------------------
names(suivi)
suivi_trt = suivi %>%
  filter(visit2=="Trt Administration")%>%
  mutate(
    subjid_num = fct_reorder(factor(subjid_num), examdl2bis, .fun=max, na.rm=TRUE)
  ) %>%
  summarise(
    first_trt = min(examdl2bis, na.rm=TRUE),
    last_trt = max(examdl2bis, na.rm=TRUE),
    .by=subjid_num
  )

names(suivi)
suivi_fu = suivi %>%
  filter(visit2=="Alive at last follow up2" | visit2=="Trt Administration")%>%
  mutate(
    subjid_num = fct_reorder(factor(subjid_num), examdl2bis, .fun=max, na.rm=TRUE)
  ) %>%
  summarise(
    first_fu = min(examdl2bis, na.rm=TRUE),
    last_fu = max(examdl2bis, na.rm=TRUE),
    .by=subjid_num
  )


dat_swim <-
  suivi |>
  mutate(max_examdl2bis = max(examdl2bis, na.rm=TRUE),  .by=subjid_num) |>
  mutate(subjid_num = fct_reorder(factor(subjid_num), max_examdl2bis,  na.rm=TRUE))


# plot_final -------------------------------------------------------------------

# Function swimmer plots --------------------------------------------------

#' Create a Swimmer Plot of Overall Response by Patient
#'
#' @param dat_swim Data frame containing visit data
#' @param suivi_trt Data frame with treatment period information
#' @param suivi_fu Data frame with follow-up period information
#' @return A ggplot object representing the swimmer plot
#' @import ggplot2 dplyr
#' @export
swimmer_plot <- function(dat_swim, suivi_trt, suivi_fu) {
  requireNamespace("ggplot2")
  requireNamespace("dplyr")

  dat_filtered <- dat_swim %>%
    dplyr::filter(!is.na(visit2)) %>%
    dplyr::filter(!visit2 %in% c("End of trt", "Alive at last follow up2", "Trt Administration")) %>%
    dplyr::select(subjid_num, visit2, examdl2bis) %>%
    dplyr::distinct()

  plot <- ggplot2::ggplot(dat_filtered, ggplot2::aes(
    x = examdl2bis,
    y = factor(subjid_num),
    color = visit2,
    shape = visit2,
    size = visit2
  )) +
    ggplot2::geom_point(position = ggplot2::position_dodge(width = 0.4), size = 2) +
    ggplot2::geom_segment(
      ggplot2::aes(x = first_trt, y = subjid_num, xend = last_trt, yend = subjid_num),
      color = "skyblue",
      alpha = 0.3,
      linewidth = 1.5,
      inherit.aes = FALSE,
      data = suivi_trt
    ) +
    ggplot2::geom_segment(
      ggplot2::aes(x = first_fu, y = subjid_num, xend = last_fu, yend = subjid_num),
      color = "grey",
      inherit.aes = FALSE,
      data = suivi_fu,
      arrow = ggplot2::arrow(length = ggplot2::unit(0.3, "cm"))
    ) +
    ggplot2::scale_shape_manual(values = c(19, 8, 15, 4, 18, 62, 15)) +
    ggplot2::scale_color_manual(values = c(
      "Treatment period" = "skyblue",
      "CR/PR" = "green",
      "PD" = "purple",
      "Not evaluable" = "grey",
      "SD" = "yellow",
      "End of trt" = "pink",
      "Death" = "red",
      "Alive at last follow up" = "grey"
    )) +
    ggplot2::scale_x_continuous(
      name = "Time (in month) since first treatment administration",
      limits = c(0, 28),
      breaks = seq(0, 28, 2)
    ) +
    ggplot2::scale_y_discrete(name = "Patient") +
    ggplot2::geom_vline(xintercept = 0) +
    ggplot2::theme_classic() +
    ggplot2::labs(
      title = "By-patient Swimmer Plot of Overall Response",
      subtitle = paste0("n=", length(unique(dat_swim$subjid_num))),
      shape = NULL,
      color = NULL
    ) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", size = 14, hjust = 0),
      plot.subtitle = ggplot2::element_text(size = 10, hjust = 0),
      axis.title.x = ggplot2::element_text(size = 10, face = "italic"),
      axis.title.y = ggplot2::element_text(size = 10, face = "italic", angle = 90),
      axis.ticks.y = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_blank(),
      legend.text = ggplot2::element_text(size = 10)
    )

  return(plot)
}

# Generate the plot using your data frames
plot_final <- swimmer_plot(dat_swim, suivi_trt, suivi_fu)

# Display the plot
print(plot_final)
