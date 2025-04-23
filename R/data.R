

#' Example databases
#'
#' Example tables, mostly used in examples and tests.
#'
#' @param N the number of patients
#' @param seed the random seed (can be `NULL`)
#' @param r,r2 proportion of the "Control" arm in `enrolres$arm` and `enrolres$arm3` respectively
#' @param t number of visit for the recist base
#' @param ... passed on to internal functions. See [example_ae()] for control over Adverse Events.
#'
#' @returns A list of datasets, like in EDCimport.
#'
#' @export
#' @importFrom dplyr mutate
#' @importFrom purrr imap
#' @importFrom tibble lst
#' @importFrom base do.call
grstat_example = function(N=200, args_ae = list(), args_rc = list(), seed=42,
                          r=0.5, r2=1/3){
  set.seed(seed)

  enrolres = example_enrol(N, r, r2)

  ae = do.call(example_ae, c(list(enrolres = enrolres), args_ae))

  recist = do.call(example_rc, c(list(enrolres = enrolres), args_rc))

  rtn = lst(enrolres, ae, recist) %>%
    imap(~.x %>% mutate(crfname=.y %>% set_label("Form name")))
  rtn$date_extraction = "2024/01/01"
  rtn$datetime_extraction = structure(1704067200, class = c("POSIXct", "POSIXt"),
                                      tzone = "Europe/Paris")
  rtn
}



# Internals -----------------------------------------------------------------------------------


#' @keywords internal
#' @importFrom tibble tibble
example_enrol = function(N, r, r2){
  tibble(
    subjid = seq_len(N),
    arm = sample(c(rep("Control", round(N*r)),
                   rep("Treatment", round(N*(1-r))) )),
    arm3 = sample(c(rep("Control", round(N*r2)),
                    rep("Treatment A", round(N*(1-r2)/2)),
                    rep("Treatment B", N-round(N*r2)-round(N*(1-r2)/2)) )),
    date_inclusion = sample(as.Date("2023-01-01") +subjid*10 + runif(N, 0, 10))
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
#' @param enrolres the enrolment result table, from `.example_enrol`
#' @param p_na proportion of missing values (can be a list with a value for each column)
#' @param p_sae,p_sae_trt proportion of serious AE in control/exp arms
#' @param n_max,n_max_trt maximum number of AE per patient in control/exp arms (binomial with probability 20%)
#' @param w_soc,w_soc_trt log-weights for SOC that should be over-representated in control/exp arms.
#' @param beta0,beta_trt,beta_sae the intercept, treatement coef and SAE coef to be used in the exponential decay model that generates the AE grade.
#'
#' @section Columns:
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
#' @importFrom purrr map
#' @importFrom stats rbinom runif
#' @importFrom tidyr unnest
example_ae = function(enrolres, p_na=0,
                      p_sae=0.1, p_sae_trt=p_sae,
                      n_max=15, n_max_trt=n_max,
                      w_soc = 1, w_soc_trt = 1,
                      beta0=-1, beta_trt=0.4, beta_sae=1) {
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
      sae = ifelse(sae, "Yes", "No"),
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
#' Used in `grstat_example()`. \cr
#' This function generates a synthetic RECIST dataset following the conventions of clinical oncology trials.
#' It includes patient tumor size measurements over time and categorizes responses according to RECIST criteria.
#'
#' @param enrolres the enrolment result table, from `.example_enrol`
#' @param num_timepoints Integer. Number of timepoints for each patient.
#' @param p_new_lesions Integer. Probability of a new lesion
#' @param p_not_evaluable Integer. Probability of a Not Evaluable measurev_bruits_variation_taille_tumeur=25
#' @param v_bruits_variation_taille_tumeur Integer. Standard deviation for the evolution of the tumeur size
#'
#' @section Columns:
#'   - `subjid`: The patient identifier.
#'   - `arm` and `arm3`: The treatment arm for the patient.
#'   - `rctlsum_b`: Baseline tumor size for patients. The size is simulated following a normal distribution with a mean of 50 and a standard deviation of 30. If the result is <10, it is replaced with a value drawn from a uniform distribution between 70 and 180.
#'   - `rctlsum`: The size of the tumor at each time point. The evolution of the tumor is calculated based on the percentage variation in tumor size from the previous time point. This variation is simulated using a uniform distribution between -30 and 30, with added noise (the noise follows a normal distribution with a mean of 0 and a standard deviation of `v_bruits_variation_taille_tumeur`).
#'   - `rctlmin`: The minimal tumor size observed so far.
#'   - `rctlresp`: The response associated with the variation in tumor size, following the RECIST criteria.
#'   - `rcntlresp`: The response associated with non-target lesions.
#'   - `rcnew`: The response associated with the appearance of a new lesion.
#'   - `rcresp`: The global response.
#'   - `rcvisit`: The number of visits.
#'   - `rcdt`: The date of the visits.
#'
#' @return A tibble containing the simulated RECIST dataset.
#' @importFrom dplyr bind_rows select mutate filter row_number
#' @importFrom stats rnorm
#' @keywords internal
example_rc = function(enrolres, num_timepoints=10,
                      p_new_lesions = 0.01,
                      p_not_evaluable = 0.01,
                      p_list_lesion_non_cibles = list(0.27, 0.09, 0.003, 0.65),
                      v_bruits_variation_taille_tumeur = 25) {
  timepoint = seq_len(num_timepoints)
  recist_data = enrolres %>%
    mutate(
      rctlsum_b = rnorm(n(),50,30),
      rctlsum_b = ifelse(rctlsum_b <10, runif(1, 70, 180), rctlsum_b),
      data = list(.simulate_patient(rctlsum_b, num_timepoints, v_bruits_variation_taille_tumeur)),
      .by = subjid
    ) %>%
    unnest(data) %>%
    mutate(
      rctlmin = ifelse(rctlsum_b < rctlsum, rctlsum_b, rctlsum),
      rctlmin = cummin(rctlmin),
      rcvisit = row_number(),
      rcdt = date_inclusion +(42*rcvisit),
      .by = subjid
    ) %>%
    mutate(rctlresp = case_when(
           rctlsum == 0 ~ "Complete response",
           (rctlmin - rctlsum)/rctlmin < -0.2 ~ "Progressive disease",
           (rctlsum_b - rctlsum)/rctlsum_b > 0.3 ~ "Partial response",
           .default = "Stable disease"
           ),
           rcntlresp = sample(c("Complete response", "Non-CR / Non-PD", "Progressive disease", NA),
                              n(), replace=TRUE, prob=p_list_lesion_non_cibles),
           rcdt = rcdt + runif(n(), -7, 7),
           rcnew = sample(c("Yes", "No"), n(), replace=TRUE, prob=c(p_new_lesions, 1-p_new_lesions)),
           not_evaluable = ifelse(runif(n())<p_not_evaluable, "Not evaluable", rctlresp),
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
           rcresp = factor(rcresp, levels=c("Complete response", "Partial response",
                                            "Stable disease", "Progressive disease",
                                            "Not evaluable"))
    ) %>%
    mutate(suivi = row_number() <= which(rcresp == 'Progressive disease')[1],
           suivi = replace_na(suivi, TRUE),
           .by = subjid
    ) %>%
    filter(suivi) %>%
    select(subjid, arm, arm3, rctlsum_b, rctlsum, rctlmin,
           rctlresp, rcntlresp, rcnew, rcresp, rcvisit, date_inclusion, rcdt) %>%
    apply_labels(
      subjid = "Subject ID",
      arm = "Treatment arm",
      arm3 = "Treatment arm",
      rctlsum_b = "Baseline tumor size",
      rctlsum = "Tumor size",
      rctlmin = "Minimal tumor size",
      rctlresp = "Response of target lesions",
      rcntlresp = "Response of non target lesions",
      rcnew = "New lesions",
      rcresp = "Global response",
      rcvisit = "Visit number",
      rcdt = "Date of local evaluation"
    )

  recist_baseline = recist_data %>%
    filter(rcvisit == 1)%>%
    mutate(rctlsum = rctlsum_b,
           rcvisit = 0,
           rctlresp = NA,
           rcntlresp = NA,
           rcresp = NA,
           rcdt = date_inclusion,
           rctlmin = rctlsum_b,
           rcnew = NA
    )
  recist_data = recist_data %>%
    bind_rows(recist_baseline) %>%
    arrange(subjid, rcdt)
}


# Internals RC ------------------------------------------------------------
#' Used in `example_rc()`
#' Determines response based on tumor size
#' @param RCTLSUM_b Integer. Initial tumor size
#' @param num_timepoints Integer. Number of timepoints for each patient.
#' @noRd
#' @keywords internal
#' @importFrom tibble tibble
.simulate_patient = function(rctlsum_b, num_timepoints, v_bruits_variation_taille_tumeur) {
  delai = 42 + runif(n(), -7, 7)
  percent_change_per_month = runif(n(), -30, 30)
  changes = rep(percent_change_per_month * delai / 30.5, num_timepoints)
  changes = changes + rnorm(num_timepoints, 0, v_bruits_variation_taille_tumeur)
  base = rep(rctlsum_b, num_timepoints)
  sizes = base * cumprod(1+changes/100)
  sizes = ifelse(sizes <1, 0, sizes)
  tibble(
    rctlsum = round(sizes, 1),
    percent_change = round(changes, 1)
  )
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
