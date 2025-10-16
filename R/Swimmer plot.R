# Library
library(dplyr)
library(lubridate)
library(grstat)

# Data Simulated

# The function `grstat_example()` is used as an example dataset to illustrate the data usage.


tm = grstat_example()
attach(tm)

View(ae)
View(enrolres)
View(recist)


dim(ae)
dim(enrolres)
dim(recist)

length(unique(recist$subjid))
length(unique(ae$subjid))
length(unique(enrolres$subjid))


## add simulated death date to recist


set.seed(2025)  # reproducibility

# Step 1: get last date per subject and simulate deaths (20% die)

death_info <- recist %>%
  summarise(
    last_rcdt = max(rcdt, na.rm = TRUE),.by = subjid ) %>%
  mutate(
    died = rbinom(n(), 1, prob = 0.2),
    death_dt = if_else(
      died == 1,
      last_rcdt + days(sample(30:180, n(), replace = TRUE)),
      as.Date(NA)
    )
  ) %>%
  select(subjid, death_dt, died)  # keep only ID + simulated death date

# Step 2: merge death info back to full recist dataset
recist_with_death <- recist %>%
  left_join(death_info, by = "subjid")


View(recist_with_death)
dim(recist_with_death)
length(unique(recist_with_death$subjid))
class(recist_with_death$death_dt)

## simulate treatment administration data

set.seed(2025)

# assume:
# I am not quite sure how many treatment administration subjid can have between 2 recist scans, I think 21 days apart. So I have created only one adm per recist scans and one adm before ever first recist scan.


adm <- recist %>%
  left_join(enrolres %>% select(subjid, date_inclusion), by = "subjid") %>%
  filter(!is.na(rcresp), rcresp != "Progressive disease") %>%
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
  # select(subjid, ADMYN, ADMDT)


View(adm)

#  Simulate EOTDT in a EOT dataset

set.seed(2025)

# Step 1: Create eot base dataset (from adm and recist_with_death)
eot <- adm %>%
  group_by(subjid) %>%
  summarise(
    last_admdt = max(ADMDT, na.rm = TRUE),
    last_rcdt  = max(rcdt, na.rm = TRUE)
  ) %>%
  left_join(select(recist_with_death, subjid, death_dt, died), by = "subjid")

# Step 2: Simulate End of Treatment Date (EOTLADDT)
eot <- eot %>%
  mutate(
    # usually after last treatment date but before death
    EOTLADDT = case_when(
      died == 1 ~ last_admdt + days(sample(7:60, n(), replace = TRUE)),  # 1–2 months after treatment end
      died == 0 | is.na(died) ~ last_admdt + days(sample(30:120, n(), replace = TRUE)) # alive: longer gap
    ),
    # ensure EOTLADDT < death date when applicable
    EOTLADDT = if_else(!is.na(death_dt) & EOTLADDT > death_dt,
                       death_dt - days(sample(3:10, n(), replace = TRUE)),  # just before death
                       EOTLADDT)
  ) %>%
  select(subjid, last_admdt, death_dt, died, EOTLADDT)

# Step 3: (Optional) Add realistic censoring or ensure no future dates
eot <- eot %>%
  mutate(
    EOTLADDT = pmin(EOTLADDT, Sys.Date()) # prevent future dates
  ) %>%
  summarise(
    EOTLADDT = max(EOTLADDT, na.rm = TRUE),.by = subjid )



# Icarus breast dataset
library(RColorBrewer)
data to plot needed are :

  dat_swim, suivi_trt, suivi_fu

#  ????? Est ce que le dataset baseline a les variable BPCONSDT,BICONSDT, ou il faut prendre les date d inclusion de enroll au lieu des dates de consentement dans baseline dataset ????? Check Matthieu and Baptiste script.

enrolres_v2=subset(enrolres,
                    select=c(subjid, date_inclusion))


ADM_first <- adm %>%
  arrange(as.numeric(subjid), rcdt) %>%
  mutate(ADMDT_first = first(ADMDT), .by = subjid) %>%
  mutate(ADMDT_last = last(ADMDT), .by = subjid) %>%
  select(subjid, ADMYN, ADMDT_first, Group)

ADM_last <- adm %>%
  arrange(as.numeric(subjid), rcdt) %>%
  mutate(ADMDT_first = first(ADMDT), .by = subjid) %>%
  mutate(ADMDT_last = last(ADMDT), .by = subjid) %>%
  select(subjid, ADMYN,  ADMDT_last, Group)

swim=enrolres_v2 %>%
  left_join(ADM_first, by=c("subjid")) %>%
  select(subjid, date_inclusion ,ADMYN,ADMDT_first, Group)
  # mutate(T0=consdt) %>%
  # mutate(T0bis=first_ADMDT) %>%
  # mutate(Texam=ADMDT)

recist_repb=recist_with_death %>%
  left_join(swim, by=c("subjid")) %>%
   mutate(Group="Recist") %>%
  # mutate(T0=consdt) %>%
  # mutate(T0bis=ADMDT_first) %>%
  # mutate(Texam=RCDT) %>%
  select(subjid , rcdt, rcresp, death_dt, date_inclusion, ADMDT_first, group) %>%
  distinct()

eot_v2=eot %>%
  left_join(recist_repb, by=c("SUBJID")) %>%
  # mutate(Texam=EOTLADDT) %>%
  # mutate(T0=consdt) %>%
  # mutate(T0bis=ADMDT_first) %>%
  mutate(Group="end of treatment")  %>%
  select(SUBJID, Group, EOTLADDT)
table(eot_v2b$Group  , useNA="always")

swim$Texam=as.POSIXct(format(swim$Texam,"%Y-%m-%d"))
recist_repb$Texam=as.POSIXct(format(recist_repb$Texam,"%Y-%m-%d"))
eot_v2b$Texam=as.POSIXct(format(eot_v2b$Texam,"%Y-%m-%d"))

summary(swim)
swim$T0bis=as.POSIXct(format(swim$T0bis,"%Y-%m-%d"))
recist_repb$T0bis=as.POSIXct(format(recist_repb$T0bis,"%Y-%m-%d"))
eot_v2b$T0bis=as.POSIXct(format(eot_v2b$T0bis,"%Y-%m-%d"))

# TO DO: change bind_row to pivot_longer

swim2=bind_rows(swim, recist_repb,eot_v2b )  %>%
  mutate(examdl=(Texam-T0)/(3600*24)) %>%
  mutate(examdlbis=(Texam-T0bis)/(3600*24)) %>%
  mutate(EXAMDL2=examdl/30) %>%
  mutate(EXAMDL2bis=examdlbis/30)

dth_death= dth_v3 %>%
  select(SUBJID, DTHDT ) %>%
  mutate(Group="Death")
dth_death$DTHDT=as.POSIXct(format(dth_death$DTHDT,"%Y-%m-%d"))
summary(swim2)
dth_death2=dth_death %>%
  left_join(swim2, by = join_by(SUBJID)) %>%
  mutate(time_to_death=(DTHDT-T0bis)) %>%
  mutate(time_to_death=time_to_death/30) %>%
  select(SUBJID, time_to_death ) %>%
  distinct(SUBJID, time_to_death)

swim3=bind_rows(swim2,dth_death2 ) %>%
  mutate(Group=ifelse(!is.na(time_to_death),"Death",Group )) %>%
  mutate(EXAMDL2bis=ifelse(!is.na(time_to_death),time_to_death,EXAMDL2bis ))

table( swim3$RCRESP,  swim3$Group, useNA="always")
table( swim3$time_to_death, useNA="always")


# FU ----------------------------------------------------------------------

names(fu)


fu_fu= fu %>%
  select(SUBJID, FUDT ) %>%
  mutate(Group="Alive at last follow up2")
table( fu_fu$FUDT, useNA="always")

fu_fu$FUDT=as.POSIXct(format(fu_fu$FUDT,"%Y-%m-%d"))

summary(swim3)
fu_fu2=fu_fu %>%
  left_join(swim3, by = join_by(SUBJID)) %>%
  mutate(time_to_fu=(FUDT-T0bis)) %>%
  mutate(time_to_fu=time_to_fu/30) %>%
  select(SUBJID, time_to_fu ) %>%
  distinct(SUBJID, time_to_fu)

swim4=bind_rows(swim3,fu_fu2 ) %>%
  mutate(Group=ifelse(!is.na(time_to_fu),"Alive at last follow up2",Group )) %>%
  mutate(EXAMDL2bis=ifelse(!is.na(time_to_fu),time_to_fu,EXAMDL2bis ))

table( swim4$RCRESP,  swim4$Group, useNA="always")
table( swim4$time_to_fu, useNA="always")


add_legend= dth_v3 %>%
  select(SUBJID) %>%
  mutate(Group="Alive at last follow up")  %>%
  filter(SUBJID==86 ) %>%
  mutate(EXAMDL2bis=-1 )

add_legend2= dth_v3 %>%
  select(SUBJID) %>%
  mutate(Group="Treatment period")  %>%
  filter(SUBJID==86 ) %>%
  mutate(EXAMDL2bis=-1 )

add_legend3=bind_rows(add_legend2,add_legend )

swim5=bind_rows(swim4,add_legend3 )


table(swim5$RCVISIT,  swim5$Group, swim5$ADMYN,useNA="always")
table( swim5$Group, useNA="always")
table( swim5$ADMYN, useNA="always")
table( swim5$RCVISIT, useNA="always")
table( swim5$RCRESP,  swim5$Group, useNA="always")
table( swim5$RCRESP,  swim5$Group, useNA="always")

swim6=swim5 %>%
  mutate(visit=ifelse(Group=="Treatment Administration",1, NA)) %>%
  mutate(visit=ifelse(Group=="Recist" & RCRESP=="Complete response" ,2, visit))%>%
  mutate(visit=ifelse(Group=="Recist" & RCRESP=="Partial response" ,2, visit))%>%
  mutate(visit=ifelse(Group=="Recist" & RCRESP=="Stable disease" ,3, visit))%>%
  mutate(visit=ifelse(Group=="Recist" & RCRESP=="Progressive disease" ,4, visit))%>%
  mutate(visit=ifelse(Group=="Recist" & RCRESP=="Not evaluable" ,5, visit))%>%
  mutate(visit=ifelse(Group=="end of treatment"  ,6, visit)) %>%
  mutate(visit=ifelse(Group=="Death"  ,7, visit)) %>%
  mutate(visit=ifelse(Group=="Alive at last follow up2"  ,8, visit)) %>%
  mutate(visit=ifelse(Group=="Alive at last follow up"  ,9, visit)) %>%
  mutate(visit=ifelse(Group=="Treatment period",10,visit )) %>%
  filter(RCVISIT=="Treatment Period" | RCVISIT=="End of treatment" |RCVISIT== "Follow-up"|is.na(RCVISIT) )  %>%
  filter(ADMYN=="Yes" | is.na(ADMYN)) %>%
  distinct() %>%
  mutate(subjid_num=as.numeric(SUBJID)) %>%
  arrange(subjid_num, Texam)

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
summary(suivi$texam)

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
