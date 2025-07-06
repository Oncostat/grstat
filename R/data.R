

#' Example databases
#'
#' Example tables, mostly used in examples and tests.
#'
#' @param N the number of patients
#' @param seed the random seed (can be `NULL`)
#' @param ... passed on to internal functions. See [example_enrol()],  [example_ae()], and  [example_rc()] for the argument names.
#'
#' @returns A list of datasets, like in EDCimport.
#'
#' @export
#' @importFrom dplyr mutate
#' @importFrom purrr imap
#' @importFrom tibble lst
grstat_example = function(N=200, seed=42, ...){

  enrolres = example_enrol(N, seed, ...)

  ae = example_ae(enrolres, seed, ...)

  recist = example_rc(enrolres, seed, ...)

  rtn = lst(enrolres, ae, recist) %>%
    imap(~.x %>% mutate(crfname=.y %>% set_label("Form name")))
  rtn$date_extraction = "2024/01/01"
  rtn$datetime_extraction = structure(1704067200, class = c("POSIXct", "POSIXt"),
                                      tzone = "Europe/Paris")
  rtn
}



# Internals -----------------------------------------------------------------------------------

#' Generate Example Enrollment Data
#'
#' Internal function that simulates subject enrollment data with random allocation
#' to treatment arms and inclusion dates.
#'
#' @param N Integer. Number of subjects to simulate.
#' @param seed Integer. Random seed for reproducibility (can be `NULL`).
#' @param r Numeric. Proportion of subjects allocated to the Control group in the binary `arm` variable (default: 0.5).
#' @param r2 Numeric. Proportion of subjects allocated to the Control group in the ternary `arm3` variable (default: 1/3).
#' @param ... Additional arguments (currently unused).
#'
#' @return A tibble with `N` rows and the following columns:
#'
#' - `subjid`: Subject ID
#' - `arm`: Two-arm treatment group ("Control" or "Treatment")
#' - `arm3`: Three-arm treatment group ("Control", "Treatment A", "Treatment B")
#' - `date_inclusion`: Inclusion date, spaced by 20 days plus an uniform jitter
#'
#' @keywords internal
#' @importFrom forcats fct_relevel
#' @importFrom tibble tibble
example_enrol = function(N, seed, r=0.5, r2=1/3, ...){
  set.seed(seed)
  n_control = round(N*r)
  n_control3 = round(N*r2)
  n_trtA = round((N - n_control3) / 2)

  tibble(
    subjid = seq_len(N),
    arm = sample(c(rep("Control", n_control),
                   rep("Treatment", N-n_control) )) %>%
      fct_relevel("Control"),
    arm3 = sample(c(rep("Control", n_control3),
                    rep("Treatment A", n_trtA),
                    rep("Treatment B", N-n_control3-n_trtA) )) %>%
      fct_relevel("Control"),
    date_inclusion = as.Date("2023-01-01") + subjid*20 + runif(N, 0, 50)
  ) %>%
    apply_labels(
      subjid = "Subject ID",
      arm = "Treatment arm",
      arm3 = "Treatment arm",
      date_inclusion = "Inclusion date"
    )
}



#' Generate an Adverse Event table
#'
#' Internal function that simulates adverse events data with a toxicity effect that
#' depends on the treatment arm `enrolres$arm`. The effect is not simulated according
#' to `enrolres$arm3`.
#'
#' @param enrolres the enrolment result table, from [example_enrol()].
#' @param seed Integer. Random seed for reproducibility (can be `NULL`).
#' @param p_na proportion of missing values (can be a list with a value for each column)
#' @param p_sae,p_sae_trt proportion of serious AE in control/exp arms
#' @param n_max,n_max_trt maximum number of AE per patient in control/exp arms (binomial with probability 20%)
#' @param w_soc,w_soc_trt log-weights for SOC that should be over-representated in control/exp arms.
#' @param beta0,beta_trt,beta_sae the intercept, treatement coef and SAE coef to be used in the exponential decay model that generates the AE grade.
#'
#' @return A tibble with `N` rows and the following columns:
#'   - `subjid`: the patient identifier. Each patient has a number of AE simulated with a binomial
#'   distribution with size `n_max` or `n_max_trt` and probability 20%.
#'   - `aesoc`: the CTCAE System Organ Class. Lazily simulated with an uniform probability.
#'   - `aeterm`: the CTCAE High Level Group Term. Lazily simulated with an uniform probability. Four examples of HLGT per SOC are provided.
#'   - `aegr`: the CTCAE grade, ranging from 1 to 5. The probability is simulated using
#'   an exponential decay rate for grades 1 to 4 (`probs = exp(rate * c(1:4))`), with probability for
#'   grade 5 being the one for grade 4 divided by 7. The probability vector is then normalized
#'   to sum to 1. The rate is calculated as `rate = beta0 + beta_trt*(arm!="Control") + beta_sae*(sae=="Yes")`.
#'   - `aerel`: the causality of the AE. Lazily simulated with an uniform probability.
#'   - `sae`: Indicator of Serious AE. Simulated using `p_sae` and `p_sae_trt`.
#'
#'
#' @keywords internal
#' @importFrom dplyr across cur_column if_else mutate n select
#' @importFrom forcats fct_relevel
#' @importFrom purrr map
#' @importFrom stats rbinom runif
#' @importFrom tidyr unnest
example_ae = function(enrolres, seed, p_na=0,
                      p_sae=0.1, p_sae_trt=p_sae,
                      n_max=15, n_max_trt=n_max,
                      w_soc = 1, w_soc_trt = 1,
                      beta0=-1, beta_trt=0.4, beta_sae=1,
                      ...) {
  set.seed(seed)
  if(!is.list(p_na)) {
    p_na = list(aesoc=p_na, aeterm=p_na, aegr=p_na, aerel=p_na, sae=p_na)
  }

  ae = enrolres %>%
    mutate(
      n_ae = rbinom(n=n(), size=ifelse(arm=="Control", n_max, n_max_trt), prob=0.2),
      # n_ae = rpois(n=n(), lambda=ifelse(arm=="Control", n_max, n_max_trt)),
      x = map(n_ae, ~seq_len(.x))
    ) %>%
    unnest(x) %>%
    mutate(
      aerel = sample(causality, n(), replace=TRUE),
      sae = runif(n())<ifelse(arm=="Control", p_sae, p_sae_trt),
      sae = ifelse(sae, "Yes", "No") %>% fct_relevel("Yes"),
      rate = beta0 + beta_trt*(arm!="Control") + beta_sae*(sae=="Yes"),
      aegr = .random_grades_n(rate),
      soc_weight = ifelse(arm=="Control", w_soc, w_soc_trt),
      .sample_term_n(soc_weight), #creates `aesoc` and `aeterm`
      across(names(p_na), ~{
        p = p_na[[cur_column()]]
        if_else(runif(n()) < p, NA, .x)
      })
    )

  ae %>%
    select(subjid, aesoc, aeterm, aegr, sae, aerel) %>%
    apply_labels(
      subjid = "Subject ID",
      aesoc = "AE SOC",
      aeterm = "AE Term (HLGT)",
      aegr = "AE grade",
      sae = "Serious AE",
    )
}


#' Simulate a RECIST dataset
#'
#' Internal function that simulates a synthetic RECIST dataset following the
#' conventions of clinical oncology trials. In the simulation, Target Lesions
#' response depends on the treatment arm `enrolres$arm` (not `enrolres$arm3`).
#'
#' @param enrolres the enrolment result table, from [example_enrol()].
#' @param seed Integer. Random seed for reproducibility (can be `NULL`).
#' @param rc_num_timepoints Integer. Number of timepoints for each patient, including baseline.
#' @param rc_p_new_lesions Integer. Probability of a new lesion
#' @param rc_p_not_evaluable Integer. Probability of a Not Evaluable measure
#' @param rc_p_nt_lesions_yn Integer. Probability of having Non-Target Lesions
#' @param rc_p_nt_lesions_resp Integer list. Probability of each Non-Target Lesions response, if present
#' @param rc_sd_tlsum_noise Integer. Standard deviation for the evolution of the Target Lesion sum of width
#' @param rc_coef_treatement Integer. Differentiates the difference in effect between the control and treatment arm (2 arms only). For example, `rc_coef_treatement` = 2 mean that the growth rate of the tumor is divide per 2 and the elimination rate is multiplied per 2. Also, the probability of a new lesion is multiplied by 2.
#'
#' @return A tibble with `N` rows and the following columns:
#'   - `subjid`: The patient identifier
#'   - `rcvisit`: The visit number
#'   - `rcdt`: The visit date
#'   - `rctlsum`: The Target Lesion length sum at each time point. The evolution of the value is calculated based on the percentage variation in tumor size from the previous time point. This variation is simulated using a uniform distribution between -30 and 30, with added noise (the noise follows a normal distribution with a mean of 0 and a standard deviation of `rc_sd_tlsum_noise`).
#'   - `rctlresp`: The response associated with Target Lesions
#'   - `rcntlresp`: The response associated with Non-Target Lesions
#'   - `rcnew`: The appearance of a new lesion
#'   - `rcresp`: The global RECIST response
#'
#' @keywords internal
#' @importFrom dplyr bind_rows select mutate filter row_number
#' @importFrom stats rnorm
example_rc = function(enrolres, seed,
                      rc_num_timepoints = 5,
                      rc_p_new_lesions = 0.09,
                      rc_p_not_evaluable = 0.01,
                      rc_p_nt_lesions_yn = 0.5,
                      rc_p_nt_lesions_resp = list("CR"=0.72, "SD"=0.24, "PD"=0.01, "NE"=0.01),
                      rc_sd_tlsum_noise = 0.5,
                      rc_coef_treatement = 3,
                      ...) {
  set.seed(seed)
  recist_data = enrolres %>%
    mutate(
      data = .simulate_one_patient(arm, rc_num_timepoints,
                                   rc_sd_tlsum_noise, rc_coef_treatement),
      .by = subjid
    ) %>%
    unnest(data) %>%
    mutate(
      rctlmin = cummin(rctlsum),
      rcvisit = row_number(),
      rcdt = date_inclusion + subj_delai,
      rcntlyn = .sample_yesno(n(), p=rc_p_nt_lesions_yn),
      .by = subjid
    ) %>%
    mutate(
      #Target Lesions
      rctlresp = case_when(
        rctlsum == 0 ~ "Complete response",
        ((rctlmin - rctlsum)/rctlmin) < -0.2 ~ "Progressive disease",
        ((rctlsum_b - rctlsum)/rctlsum_b) > 0.3 ~ "Partial response",
        .default = "Stable disease"
      ),
      #Non-Target Lesions
      rcntlresp = sample(c("Complete response", "Non-CR / Non-PD", "Progressive disease", NA),
                         n(), replace=TRUE,
                         prob=c(rc_p_nt_lesions_resp$CR, rc_p_nt_lesions_resp$SD,
                                rc_p_nt_lesions_resp$PD, rc_p_nt_lesions_resp$NE)),
      rcntlresp = ifelse(rcntlyn=="Yes", rcntlresp, NA),
      #New Lesions
      rcnew = case_when(
        rcvisit == 1 ~ NA,
        arm=="Control" ~ .sample_yesno(n(), p=rc_p_new_lesions),
        .default = .sample_yesno(n(), p=rc_p_new_lesions/rc_coef_treatement)
      ),
      #Global resp
      rcresp = case_when(
        rcnew == "Yes" | rctlresp=="Progressive disease" | rcntlresp=="Progressive disease"
        ~ "Progressive disease",
        rctlresp == "Complete response" & (rcntlresp == "Complete response" | is.na(rcntlresp))
        ~ "Complete response",
        rctlresp %in% c("Complete response", "Partial response")
        ~ "Partial response",
        rctlresp == "Stable disease"
        ~ "Stable disease",
        rctlresp == "Not evaluable"
        ~ "Not evaluable",
        .default = "ERROR"
      ),
      across(c(rctlresp, rcntlresp, rcresp), ~{
        .x = ifelse(.data$rcvisit == 1, NA, .x)
        .x %>%
          factor(levels=c("Complete response", "Partial response", "Non-CR / Non-PD",
                          "Stable disease", "Progressive disease")) %>%
          fct_drop()
      }),
    ) %>%
    mutate(before_pd = row_number() <= which(rcresp == 'Progressive disease')[1],
           before_pd = replace_na(before_pd, TRUE),
           .by = subjid
    ) %>%
    filter(before_pd)

  recist_data = recist_data %>%
    arrange(subjid, rcdt) %>%
    select(subjid, rcvisit, rcdt, rctlsum,
           rctlresp, rcntlyn, rcntlresp, rcnew, rcresp) %>%
    apply_labels(
      subjid = "Subject ID",
      rcvisit = "Visit number",
      rcdt = "Date of local evaluation",
      rctlsum = "Target Lesions length sum",
      rctlresp = "Response of Target Lesions",
      rcntlyn = "Presence of Non-Target Lesions",
      rcntlresp = "Response of Non-Target Lesions",
      rcnew = "Apparition of new lesions",
      rcresp = "Global RECIST response"
    )
}


# Internals RC ------------------------------------------------------------

#' Used in `example_rc()`
#' Simulate the linear decrease of the TL length sum
#' @noRd
#' @keywords internal
#' @importFrom tibble tibble
.simulate_one_patient = function(arm, rc_num_timepoints,
                                 rc_sd_tlsum_noise, rc_coef_treatement) {
  rc_num_timepoints = rc_num_timepoints-1 #add baseline later
  rctlsum_b = rnorm(1, 50, 30)
  rctlsum_b = ifelse(rctlsum_b <10, runif(1, 10, 150), rctlsum_b)
  percent_change_per_month = rnorm(1, -0.2, 0.5)
  coef = case_when(arm == "Control" ~ 1,
                   percent_change_per_month > 0 ~ 1 / rc_coef_treatement,
                   .default = rc_coef_treatement)
  percent_change_per_month = percent_change_per_month * coef
  subj_delai = 42 * seq(rc_num_timepoints) + runif(rc_num_timepoints, -7, 7)
  percent_change = percent_change_per_month * subj_delai / 30.5
  percent_change = percent_change + rnorm(rc_num_timepoints, 0, rc_sd_tlsum_noise)
  percent_change = c(0, percent_change)
  sizes = rctlsum_b * (1+percent_change)
  sizes = ifelse(sizes <1, 0, sizes)
  list(tibble(
    rctlsum_b,
    subj_delai = c(0, subj_delai),
    percent_change_per_month,
    percent_change,
    rctlsum = round(sizes, 1)
  ))
}

# Internals AE ------------------------------------------------------------


#' Used in `.random_grades_n()`
#' Construit un vecteur de grade avec exponential decay
#' @param rate length 1
#' @noRd
#' @keywords internal
.random_grades = function(n, rate=-1) {
  probs = exp(rate * c(1:4))
  probs = c(probs, probs[4]/7) #grade 5 always minor
  probs = probs / sum(probs)   #normalize to sum to 1
  sample(1:5, size=n, replace=TRUE, prob=probs)
}


#' Used in `.example_ae()`
#' Construit un vecteur de grade par rate possible puis attribue selon le rate.
#' impossible d'indexer sur un numeric (pas de names) donc j'indexe sur le dense_rank
#' @param v_rate a vector of rate
#' @noRd
#' @keywords internal
#' @importFrom dplyr dense_rank
#' @importFrom purrr map map2_dbl
.random_grades_n = function(v_rate){
  rates = v_rate %>% unique() %>% sort()
  r = rates %>% map(~.random_grades(length(v_rate), .x))
  x = dense_rank(v_rate)
  map2_dbl(x, seq_along(x), ~ r[[.x]][.y])
}


#' @noRd
#' @keywords internal
#' @importFrom stats runif
.sample_yesno = function(n, p){
  ifelse(runif(n) < p, "Yes", "No") %>% factor(levels=c("Yes", "No"))
}

#' Used in `.sample_term_n()`
#' Construit un vecteur de SOC avec un weight prédéfini
#' Utilise le global `specific_soc`
#' @param w length 1 weight
#' @noRd
#' @keywords internal
#' @importFrom purrr map_chr
#' @importFrom tibble enframe
.sample_term = function(n, w=1){
  specific_soc = getOption("grstat_specific_soc", specific_soc)

  v = seq_along(names(sample_ctcae))
  v = v * ifelse(names(sample_ctcae) %in% specific_soc, w, 1)
  log_proba = v/sum(v) * 30
  proba = exp(log_proba)

  sample(sample_ctcae, size=n, replace=TRUE, prob=proba) %>%
    map_chr(~sample(.x, 1)) %>%
    enframe(name="aesoc", value="aeterm")
}

#' Used in `.example_ae()`
#' Take `n` items from `sample_ctcae` (length 27), then take one random child of each.
#' The probability of each SOC is exponentially decreasing along `names(sample_ctcae)`, with increased probability for some specific soc.
#' @param v_weight a vector of weights
#' @noRd
#' @keywords internal
#' @importFrom dplyr dense_rank
#' @importFrom purrr list_rbind map map2
#' @importFrom rlang set_names
.sample_term_n =  function(v_weight){
  weights = v_weight %>% unique() %>% sort()
  r = weights %>% set_names() %>% map(~.sample_term(length(v_weight), .x))
  x = dense_rank(v_weight)
  map2(x, seq_along(x), ~ r[[.x]][.y,]) %>%
    list_rbind()
}

# CTCAE Data ----------------------------------------------------------------------------------


causality =c("Experimental treatment", "Standard treatment",
             "Radiotherapy", "Cancer", "Other")

#Default SOC that are simulated as over-representated in treatment ARM
specific_soc = c("Blood and lymphatic system disorders",
                 "Endocrine disorders",
                 "Infections and infestations",
                 "Respiratory, thoracic and mediastinal disorders",
                 "Skin and subcutaneous tissue disorders")

#Courtesy to ChatGPT.
#Prompt: "give me an R list with 4 examples of HLGT per SOC"
sample_ctcae = list(
  `Gastrointestinal disorders` = c(
    "Gastrointestinal motility and defecation conditions", "Esophageal disorders",
    "Gastric disorders", "Intestinal disorders"
  ),
  `General disorders and administration site conditions` = c(
    "Device issues", "Pain and discomfort",
    "General physical health deterioration", "Injection site reactions"
  ),
  `Blood and lymphatic system disorders` = c(
    "Hematologic neoplasms", "Bone marrow disorders",
    "Coagulation and bleeding analyses", "Red blood cell disorders"
  ),
  `Renal and urinary disorders` = c(
    "Kidney disorders", "Bladder disorders", "Urethral disorders",
    "Urinary tract disorders"
  ),
  `Reproductive system and breast disorders` = c(
    "Female reproductive disorders", "Male reproductive disorders",
    "Breast disorders", "Menstrual disorders"
  ),
  Investigations = c(
    "Blood analyses", "Imaging studies", "Liver function analyses",
    "Cardiovascular assessments"
  ),
  `Infections and infestations` = c(
    "Bacterial infectious disorders", "Fungal infectious disorders",
    "Parasitic infectious disorders", "Viral infectious disorders"
  ),
  `Metabolism and nutrition disorders` = c(
    "Fluid and electrolyte disorders", "Lipid metabolism disorders",
    "Nutritional disorders", "Vitamin deficiencies"
  ),
  `Skin and subcutaneous tissue disorders` = c(
    "Skin infections", "Skin pigmentation disorders",
    "Skin and subcutaneous tissue injuries", "Dermatitis"
  ),
  `Nervous system disorders` = c(
    "Neurological disorders of the central nervous system", "Headache disorders",
    "Seizure disorders", "Peripheral neuropathies"
  ),
  `Musculoskeletal and connective tissue disorders` = c(
    "Arthritis and joint disorders", "Bone disorders",
    "Muscle disorders", "Connective tissue disorders"
  ),
  `Ear and labyrinth disorders` = c(
    "Hearing disorders", "Vertigo and balance disorders",
    "Labyrinth disorders", "Tinnitus"
  ),
  `Vascular disorders` = c(
    "Hypertension-related conditions", "Hypotension-related conditions",
    "Vascular hemorrhagic disorders", "Venous thromboembolic events"
  ),
  `Endocrine disorders` = c(
    "Adrenal gland disorders", "Pituitary gland disorders",
    "Thyroid gland disorders", "Parathyroid gland disorders"
  ),
  `Psychiatric disorders` = c(
    "Anxiety disorders", "Mood disorders",
    "Sleep disorders", "Substance-related disorders"
  ),
  `Respiratory, thoracic and mediastinal disorders` = c(
    "Pulmonary vascular disorders", "Respiratory infections",
    "Pleural disorders", "Lung function disorders"
  ),
  `Hepatobiliary disorders` = c(
    "Liver disorders", "Bile duct disorders",
    "Gallbladder disorders", "Hepatic failure"
  ),
  `Cardiac disorders` = c(
    "Cardiac arrhythmias", "Cardiac valve disorders",
    "Coronary artery disorders", "Heart failures"
  ),
  `Immune system disorders` = c(
    "Autoimmune disorders", "Hypersensitivity conditions",
    "Immunodeficiency", "Inflammatory responses"
  ),
  `Injury, poisoning and procedural complications` = c(
    "Procedural complications", "Traumatic injuries",
    "Poisonings", "Radiation-related toxicities"
  ),
  `Neoplasms benign, malignant, and unspecified` = c(
    "Benign neoplasms", "Malignant neoplasms",
    "Tumor progression", "Neoplasms unspecified"
  ),
  `Surgical and medical procedures` = c(
    "Diagnostic procedures", "Therapeutic procedures",
    "Device implantation procedures", "Surgical complications"
  ),
  `Eye disorders` = c(
    "Vision disorders", "Eyelid disorders",
    "Retinal disorders", "Corneal disorders"),
  `Pregnancy, puerperium and perinatal conditions` = c(
    "Pregnancy complications", "Labor and delivery complications",
    "Fetal complications", "Breastfeeding issues"
  ),
  `Social circumstances` = c(
    "Social and environmental issues", "Family support issues",
    "Economic conditions affecting care", "Cultural issues"
  ),
  `Congenital, familial and genetic disorders` = c(
    "Chromosomal abnormalities", "Hereditary connective tissue disorders",
    "Familial hematologic disorders", "Congenital nervous system disorders"
  )
)

stopifnot(unique(lengths(sample_ctcae)) == 4)
