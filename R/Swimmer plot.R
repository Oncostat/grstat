rm(list=ls())

# Library
library(dplyr)
library(lubridate)
library(grstat)
# not sure if needed
library(RColorBrewer)
library(forcats)
library(ggplot2)

# PROBLEM: subjid_num: sometimes num , sometimes factor even integer... so not quite sure as it changes a lot the results so it needs to be well revise!

# Data Simulated ----------------------------------------------------------


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


### dth dataset -------------------------------------------------------------

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
  select(subjid, dthdt, died)

dim(dth)
length(unique(dth$subjid))
class(dth$dthdt)
table(dth$died)

### adm dataset -------------------------------------------------------------

set.seed(2025)

# I am not quite sure how many treatment administration subjid can have between 2 recist scans, I think 21 days apart. So I have created only one adm per recist scans and one adm before ever first recist scan.

adm <- recist %>%
  left_join(enrolres %>% select(subjid, date_inclusion), by = "subjid") %>%
  filter(!is.na(rcresp)) %>%
  arrange(subjid, rcdt) %>%

  mutate(
    first_delay  = sample(5:15, 1),
    follow_delay = sample(21:30, 1)
    , .by = subjid) %>%

  mutate(
    ADMDT = if_else(
      row_number() == 1,
      pmin(date_inclusion + days(first_delay), rcdt),
      rcdt - days(follow_delay)
    ),
    .by = subjid
  ) %>%

  select(subjid, ADMDT, date_inclusion, rcdt, rcresp) %>%
  mutate(group = "Treatment Administration")

# adm <- recist %>%
#   left_join(enrolres %>% select(subjid, date_inclusion), by = "subjid") %>%
#   # filter(!is.na(rcresp), rcresp != "Progressive disease") %>%
#   filter(!is.na(rcresp)) %>%
#   arrange(subjid, rcdt) %>%   # ensure ordered by patient and RECIST
#   group_by(subjid) %>%
#   # cannot make this ADMYN variable correctly and I am not so sure if it is really needed
#   mutate(
#     #   ADMYN = sample(c("Yes", "No"), n(), replace = TRUE, prob = c(0.99, 0.01)),
#
#     # first admission date
#     ADMDT = if_else(
#       row_number() == 1,
#       pmin(date_inclusion + days(sample(5:15, 1)), rcdt),  # 5–15 days after inclusion but before first RECIST
#       rcdt - days(sample(21:30, 1))          # subsequent admissions: 21–30 days before each RECIST
#     )
#   ) %>%
#   ungroup() %>%
#   select(subjid, ADMDT,date_inclusion,rcdt, rcresp) %>%
#   mutate(group="Treatment Administration")


length(unique(adm$subjid))

### eot dataset -------------------------------------------------------------

set.seed(2025)

eot <- adm %>%
  summarise(
    last_admdt = max(ADMDT, na.rm = TRUE),
    last_rcdt  = max(rcdt, na.rm = TRUE)
    ,.by = subjid) %>%
  left_join(select(dth, subjid, dthdt, died), by = "subjid")

# Step 2: Simulate End of Treatment date (EOTLADDT)
eot <- eot %>%
  mutate(
    # usually after last treatment date but before death
    EOTLADDT = case_when(
      died == 1 ~ last_admdt + days(sample(7:60, n(), replace = TRUE)),  # 1–2 months after treatment end
      died == 0 | is.na(died) ~ last_admdt + days(sample(30:120, n(), replace = TRUE)) # alive: longer gap
    )
  ) %>%
  select(subjid, last_admdt, dthdt, died, EOTLADDT)


length(unique(eot$subjid))


# Step 4: keep EOTLADDT for all subjid that had progressive disease and reduce some for others

eot <- eot %>%
  left_join(recist, by = "subjid") %>%
  select(subjid, EOTLADDT, rcresp) %>%
  mutate(
    EOTLADDT_v2 = if_else(rcresp == "Progressive disease", EOTLADDT, as.Date(NA))
  ) %>%
  mutate(
    EOTLADDT = if_else(
      runif(n()) < 0.99,          # with 70% probability
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

### fu dataset -------------------------------------------------------------

set.seed(2025)

# fu <- eot %>%
#   rowwise() %>%
#   mutate(
#     n_fu = sample(1)  # number of follow-ups per subject
#   ) %>%
#   do({
#     subjid <- .$subjid
#     eot_date <- .$EOTLADDT
#     n_fu <- .$n_fu
#
#     # Simulate follow-up dates: between 4 and 180 days post-EOTLADDT
#     data.frame(
#       subjid = subjid,
#       FUDT = sort(eot_date + days(sample(4:180, n_fu, replace = FALSE)))
#     )
#   }) %>%
#   ungroup() %>%
#   mutate(
#     FUDT = if_else(
#       runif(n()) < 0.7,   # 80% probability
#       as.Date(NA),        # set to missing
#       FUDT                # keep original
#     )
#   ) %>%
#   distinct() %>%
#   filter(!is.na(FUDT))


fu=eot %>%
  rowwise() %>%
  mutate(
    n_fu = sample(1),  # number of follow-ups per subject
    FUDT = sort(EOTLADDT + days(sample(4:180, n_fu, replace = FALSE)))
  ) %>%
  ungroup() %>%
  slice_sample(prop=0.35) %>%
  select(subjid, FUDT)

length(unique(fu$subjid))


### add rcvisit to recist ---------------------------------------------------


recist <- recist %>%
  mutate(RCVISIT = ifelse(is.na(rcresp), "Baseline", NA), .by = subjid)

dim(recist)
length(unique(recist$subjid))



# create the dataset for the plot -----------------------------------------


# # dataset needed to create the plot dataset.
# - enrolres (not sure if that data is really needed)
# - recist
# - adm
# - eot
# - dth
# - FU


### date of inclusion -------------------------------------------------------


enrolres_v2=subset(enrolres,
                   select=c(subjid, date_inclusion))



### subset of first adm date plus the other following administration dates-------------------------------------------------------

ADM_first <- adm %>%
  arrange(as.numeric(subjid), rcdt) %>%
  mutate(ADMDT_min = first(ADMDT), .by = subjid) %>%
  mutate(ADMDT_max = last(ADMDT), .by = subjid) %>%
  select(subjid, ADMDT_min, group, ADMDT) %>%
  mutate(group="Treatment Administration") %>%
  mutate(date=ADMDT)

length(unique(ADM_first$subjid))


### join date of inclusion + first adm date + the following adm dates -------------------------------------------------------

adm_v2=enrolres_v2 %>%
  left_join(ADM_first, by=c("subjid")) %>%
  select(subjid, date_inclusion ,ADMDT_min, group, date)
# mutate(T0=consdt) %>%
# mutate(T0bis=first_ADMDT) %>%

length(unique(adm_v2$subjid))

###  create the dataset date_inclusion_ADMDT_min that will be left join to every subset of the datasets

date_inclusion_ADMDT_min=adm_v2 %>%
  select(subjid,date_inclusion, ADMDT_min ) %>%
  distinct()
length(unique(date_inclusion_ADMDT_min$subjid))

### subset of the dataset recist of the rcdt and responses -------------------------------------------------------

recist_repb=recist %>%
  mutate(group="Recist") %>%
  left_join(date_inclusion_ADMDT_min, by=c("subjid")) %>%
  mutate(date=rcdt) %>%
  select(subjid , date, rcresp, date_inclusion, ADMDT_min, group, RCVISIT) %>%
  distinct()

length(unique(recist_repb$subjid))

### subset of eot dataset,  end of treatment date -------------------------------------------------------

names(eot)
eot_v2=eot %>%
  left_join(date_inclusion_ADMDT_min, by=c("subjid")) %>%
  mutate(date=EOTLADDT) %>%
  mutate(group="End of treatment")  %>%
  select(subjid,group, date_inclusion,ADMDT_min, date) %>%
  distinct() %>%
  filter(!is.na(date))



table(eot_v2$group  , useNA="always")

length(unique(eot_v2$subjid))


#  subset of death datset -------------------------------------------------

dth_death= dth %>%
  select(subjid, dthdt ) %>%
  left_join(date_inclusion_ADMDT_min, by=c("subjid")) %>%
  mutate(date=dthdt) %>%
  mutate(group="Death") %>%
  select(subjid,group, date_inclusion,ADMDT_min, date) %>%
  distinct() %>%
  filter(!is.na(date))


length(unique(dth_death$subjid))

#  subset of FU dataset -------------------------------------------------

fu_v2= fu %>%
  select(subjid, FUDT ) %>%
  mutate(group="Alive at last follow up2") %>%
  left_join(date_inclusion_ADMDT_min, by=c("subjid")) %>%
  mutate(date=FUDT) %>%
  select(subjid,group, date_inclusion,ADMDT_min, date) %>%
  distinct() %>%
  filter(!is.na(date))

length(unique(fu_v2$subjid))

### caculate time_from_date_inclusion_to_any date( any adm/fu/dth/eot) and time_from_first_adm_date_to_any dates (any adm/fu/dth/eot)-------------------------------------------------------

swim=bind_rows(adm_v2, recist_repb ,eot_v2, dth_death, fu_v2) %>%
  mutate(time_from_date_inclusion_to_date=(date-date_inclusion)) %>%
  mutate(time=(date-ADMDT_min)) %>%
  mutate(time_from_date_inclusion_to_date_months=time_from_date_inclusion_to_date/30) %>%
  mutate(time_months=time/30)

length(unique(swim$subjid))
summary(swim)
dim(swim)

# prepare final dataset for plot ------------------------------------------


#  add legend to the main dataset (swim) for those data that creates bellow length of treatment period and lenght from first adm to alive at last follow up

target_id <- sample(unique(swim$subjid), 1)

add_legend <- swim %>%
  select(subjid) %>%
  filter(subjid == target_id) %>%
  slice(rep(1, 2)) %>%                      # duplicate the row
  mutate(
    group = c("Alive at last follow up", "Treatment period"),
    time = -1
  )

swim=swim %>%
  mutate(time=as.numeric(time))

swim_final=bind_rows(swim,add_legend )

table( swim_final$group, useNA="always")
table( swim_final$RCVISIT, useNA="always")
table( swim_final$rcresp,  swim_final$group, useNA="always")


# swim_v2=swim_final %>%
#   mutate(visit=ifelse(group=="Treatment Administration",1, NA)) %>%
#   mutate(visit=ifelse(group=="Recist" & rcresp=="Complete response" ,2, visit))%>%
#   mutate(visit=ifelse(group=="Recist" & rcresp=="Partial response" ,2, visit))%>%
#   mutate(visit=ifelse(group=="Recist" & rcresp=="Stable disease" ,3, visit))%>%
#   mutate(visit=ifelse(group=="Recist" & rcresp=="Progressive disease" ,4, visit))%>%
#   mutate(visit=ifelse(group=="Recist" & rcresp=="Not Evaluable" ,5, visit))%>%
#   mutate(visit=ifelse(group=="End of treatment"  ,6, visit)) %>%
#   mutate(visit=ifelse(group=="Death"  ,7, visit)) %>%
#   mutate(visit=ifelse(group=="Alive at last follow up2"  ,8, visit)) %>%
#   mutate(visit=ifelse(group=="Alive at last follow up"  ,9, visit)) %>%
#   mutate(visit=ifelse(group=="Treatment period",10,visit )) %>%
#   filter(!RCVISIT %in% "Baseline") %>%
#   distinct() %>%
#   # Could not amke this that variable work but again I am not so sure how much we need it
#   # filter(ADMYN=="Yes" | is.na(ADMYN)) %>%
#   mutate(subjid_num=as.numeric(subjid)) %>%
#   arrange(subjid_num, date)

swim_v2 <- swim_final %>%
  mutate(
    visit = dplyr::case_when(
      group == "Treatment Administration" ~ 1,
      group == "Recist" & rcresp %in% c("Complete response", "Partial response") ~ 2,
      group == "Recist" & rcresp == "Stable disease" ~ 3,
      group == "Recist" & rcresp == "Progressive disease" ~ 4,
      group == "Recist" & rcresp == "Not Evaluable" ~ 5,
      group == "End of treatment" ~ 6,
      group == "Death" ~ 7,
      group == "Alive at last follow up2" ~ 8,
      group == "Alive at last follow up" ~ 9,
      group == "Treatment period" ~ 10,
      TRUE ~ NA_real_
    ),

    visit2 = factor(
      visit,
      levels = 1:10,
      labels = c(
        "Trt Administration",
        "CR/PR",
        "SD",
        "PD",
        "Not evaluable",
        "End of trt",
        "Death",
        "Alive at last follow up2",
        "Alive at last follow up",
        "Treatment period"
      )
    )
  ) %>%
  filter(!RCVISIT %in% "Baseline") %>%
  distinct() %>%
  mutate(subjid_num = as.numeric(subjid)) %>%
  arrange(subjid_num, date)


suivi=swim_v2

length(unique(suivi$subjid))

table( suivi$visit, useNA="always")

# # Conversion de la variable visite en facteur
#
# suivi$visit2 <- factor(suivi$visit, c(1:10),
#                        c("Trt Administration",
#                          "CR/PR",
#                          "SD",
#                          "PD",
#                          "Not evaluable",
#                          "End of trt", "Death", "Alive at last follow up2",  "Alive at last follow up", "Treatment period" ))

table(suivi$rcresp, useNA="always")
table( suivi$visit2, useNA="always")


summary(suivi$time)
summary(suivi$visit2)
summary(suivi$date)

dat_swim <-
  suivi |>
  mutate(max_time = max(time, na.rm=TRUE),  .by=subjid_num) |>
  mutate(subjid_num = fct_reorder(factor(subjid_num), max_time,  na.rm=TRUE))

names(suivi)

suivi_trt = suivi %>%
  filter(visit2=="Trt Administration") %>%
  mutate(
    subjid_num = fct_reorder(factor(subjid_num), time, .fun=max, na.rm=TRUE)
  ) %>%
  # arrange(subjid_num, time) %>%
  summarise(
    first_trt = min(time, na.rm=TRUE),
    last_trt = max(time, na.rm=TRUE),
    .by=subjid_num
  )

length(unique(suivi_trt$subjid_num))
dim(suivi_trt)
summary(suivi_trt)


suivi_fu = suivi %>%
  filter(visit2=="Alive at last follow up2" | visit2=="Trt Administration"| group == "Recist") %>%
  mutate(
    subjid_num = fct_reorder(factor(subjid_num), time, .fun=max, na.rm=TRUE)
  ) %>%
  # arrange(subjid_num, time) %>%
  summarise(
    first_fu = min(time, na.rm=TRUE),
    last_fu = max(time, na.rm=TRUE),
    .by=subjid_num
  )


length(unique(suivi_fu$subjid_num))
dim(suivi_fu)
summary(suivi_fu)
head(suivi_fu)


# merge suivi_trt and _fu -------------------------------------------------


names(suivi_fu)
names(suivi_trt)
suivi_trt_fu=suivi_trt %>%
  full_join(suivi_fu, join_by(subjid_num))
length(unique(suivi_trt_fu$subjid_num))
dim(suivi_trt_fu)

# Final plot --------------------------------------------------------------

plot_final= dat_swim %>%
  dplyr::filter(!is.na(visit2))%>%
  # dplyr::filter(visit2!="End of trt")%>%
  dplyr::filter(visit2!="Alive at last follow up2")%>%
  dplyr::select(c(subjid_num,visit2,time))%>%
  dplyr::distinct() %>%
  filter(visit2!="Trt Administration") %>%
  ggplot( aes(x=time, y=factor(subjid_num), color=visit2, shape=visit2))+
  geom_point(position= position_dodge(width=0.4), size=2)+
  geom_segment(aes(x=first_fu, y=subjid_num, xend=last_fu, yend=subjid_num),  color="grey", inherit.aes=FALSE,  data=suivi_trt_fu, arrow=arrow(length=unit(0.3, "cm")))+
  geom_segment(aes(x=first_trt, y=subjid_num, xend=last_trt, yend=subjid_num), color="skyblue", alpha=0.3, linewidth=1.5,
               inherit.aes=FALSE, data=suivi_trt_fu)+
  scale_shape_manual(values = c(19,8,15,4,16,18,62,15))+
  scale_color_manual(values = c("Treatment period"="skyblue", "CR/PR"="green", "PD"="purple", "Not evaluable"="grey", "SD"="yellow","End of trt"="pink", "Death"="red", "Alive at last follow up"="grey"))+
  scale_x_continuous(name ="Time (in days) since first treatment administration",
                     limits = c(0,400),
                     breaks = seq(0,400,20))+
  scale_y_discrete(name="Patient")+
  geom_vline(xintercept=0)+
  theme_classic()+
  labs(title = "By-patient Swimmer Plot of Overall Response",
       subtitle = paste0("n=",length(unique(suivi$subjid))),
       shape=NULL, color=NULL)+
  theme(plot.title = element_text(face = "bold", size = 14, hjust = 0),
        plot.subtitle = element_text(size=10, hjust=0),
        axis.title.x= element_text(size=10, face="italic"),
        axis.title.y= element_text(size=10, face="italic", angle = 90),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        legend.text = element_text(size=10),
  )
print(plot_final)

plotly::ggplotly()

# Test SW plot function -----------------------------------------------------------


## STEP 1 ------------------------------------------------------------------


### step 1A ---------------------------------------------------------------

# put all together without repetition of what you will exactly need and that you understand of what Dan do in first step 1a


# not sure yet where to put that :
# geom_point(position= position_dodge(width=0.4), size=2)
#
# color="grey", inherit.aes=FALSE,  data=suivi_trt_fu, arrow=arrow(length=unit(0.3, "cm")))+
#
#   color="skyblue", alpha=0.3, linewidth=1.5,

swimmer_plot = function(
    dat_swim, ..., suivi_trt_fu,
    y = "subjid_num",
    x="time",
    color="visit2",
    shape="visit2",
    x="first_trt",
    xend="last_trt",
    x="first_fu"
    xend="last_fu",
    yend="subjid_num",
    resp_shape = (values = c(19,8,15,4,16,18,62,15))+
      resp_colors = c("Treatment period"="skyblue", "CR/PR"="green", "PD"="purple", "Not evaluable"="grey", "SD"="yellow","End of trt"="pink", "Death"="red", "Alive at last follow up"="grey")),
warnings = getOption("grstat_wp_warnings", TRUE)
)

### step 1B ------------------------------------------------------------------

# conceptualize the STEP1A

swimmer_plot = function(
    data_event, ..., data_trt_fu,
    subjid = "subjid" or y="subjid",
    time="time",
    event="visit2",
    first_trt="first_trt",
    last_trt="last_trt",
    first_fu="first_fu",
    last_fu="last_fu",
    yend="subjid_num",
    resp_shape = (values = c(19,8,15,4,16,18,62,15)),
    resp_colors = c("Treatment period"="skyblue", "CR/PR"="green", "PD"="purple", "Not evaluable"="grey", "SD"="yellow","End of trt"="pink", "Death"="red", "Alive at last follow up"="grey")),
# not sure about the warning bits.
warnings = getOption("grstat_wp_warnings", TRUE)
)


# Step 2 checks as Dan functions writting way------------------------------------------------------------------
rlang::check_dots_empty()

if(!is.data.frame(data_event))
  stop("data_event must be a data.frame")
if(!is.data.frame(data_trt_fu))
  stop("data_trt_fu must be a data.frame")

id_time_event <- c(subjid, time, event)
if(!all(id_time_event %in% names(data_event)))
  stop("data_event must contain: ", paste(id_time_event, collapse=", "))

id_trt_fu <- c(subjid, first_trt, last_trt, first_fu, last_fu)
if(!all(id_trt_fu %in% names(data_trt_fu)))
  stop("data_trt_fu must contain: ", paste(id_trt_fu, collapse=", "))

# Duplicate subject checks
dup_ev <- data_event[[subjid]][duplicated(data_event[[subjid]])]
if(length(dup_ev) > 0){
  dup_list <- sort(unique(dup_ev))
  stop("Duplicate subject IDs found in `data_event`: ",
       paste(dup_list, collapse = ", "),
       call. = FALSE)
}

dup_trt <- data_trt_fu[[subjid]][duplicated(data_trt_fu[[subjid]])]
if(length(dup_trt) > 0){
  dup_list <- sort(unique(dup_trt))
  stop("Duplicate subject IDs found in `data_trt_fu`: ",
       paste(dup_list, collapse = ", "),
       call. = FALSE)
}

#' I am trying to do a help R support plus redo those checks bellow.
#' #' Title
#' #'
#' #' @param data
#' #' @param subjid
#' #'
#' #' @return
#' #' @export
#' #'
#' #' @examples
#' check_legacy = function(data, subjid) {
#'   dup_id = duplicated(data[[subjid]])
#'   if(any(dup_id)){
#'     dup = sort(unique(data[[subjid]][dup_id]))
#'
#'     Ensure Unused Arguments Are Not Provided
#'     check_dots_empty()
#'     If the user passes any unknown argument (via `...`), the function will stop and notify the user.
#'     This avoids silent errors and prevents ambiguous input interpretation.


# Sample plot -------------------------------------------------------------------

#  Sample 100 unique subject IDs once
selected_ids <- sample(unique(suivi_fu$subjid_num), 50)

#  Filter both datasets using the same IDs
suivi_fu_sample <- suivi_fu %>%
  dplyr::filter(subjid_num %in% selected_ids)  %>%
  mutate(same=first_fu==last_fu) %>%
  mutate(first_fu=if_else(same=="TRUE",NA, first_fu))


dat_swim_sample <- dat_swim %>%
  dplyr::filter(subjid_num %in% selected_ids)

length(unique(suivi_fu_sample$subjid_num))
length(unique(dat_swim_sample$subjid_num))

unique(suivi_fu_sample$subjid_num)
unique(dat_swim_sample$subjid_num)

sample_plot_final= dat_swim_sample %>%
  dplyr::filter(!is.na(visit2))%>%
  # dplyr::filter(visit2!="End of trt")%>%
  dplyr::filter(visit2!="Alive at last follow up2")%>%
  dplyr::select(c(subjid_num,visit2,time))%>%
  dplyr::distinct() %>%
  filter(visit2!="Trt Administration") %>%
  ggplot( aes(x=time, y=factor(subjid_num), color=visit2, shape=visit2, size=visit2))+
  geom_point(position= position_dodge(width=0.4), size=2)+
  geom_segment(aes(x=first_fu, y=subjid_num, xend=last_fu, yend=subjid_num),  color="grey", inherit.aes=FALSE,  data=suivi_fu_sample, arrow=arrow(length=unit(0.3, "cm")))








