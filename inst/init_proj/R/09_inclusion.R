

#TODO adapt this code to your study

# Tables --------------------------------------------------------------------------------------

## Section 9 Table 1 ----
tbl$s9_populations = enrolres %>%
  transmute(
    SUBJID, ARM,
    # a = (map(x, ~tibble(SUBJID %in% .x)))
    "ITT population" = fct_yesno(SUBJID %in% pop$itt),
    "mITT population" = fct_yesno(SUBJID %in% pop$m_itt),
    "Response Evaluable population" = fct_yesno(SUBJID %in% pop$resp_evaluable),
    "Safety population" = fct_yesno(SUBJID %in% pop$treated),
  ) %>%
  crosstable(-SUBJID, margin="col", total="row", by=ARM) %>%
  filter(variable=="Yes") %>% select(-variable) %>%
  as_flextable(compact=FALSE) %>%
  hline(i=1:4, border=fp_border(width=0))

## Section 9 Table 2 ----
tbl$s9_incl_centre = enrolres %>%
  mutate(STNAME = fct_infreq(STNAME)) %>%
  apply_labels(STNAME="Center") %>%
  crosstable(STNAME, margin="col", total="row", by=ARM) %>%
  as_flextable()

txt$s9_populations = "Populations are defined as: **Intent-to-treat (ITT) population**: all randomised patients, **Modified ITT population (mITT)**: all randomised patients who met all eligibility criteria, **Response-evaluable population**: patients in the ITT population with measurable disease at baseline, who received at least one cycle of treatment, and had at least one post-baseline tumour assessment, and **Safety population** all randomised patients who received any amount of any study treatment. "

# Paragraphs ----------------------------------------------------------------------------------

n_centers = n_distinct(enrolres$STNAME)
txt$date_last_patient = max(enrolres$ENROLLDT) %>% format()
txt$date_first_patient = min(enrolres$ENROLLDT) %>% format()
pat_per_day = nrow(enrolres) / as.numeric(max(enrolres$ENROLLDT) - min(enrolres$ENROLLDT))
incl_dir = "higher"
lplv_date = ymd("2025-05-13") #cf mail du BPP le xx/xx/xxxx à 12h34

txt$s9_inclusion1 = format_inline(
  "{n_centers} centre{?s} participated in the study and {nrow(enrolres)} patients were ",
  "included between {min(enrolres$ENROLLDT)} and {max(enrolres$ENROLLDT)}. ",
  "With {round(pat_per_day*30.5, 1)} patient{?s} included per month on average, the rhythm ",
  "of inclusion in the trial was {incl_dir} than those expected, as shown on the figure @ref(inclusions)."
)

txt$s9_inclusion2 = format_inline(
  "The Last Patient Last Visit (LPLV), corresponding to the last visit of the last patient ",
  "included, occurred on {lplv_date}. The present report presents the final analysis of the ",
  "study, covering both the primary and secondary endpoints."
)

not_treated = setdiff(pop$total, pop$safety) %>% as.character()
not_treated_exp = setdiff(pop$arm_exp, pop$treated_atz) %>% as.character()
not_treated_reasons = eot %>%
  filter(SUBJID %in% c(not_treated, not_treated_exp)) %>%
  mutate(reason=if_else(TRT_R=="Other", str_to_sentence(TRT_S), str_to_sentence(TRT_R))) %>%
  pull(reason)
txt$s9_inclusion3 = format_inline(
  collapse=FALSE,
  "In the study, {length(not_treated)} patient{?s} did not receive any treatment. ",
  "In the experimental arm, {length(not_treated_exp)} patient{?s} didn't receive ",
  "the experimental treatment.\n",
  "The reasons given were as follows: {shQuote(not_treated_reasons)}."
)


txt$s9_inclusion4 = "There were no major protocol violations and no serious breaches."
txt$s9_inclusion5 = "All patients were evaluable for the efficacy primary endpoint (PFS)."

# Plots: accrual ------------------------------------------------------------------------------

max_date = max(enrolres$ENROLLDT)
last_patient_id = max(as.numeric(as.character(enrolres$SUBJID)))
fig$s9_inclusions = enrolres %>%
  mutate(index=row_number(ENROLLDT)) %>%
  ggplot(aes(x=ENROLLDT, y=index)) +
  geom_line(linewidth=1.5, color="#496b96") +
  annotate("segment", x=date_minf, xend=max_date, y=last_patient_id, yend=last_patient_id) +
  annotate("segment", x=max_date, xend=max_date, y=-Inf, yend=last_patient_id) +
  annotate("text", x=min(enrolres$ENROLLDT), y=nrow(enrolres),
           label=glue("N={nrow(enrolres)} on {max_date}"),
           vjust=1, hjust=0) +
  labs(x="Date of enrollment", y="Number of inclusions") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))



# Plots: flowchart ----------------------------------------------------------------------------

#use the package "flowchart", export as image and include the image in the report.


