
sample_soc = c(
  "Gastrointestinal disorders",
  "General disorders and administration site conditions",
  "Renal and urinary disorders",
  "Blood and lymphatic system disorders",
  "Reproductive system and breast disorders",
  "Infections and infestations",
  "Investigations",
  "Metabolism and nutrition disorders",
  "Skin and subcutaneous tissue disorders",
  "Ear and labyrinth disorders",
  "Nervous system disorders",
  "Musculoskeletal and connective tissue disorders",
  "Vascular disorders",
  "Endocrine disorders",
  "Respiratory, thoracic and mediastinal disorders",
  "Psychiatric disorders",
  "Hepatobiliary disorders",
  "Cardiac disorders",
  "Immune system disorders",
  "Injury, poisoning and procedural complications",
  "Eye disorders",
  "Neoplasms benign, malignant and unspecified (incl cysts and polyps)",
  "Surgical and medical procedures"
)


#' @rdname data_example
#' @export
#' @importFrom dplyr mutate n select
#' @importFrom purrr imap map
#' @importFrom stats rbinom runif
#' @importFrom tibble lst tibble
#' @importFrom tidyr unnest
grstat_example = function(N=50, seed=42){
  set.seed(seed)

  enrolres = tibble(subjid=1:N, arm=sample(c("Trt", "Ctl"), size=N, replace=TRUE))

  ae = tibble(subjid=1:N, n_ae=rbinom(n=N, size=15, prob=0.2)) %>%
    mutate(x = map(n_ae, ~seq_len(.x))) %>%
    unnest(x) %>%
    mutate(
      aegr = sample(1:5, size=n(), replace=TRUE, prob=c(0.3,0.25,0.2,0.1,0.05)) %>% set_label("AE grade"),
      aesoc = sample(sample_soc, size=n(), replace=TRUE) %>% set_label("AE SOC"),
      sae = fct_yesno(runif(n())<0.1) %>% set_label("Serious AE"),
    ) %>%
    select(subjid, aesoc, aegr, n_ae, sae)

  rtn = lst(enrolres, ae) %>%
    imap(~.x %>% mutate(crfname=.y %>% set_label("Form name")))

  rtn
}
