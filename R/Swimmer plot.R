rm(list=ls())

# Library
library(dplyr)
library(lubridate)
library(grstat)
# not sure if needed
library(RColorBrewer)
library(forcats)
library(ggplot2)


# Data Simulated ----------------------------------------------------------


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
  select(subjid, dthdt, died)  # keep only ID + simulated death date

dim(dth)
length(unique(dth$subjid))
class(dth$dthdt)


### adm dataset -------------------------------------------------------------

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

### eot dataset -------------------------------------------------------------

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
    )
    # # ensure EOTLADDT < death date when applicable
    # EOTLADDT = if_else(!is.na(dthdt) & EOTLADDT > dthdt,
    #                    dthdt - days(sample(3:10, n(), replace = TRUE)),  # just before death
    #                    EOTLADDT)
  ) %>%
  select(subjid, last_admdt, dthdt, died, EOTLADDT)

# Step 3: (Optional) Add realistic censoring or ensure no future dates
# eot <- eot %>%
#   mutate(
#     EOTLADDT = pmin(EOTLADDT, Sys.Date()) # prevent future dates
#   ) %>%
#   summarise(
#     EOTLADDT = max(EOTLADDT, na.rm = TRUE),.by = subjid )

length(unique(eot$subjid))
#  something wrong as lots of subjid have a end of tretment before last adm

eot_adjustement <- adm %>%
  arrange(as.numeric(subjid), rcdt) %>%
  mutate(ADMDT_last = last(ADMDT), .by = subjid) %>%
  select(subjid, ADMDT_last) %>%
  left_join(eot) %>%
  left_join(dth) %>%
  filter(!is.na(EOTLADDT)) %>%
  mutate(time_from_end_trt_to_last_adm=EOTLADDT-ADMDT_last) %>%
mutate(time_from_end_trt_to_last_dth=dthdt-EOTLADDT)
  filter(time_from_end_trt_to_last_adm>0)


# Step 4: keep EOTLADDT for all subjid that had progressive deasease

eot <- eot_adjustement %>%
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

### add rcvisit to recist ---------------------------------------------------


recist <- recist %>%
  group_by(subjid) %>%
  mutate(RCVISIT = ifelse(is.na(rcresp), "Baseline", NA)) %>%
  ungroup()

dim(recist)
length(unique(recist$subjid))



# create the dataset for the plot -----------------------------------------


# dataset needed to create the plot dataset.
data needed
- enrolres (not sure if that data is really nedded)
- recist
- adm
- eot
- dth
- FU



### date of inclusion -------------------------------------------------------


enrolres_v2=subset(enrolres,
                    select=c(subjid, date_inclusion))



### first adm date plus the other following administration dates-------------------------------------------------------

ADM_first <- adm %>%
  arrange(as.numeric(subjid), rcdt) %>%
  mutate(ADMDT_first = first(ADMDT), .by = subjid) %>%
  mutate(ADMDT_last = last(ADMDT), .by = subjid) %>%
  select(subjid, ADMYN, ADMDT_first, group, ADMDT) %>%
  mutate(group="Treatment Administration") %>%
  mutate(date=ADMDT)

length(unique(ADM_first$subjid))

### join date of inclusion + first adm date + the following adm dates -------------------------------------------------------

adm_v2=enrolres_v2 %>%
  left_join(ADM_first, by=c("subjid")) %>%
  select(subjid, date_inclusion ,ADMYN,ADMDT_first, group, date)
  # mutate(T0=consdt) %>%
  # mutate(T0bis=first_ADMDT) %>%

length(unique(adm_v2$subjid))

###  create the dataset date_inclusion_ADMDT_first that will be left join to every subset of the datsets

date_inclusion_ADMDT_first=adm_v2 %>%
  select(subjid,date_inclusion, ADMDT_first ) %>%
  distinct()
length(unique(date_inclusion_ADMDT_first$subjid))

### get the recist rcdt and responses -------------------------------------------------------

recist_repb=recist %>%
    mutate(group="Recist") %>%
  left_join(date_inclusion_ADMDT_first, by=c("subjid")) %>%
  # mutate(T0=consdt) %>%
  # mutate(T0bis=ADMDT_first) %>%
   mutate(date=rcdt) %>%
  select(subjid , date, rcresp, date_inclusion, ADMDT_first, group, RCVISIT) %>%
  distinct()

length(unique(recist_repb$subjid))

### subset of eot datset,  end of treatment date -------------------------------------------------------

names(eot)
eot_v2=eot %>%
  left_join(date_inclusion_ADMDT_first, by=c("subjid")) %>%
  mutate(date=EOTLADDT) %>%
  # mutate(T0=consdt) %>%
  # mutate(T0bis=ADMDT_first) %>%
  mutate(group="End of treatment")  %>%
  select(subjid,group, date_inclusion,ADMDT_first, date) %>%
  distinct() %>%
  filter(!is.na(date))



table(eot_v2$group  , useNA="always")

length(unique(eot_v2$subjid))


#  subset of death datset -------------------------------------------------

dth_death= dth %>%
  select(subjid, dthdt ) %>%
left_join(date_inclusion_ADMDT_first, by=c("subjid")) %>%
  mutate(date=dthdt) %>%
mutate(group="Death") %>%
  select(subjid,group, date_inclusion,ADMDT_first, date) %>%
  distinct() %>%
  filter(!is.na(date))


length(unique(dth_death$subjid))

#  subset of FU dataset -------------------------------------------------

fu_v2= fu %>%
  select(subjid, FUDT ) %>%
  mutate(group="Alive at last follow up2") %>%
  left_join(date_inclusion_ADMDT_first, by=c("subjid")) %>%
  mutate(date=FUDT) %>%
select(subjid,group, date_inclusion,ADMDT_first, date) %>%
  distinct() %>%
  filter(!is.na(date))

length(unique(fu_v2$subjid))

### caculate time_from_date_inclusion_to_any date( any adm/fu/dth/eot) and time_from_first_adm_date_to_any dates (any adm/fu/dth/eot)-------------------------------------------------------

summary(swim)
dim(swim)

swim=bind_rows(adm_v2, recist_repb ,eot_v2, dth_death, fu_v2) %>%
   mutate(time_from_date_inclusion_to_date=(date-date_inclusion)) %>%
  mutate(time=(date-ADMDT_first)) %>%
  mutate(time_from_date_inclusion_to_date_months=time_from_date_inclusion_to_date/30) %>%
  mutate(time_months=time/30)

length(unique(swim$subjid))

table( swim_checks$group, useNA="always")

#  add death dataset and calculate time_to_death------------------------------------------------------
#
# dth_death2=dth_death %>%
#   left_join(swim2, by = join_by(subjid)) %>%
#   mutate(time_to_death=(dthdt-ADMDT_first)) %>%
#   mutate(time_to_death_months=time_to_death/30) %>%
#   select(subjid, time_to_death ) %>%
#   distinct(subjid, time_to_death)
#
# swim3=bind_rows(swim2,dth_death2 ) %>%
#   mutate(group=ifelse(!is.na(time_to_death),"Death",group )) %>%
#   mutate(time=ifelse(!is.na(time_to_death),time_to_death,time ))
#
# table( dth_death2$time_to_death, useNA="always")

# add fu dataset and calculate time_ADMDT_first_to_fu----------------------------------------------------------


# names(FU)
#
#
# fu_v2= fu %>%
#   select(subjid, FUDT ) %>%
#   mutate(group="Alive at last follow up2")
#
# fu_v3=fu_v2 %>%
#   left_join(swim3, by = join_by(subjid)) %>%
#   mutate(time_ADMDT_first_to_fu=(FUDT-ADMDT_first)) %>%
#   mutate(time_ADMDT_first_to_fu_months=time_ADMDT_first_to_fu/30) %>%
#   select(subjid, time_ADMDT_first_to_fu ) %>%
#   distinct(subjid, time_ADMDT_first_to_fu)
#
# swim4=bind_rows(swim3,fu_v3 ) %>%
#   mutate(group=ifelse(!is.na(time_ADMDT_first_to_fu),"Alive at last follow up2",group )) %>%
#   mutate(time=ifelse(!is.na(time_ADMDT_first_to_fu),time_ADMDT_first_to_fu,time ))
#
# table( swim4$rcresp,  swim4$group, useNA="always")
# table( fu_v3$time_ADMDT_first_to_fu, useNA="always")


# add_legend= dth_v3 %>%
#   select(SUBJID) %>%
#   mutate(group="Alive at last follow up")  %>%
#   filter(SUBJID==86 ) %>%
#   mutate(EXAMDL2bis=-1 )
#
# add_legend2= dth_v3 %>%
#   select(SUBJID) %>%
#   mutate(group="Treatment period")  %>%
#   filter(SUBJID==86 ) %>%
#   mutate(EXAMDL2bis=-1 )
#
# add_legend3=bind_rows(add_legend2,add_legend )

# swim5=bind_rows(swim4,add_legend3 )


table(swim_v2$RCVISIT,  swim$group, swim$ADMYN,useNA="always")
table( swim$group, useNA="always")
table( swim$ADMYN, useNA="always")
table( swim_v2$RCVISIT, useNA="always")
table( swim$rcresp,  swim$group, useNA="always")

swim_v2=swim %>%
  mutate(visit=ifelse(group=="Treatment Administration",1, NA)) %>%
  mutate(visit=ifelse(group=="End of treatment"  ,6, visit)) %>%
  mutate(visit=ifelse(group=="Death"  ,7, visit)) %>%
  mutate(visit=ifelse(group=="Recist" & rcresp=="Complete response" ,2, visit))%>%
  mutate(visit=ifelse(group=="Recist" & rcresp=="Partial response" ,2, visit))%>%
  mutate(visit=ifelse(group=="Recist" & rcresp=="Stable disease" ,3, visit))%>%
  mutate(visit=ifelse(group=="Recist" & rcresp=="Progressive disease" ,4, visit))%>%
  mutate(visit=ifelse(group=="Recist" & rcresp=="Not Evaluable" ,5, visit))%>%
  mutate(visit=ifelse(group=="Alive at last follow up2"  ,8, visit)) %>%
  filter(!RCVISIT %in% "Baseline") %>%
distinct() %>%
  filter(ADMYN=="Yes" | is.na(ADMYN)) %>%
  mutate(subjid_num=as.numeric(subjid)) %>%
  arrange(subjid_num, date)

table( swim_v2$visit, useNA="always")

dim(swim_v2)
summary(swim_v2)
suivi=swim_v2

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

summary(suivi$time)
summary(suivi$visit2)
summary(suivi$date)

names(suivi)

suivi_trt = suivi %>%
  filter(visit2=="Trt Administration")%>%
  mutate(
    subjid_num = fct_reorder(factor(subjid_num), time, .fun=max, na.rm=TRUE)
  ) %>%
  summarise(
    first_trt = min(time, na.rm=TRUE),
    last_trt = max(time, na.rm=TRUE),
    .by=subjid_num
  )

names(suivi)

suivi_fu = suivi %>%
  filter(visit2=="Alive at last follow up2" | visit2=="Trt Administration")%>%
  mutate(
    subjid_num = fct_reorder(factor(subjid_num), time, .fun=max, na.rm=TRUE)
  ) %>%
  summarise(
    first_fu = min(time, na.rm=TRUE),
    last_fu = max(time, na.rm=TRUE),
    .by=subjid_num
  )


dat_swim <-
  suivi |>
  mutate(max_time = max(time, na.rm=TRUE),  .by=subjid_num) |>
  mutate(subjid_num = fct_reorder(factor(subjid_num), max_time,  na.rm=TRUE))


# plot -------------------------------------------------------------------

plot_final = dat_swim %>%
  dplyr::filter(!is.na(visit2))%>%
  dplyr::filter(visit2!="End of trt")%>%
  dplyr::filter(visit2!="Alive at last follow up2")%>%
  dplyr::select(c(subjid_num,visit2,time))%>%
  dplyr::distinct() %>%
  filter(visit2!="Trt Administration") %>%
  ggplot( aes(x=time, y=factor(subjid_num), color=visit2, shape=visit2, size=visit2))+
  geom_point(position= position_dodge(width=0.4), size=2)+
  geom_segment(aes(x=first_trt, y=subjid_num, xend=last_trt, yend=subjid_num), color="skyblue", alpha=0.3, linewidth=1.5,
               inherit.aes=FALSE, data=suivi_trt)



  # scale_shape_manual(values = c(19,8,15,4,18,62,15)) +
  # scale_color_manual(values = c("Treatment period"="skyblue", "CR/PR"="green", "PD"="purple", "Not evaluable"="grey",
  #                               "SD"="yellow", "End of trt"="pink", "Death"="red", "Alive at last follow up"="grey"))+
  #
  # scale_x_continuous(name ="Time (in month) since first treatment administration",
  #                    limits = c(0,28),
  #                    breaks = seq(0,28,2))+
  #
  # scale_y_discrete(name="Patient")+
  # geom_vline(xintercept=0)+
  # theme_classic()+
  # labs(title = "By-patient Swimmer Plot of Overall Response",
  #      subtitle = paste0("n=",length(unique(suivi$subjid))),
  #      shape=NULL, color=NULL)+
  # theme(plot.title = element_text(face = "bold", size = 14, hjust = 0),
  #       plot.subtitle = element_text(size=10, hjust=0),
  #       axis.title.x= element_text(size=10, face="italic"),
  #       axis.title.y= element_text(size=10, face="italic", angle = 90),
  #       axis.ticks.y=element_blank(),
  #       axis.text.y=element_blank(),
  #       legend.text = element_text(size=10),
  # )
  #

