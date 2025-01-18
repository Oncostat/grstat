

#' Example databases
#'
#' Example tables, mostly used in examples and tests.
#'
#' @param N the number of patients
#' @param seed the random seed
#' @param r,r2 proportion of the "Control" arm in `enrolres$arm` and `enrolres$arm3`
#'
#' @export
#' @importFrom dplyr mutate n select
#' @importFrom purrr imap map
#' @importFrom stats rbinom runif
#' @importFrom tibble enframe lst tibble
#' @importFrom tidyr unnest unpack
#'
#' @examples
#' tm = grstat_example(500, p_na=0.1)
#' ae_table_soc(df_ae=tm$ae, df_enrol=tm$enrolres, arm="ARM") %>% as_flextable()
#' ae_table_soc(df_ae=tm$ae, df_enrol=tm$enrolres, arm="ARM", term="AETERM") %>% as_flextable()
grstat_example = function(N=50, seed=42, n_ae_max=15, p_sae=0.1, p_na=0, r=0.5, r2=1/3){
  set.seed(seed)

  enrolres = tibble(
    subjid = seq_len(N),
    arm = sample(c(rep("Control", round(N*r)),
                   rep("Treatment", round(N*(1-r))) )),
    arm3 = sample(c(rep("Control", round(N*r2)),
                    rep("Treatment A", round(N*(1-r2)/2)),
                    rep("Treatment B", N-round(N*r2)-round(N*(1-r2)/2)) ))
  )

  if(!is.list(p_na)) {
    p_na = list(aesoc=p_na, aeterm=p_na, aegr=p_na, sae=p_na)
  }

  ae = tibble(subjid=seq_len(N),
              n_ae=rbinom(n=N, size=n_ae_max, prob=0.2)) %>%
    mutate(x = map(n_ae, ~seq_len(.x))) %>%
    unnest(x) %>%
    mutate(
      sae = fct_yesno(runif(n())<p_sae),
      aegr = sample(1:5, size=n(), replace=TRUE, prob=c(0.4,0.3,0.2,0.1,0.01)),
      aegr_sae = sample(1:5, size=n(), replace=TRUE, prob=c(0.15,0.15,0.3,0.3,0.1)),
      aegr = if_else(sae=="Yes", aegr_sae, aegr),
      .sample_term(n()),
      across(names(p_na), \(.x){
        p = p_na[[cur_column()]]
        if_else(runif(n())<p, NA, .x)
      })
    ) %>%
    select(subjid, aesoc, aeterm, aegr, sae, n_ae) %>%
    apply_labels(
      aesoc = "AE SOC",
      aeterm = "AE Term (HLGT)",
      aegr = "AE grade",
      sae = "Serious AE",
    )

  rtn = lst(enrolres, ae) %>%
    imap(~.x %>% mutate(crfname=.y %>% set_label("Form name")))
  rtn$date_extraction = "2024/01/01"
  rtn$datetime_extraction = structure(1704067200, class = c("POSIXct", "POSIXt"),
                                      tzone = "Europe/Paris")

  rtn
}

.example_enrol = function(N){

}




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
