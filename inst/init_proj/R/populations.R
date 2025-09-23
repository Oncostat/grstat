


#FIXME Ce fichier est un exemple de {grstat} qui doit être adapté à l'étude réelle
#les populations sont définies ici pour être utilisées comme filtres dans les outputs
#TODO remplacer les commentaires par les définitions exactes du protocole


# Pop protocolaires -------------------------------------------------------------------
pop$total = enrolres$SUBJID %>% sort()
# Chap 8.1: Analysis populations

# Intent-to-treat (ITT) population: all randomised patients, whether or not the
#  assigned study treatment was received.
pop$itt = enrolres %>% filter(!is.na(ARM)) %>% pull(SUBJID) %>% sort()
stopifnot(identical(pop$itt, pop$total))

# Modified ITT population (mITT): all randomised patients who received any amount
#  of the assigned study treatment and met all eligibility criteria.
pop$m_itt = pop$itt

# Safety population: all randomised patients who received any amount of any study
#  treatment.
pop$safety = NA #defined below


# Pop randomisation -------------------------------------------------------------------

pop$arm_exp = enrolres %>% filter(ARM=="Experimental") %>%
  pull(SUBJID) %>% unique() %>% sort()
pop$arm_ctl = enrolres %>% filter(ARM=="Control") %>%
  pull(SUBJID) %>% unique() %>% sort()


# Pop par traitement ------------------------------------------------------------------

pop$treated_soc = ex %>% filter(fct_yesno(EXYN)=="Yes") %>% filter(REALDO>0) %>%
  pull(SUBJID) %>% unique() %>% sort()
pop$treated_exp = qgex %>% filter(REALDO>0) %>%
  pull(SUBJID) %>% unique() %>% sort()
pop$treated_other = bt %>% filter(fct_yesno(BTYN)=="Yes") %>%
  pull(SUBJID) %>% unique() %>% sort()

pop$treated = c(pop$treated_soc, pop$treated_exp, pop$treated_other) %>% unique() %>% sort()
pop$safety = pop$treated

# Pop response ------------------------------------------------------------------------

# Response-evaluable population: patients in the ITT population with
# * measurable disease at baseline,
# * who received at least one cycle of treatment,
# * and had at least one post-baseline tumour assessment.
pop$resp_evaluable = rc %>%
  mutate(baseline = RCDT==min_narm(RCDT), .by=SUBJID) %>%
  filter(SUBJID %in% pop$treated) %>% #one cycle of trt
  filter(!baseline | RCTLSUM>0) %>%                             #baseline RCTLSUM>0
  filter( baseline | !RCRESP %in% c(NA, "5-Not evaluable")) %>% #post-baseline reponse
  filter(n_distinct(RCDT)>=2, .by=SUBJID) %>%
  pull(SUBJID) %>% unique() %>%
  sort()


# Pop: check --------------------------------------------------------------------------

#On vérifie qu'on n'en a pas oublié

pop_names = c(
  "total"="All patients", "itt"="ITT population", "m_itt"="mITT population",
  "safety"="Safety population", "resp_evaluable"="Response Evaluable population",
  "arm_exp"="Experimental arm", "arm_ctl"="Control arm",
  "treated_soc"="Received SoC", "treated_exp"="Received Treatment",
  "treated_other"="Received some other stuff",
  "treated"="Received any treatment"
)
testthat::expect_setequal(names(pop_names), names(pop))
