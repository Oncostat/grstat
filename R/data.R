

#' Example databases
#'
#' Example tables, mostly used in examples and tests.
#'
#' @param N the number of patients
#' @param seed the random seed (can be `NULL`)
#' @param ae_n_max maximum number of AE per patient
#' @param ae_p_sae proportion of serious AE
#' @param ae_p_na proportion of missing values (can be a list with a number for each column)
#' @param r,r2 proportion of the "Control" arm in `enrolres$arm` and `enrolres$arm3`
#'
#' @returns A list of datasets, like in EDCimport.
#'
#' @export
#' @importFrom dplyr mutate n select
#' @importFrom purrr imap map
#' @importFrom stats rbinom runif
#' @importFrom tibble enframe lst tibble
#' @importFrom tidyr unnest unpack
grstat_example = function(N=50, seed=42,
                          ae_n_max=15, ae_n_max_trt=ae_n_max, ae_p_sae=0.1, ae_p_na=0,
                          r=0.5, r2=1/3){
  set.seed(seed)

  enrolres = .example_enrol(N, r, r2)

  ae = .example_ae(enrolres, p_na=ae_p_na, p_sae=ae_p_sae,
                   n_max=ae_n_max, n_max_trt=ae_n_max_trt)

  rtn = lst(enrolres, ae) %>%
    imap(~.x %>% mutate(crfname=.y %>% set_label("Form name")))
  rtn$date_extraction = "2024/01/01"
  rtn$datetime_extraction = structure(1704067200, class = c("POSIXct", "POSIXt"),
                                      tzone = "Europe/Paris")

  rtn
}


# Internals -----------------------------------------------------------------------------------

#' @noRd
#' @keywords internal
.example_enrol = function(N, r, r2){
  tibble(
    subjid = seq_len(N),
    arm = sample(c(rep("Control", round(N*r)),
                   rep("Treatment", round(N*(1-r))) )),
    arm3 = sample(c(rep("Control", round(N*r2)),
                    rep("Treatment A", round(N*(1-r2)/2)),
                    rep("Treatment B", N-round(N*r2)-round(N*(1-r2)/2)) ))
  ) %>%
    apply_labels(
      subjid = "Subject ID",
      arm = "Treatment arm",
      arm3 = "Treatment arm"
    )
}


#' @noRd
#' @keywords internal
.example_ae = function(enrolres, p_na, p_sae, n_max, n_max_trt) {
  if(!is.list(p_na)) {
    p_na = list(aesoc=p_na, aeterm=p_na, aegr=p_na, sae=p_na)
  }

  ae = enrolres %>%
    mutate(
      n_ae = rbinom(n=n(), size=ifelse(arm=="Control", n_max, n_max_trt), prob=0.2),
      x = map(n_ae, ~seq_len(.x))
    ) %>%
    unnest(x) %>%
    mutate(
      sae = fct_yesno(runif(n())<p_sae), #TODO p_sae function of treatment
      # aegr = .random_grades(n(), rate=-0.4),
      # aegr_sae = .random_grades(n(), rate=0.4),
      rate = 0 - 0.5*(arm=="Control") + 1*(sae=="Yes"),
      aegr = .random_grades_n(rate),
      .sample_term(n()),
      across(names(p_na), ~{
        p = p_na[[cur_column()]]
        if_else(runif(n()) < p, NA, .x)
      })
    )

  ae %>%
    select(subjid, aesoc, aeterm, aegr, sae, n_ae) %>%
    apply_labels(
      subjid = "Subject ID",
      aesoc = "AE SOC",
      aeterm = "AE Term (HLGT)",
      aegr = "AE grade",
      sae = "Serious AE",
    )
}


#' Used in `.example_ae()`
#' Construit un vecteur de grade avec exponential decay
#' @noRd
#' @keywords internal
.random_grades = function(n, rate=-1) {
  # probs = exp(rate * c(1:5))
  # rightness = sum(probs/cumsum(probs)) #1 if rate=-Inf, to 5 if rate=Inf
  # print(rightness)
  probs = exp(rate * c(1:4))
  probs = c(probs, probs[4]/7) #grade 5 always minor
  probs = probs / sum(probs)   #normalize to sum to 1
  sample(1:5, size=n, replace=TRUE, prob=probs)
  # probs
}



#' Used in `.example_ae()`
#' Construit un vecteur de grade par rate possible puis attribue selon le rate.
#' impossible d'indexer sur un numeric (pas de names) donc j'indexe sur le dense_rank
#' @param v_rate a vector of rate
#' @noRd
#' @keywords internal
.random_grades_n = function(v_rate){
  rates = v_rate %>% unique() %>% sort()
  r = rates %>% map(~.random_grades(length(v_rate), .x))
  x = dense_rank(v_rate)
  map2_dbl(x, seq_along(x), ~ r[[.x]][.y])
}


#' Used in `.example_ae()`
#' @noRd
#' @keywords internal
.sample_term = function(n){
  sample(sample_ctcae, size=n, replace=TRUE) %>%
    map_chr(~sample(.x, 1)) %>%
    enframe(name="aesoc", value="aeterm")
}

# CTCAE Data ----------------------------------------------------------------------------------

#Courtesy to ChatGPT.
#Prompt: "give me an R list with 4 examples of HLGT per SOC"
sample_ctcae = list(
  "Blood and lymphatic system disorders" = c("Hematologic neoplasms", "Bone marrow disorders", "Coagulation and bleeding analyses", "Red blood cell disorders"),
  "Cardiac disorders" = c("Cardiac arrhythmias", "Cardiac valve disorders", "Coronary artery disorders", "Heart failures"),
  "Congenital, familial and genetic disorders" = c("Chromosomal abnormalities", "Hereditary connective tissue disorders", "Familial hematologic disorders", "Congenital nervous system disorders"),
  "Ear and labyrinth disorders" = c("Hearing disorders", "Vertigo and balance disorders", "Labyrinth disorders", "Tinnitus"),
  "Endocrine disorders" = c("Adrenal gland disorders", "Pituitary gland disorders", "Thyroid gland disorders", "Parathyroid gland disorders"),
  "Eye disorders" = c("Vision disorders", "Eyelid disorders", "Retinal disorders", "Corneal disorders"),
  "Gastrointestinal disorders" = c("Gastrointestinal motility and defecation conditions", "Esophageal disorders", "Gastric disorders", "Intestinal disorders"),
  "General disorders and administration site conditions" = c("Device issues", "Pain and discomfort", "General physical health deterioration", "Injection site reactions"),
  "Hepatobiliary disorders" = c("Liver disorders", "Bile duct disorders", "Gallbladder disorders", "Hepatic failure"),
  "Immune system disorders" = c("Hypersensitivity conditions", "Immune system analysis disorders", "Immune-mediated adverse events", "Autoimmune diseases"),
  "Infections and infestations" = c("Bacterial infectious disorders", "Fungal infectious disorders", "Parasitic infectious disorders", "Viral infectious disorders"),
  "Injury, poisoning and procedural complications" = c("Procedural complications", "Traumatic injuries", "Poisonings", "Radiation-related toxicities"),
  "Investigations" = c("Blood analyses", "Imaging studies", "Liver function analyses", "Cardiovascular assessments"),
  "Metabolism and nutrition disorders" = c("Fluid and electrolyte disorders", "Lipid metabolism disorders", "Nutritional disorders", "Vitamin deficiencies"),
  "Musculoskeletal and connective tissue disorders" = c("Arthritis and joint disorders", "Bone disorders", "Muscle disorders", "Connective tissue disorders"),
  "Neoplasms benign, malignant, and unspecified" = c("Benign neoplasms", "Malignant neoplasms", "Tumor progression", "Neoplasms unspecified"),
  "Nervous system disorders" = c("Neurological disorders of the central nervous system", "Headache disorders", "Seizure disorders", "Peripheral neuropathies"),
  "Psychiatric disorders" = c("Anxiety disorders", "Mood disorders", "Sleep disorders", "Substance-related disorders"),
  "Renal and urinary disorders" = c("Kidney disorders", "Bladder disorders", "Urethral disorders", "Urinary tract disorders"),
  "Reproductive system and breast disorders" = c("Female reproductive disorders", "Male reproductive disorders", "Breast disorders", "Menstrual disorders"),
  "Respiratory, thoracic and mediastinal disorders" = c("Pulmonary vascular disorders", "Respiratory infections", "Pleural disorders", "Lung function disorders"),
  "Skin and subcutaneous tissue disorders" = c("Skin infections", "Skin pigmentation disorders", "Skin and subcutaneous tissue injuries", "Dermatitis"),
  "Social circumstances" = c("Social and environmental issues", "Family support issues", "Economic conditions affecting care", "Cultural issues"),
  "Surgical and medical procedures" = c("Diagnostic procedures", "Therapeutic procedures", "Device implantation procedures", "Surgical complications"),
  "Vascular disorders" = c("Hypertension-related conditions", "Hypotension-related conditions", "Vascular hemorrhagic disorders", "Venous thromboembolic events"),
  "Pregnancy, puerperium and perinatal conditions" = c("Pregnancy complications", "Labor and delivery complications", "Fetal complications", "Breastfeeding issues"),
  "Immune system disorders" = c("Autoimmune disorders", "Alloimmune responses", "Immunodeficiency", "Inflammatory responses")
)
