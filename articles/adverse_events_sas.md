# Adverse Events : Macros SAS

Cette vignette a pour but de faire le parallèle entre les macros SAS de
description des AE et les fonctions disponibles dans le package
`grstat`.

Elle reprend le document Word des macros SAS et n’existe que pour donner
la correspondance entre les deux systèmes.

Pour apprendre comment utiliser `grstat` pour décrire les AE, utilisez
plutôt la vignette dédiée.

## Data

On commence par charger la base de données.

Ici j’utilise la fonction
[`grstat_example()`](https://oncostat.github.io/grstat/reference/grstat_example.md)
pour ne pas dépendre de données réelles privées, mais en pratique on
utiliserait plutôt `EDCimport::read_trialmaster("path/to/file.zip")`.

On s’intéresse à deux datasets : - `ae` qui contient les données
d’adverse events - `enrolres` qui contient tous les patients et leur
bras de traitement.

``` r
library(grstat)
library(flextable)
library(dplyr)

# db = EDCimport::read_trialmaster("path/to/file.zip")
db = grstat_example()
attach(db)

head(ae)
#> # A tibble: 6 × 7
#>   subjid aesoc                                  aeterm  aegr sae   aerel crfname
#>    <int> <chr>                                  <chr>  <dbl> <fct> <chr> <chr>  
#> 1      1 Psychiatric disorders                  Subst…     1 No    Stan… ae     
#> 2      1 Social circumstances                   Cultu…     1 No    Expe… ae     
#> 3      1 Pregnancy, puerperium and perinatal c… Fetal…     2 Yes   Canc… ae     
#> 4      1 Eye disorders                          Visio…     1 No    Radi… ae     
#> 5      1 Cardiac disorders                      Cardi…     2 No    Other ae     
#> 6      2 Eye disorders                          Retin…     1 No    Stan… ae

head(enrolres)
#> # A tibble: 6 × 5
#>   subjid arm       arm3        date_inclusion crfname 
#>    <int> <fct>     <fct>       <date>         <chr>   
#> 1      1 Control   Treatment B 2023-01-22     enrolres
#> 2      2 Control   Control     2023-03-12     enrolres
#> 3      3 Treatment Treatment A 2023-03-30     enrolres
#> 4      4 Control   Control     2023-04-03     enrolres
#> 5      5 Treatment Treatment A 2023-05-26     enrolres
#> 6      6 Treatment Treatment A 2023-06-03     enrolres
```

## Macro `AE_grades`

La macro `AE_grades` est implémentée dans la fonction
[`ae_table_grade()`](https://oncostat.github.io/grstat/reference/ae_table_grade.md).
Cette fonction retourne des objets de classe `crosstable`, lesquels ont
une méthode
[`as_flextable()`](https://davidgohel.github.io/flextable/reference/as_flextable.html)
qui les transforme en table HTML de classe `flextable`.

Voir la description du package
[crosstable](https://danchaltiel.github.io/crosstable/) pour plus
d’informations:
[documentation](https://danchaltiel.github.io/crosstable/reference/as_flextable.html).  
Voir la description du package
[flextable](https://ardata-fr.github.io/flextable-book/) pour la liste
des modificateurs (comme
[`add_footer_lines()`](https://davidgohel.github.io/flextable/reference/add_footer_lines.html))
:
[documentation](https://davidgohel.github.io/flextable/reference/index.html).

### `AE_grades1` : Table des grades maximum par patient

``` r
ae_table_grade(data_ae=ae, data_pat=enrolres, arm=NULL, variant="max") %>% 
  as_flextable() %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum AE grade was as indicated.")
```

[TABLE]

### `AE_grades2` : Table des grades maximum par patient stratifié sur le bras

On pourrait retrouver exactement la sortie SAS en mettant `total=FALSE`.

``` r
ae_table_grade(data_ae=ae, data_pat=enrolres, arm="arm", variant="max") %>% 
  as_flextable() %>% 
  add_footer_lines("Percentages reflect the proportion of patients presenting at most one AE of given grade")
```

[TABLE]

### `AE_grades3` : Table de tous les grades pour chaque patient

``` r
ae_table_grade(data_ae=ae, data_pat=enrolres, arm=NULL, variant="eq") %>% 
  as_flextable() %>% 
  add_footer_lines("Percentages reflect the proportion of patients presenting at least one AE of given grade")
```

[TABLE]

### `AE_grades3bis` : Table de tous les grades pour chaque patient, stratifié sur le bras

On pourrait retrouver exactement la sortie SAS en mettant `total=FALSE`.

``` r
ae_table_grade(data_ae=ae, data_pat=enrolres, arm="arm", variant="eq") %>% 
  as_flextable() %>% 
  add_footer_lines("Percentages reflect the proportion of patients presenting at least one AE of given grade")
```

[TABLE]

### `AE_grades4` : Table des grades maximum par patient, filtrée sur les SAE

Il suffit de filtrer la table `ae` en amont et d’indiquer que le label
doit être “SAE”.

``` r
ae %>% 
  filter(sae=="Yes") %>% 
  ae_table_grade(data_pat=enrolres, arm=NULL, variant="max", ae_label="SAE") %>% 
  as_flextable() %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum SAE grade was as indicated.")
```

[TABLE]

## Macro `AE_SOC`

La macro `AE_SOC` est implémentée dans la fonction
[`ae_table_soc()`](https://oncostat.github.io/grstat/reference/ae_table_soc.md).
Cette fonction retourne des objets de classe `ae_table_soc`. Ils ont
également une méthode `as_flextable` qui les transforme en table HTML de
classe `flextable`, mais différente de celle de `crosstable`.

Voir
[`?as_flextable.ae_table_soc`](https://oncostat.github.io/grstat/reference/ae_table_soc.md)
pour plus d’informations:
[lien](https://oncostat.github.io/grstat/reference/ae_table_soc.html).  
Voir la description du package
[flextable](https://ardata-fr.github.io/flextable-book/) pour la liste
des modificateurs (comme
[`add_footer_lines()`](https://davidgohel.github.io/flextable/reference/add_footer_lines.html))
:
[documentation](https://davidgohel.github.io/flextable/reference/index.html).

**Astuce:** Pour les sorties sur
[officer](https://ardata-fr.github.io/officeverse/), comme ces tables
sont très larges, pensez bien à basculer en format paysage en utilisant
[`officer::body_end_section_continuous()`](https://davidgohel.github.io/officer/reference/body_end_section_continuous.html),
puis
[`officer::body_end_section_landscape()`](https://davidgohel.github.io/officer/reference/body_end_section_landscape.html)
pour revenir au format portrait.

### `AE_SOC1` : Table des grades par soc

On peut ajouter `total=FALSE` pour retirer la colonne “Tot”.

``` r
ae_table_soc(df_ae=ae, df_enrol=enrolres, arm=NULL, term=NULL, 
             sort_by_count=FALSE) %>% 
  as_flextable() %>% 
  add_footer_lines("In the header, N represents the number of patients.") %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum AE grade was as indicated.")
```

|                                                                                         | All patients (N=200) |         |        |        |        |        |          |
|-----------------------------------------------------------------------------------------|----------------------|---------|--------|--------|--------|--------|----------|
| CTCAE SOC                                                                               | G1                   | G2      | G3     | G4     | G5     | NA     | Tot      |
| Blood and lymphatic system disorders                                                    | 3 (2%)               | 3 (2%)  | 3 (2%) | 1 (0%) |        |        | 10 (5%)  |
| Cardiac disorders                                                                       | 11 (6%)              | 4 (2%)  | 7 (4%) | 4 (2%) |        |        | 26 (13%) |
| Congenital, familial and genetic disorders                                              | 23 (12%)             | 10 (5%) | 4 (2%) | 5 (2%) |        |        | 42 (21%) |
| Ear and labyrinth disorders                                                             | 7 (4%)               | 7 (4%)  | 4 (2%) |        |        |        | 18 (9%)  |
| Endocrine disorders                                                                     | 11 (6%)              | 2 (1%)  | 2 (1%) | 1 (0%) |        |        | 16 (8%)  |
| Eye disorders                                                                           | 21 (10%)             | 16 (8%) | 9 (4%) | 3 (2%) |        |        | 49 (24%) |
| Gastrointestinal disorders                                                              | 5 (2%)               | 1 (0%)  |        | 1 (0%) |        |        | 7 (4%)   |
| General disorders and administration site conditions                                    | 2 (1%)               | 5 (2%)  | 2 (1%) |        |        |        | 9 (4%)   |
| Hepatobiliary disorders                                                                 | 17 (8%)              | 8 (4%)  | 1 (0%) | 2 (1%) |        |        | 28 (14%) |
| Immune system disorders                                                                 | 15 (8%)              | 9 (4%)  | 7 (4%) | 3 (2%) |        |        | 34 (17%) |
| Infections and infestations                                                             | 10 (5%)              | 3 (2%)  | 1 (0%) |        | 1 (0%) |        | 15 (8%)  |
| Injury, poisoning and procedural complications                                          | 17 (8%)              | 13 (6%) | 3 (2%) | 2 (1%) |        |        | 35 (18%) |
| Investigations                                                                          | 7 (4%)               | 1 (0%)  | 3 (2%) |        |        |        | 11 (6%)  |
| Metabolism and nutrition disorders                                                      | 8 (4%)               | 2 (1%)  |        |        |        |        | 10 (5%)  |
| Musculoskeletal and connective tissue disorders                                         | 5 (2%)               | 3 (2%)  | 4 (2%) | 1 (0%) | 2 (1%) |        | 15 (8%)  |
| Neoplasms benign, malignant, and unspecified                                            | 12 (6%)              | 12 (6%) | 4 (2%) | 2 (1%) |        |        | 30 (15%) |
| Nervous system disorders                                                                | 5 (2%)               | 6 (3%)  |        | 1 (0%) |        |        | 12 (6%)  |
| Pregnancy, puerperium and perinatal conditions                                          | 14 (7%)              | 12 (6%) | 4 (2%) | 3 (2%) |        |        | 33 (16%) |
| Psychiatric disorders                                                                   | 10 (5%)              | 2 (1%)  | 3 (2%) | 1 (0%) |        |        | 16 (8%)  |
| Renal and urinary disorders                                                             | 5 (2%)               |         | 1 (0%) | 1 (0%) |        |        | 7 (4%)   |
| Reproductive system and breast disorders                                                | 3 (2%)               | 2 (1%)  | 2 (1%) |        |        |        | 7 (4%)   |
| Respiratory, thoracic and mediastinal disorders                                         | 11 (6%)              | 6 (3%)  | 5 (2%) | 1 (0%) | 1 (0%) |        | 24 (12%) |
| Skin and subcutaneous tissue disorders                                                  | 6 (3%)               | 3 (2%)  |        | 1 (0%) |        |        | 10 (5%)  |
| Social circumstances                                                                    | 27 (14%)             | 12 (6%) | 6 (3%) | 4 (2%) |        |        | 49 (24%) |
| Surgical and medical procedures                                                         | 13 (6%)              | 10 (5%) | 4 (2%) | 1 (0%) |        |        | 28 (14%) |
| Vascular disorders                                                                      | 10 (5%)              | 3 (2%)  | 1 (0%) | 2 (1%) |        |        | 16 (8%)  |
| No Declared AE                                                                          |                      |         |        |        |        | 8 (4%) | 8 (4%)   |
| In the header, N represents the number of patients.                                     |                      |         |        |        |        |        |          |
| Percentages reflect the proportion of patients whose maximum AE grade was as indicated. |                      |         |        |        |        |        |          |

### `AE_SOC2` : Table des grades par soc et termes

``` r
ae_table_soc(df_ae=ae, df_enrol=enrolres, arm=NULL, term="aeterm", 
             sort_by_count=FALSE) %>% 
  as_flextable() %>% 
  add_footer_lines("In the header, N represents the number of patients.") %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum AE grade was as indicated.")
```

|                                                                                         |                                                      | All patients (N=200) |        |        |        |        |        |          |
|-----------------------------------------------------------------------------------------|------------------------------------------------------|----------------------|--------|--------|--------|--------|--------|----------|
| CTCAE SOC                                                                               | CTCAE v4.0 Term                                      | G1                   | G2     | G3     | G4     | G5     | NA     | Tot      |
| Blood and lymphatic system disorders                                                    | Bone marrow disorders                                |                      |        |        | 1 (0%) |        |        | 1 (0%)   |
|                                                                                         | Coagulation and bleeding analyses                    |                      |        | 1 (0%) |        |        |        | 1 (0%)   |
|                                                                                         | Hematologic neoplasms                                |                      |        | 1 (0%) |        |        |        | 1 (0%)   |
|                                                                                         | Red blood cell disorders                             | 3 (2%)               | 3 (2%) | 1 (0%) |        |        |        | 7 (4%)   |
| Cardiac disorders                                                                       | Cardiac arrhythmias                                  | 5 (2%)               | 2 (1%) | 1 (0%) | 1 (0%) |        |        | 9 (4%)   |
|                                                                                         | Cardiac valve disorders                              | 3 (2%)               | 1 (0%) | 5 (2%) | 2 (1%) |        |        | 11 (6%)  |
|                                                                                         | Coronary artery disorders                            | 3 (2%)               |        |        | 1 (0%) |        |        | 4 (2%)   |
|                                                                                         | Heart failures                                       | 2 (1%)               | 1 (0%) | 1 (0%) |        |        |        | 4 (2%)   |
| Congenital, familial and genetic disorders                                              | Chromosomal abnormalities                            | 5 (2%)               | 2 (1%) | 2 (1%) | 3 (2%) |        |        | 12 (6%)  |
|                                                                                         | Congenital nervous system disorders                  | 10 (5%)              | 4 (2%) |        |        |        |        | 14 (7%)  |
|                                                                                         | Familial hematologic disorders                       | 5 (2%)               | 2 (1%) |        | 1 (0%) |        |        | 8 (4%)   |
|                                                                                         | Hereditary connective tissue disorders               | 8 (4%)               | 2 (1%) | 2 (1%) | 1 (0%) |        |        | 13 (6%)  |
| Ear and labyrinth disorders                                                             | Hearing disorders                                    | 2 (1%)               | 1 (0%) | 1 (0%) |        |        |        | 4 (2%)   |
|                                                                                         | Labyrinth disorders                                  | 1 (0%)               | 2 (1%) | 1 (0%) |        |        |        | 4 (2%)   |
|                                                                                         | Tinnitus                                             | 2 (1%)               | 2 (1%) | 2 (1%) |        |        |        | 6 (3%)   |
|                                                                                         | Vertigo and balance disorders                        | 2 (1%)               | 2 (1%) |        |        |        |        | 4 (2%)   |
| Endocrine disorders                                                                     | Adrenal gland disorders                              | 3 (2%)               |        |        |        |        |        | 3 (2%)   |
|                                                                                         | Parathyroid gland disorders                          | 3 (2%)               |        |        |        |        |        | 3 (2%)   |
|                                                                                         | Pituitary gland disorders                            | 4 (2%)               | 1 (0%) |        |        |        |        | 5 (2%)   |
|                                                                                         | Thyroid gland disorders                              | 2 (1%)               | 1 (0%) | 2 (1%) | 1 (0%) |        |        | 6 (3%)   |
| Eye disorders                                                                           | Corneal disorders                                    | 8 (4%)               | 3 (2%) | 1 (0%) |        |        |        | 12 (6%)  |
|                                                                                         | Eyelid disorders                                     | 5 (2%)               | 3 (2%) | 2 (1%) |        |        |        | 10 (5%)  |
|                                                                                         | Retinal disorders                                    | 6 (3%)               | 6 (3%) | 4 (2%) | 2 (1%) |        |        | 18 (9%)  |
|                                                                                         | Vision disorders                                     | 6 (3%)               | 4 (2%) | 2 (1%) | 1 (0%) |        |        | 13 (6%)  |
| Gastrointestinal disorders                                                              | Esophageal disorders                                 | 1 (0%)               |        |        | 1 (0%) |        |        | 2 (1%)   |
|                                                                                         | Gastric disorders                                    | 2 (1%)               |        |        |        |        |        | 2 (1%)   |
|                                                                                         | Intestinal disorders                                 | 2 (1%)               | 1 (0%) |        |        |        |        | 3 (2%)   |
| General disorders and administration site conditions                                    | General physical health deterioration                |                      | 3 (2%) |        |        |        |        | 3 (2%)   |
|                                                                                         | Injection site reactions                             | 1 (0%)               | 1 (0%) | 2 (1%) |        |        |        | 4 (2%)   |
|                                                                                         | Pain and discomfort                                  | 1 (0%)               | 1 (0%) |        |        |        |        | 2 (1%)   |
| Hepatobiliary disorders                                                                 | Bile duct disorders                                  | 4 (2%)               | 4 (2%) |        | 1 (0%) |        |        | 9 (4%)   |
|                                                                                         | Gallbladder disorders                                | 4 (2%)               | 1 (0%) |        | 1 (0%) |        |        | 6 (3%)   |
|                                                                                         | Hepatic failure                                      | 5 (2%)               | 2 (1%) |        |        |        |        | 7 (4%)   |
|                                                                                         | Liver disorders                                      | 6 (3%)               | 1 (0%) | 1 (0%) |        |        |        | 8 (4%)   |
| Immune system disorders                                                                 | Autoimmune disorders                                 | 3 (2%)               | 1 (0%) | 1 (0%) | 1 (0%) |        |        | 6 (3%)   |
|                                                                                         | Hypersensitivity conditions                          | 7 (4%)               | 4 (2%) | 2 (1%) | 1 (0%) |        |        | 14 (7%)  |
|                                                                                         | Immunodeficiency                                     | 2 (1%)               | 2 (1%) | 2 (1%) |        |        |        | 6 (3%)   |
|                                                                                         | Inflammatory responses                               | 4 (2%)               | 4 (2%) | 2 (1%) | 1 (0%) |        |        | 11 (6%)  |
| Infections and infestations                                                             | Bacterial infectious disorders                       | 2 (1%)               |        |        |        |        |        | 2 (1%)   |
|                                                                                         | Fungal infectious disorders                          | 1 (0%)               |        |        |        | 1 (0%) |        | 2 (1%)   |
|                                                                                         | Parasitic infectious disorders                       | 5 (2%)               | 2 (1%) | 1 (0%) |        |        |        | 8 (4%)   |
|                                                                                         | Viral infectious disorders                           | 3 (2%)               | 1 (0%) |        |        |        |        | 4 (2%)   |
| Injury, poisoning and procedural complications                                          | Poisonings                                           | 4 (2%)               | 4 (2%) | 1 (0%) |        |        |        | 9 (4%)   |
|                                                                                         | Procedural complications                             | 12 (6%)              | 1 (0%) | 2 (1%) | 1 (0%) |        |        | 16 (8%)  |
|                                                                                         | Radiation-related toxicities                         | 2 (1%)               | 4 (2%) |        | 1 (0%) |        |        | 7 (4%)   |
|                                                                                         | Traumatic injuries                                   | 3 (2%)               | 4 (2%) |        |        |        |        | 7 (4%)   |
| Investigations                                                                          | Blood analyses                                       | 2 (1%)               |        | 1 (0%) |        |        |        | 3 (2%)   |
|                                                                                         | Cardiovascular assessments                           | 2 (1%)               |        | 1 (0%) |        |        |        | 3 (2%)   |
|                                                                                         | Imaging studies                                      |                      | 1 (0%) | 1 (0%) |        |        |        | 2 (1%)   |
|                                                                                         | Liver function analyses                              | 3 (2%)               |        |        |        |        |        | 3 (2%)   |
| Metabolism and nutrition disorders                                                      | Fluid and electrolyte disorders                      | 2 (1%)               |        |        |        |        |        | 2 (1%)   |
|                                                                                         | Lipid metabolism disorders                           | 3 (2%)               |        |        |        |        |        | 3 (2%)   |
|                                                                                         | Nutritional disorders                                | 2 (1%)               | 1 (0%) |        |        |        |        | 3 (2%)   |
|                                                                                         | Vitamin deficiencies                                 | 2 (1%)               | 1 (0%) |        |        |        |        | 3 (2%)   |
| Musculoskeletal and connective tissue disorders                                         | Arthritis and joint disorders                        |                      | 2 (1%) |        |        | 1 (0%) |        | 3 (2%)   |
|                                                                                         | Bone disorders                                       |                      | 1 (0%) | 2 (1%) |        | 1 (0%) |        | 4 (2%)   |
|                                                                                         | Connective tissue disorders                          | 3 (2%)               |        | 1 (0%) | 1 (0%) |        |        | 5 (2%)   |
|                                                                                         | Muscle disorders                                     | 2 (1%)               |        | 1 (0%) |        |        |        | 3 (2%)   |
| Neoplasms benign, malignant, and unspecified                                            | Benign neoplasms                                     | 4 (2%)               | 7 (4%) | 1 (0%) | 1 (0%) |        |        | 13 (6%)  |
|                                                                                         | Malignant neoplasms                                  | 2 (1%)               | 1 (0%) |        |        |        |        | 3 (2%)   |
|                                                                                         | Neoplasms unspecified                                | 1 (0%)               | 2 (1%) | 2 (1%) |        |        |        | 5 (2%)   |
|                                                                                         | Tumor progression                                    | 5 (2%)               | 3 (2%) | 1 (0%) | 1 (0%) |        |        | 10 (5%)  |
| Nervous system disorders                                                                | Headache disorders                                   | 3 (2%)               | 1 (0%) |        | 1 (0%) |        |        | 5 (2%)   |
|                                                                                         | Neurological disorders of the central nervous system | 1 (0%)               | 2 (1%) |        |        |        |        | 3 (2%)   |
|                                                                                         | Peripheral neuropathies                              |                      | 2 (1%) |        |        |        |        | 2 (1%)   |
|                                                                                         | Seizure disorders                                    | 2 (1%)               | 1 (0%) |        |        |        |        | 3 (2%)   |
| Pregnancy, puerperium and perinatal conditions                                          | Breastfeeding issues                                 | 3 (2%)               | 2 (1%) |        |        |        |        | 5 (2%)   |
|                                                                                         | Fetal complications                                  | 2 (1%)               | 7 (4%) | 1 (0%) | 2 (1%) |        |        | 12 (6%)  |
|                                                                                         | Labor and delivery complications                     | 6 (3%)               | 1 (0%) | 2 (1%) | 1 (0%) |        |        | 10 (5%)  |
|                                                                                         | Pregnancy complications                              | 4 (2%)               | 2 (1%) | 1 (0%) |        |        |        | 7 (4%)   |
| Psychiatric disorders                                                                   | Anxiety disorders                                    | 2 (1%)               | 2 (1%) | 1 (0%) |        |        |        | 5 (2%)   |
|                                                                                         | Mood disorders                                       | 2 (1%)               |        | 2 (1%) |        |        |        | 4 (2%)   |
|                                                                                         | Sleep disorders                                      | 4 (2%)               |        |        | 1 (0%) |        |        | 5 (2%)   |
|                                                                                         | Substance-related disorders                          | 3 (2%)               |        |        |        |        |        | 3 (2%)   |
| Renal and urinary disorders                                                             | Bladder disorders                                    |                      |        |        | 1 (0%) |        |        | 1 (0%)   |
|                                                                                         | Kidney disorders                                     | 2 (1%)               |        |        |        |        |        | 2 (1%)   |
|                                                                                         | Urethral disorders                                   | 1 (0%)               |        | 1 (0%) |        |        |        | 2 (1%)   |
|                                                                                         | Urinary tract disorders                              | 2 (1%)               |        |        |        |        |        | 2 (1%)   |
| Reproductive system and breast disorders                                                | Breast disorders                                     |                      |        | 1 (0%) |        |        |        | 1 (0%)   |
|                                                                                         | Female reproductive disorders                        | 1 (0%)               |        | 1 (0%) |        |        |        | 2 (1%)   |
|                                                                                         | Male reproductive disorders                          | 1 (0%)               | 2 (1%) |        |        |        |        | 3 (2%)   |
|                                                                                         | Menstrual disorders                                  | 1 (0%)               |        |        |        |        |        | 1 (0%)   |
| Respiratory, thoracic and mediastinal disorders                                         | Lung function disorders                              | 2 (1%)               | 2 (1%) | 3 (2%) |        |        |        | 7 (4%)   |
|                                                                                         | Pleural disorders                                    | 3 (2%)               |        | 1 (0%) |        | 1 (0%) |        | 5 (2%)   |
|                                                                                         | Pulmonary vascular disorders                         | 5 (2%)               | 1 (0%) |        | 1 (0%) |        |        | 7 (4%)   |
|                                                                                         | Respiratory infections                               | 2 (1%)               | 3 (2%) | 2 (1%) |        |        |        | 7 (4%)   |
| Skin and subcutaneous tissue disorders                                                  | Dermatitis                                           | 2 (1%)               | 1 (0%) |        |        |        |        | 3 (2%)   |
|                                                                                         | Skin and subcutaneous tissue injuries                | 1 (0%)               | 1 (0%) |        |        |        |        | 2 (1%)   |
|                                                                                         | Skin infections                                      | 2 (1%)               |        |        |        |        |        | 2 (1%)   |
|                                                                                         | Skin pigmentation disorders                          | 1 (0%)               | 1 (0%) |        | 1 (0%) |        |        | 3 (2%)   |
| Social circumstances                                                                    | Cultural issues                                      | 11 (6%)              | 3 (2%) | 3 (2%) | 2 (1%) |        |        | 19 (10%) |
|                                                                                         | Economic conditions affecting care                   | 2 (1%)               | 4 (2%) |        | 1 (0%) |        |        | 7 (4%)   |
|                                                                                         | Family support issues                                | 14 (7%)              | 4 (2%) | 2 (1%) |        |        |        | 20 (10%) |
|                                                                                         | Social and environmental issues                      | 7 (4%)               | 2 (1%) | 2 (1%) | 1 (0%) |        |        | 12 (6%)  |
| Surgical and medical procedures                                                         | Device implantation procedures                       | 5 (2%)               | 1 (0%) | 1 (0%) |        |        |        | 7 (4%)   |
|                                                                                         | Diagnostic procedures                                | 3 (2%)               | 3 (2%) | 1 (0%) |        |        |        | 7 (4%)   |
|                                                                                         | Surgical complications                               | 3 (2%)               | 3 (2%) | 2 (1%) |        |        |        | 8 (4%)   |
|                                                                                         | Therapeutic procedures                               | 3 (2%)               | 3 (2%) | 1 (0%) | 1 (0%) |        |        | 8 (4%)   |
| Vascular disorders                                                                      | Hypertension-related conditions                      |                      | 2 (1%) | 1 (0%) |        |        |        | 3 (2%)   |
|                                                                                         | Hypotension-related conditions                       | 3 (2%)               |        |        |        |        |        | 3 (2%)   |
|                                                                                         | Vascular hemorrhagic disorders                       | 5 (2%)               |        |        | 1 (0%) |        |        | 6 (3%)   |
|                                                                                         | Venous thromboembolic events                         | 2 (1%)               | 1 (0%) |        | 1 (0%) |        |        | 4 (2%)   |
| No Declared AE                                                                          |                                                      |                      |        |        |        |        | 8 (4%) | 8 (4%)   |
| In the header, N represents the number of patients.                                     |                                                      |                      |        |        |        |        |        |          |
| Percentages reflect the proportion of patients whose maximum AE grade was as indicated. |                                                      |                      |        |        |        |        |        |          |

### `AE_SOC3` : Table des grades par termes uniquement, filtrée sur les SAE

Il suffit de filtrer la table AE en amont.

``` r
ae %>% 
  filter(sae=="Yes") %>%
  ae_table_soc(df_enrol=enrolres, term=NULL, arm=NULL, sort_by_count=FALSE) %>% 
  as_flextable() %>% 
  add_footer_lines(c("In the header, N represents the number of patients.",
                     "Percentages reflect the proportion of patients whose maximum SAE grade was as indicated."))
```

|                                                                                          | All patients (N=200) |        |        |        |        |           |           |
|------------------------------------------------------------------------------------------|----------------------|--------|--------|--------|--------|-----------|-----------|
| CTCAE SOC                                                                                | G1                   | G2     | G3     | G4     | G5     | NA        | Tot       |
| Blood and lymphatic system disorders                                                     |                      |        | 1 (0%) | 1 (0%) |        |           | 2 (1%)    |
| Cardiac disorders                                                                        |                      | 1 (0%) | 2 (1%) | 1 (0%) |        |           | 4 (2%)    |
| Congenital, familial and genetic disorders                                               | 3 (2%)               | 3 (2%) |        | 1 (0%) |        |           | 7 (4%)    |
| Endocrine disorders                                                                      |                      |        | 1 (0%) | 1 (0%) |        |           | 2 (1%)    |
| Eye disorders                                                                            |                      | 2 (1%) | 1 (0%) |        |        |           | 3 (2%)    |
| Gastrointestinal disorders                                                               | 2 (1%)               |        |        | 1 (0%) |        |           | 3 (2%)    |
| Hepatobiliary disorders                                                                  | 1 (0%)               |        |        | 1 (0%) |        |           | 2 (1%)    |
| Immune system disorders                                                                  | 3 (2%)               |        |        | 1 (0%) |        |           | 4 (2%)    |
| Injury, poisoning and procedural complications                                           |                      | 2 (1%) |        |        |        |           | 2 (1%)    |
| Investigations                                                                           | 1 (0%)               |        |        |        |        |           | 1 (0%)    |
| Metabolism and nutrition disorders                                                       | 1 (0%)               |        |        |        |        |           | 1 (0%)    |
| Musculoskeletal and connective tissue disorders                                          |                      |        | 1 (0%) |        |        |           | 1 (0%)    |
| Neoplasms benign, malignant, and unspecified                                             | 1 (0%)               | 2 (1%) | 1 (0%) |        |        |           | 4 (2%)    |
| Pregnancy, puerperium and perinatal conditions                                           | 1 (0%)               | 5 (2%) |        | 1 (0%) |        |           | 7 (4%)    |
| Psychiatric disorders                                                                    |                      |        | 1 (0%) |        |        |           | 1 (0%)    |
| Renal and urinary disorders                                                              |                      |        | 1 (0%) |        |        |           | 1 (0%)    |
| Respiratory, thoracic and mediastinal disorders                                          |                      |        |        | 1 (0%) | 1 (0%) |           | 2 (1%)    |
| Skin and subcutaneous tissue disorders                                                   | 1 (0%)               | 1 (0%) |        |        |        |           | 2 (1%)    |
| Social circumstances                                                                     | 2 (1%)               | 2 (1%) | 1 (0%) | 1 (0%) |        |           | 6 (3%)    |
| Surgical and medical procedures                                                          | 2 (1%)               | 1 (0%) | 1 (0%) | 1 (0%) |        |           | 5 (2%)    |
| Vascular disorders                                                                       |                      |        | 1 (0%) | 1 (0%) |        |           | 2 (1%)    |
| No Declared AE                                                                           |                      |        |        |        |        | 144 (72%) | 144 (72%) |
| In the header, N represents the number of patients.                                      |                      |        |        |        |        |           |           |
| Percentages reflect the proportion of patients whose maximum SAE grade was as indicated. |                      |        |        |        |        |           |           |

### `AE_SOC4/5` : Table des grades stratifiée sur le bras (sans colonne total)

On peut ajouter `total=FALSE` pour retirer la colonne “Tot” et obtenir
la sortie *AE_SOC5*.

``` r
ae_table_soc(df_ae=ae, df_enrol=enrolres, term=NULL, arm="arm", sort_by_count=FALSE) %>% 
  as_flextable() %>% 
  add_footer_lines("In the header, N represents the number of patients.") %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum AE grade was as indicated.")
```

|                                                                                         | Control (N=100) |          |        |        |        |        |          | Treatment (N=100) |        |        |        |        |        |          |
|-----------------------------------------------------------------------------------------|-----------------|----------|--------|--------|--------|--------|----------|-------------------|--------|--------|--------|--------|--------|----------|
| CTCAE SOC                                                                               | G1              | G2       | G3     | G4     | G5     | NA     | Tot      | G1                | G2     | G3     | G4     | G5     | NA     | Tot      |
| Blood and lymphatic system disorders                                                    |                 | 1 (1%)   | 1 (1%) | 1 (1%) |        |        | 3 (3%)   | 3 (3%)            | 2 (2%) | 2 (2%) |        |        |        | 7 (7%)   |
| Cardiac disorders                                                                       | 7 (7%)          | 3 (3%)   | 4 (4%) |        |        |        | 14 (14%) | 4 (4%)            | 1 (1%) | 3 (3%) | 4 (4%) |        |        | 12 (12%) |
| Congenital, familial and genetic disorders                                              | 10 (10%)        | 7 (7%)   | 2 (2%) | 1 (1%) |        |        | 20 (20%) | 13 (13%)          | 3 (3%) | 2 (2%) | 4 (4%) |        |        | 22 (22%) |
| Ear and labyrinth disorders                                                             | 4 (4%)          | 2 (2%)   | 2 (2%) |        |        |        | 8 (8%)   | 3 (3%)            | 5 (5%) | 2 (2%) |        |        |        | 10 (10%) |
| Endocrine disorders                                                                     | 9 (9%)          |          | 1 (1%) | 1 (1%) |        |        | 11 (11%) | 2 (2%)            | 2 (2%) | 1 (1%) |        |        |        | 5 (5%)   |
| Eye disorders                                                                           | 14 (14%)        | 11 (11%) | 4 (4%) | 2 (2%) |        |        | 31 (31%) | 7 (7%)            | 5 (5%) | 5 (5%) | 1 (1%) |        |        | 18 (18%) |
| Gastrointestinal disorders                                                              | 2 (2%)          | 1 (1%)   |        | 1 (1%) |        |        | 4 (4%)   | 3 (3%)            |        |        |        |        |        | 3 (3%)   |
| General disorders and administration site conditions                                    |                 | 4 (4%)   | 2 (2%) |        |        |        | 6 (6%)   | 2 (2%)            | 1 (1%) |        |        |        |        | 3 (3%)   |
| Hepatobiliary disorders                                                                 | 9 (9%)          | 3 (3%)   |        | 2 (2%) |        |        | 14 (14%) | 8 (8%)            | 5 (5%) | 1 (1%) |        |        |        | 14 (14%) |
| Immune system disorders                                                                 | 8 (8%)          | 4 (4%)   | 4 (4%) | 2 (2%) |        |        | 18 (18%) | 7 (7%)            | 5 (5%) | 3 (3%) | 1 (1%) |        |        | 16 (16%) |
| Infections and infestations                                                             | 8 (8%)          | 3 (3%)   |        |        |        |        | 11 (11%) | 2 (2%)            |        | 1 (1%) |        | 1 (1%) |        | 4 (4%)   |
| Injury, poisoning and procedural complications                                          | 12 (12%)        | 8 (8%)   | 1 (1%) | 1 (1%) |        |        | 22 (22%) | 5 (5%)            | 5 (5%) | 2 (2%) | 1 (1%) |        |        | 13 (13%) |
| Investigations                                                                          | 5 (5%)          | 1 (1%)   | 1 (1%) |        |        |        | 7 (7%)   | 2 (2%)            |        | 2 (2%) |        |        |        | 4 (4%)   |
| Metabolism and nutrition disorders                                                      | 4 (4%)          | 1 (1%)   |        |        |        |        | 5 (5%)   | 4 (4%)            | 1 (1%) |        |        |        |        | 5 (5%)   |
| Musculoskeletal and connective tissue disorders                                         | 4 (4%)          | 2 (2%)   | 2 (2%) | 1 (1%) | 2 (2%) |        | 11 (11%) | 1 (1%)            | 1 (1%) | 2 (2%) |        |        |        | 4 (4%)   |
| Neoplasms benign, malignant, and unspecified                                            | 6 (6%)          | 7 (7%)   | 3 (3%) | 1 (1%) |        |        | 17 (17%) | 6 (6%)            | 5 (5%) | 1 (1%) | 1 (1%) |        |        | 13 (13%) |
| Nervous system disorders                                                                | 2 (2%)          | 3 (3%)   |        |        |        |        | 5 (5%)   | 3 (3%)            | 3 (3%) |        | 1 (1%) |        |        | 7 (7%)   |
| Pregnancy, puerperium and perinatal conditions                                          | 7 (7%)          | 5 (5%)   | 2 (2%) | 2 (2%) |        |        | 16 (16%) | 7 (7%)            | 7 (7%) | 2 (2%) | 1 (1%) |        |        | 17 (17%) |
| Psychiatric disorders                                                                   | 4 (4%)          | 1 (1%)   | 1 (1%) |        |        |        | 6 (6%)   | 6 (6%)            | 1 (1%) | 2 (2%) | 1 (1%) |        |        | 10 (10%) |
| Renal and urinary disorders                                                             | 3 (3%)          |          | 1 (1%) |        |        |        | 4 (4%)   | 2 (2%)            |        |        | 1 (1%) |        |        | 3 (3%)   |
| Reproductive system and breast disorders                                                | 1 (1%)          | 1 (1%)   | 1 (1%) |        |        |        | 3 (3%)   | 2 (2%)            | 1 (1%) | 1 (1%) |        |        |        | 4 (4%)   |
| Respiratory, thoracic and mediastinal disorders                                         | 7 (7%)          | 3 (3%)   | 1 (1%) |        |        |        | 11 (11%) | 4 (4%)            | 3 (3%) | 4 (4%) | 1 (1%) | 1 (1%) |        | 13 (13%) |
| Skin and subcutaneous tissue disorders                                                  | 2 (2%)          | 1 (1%)   |        | 1 (1%) |        |        | 4 (4%)   | 4 (4%)            | 2 (2%) |        |        |        |        | 6 (6%)   |
| Social circumstances                                                                    | 16 (16%)        | 8 (8%)   | 3 (3%) |        |        |        | 27 (27%) | 11 (11%)          | 4 (4%) | 3 (3%) | 4 (4%) |        |        | 22 (22%) |
| Surgical and medical procedures                                                         | 6 (6%)          | 5 (5%)   | 2 (2%) |        |        |        | 13 (13%) | 7 (7%)            | 5 (5%) | 2 (2%) | 1 (1%) |        |        | 15 (15%) |
| Vascular disorders                                                                      | 6 (6%)          | 1 (1%)   |        |        |        |        | 7 (7%)   | 4 (4%)            | 2 (2%) | 1 (1%) | 2 (2%) |        |        | 9 (9%)   |
| No Declared AE                                                                          |                 |          |        |        |        | 3 (3%) | 3 (3%)   |                   |        |        |        |        | 5 (5%) | 5 (5%)   |
| In the header, N represents the number of patients.                                     |                 |          |        |        |        |        |          |                   |        |        |        |        |        |          |
| Percentages reflect the proportion of patients whose maximum AE grade was as indicated. |                 |          |        |        |        |        |          |                   |        |        |        |        |        |          |

### `AE_SOC6` : Table des soc et termes tous grades confondus stratifiée sur le bras

``` r
ae_table_soc(df_ae=ae, df_enrol=enrolres, arm="arm", term="aeterm", 
             sort_by_count=FALSE) %>% 
  as_flextable() %>% 
  add_footer_lines("In the header, N represents the number of patients.") %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum AE grade was as indicated.")
```

|                                                                                         |                                                      | Control (N=100) |        |        |        |        |        |          | Treatment (N=100) |        |        |        |        |        |        |
|-----------------------------------------------------------------------------------------|------------------------------------------------------|-----------------|--------|--------|--------|--------|--------|----------|-------------------|--------|--------|--------|--------|--------|--------|
| CTCAE SOC                                                                               | CTCAE v4.0 Term                                      | G1              | G2     | G3     | G4     | G5     | NA     | Tot      | G1                | G2     | G3     | G4     | G5     | NA     | Tot    |
| Blood and lymphatic system disorders                                                    | Bone marrow disorders                                |                 |        |        | 1 (1%) |        |        | 1 (1%)   |                   |        |        |        |        |        |        |
|                                                                                         | Coagulation and bleeding analyses                    |                 |        | 1 (1%) |        |        |        | 1 (1%)   |                   |        |        |        |        |        |        |
|                                                                                         | Hematologic neoplasms                                |                 |        |        |        |        |        |          |                   |        | 1 (1%) |        |        |        | 1 (1%) |
|                                                                                         | Red blood cell disorders                             |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 3 (3%)            | 2 (2%) | 1 (1%) |        |        |        | 6 (6%) |
| Cardiac disorders                                                                       | Cardiac arrhythmias                                  | 2 (2%)          | 2 (2%) |        |        |        |        | 4 (4%)   | 3 (3%)            |        | 1 (1%) | 1 (1%) |        |        | 5 (5%) |
|                                                                                         | Cardiac valve disorders                              | 3 (3%)          | 1 (1%) | 4 (4%) |        |        |        | 8 (8%)   |                   |        | 1 (1%) | 2 (2%) |        |        | 3 (3%) |
|                                                                                         | Coronary artery disorders                            | 1 (1%)          |        |        |        |        |        | 1 (1%)   | 2 (2%)            |        |        | 1 (1%) |        |        | 3 (3%) |
|                                                                                         | Heart failures                                       | 1 (1%)          |        |        |        |        |        | 1 (1%)   | 1 (1%)            | 1 (1%) | 1 (1%) |        |        |        | 3 (3%) |
| Congenital, familial and genetic disorders                                              | Chromosomal abnormalities                            | 2 (2%)          | 2 (2%) | 1 (1%) |        |        |        | 5 (5%)   | 3 (3%)            |        | 1 (1%) | 3 (3%) |        |        | 7 (7%) |
|                                                                                         | Congenital nervous system disorders                  | 4 (4%)          | 2 (2%) |        |        |        |        | 6 (6%)   | 6 (6%)            | 2 (2%) |        |        |        |        | 8 (8%) |
|                                                                                         | Familial hematologic disorders                       | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   | 4 (4%)            | 1 (1%) |        | 1 (1%) |        |        | 6 (6%) |
|                                                                                         | Hereditary connective tissue disorders               | 6 (6%)          | 2 (2%) | 1 (1%) | 1 (1%) |        |        | 10 (10%) | 2 (2%)            |        | 1 (1%) |        |        |        | 3 (3%) |
| Ear and labyrinth disorders                                                             | Hearing disorders                                    |                 |        |        |        |        |        |          | 2 (2%)            | 1 (1%) | 1 (1%) |        |        |        | 4 (4%) |
|                                                                                         | Labyrinth disorders                                  | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   |                   | 1 (1%) | 1 (1%) |        |        |        | 2 (2%) |
|                                                                                         | Tinnitus                                             | 2 (2%)          |        | 2 (2%) |        |        |        | 4 (4%)   |                   | 2 (2%) |        |        |        |        | 2 (2%) |
|                                                                                         | Vertigo and balance disorders                        | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   | 1 (1%)            | 1 (1%) |        |        |        |        | 2 (2%) |
| Endocrine disorders                                                                     | Adrenal gland disorders                              | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Parathyroid gland disorders                          | 3 (3%)          |        |        |        |        |        | 3 (3%)   |                   |        |        |        |        |        |        |
|                                                                                         | Pituitary gland disorders                            | 3 (3%)          |        |        |        |        |        | 3 (3%)   | 1 (1%)            | 1 (1%) |        |        |        |        | 2 (2%) |
|                                                                                         | Thyroid gland disorders                              | 2 (2%)          |        | 1 (1%) | 1 (1%) |        |        | 4 (4%)   |                   | 1 (1%) | 1 (1%) |        |        |        | 2 (2%) |
| Eye disorders                                                                           | Corneal disorders                                    | 7 (7%)          | 2 (2%) |        |        |        |        | 9 (9%)   | 1 (1%)            | 1 (1%) | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Eyelid disorders                                     | 3 (3%)          | 1 (1%) | 1 (1%) |        |        |        | 5 (5%)   | 2 (2%)            | 2 (2%) | 1 (1%) |        |        |        | 5 (5%) |
|                                                                                         | Retinal disorders                                    | 4 (4%)          | 6 (6%) | 3 (3%) | 2 (2%) |        |        | 15 (15%) | 2 (2%)            |        | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Vision disorders                                     | 4 (4%)          | 2 (2%) |        |        |        |        | 6 (6%)   | 2 (2%)            | 2 (2%) | 2 (2%) | 1 (1%) |        |        | 7 (7%) |
| Gastrointestinal disorders                                                              | Esophageal disorders                                 | 1 (1%)          |        |        | 1 (1%) |        |        | 2 (2%)   |                   |        |        |        |        |        |        |
|                                                                                         | Gastric disorders                                    | 1 (1%)          |        |        |        |        |        | 1 (1%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Intestinal disorders                                 |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 2 (2%)            |        |        |        |        |        | 2 (2%) |
| General disorders and administration site conditions                                    | General physical health deterioration                |                 | 2 (2%) |        |        |        |        | 2 (2%)   |                   | 1 (1%) |        |        |        |        | 1 (1%) |
|                                                                                         | Injection site reactions                             |                 | 1 (1%) | 2 (2%) |        |        |        | 3 (3%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Pain and discomfort                                  |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
| Hepatobiliary disorders                                                                 | Bile duct disorders                                  | 2 (2%)          | 2 (2%) |        | 1 (1%) |        |        | 5 (5%)   | 2 (2%)            | 2 (2%) |        |        |        |        | 4 (4%) |
|                                                                                         | Gallbladder disorders                                | 2 (2%)          |        |        | 1 (1%) |        |        | 3 (3%)   | 2 (2%)            | 1 (1%) |        |        |        |        | 3 (3%) |
|                                                                                         | Hepatic failure                                      | 4 (4%)          |        |        |        |        |        | 4 (4%)   | 1 (1%)            | 2 (2%) |        |        |        |        | 3 (3%) |
|                                                                                         | Liver disorders                                      | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   | 5 (5%)            |        | 1 (1%) |        |        |        | 6 (6%) |
| Immune system disorders                                                                 | Autoimmune disorders                                 | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            | 1 (1%) | 1 (1%) | 1 (1%) |        |        | 4 (4%) |
|                                                                                         | Hypersensitivity conditions                          | 5 (5%)          | 2 (2%) | 2 (2%) | 1 (1%) |        |        | 10 (10%) | 2 (2%)            | 2 (2%) |        |        |        |        | 4 (4%) |
|                                                                                         | Immunodeficiency                                     |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 2 (2%)            | 1 (1%) | 2 (2%) |        |        |        | 5 (5%) |
|                                                                                         | Inflammatory responses                               | 1 (1%)          | 1 (1%) | 2 (2%) | 1 (1%) |        |        | 5 (5%)   | 3 (3%)            | 3 (3%) |        |        |        |        | 6 (6%) |
| Infections and infestations                                                             | Bacterial infectious disorders                       | 2 (2%)          |        |        |        |        |        | 2 (2%)   |                   |        |        |        |        |        |        |
|                                                                                         | Fungal infectious disorders                          | 1 (1%)          |        |        |        |        |        | 1 (1%)   |                   |        |        |        | 1 (1%) |        | 1 (1%) |
|                                                                                         | Parasitic infectious disorders                       | 3 (3%)          | 2 (2%) |        |        |        |        | 5 (5%)   | 2 (2%)            |        | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Viral infectious disorders                           | 3 (3%)          | 1 (1%) |        |        |        |        | 4 (4%)   |                   |        |        |        |        |        |        |
| Injury, poisoning and procedural complications                                          | Poisonings                                           | 4 (4%)          | 2 (2%) |        |        |        |        | 6 (6%)   |                   | 2 (2%) | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Procedural complications                             | 7 (7%)          | 1 (1%) | 1 (1%) |        |        |        | 9 (9%)   | 5 (5%)            |        | 1 (1%) | 1 (1%) |        |        | 7 (7%) |
|                                                                                         | Radiation-related toxicities                         | 2 (2%)          | 2 (2%) |        | 1 (1%) |        |        | 5 (5%)   |                   | 2 (2%) |        |        |        |        | 2 (2%) |
|                                                                                         | Traumatic injuries                                   | 1 (1%)          | 3 (3%) |        |        |        |        | 4 (4%)   | 2 (2%)            | 1 (1%) |        |        |        |        | 3 (3%) |
| Investigations                                                                          | Blood analyses                                       | 2 (2%)          |        | 1 (1%) |        |        |        | 3 (3%)   |                   |        |        |        |        |        |        |
|                                                                                         | Cardiovascular assessments                           | 1 (1%)          |        |        |        |        |        | 1 (1%)   | 1 (1%)            |        | 1 (1%) |        |        |        | 2 (2%) |
|                                                                                         | Imaging studies                                      |                 | 1 (1%) |        |        |        |        | 1 (1%)   |                   |        | 1 (1%) |        |        |        | 1 (1%) |
|                                                                                         | Liver function analyses                              | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
| Metabolism and nutrition disorders                                                      | Fluid and electrolyte disorders                      |                 |        |        |        |        |        |          | 2 (2%)            |        |        |        |        |        | 2 (2%) |
|                                                                                         | Lipid metabolism disorders                           | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Nutritional disorders                                | 2 (2%)          |        |        |        |        |        | 2 (2%)   |                   | 1 (1%) |        |        |        |        | 1 (1%) |
|                                                                                         | Vitamin deficiencies                                 |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 2 (2%)            |        |        |        |        |        | 2 (2%) |
| Musculoskeletal and connective tissue disorders                                         | Arthritis and joint disorders                        |                 | 2 (2%) |        |        | 1 (1%) |        | 3 (3%)   |                   |        |        |        |        |        |        |
|                                                                                         | Bone disorders                                       |                 |        | 1 (1%) |        | 1 (1%) |        | 2 (2%)   |                   | 1 (1%) | 1 (1%) |        |        |        | 2 (2%) |
|                                                                                         | Connective tissue disorders                          | 2 (2%)          |        | 1 (1%) | 1 (1%) |        |        | 4 (4%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Muscle disorders                                     | 2 (2%)          |        |        |        |        |        | 2 (2%)   |                   |        | 1 (1%) |        |        |        | 1 (1%) |
| Neoplasms benign, malignant, and unspecified                                            | Benign neoplasms                                     | 2 (2%)          | 5 (5%) | 1 (1%) | 1 (1%) |        |        | 9 (9%)   | 2 (2%)            | 2 (2%) |        |        |        |        | 4 (4%) |
|                                                                                         | Malignant neoplasms                                  |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 2 (2%)            |        |        |        |        |        | 2 (2%) |
|                                                                                         | Neoplasms unspecified                                | 1 (1%)          |        | 2 (2%) |        |        |        | 3 (3%)   |                   | 2 (2%) |        |        |        |        | 2 (2%) |
|                                                                                         | Tumor progression                                    | 3 (3%)          | 2 (2%) |        |        |        |        | 5 (5%)   | 2 (2%)            | 1 (1%) | 1 (1%) | 1 (1%) |        |        | 5 (5%) |
| Nervous system disorders                                                                | Headache disorders                                   | 3 (3%)          |        |        |        |        |        | 3 (3%)   |                   | 1 (1%) |        | 1 (1%) |        |        | 2 (2%) |
|                                                                                         | Neurological disorders of the central nervous system |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 1 (1%)            | 1 (1%) |        |        |        |        | 2 (2%) |
|                                                                                         | Peripheral neuropathies                              |                 | 1 (1%) |        |        |        |        | 1 (1%)   |                   | 1 (1%) |        |        |        |        | 1 (1%) |
|                                                                                         | Seizure disorders                                    |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 2 (2%)            |        |        |        |        |        | 2 (2%) |
| Pregnancy, puerperium and perinatal conditions                                          | Breastfeeding issues                                 | 3 (3%)          | 2 (2%) |        |        |        |        | 5 (5%)   |                   |        |        |        |        |        |        |
|                                                                                         | Fetal complications                                  | 1 (1%)          | 2 (2%) |        | 1 (1%) |        |        | 4 (4%)   | 1 (1%)            | 5 (5%) | 1 (1%) | 1 (1%) |        |        | 8 (8%) |
|                                                                                         | Labor and delivery complications                     | 3 (3%)          | 1 (1%) | 2 (2%) | 1 (1%) |        |        | 7 (7%)   | 3 (3%)            |        |        |        |        |        | 3 (3%) |
|                                                                                         | Pregnancy complications                              |                 |        |        |        |        |        |          | 4 (4%)            | 2 (2%) | 1 (1%) |        |        |        | 7 (7%) |
| Psychiatric disorders                                                                   | Anxiety disorders                                    | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   | 1 (1%)            | 1 (1%) | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Mood disorders                                       |                 |        | 1 (1%) |        |        |        | 1 (1%)   | 2 (2%)            |        | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Sleep disorders                                      | 1 (1%)          |        |        |        |        |        | 1 (1%)   | 3 (3%)            |        |        | 1 (1%) |        |        | 4 (4%) |
|                                                                                         | Substance-related disorders                          | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
| Renal and urinary disorders                                                             | Bladder disorders                                    |                 |        |        |        |        |        |          |                   |        |        | 1 (1%) |        |        | 1 (1%) |
|                                                                                         | Kidney disorders                                     | 2 (2%)          |        |        |        |        |        | 2 (2%)   |                   |        |        |        |        |        |        |
|                                                                                         | Urethral disorders                                   |                 |        | 1 (1%) |        |        |        | 1 (1%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Urinary tract disorders                              | 1 (1%)          |        |        |        |        |        | 1 (1%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
| Reproductive system and breast disorders                                                | Breast disorders                                     |                 |        |        |        |        |        |          |                   |        | 1 (1%) |        |        |        | 1 (1%) |
|                                                                                         | Female reproductive disorders                        |                 |        | 1 (1%) |        |        |        | 1 (1%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Male reproductive disorders                          | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   |                   | 1 (1%) |        |        |        |        | 1 (1%) |
|                                                                                         | Menstrual disorders                                  |                 |        |        |        |        |        |          | 1 (1%)            |        |        |        |        |        | 1 (1%) |
| Respiratory, thoracic and mediastinal disorders                                         | Lung function disorders                              | 2 (2%)          | 1 (1%) |        |        |        |        | 3 (3%)   |                   | 1 (1%) | 3 (3%) |        |        |        | 4 (4%) |
|                                                                                         | Pleural disorders                                    | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            |        | 1 (1%) |        | 1 (1%) |        | 3 (3%) |
|                                                                                         | Pulmonary vascular disorders                         | 2 (2%)          | 1 (1%) |        |        |        |        | 3 (3%)   | 3 (3%)            |        |        | 1 (1%) |        |        | 4 (4%) |
|                                                                                         | Respiratory infections                               | 2 (2%)          | 1 (1%) | 1 (1%) |        |        |        | 4 (4%)   |                   | 2 (2%) | 1 (1%) |        |        |        | 3 (3%) |
| Skin and subcutaneous tissue disorders                                                  | Dermatitis                                           | 2 (2%)          | 1 (1%) |        |        |        |        | 3 (3%)   |                   |        |        |        |        |        |        |
|                                                                                         | Skin and subcutaneous tissue injuries                |                 |        |        |        |        |        |          | 1 (1%)            | 1 (1%) |        |        |        |        | 2 (2%) |
|                                                                                         | Skin infections                                      |                 |        |        |        |        |        |          | 2 (2%)            |        |        |        |        |        | 2 (2%) |
|                                                                                         | Skin pigmentation disorders                          |                 |        |        | 1 (1%) |        |        | 1 (1%)   | 1 (1%)            | 1 (1%) |        |        |        |        | 2 (2%) |
| Social circumstances                                                                    | Cultural issues                                      | 7 (7%)          | 2 (2%) | 2 (2%) |        |        |        | 11 (11%) | 4 (4%)            | 1 (1%) | 1 (1%) | 2 (2%) |        |        | 8 (8%) |
|                                                                                         | Economic conditions affecting care                   |                 | 3 (3%) |        |        |        |        | 3 (3%)   | 2 (2%)            | 1 (1%) |        | 1 (1%) |        |        | 4 (4%) |
|                                                                                         | Family support issues                                | 9 (9%)          | 3 (3%) |        |        |        |        | 12 (12%) | 5 (5%)            | 1 (1%) | 2 (2%) |        |        |        | 8 (8%) |
|                                                                                         | Social and environmental issues                      | 2 (2%)          | 1 (1%) | 1 (1%) |        |        |        | 4 (4%)   | 5 (5%)            | 1 (1%) | 1 (1%) | 1 (1%) |        |        | 8 (8%) |
| Surgical and medical procedures                                                         | Device implantation procedures                       | 2 (2%)          |        | 1 (1%) |        |        |        | 3 (3%)   | 3 (3%)            | 1 (1%) |        |        |        |        | 4 (4%) |
|                                                                                         | Diagnostic procedures                                | 3 (3%)          | 1 (1%) | 1 (1%) |        |        |        | 5 (5%)   |                   | 2 (2%) |        |        |        |        | 2 (2%) |
|                                                                                         | Surgical complications                               | 1 (1%)          | 3 (3%) |        |        |        |        | 4 (4%)   | 2 (2%)            |        | 2 (2%) |        |        |        | 4 (4%) |
|                                                                                         | Therapeutic procedures                               | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   | 2 (2%)            | 2 (2%) | 1 (1%) | 1 (1%) |        |        | 6 (6%) |
| Vascular disorders                                                                      | Hypertension-related conditions                      |                 |        |        |        |        |        |          |                   | 2 (2%) | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Hypotension-related conditions                       | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Vascular hemorrhagic disorders                       | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 3 (3%)            |        |        | 1 (1%) |        |        | 4 (4%) |
|                                                                                         | Venous thromboembolic events                         | 2 (2%)          | 1 (1%) |        |        |        |        | 3 (3%)   |                   |        |        | 1 (1%) |        |        | 1 (1%) |
| No Declared AE                                                                          |                                                      |                 |        |        |        |        | 3 (3%) | 3 (3%)   |                   |        |        |        |        | 5 (5%) | 5 (5%) |
| In the header, N represents the number of patients.                                     |                                                      |                 |        |        |        |        |        |          |                   |        |        |        |        |        |        |
| Percentages reflect the proportion of patients whose maximum AE grade was as indicated. |                                                      |                 |        |        |        |        |        |          |                   |        |        |        |        |        |        |
