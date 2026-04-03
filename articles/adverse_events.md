# Adverse Events (AE)

## Introduction

This tutorial demonstrates how to generate adverse event (AE) summary
tables in R using the `grstat` package. AE tables are a standard tool in
clinical research for evaluating the severity (grade) of events and
identifying specific AE terms.

In this tutorial, it is demonstrated how to use two key functions:

- [`ae_table_grade()`](https://oncostat.github.io/grstat/reference/ae_table_grade.md),
  which creates table(s) summarising AE grades overall.

- [`ae_table_soc()`](https://oncostat.github.io/grstat/reference/ae_table_soc.md),
  which summarises adverse events by System Organ Class (SOC) and by
  grades. It reports the number and proportion of patients experiencing
  at least one event within each SOC, based on their maximum recorded AE
  grade.

Additional features are available via the
[`help()`](https://rdrr.io/r/utils/help.html) function.

First, install packages if needed and load them.

``` r
library(grstat)
library(flextable)
library(dplyr)
```

## Data Overview

The function
[`grstat_example()`](https://oncostat.github.io/grstat/reference/grstat_example.md)returns
a set of example datasets used to demonstrate data usage.

This analysis focuses on two datasets:

- `ae`, which contains data on adverse events.
- `enrolres`, which includes all patients and their respective treatment
  arms.

The AE table provides one row for each adverse event reported for a
patient, capturing key details such as the event term, its grade, the
associated System Organ Class, whether it is related to the study
treatment, and whether it meets the criteria for a serious adverse
event. A single patient may therefore appear multiple times if they
experience several events, while those with no adverse events do not
appear in the table at all.

``` r
tm = grstat_example()
attach(tm)

head(ae, 4)
```

    ## # A tibble: 4 × 7
    ##   subjid aesoc                                  aeterm  aegr sae   aerel crfname
    ##    <int> <chr>                                  <chr>  <dbl> <fct> <chr> <chr>  
    ## 1      1 Psychiatric disorders                  Subst…     1 No    Stan… ae     
    ## 2      1 Social circumstances                   Cultu…     1 No    Expe… ae     
    ## 3      1 Pregnancy, puerperium and perinatal c… Fetal…     2 Yes   Canc… ae     
    ## 4      1 Eye disorders                          Visio…     1 No    Radi… ae

``` r
head(enrolres,4)
```

    ## # A tibble: 4 × 5
    ##   subjid arm       arm3        date_inclusion crfname 
    ##    <int> <fct>     <fct>       <date>         <chr>   
    ## 1      1 Control   Treatment B 2023-01-22     enrolres
    ## 2      2 Control   Control     2023-03-12     enrolres
    ## 3      3 Treatment Treatment A 2023-03-30     enrolres
    ## 4      4 Control   Control     2023-04-03     enrolres

## Grade Tables only: `ae_table_grade()`

Create adverse event (AE) grade tables using
[`ae_table_grade()`](https://oncostat.github.io/grstat/reference/ae_table_grade.md).

The function `ae_table_grade` produces AE grade table summaries based on
the variant argument, which can take three different values (“max”,
“sup”, “eq”) and determines the type of summary applied to AE grades.
When variant = NULL (or not specified), all three summary types are
returned in a single output by default.

- The summary type, **`variant = "max"`**, generates a table showing the
  maximum AE grade per patient, where N is the total number of patients
  in the study.

- **`variant = "sup"`**, summarises the grades greater than or equal to
  a specified grade per patient, where n is the number of patients
  having experienced at least one AE of grade ≥ X, where X ∈ {1, 2, 3,
  4, 5}.

- **`variant = "eq"`**, presents all grades for all patients. In this
  table, each proportion represents the number of patients who
  experienced a given grade at least once, where n is the number of
  patients having experienced at least one AE of grade equal to X, where
  X ∈ {1, 2, 3, 4, 5}.

### Default AE Table Grades - incuding All Variants (Max, Sup, Eq)

``` r
ae_table_grade(df_ae=ae, df_enrol=enrolres) %>% 
  as_flextable(header_show_n=TRUE) %>% 
  fontsize(size = 8, part = "all") %>% 
  padding(padding.top=0, padding.bottom=0)
```

| label                                 | variable       | Treatment arm        |
|---------------------------------------|----------------|----------------------|
|                                       |                | All patients (N=200) |
| Patient maximum AE grade              | No declared AE | 8 (4%)               |
|                                       | Grade 1        | 38 (19%)             |
|                                       | Grade 2        | 62 (31%)             |
|                                       | Grade 3        | 54 (27%)             |
|                                       | Grade 4        | 34 (17%)             |
|                                       | Grade 5        | 4 (2%)               |
| Patient had at least one AE of grade  | No declared AE | 8 (4%)               |
|                                       | Grade ≥ 1      | 192 (96%)            |
|                                       | Grade ≥ 2      | 154 (77%)            |
|                                       | Grade ≥ 3      | 92 (46%)             |
|                                       | Grade ≥ 4      | 38 (19%)             |
|                                       | Grade = 5      | 4 (2%)               |
| Patient had at least one AE of grade  | No declared AE | 8 (4%)               |
|                                       | Grade 1        | 164 (82%)            |
|                                       | Grade 2        | 110 (55%)            |
|                                       | Grade 3        | 62 (31%)             |
|                                       | Grade 4        | 36 (18%)             |
|                                       | Grade 5        | 4 (2%)               |

### Custom table of maximum AE grade per patient per arm

As an extra example of AE grade table, a table of maximum grade per
patient and per arm (i.e. variant = “max”) is also presented.

``` r
ae_table_grade(df_ae=ae, df_enrol=enrolres, arm="arm", variant="max") %>% 
  as_flextable(header_show_n=TRUE) %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum AE grade was as indicated per given arm.") %>% 
  fontsize(size = 8, part = "all") %>% 
  padding(padding.top=0, padding.bottom=0)
```

| label                                                                                                 | variable       | Treatment arm   |                   | Total    |
|-------------------------------------------------------------------------------------------------------|----------------|-----------------|-------------------|----------|
|                                                                                                       |                | Control (N=100) | Treatment (N=100) |          |
| Patient maximum AE grade                                                                              | No declared AE | 3 (3%)          | 5 (5%)            | 8 (4%)   |
|                                                                                                       | Grade 1        | 23 (23%)        | 15 (15%)          | 38 (19%) |
|                                                                                                       | Grade 2        | 32 (32%)        | 30 (30%)          | 62 (31%) |
|                                                                                                       | Grade 3        | 27 (27%)        | 27 (27%)          | 54 (27%) |
|                                                                                                       | Grade 4        | 13 (13%)        | 21 (21%)          | 34 (17%) |
|                                                                                                       | Grade 5        | 2 (2%)          | 2 (2%)            | 4 (2%)   |
| Percentages reflect the proportion of patients whose maximum AE grade was as indicated per given arm. |                |                 |                   |          |

## SOC’s tables: `ae_table_soc()`

The function ae_table_soc() creates a summary table of AE grades for
each patient according to AE term and SOC Common Terminology Criteria
for Adverse Events. (CTCAE). The resulting dataframe can be piped to
as_flextable() to get a nicely formatted flextable.

### Table of AE grades by SOC

This table summarises the distribution of adverse event grades by System
Organ Class (SOC). You can add total = FALSE to remove the “Total”
column.

``` r
ae_table_soc(df_ae=ae, df_enrol=enrolres, arm=NULL, term=NULL, 
             sort_by_count=FALSE) %>% 
  head(10) %>% 
  as_flextable() %>% 
  add_footer_lines("In the header, N represents the number of patients.") %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum AE grade was as indicated.") 
```

|                                                                                         | All patients (N=200) |         |        |        |     |     |          |
|-----------------------------------------------------------------------------------------|----------------------|---------|--------|--------|-----|-----|----------|
| CTCAE SOC                                                                               | G1                   | G2      | G3     | G4     | G5  | NA  | Tot      |
| Blood and lymphatic system disorders                                                    | 3 (2%)               | 3 (2%)  | 3 (2%) | 1 (0%) |     |     | 10 (5%)  |
| Cardiac disorders                                                                       | 11 (6%)              | 4 (2%)  | 7 (4%) | 4 (2%) |     |     | 26 (13%) |
| Congenital, familial and genetic disorders                                              | 23 (12%)             | 10 (5%) | 4 (2%) | 5 (2%) |     |     | 42 (21%) |
| Ear and labyrinth disorders                                                             | 7 (4%)               | 7 (4%)  | 4 (2%) |        |     |     | 18 (9%)  |
| Endocrine disorders                                                                     | 11 (6%)              | 2 (1%)  | 2 (1%) | 1 (0%) |     |     | 16 (8%)  |
| Eye disorders                                                                           | 21 (10%)             | 16 (8%) | 9 (4%) | 3 (2%) |     |     | 49 (24%) |
| Gastrointestinal disorders                                                              | 5 (2%)               | 1 (0%)  |        | 1 (0%) |     |     | 7 (4%)   |
| General disorders and administration site conditions                                    | 2 (1%)               | 5 (2%)  | 2 (1%) |        |     |     | 9 (4%)   |
| Hepatobiliary disorders                                                                 | 17 (8%)              | 8 (4%)  | 1 (0%) | 2 (1%) |     |     | 28 (14%) |
| Immune system disorders                                                                 | 15 (8%)              | 9 (4%)  | 7 (4%) | 3 (2%) |     |     | 34 (17%) |
| In the header, N represents the number of patients.                                     |                      |         |        |        |     |     |          |
| Percentages reflect the proportion of patients whose maximum AE grade was as indicated. |                      |         |        |        |     |     |          |

### Table of SOC and AE terms, all grades combined, stratified by arm

Presents SOC and Preferred Term frequencies with all AE grades combined,
stratified by treatment arm. Provides an overall summary of event
occurrence per arm, regardless of grade.

``` r
ae_table_soc(df_ae=ae, df_enrol=enrolres, arm="arm", term="aeterm", 
             sort_by_count=FALSE) %>%
  head(10) %>% 
  as_flextable() %>% 
  add_footer_lines("In the header, N represents the number of patients.") %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum AE grade was as indicated.")
```

|                                                                                         |                                     | Control (N=100) |        |        |        |     |     |        | Treatment (N=100) |        |        |        |     |     |        |
|-----------------------------------------------------------------------------------------|-------------------------------------|-----------------|--------|--------|--------|-----|-----|--------|-------------------|--------|--------|--------|-----|-----|--------|
| CTCAE SOC                                                                               | CTCAE v4.0 Term                     | G1              | G2     | G3     | G4     | G5  | NA  | Tot    | G1                | G2     | G3     | G4     | G5  | NA  | Tot    |
| Blood and lymphatic system disorders                                                    | Bone marrow disorders               |                 |        |        | 1 (1%) |     |     | 1 (1%) |                   |        |        |        |     |     |        |
|                                                                                         | Coagulation and bleeding analyses   |                 |        | 1 (1%) |        |     |     | 1 (1%) |                   |        |        |        |     |     |        |
|                                                                                         | Hematologic neoplasms               |                 |        |        |        |     |     |        |                   |        | 1 (1%) |        |     |     | 1 (1%) |
|                                                                                         | Red blood cell disorders            |                 | 1 (1%) |        |        |     |     | 1 (1%) | 3 (3%)            | 2 (2%) | 1 (1%) |        |     |     | 6 (6%) |
| Cardiac disorders                                                                       | Cardiac arrhythmias                 | 2 (2%)          | 2 (2%) |        |        |     |     | 4 (4%) | 3 (3%)            |        | 1 (1%) | 1 (1%) |     |     | 5 (5%) |
|                                                                                         | Cardiac valve disorders             | 3 (3%)          | 1 (1%) | 4 (4%) |        |     |     | 8 (8%) |                   |        | 1 (1%) | 2 (2%) |     |     | 3 (3%) |
|                                                                                         | Coronary artery disorders           | 1 (1%)          |        |        |        |     |     | 1 (1%) | 2 (2%)            |        |        | 1 (1%) |     |     | 3 (3%) |
|                                                                                         | Heart failures                      | 1 (1%)          |        |        |        |     |     | 1 (1%) | 1 (1%)            | 1 (1%) | 1 (1%) |        |     |     | 3 (3%) |
| Congenital, familial and genetic disorders                                              | Chromosomal abnormalities           | 2 (2%)          | 2 (2%) | 1 (1%) |        |     |     | 5 (5%) | 3 (3%)            |        | 1 (1%) | 3 (3%) |     |     | 7 (7%) |
|                                                                                         | Congenital nervous system disorders | 4 (4%)          | 2 (2%) |        |        |     |     | 6 (6%) | 6 (6%)            | 2 (2%) |        |        |     |     | 8 (8%) |
| In the header, N represents the number of patients.                                     |                                     |                 |        |        |        |     |     |        |                   |        |        |        |     |     |        |
| Percentages reflect the proportion of patients whose maximum AE grade was as indicated. |                                     |                 |        |        |        |     |     |        |                   |        |        |        |     |     |        |

**Using sort_by_count=TRUE**

``` r
ae_table_soc(df_ae=ae, df_enrol=enrolres, arm="arm", term="aeterm", 
             sort_by_count=TRUE) %>%
  as_flextable() %>% 
  add_footer_lines("In the header, N represents the number of patients.") %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum AE grade was as indicated.")
```

|                                                                                         |                                                      | Control (N=100) |        |        |        |        |        |          | Treatment (N=100) |        |        |        |        |        |        |
|-----------------------------------------------------------------------------------------|------------------------------------------------------|-----------------|--------|--------|--------|--------|--------|----------|-------------------|--------|--------|--------|--------|--------|--------|
| CTCAE SOC                                                                               | CTCAE v4.0 Term                                      | G1              | G2     | G3     | G4     | G5     | NA     | Tot      | G1                | G2     | G3     | G4     | G5     | NA     | Tot    |
| Social circumstances                                                                    | Cultural issues                                      | 7 (7%)          | 2 (2%) | 2 (2%) |        |        |        | 11 (11%) | 4 (4%)            | 1 (1%) | 1 (1%) | 2 (2%) |        |        | 8 (8%) |
|                                                                                         | Economic conditions affecting care                   |                 | 3 (3%) |        |        |        |        | 3 (3%)   | 2 (2%)            | 1 (1%) |        | 1 (1%) |        |        | 4 (4%) |
|                                                                                         | Family support issues                                | 9 (9%)          | 3 (3%) |        |        |        |        | 12 (12%) | 5 (5%)            | 1 (1%) | 2 (2%) |        |        |        | 8 (8%) |
|                                                                                         | Social and environmental issues                      | 2 (2%)          | 1 (1%) | 1 (1%) |        |        |        | 4 (4%)   | 5 (5%)            | 1 (1%) | 1 (1%) | 1 (1%) |        |        | 8 (8%) |
| Eye disorders                                                                           | Corneal disorders                                    | 7 (7%)          | 2 (2%) |        |        |        |        | 9 (9%)   | 1 (1%)            | 1 (1%) | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Eyelid disorders                                     | 3 (3%)          | 1 (1%) | 1 (1%) |        |        |        | 5 (5%)   | 2 (2%)            | 2 (2%) | 1 (1%) |        |        |        | 5 (5%) |
|                                                                                         | Retinal disorders                                    | 4 (4%)          | 6 (6%) | 3 (3%) | 2 (2%) |        |        | 15 (15%) | 2 (2%)            |        | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Vision disorders                                     | 4 (4%)          | 2 (2%) |        |        |        |        | 6 (6%)   | 2 (2%)            | 2 (2%) | 2 (2%) | 1 (1%) |        |        | 7 (7%) |
| Congenital, familial and genetic disorders                                              | Chromosomal abnormalities                            | 2 (2%)          | 2 (2%) | 1 (1%) |        |        |        | 5 (5%)   | 3 (3%)            |        | 1 (1%) | 3 (3%) |        |        | 7 (7%) |
|                                                                                         | Congenital nervous system disorders                  | 4 (4%)          | 2 (2%) |        |        |        |        | 6 (6%)   | 6 (6%)            | 2 (2%) |        |        |        |        | 8 (8%) |
|                                                                                         | Familial hematologic disorders                       | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   | 4 (4%)            | 1 (1%) |        | 1 (1%) |        |        | 6 (6%) |
|                                                                                         | Hereditary connective tissue disorders               | 6 (6%)          | 2 (2%) | 1 (1%) | 1 (1%) |        |        | 10 (10%) | 2 (2%)            |        | 1 (1%) |        |        |        | 3 (3%) |
| Injury, poisoning and procedural complications                                          | Poisonings                                           | 4 (4%)          | 2 (2%) |        |        |        |        | 6 (6%)   |                   | 2 (2%) | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Procedural complications                             | 7 (7%)          | 1 (1%) | 1 (1%) |        |        |        | 9 (9%)   | 5 (5%)            |        | 1 (1%) | 1 (1%) |        |        | 7 (7%) |
|                                                                                         | Radiation-related toxicities                         | 2 (2%)          | 2 (2%) |        | 1 (1%) |        |        | 5 (5%)   |                   | 2 (2%) |        |        |        |        | 2 (2%) |
|                                                                                         | Traumatic injuries                                   | 1 (1%)          | 3 (3%) |        |        |        |        | 4 (4%)   | 2 (2%)            | 1 (1%) |        |        |        |        | 3 (3%) |
| Immune system disorders                                                                 | Autoimmune disorders                                 | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            | 1 (1%) | 1 (1%) | 1 (1%) |        |        | 4 (4%) |
|                                                                                         | Hypersensitivity conditions                          | 5 (5%)          | 2 (2%) | 2 (2%) | 1 (1%) |        |        | 10 (10%) | 2 (2%)            | 2 (2%) |        |        |        |        | 4 (4%) |
|                                                                                         | Immunodeficiency                                     |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 2 (2%)            | 1 (1%) | 2 (2%) |        |        |        | 5 (5%) |
|                                                                                         | Inflammatory responses                               | 1 (1%)          | 1 (1%) | 2 (2%) | 1 (1%) |        |        | 5 (5%)   | 3 (3%)            | 3 (3%) |        |        |        |        | 6 (6%) |
| Pregnancy, puerperium and perinatal conditions                                          | Breastfeeding issues                                 | 3 (3%)          | 2 (2%) |        |        |        |        | 5 (5%)   |                   |        |        |        |        |        |        |
|                                                                                         | Fetal complications                                  | 1 (1%)          | 2 (2%) |        | 1 (1%) |        |        | 4 (4%)   | 1 (1%)            | 5 (5%) | 1 (1%) | 1 (1%) |        |        | 8 (8%) |
|                                                                                         | Labor and delivery complications                     | 3 (3%)          | 1 (1%) | 2 (2%) | 1 (1%) |        |        | 7 (7%)   | 3 (3%)            |        |        |        |        |        | 3 (3%) |
|                                                                                         | Pregnancy complications                              |                 |        |        |        |        |        |          | 4 (4%)            | 2 (2%) | 1 (1%) |        |        |        | 7 (7%) |
| Neoplasms benign, malignant, and unspecified                                            | Benign neoplasms                                     | 2 (2%)          | 5 (5%) | 1 (1%) | 1 (1%) |        |        | 9 (9%)   | 2 (2%)            | 2 (2%) |        |        |        |        | 4 (4%) |
|                                                                                         | Malignant neoplasms                                  |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 2 (2%)            |        |        |        |        |        | 2 (2%) |
|                                                                                         | Neoplasms unspecified                                | 1 (1%)          |        | 2 (2%) |        |        |        | 3 (3%)   |                   | 2 (2%) |        |        |        |        | 2 (2%) |
|                                                                                         | Tumor progression                                    | 3 (3%)          | 2 (2%) |        |        |        |        | 5 (5%)   | 2 (2%)            | 1 (1%) | 1 (1%) | 1 (1%) |        |        | 5 (5%) |
| Hepatobiliary disorders                                                                 | Bile duct disorders                                  | 2 (2%)          | 2 (2%) |        | 1 (1%) |        |        | 5 (5%)   | 2 (2%)            | 2 (2%) |        |        |        |        | 4 (4%) |
|                                                                                         | Gallbladder disorders                                | 2 (2%)          |        |        | 1 (1%) |        |        | 3 (3%)   | 2 (2%)            | 1 (1%) |        |        |        |        | 3 (3%) |
|                                                                                         | Hepatic failure                                      | 4 (4%)          |        |        |        |        |        | 4 (4%)   | 1 (1%)            | 2 (2%) |        |        |        |        | 3 (3%) |
|                                                                                         | Liver disorders                                      | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   | 5 (5%)            |        | 1 (1%) |        |        |        | 6 (6%) |
| Surgical and medical procedures                                                         | Device implantation procedures                       | 2 (2%)          |        | 1 (1%) |        |        |        | 3 (3%)   | 3 (3%)            | 1 (1%) |        |        |        |        | 4 (4%) |
|                                                                                         | Diagnostic procedures                                | 3 (3%)          | 1 (1%) | 1 (1%) |        |        |        | 5 (5%)   |                   | 2 (2%) |        |        |        |        | 2 (2%) |
|                                                                                         | Surgical complications                               | 1 (1%)          | 3 (3%) |        |        |        |        | 4 (4%)   | 2 (2%)            |        | 2 (2%) |        |        |        | 4 (4%) |
|                                                                                         | Therapeutic procedures                               | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   | 2 (2%)            | 2 (2%) | 1 (1%) | 1 (1%) |        |        | 6 (6%) |
| Cardiac disorders                                                                       | Cardiac arrhythmias                                  | 2 (2%)          | 2 (2%) |        |        |        |        | 4 (4%)   | 3 (3%)            |        | 1 (1%) | 1 (1%) |        |        | 5 (5%) |
|                                                                                         | Cardiac valve disorders                              | 3 (3%)          | 1 (1%) | 4 (4%) |        |        |        | 8 (8%)   |                   |        | 1 (1%) | 2 (2%) |        |        | 3 (3%) |
|                                                                                         | Coronary artery disorders                            | 1 (1%)          |        |        |        |        |        | 1 (1%)   | 2 (2%)            |        |        | 1 (1%) |        |        | 3 (3%) |
|                                                                                         | Heart failures                                       | 1 (1%)          |        |        |        |        |        | 1 (1%)   | 1 (1%)            | 1 (1%) | 1 (1%) |        |        |        | 3 (3%) |
| Respiratory, thoracic and mediastinal disorders                                         | Lung function disorders                              | 2 (2%)          | 1 (1%) |        |        |        |        | 3 (3%)   |                   | 1 (1%) | 3 (3%) |        |        |        | 4 (4%) |
|                                                                                         | Pleural disorders                                    | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            |        | 1 (1%) |        | 1 (1%) |        | 3 (3%) |
|                                                                                         | Pulmonary vascular disorders                         | 2 (2%)          | 1 (1%) |        |        |        |        | 3 (3%)   | 3 (3%)            |        |        | 1 (1%) |        |        | 4 (4%) |
|                                                                                         | Respiratory infections                               | 2 (2%)          | 1 (1%) | 1 (1%) |        |        |        | 4 (4%)   |                   | 2 (2%) | 1 (1%) |        |        |        | 3 (3%) |
| Ear and labyrinth disorders                                                             | Hearing disorders                                    |                 |        |        |        |        |        |          | 2 (2%)            | 1 (1%) | 1 (1%) |        |        |        | 4 (4%) |
|                                                                                         | Labyrinth disorders                                  | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   |                   | 1 (1%) | 1 (1%) |        |        |        | 2 (2%) |
|                                                                                         | Tinnitus                                             | 2 (2%)          |        | 2 (2%) |        |        |        | 4 (4%)   |                   | 2 (2%) |        |        |        |        | 2 (2%) |
|                                                                                         | Vertigo and balance disorders                        | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   | 1 (1%)            | 1 (1%) |        |        |        |        | 2 (2%) |
| Endocrine disorders                                                                     | Adrenal gland disorders                              | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Parathyroid gland disorders                          | 3 (3%)          |        |        |        |        |        | 3 (3%)   |                   |        |        |        |        |        |        |
|                                                                                         | Pituitary gland disorders                            | 3 (3%)          |        |        |        |        |        | 3 (3%)   | 1 (1%)            | 1 (1%) |        |        |        |        | 2 (2%) |
|                                                                                         | Thyroid gland disorders                              | 2 (2%)          |        | 1 (1%) | 1 (1%) |        |        | 4 (4%)   |                   | 1 (1%) | 1 (1%) |        |        |        | 2 (2%) |
| Psychiatric disorders                                                                   | Anxiety disorders                                    | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   | 1 (1%)            | 1 (1%) | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Mood disorders                                       |                 |        | 1 (1%) |        |        |        | 1 (1%)   | 2 (2%)            |        | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Sleep disorders                                      | 1 (1%)          |        |        |        |        |        | 1 (1%)   | 3 (3%)            |        |        | 1 (1%) |        |        | 4 (4%) |
|                                                                                         | Substance-related disorders                          | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
| Infections and infestations                                                             | Bacterial infectious disorders                       | 2 (2%)          |        |        |        |        |        | 2 (2%)   |                   |        |        |        |        |        |        |
|                                                                                         | Fungal infectious disorders                          | 1 (1%)          |        |        |        |        |        | 1 (1%)   |                   |        |        |        | 1 (1%) |        | 1 (1%) |
|                                                                                         | Parasitic infectious disorders                       | 3 (3%)          | 2 (2%) |        |        |        |        | 5 (5%)   | 2 (2%)            |        | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Viral infectious disorders                           | 3 (3%)          | 1 (1%) |        |        |        |        | 4 (4%)   |                   |        |        |        |        |        |        |
| Vascular disorders                                                                      | Hypertension-related conditions                      |                 |        |        |        |        |        |          |                   | 2 (2%) | 1 (1%) |        |        |        | 3 (3%) |
|                                                                                         | Hypotension-related conditions                       | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Vascular hemorrhagic disorders                       | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 3 (3%)            |        |        | 1 (1%) |        |        | 4 (4%) |
|                                                                                         | Venous thromboembolic events                         | 2 (2%)          | 1 (1%) |        |        |        |        | 3 (3%)   |                   |        |        | 1 (1%) |        |        | 1 (1%) |
| Musculoskeletal and connective tissue disorders                                         | Arthritis and joint disorders                        |                 | 2 (2%) |        |        | 1 (1%) |        | 3 (3%)   |                   |        |        |        |        |        |        |
|                                                                                         | Bone disorders                                       |                 |        | 1 (1%) |        | 1 (1%) |        | 2 (2%)   |                   | 1 (1%) | 1 (1%) |        |        |        | 2 (2%) |
|                                                                                         | Connective tissue disorders                          | 2 (2%)          |        | 1 (1%) | 1 (1%) |        |        | 4 (4%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Muscle disorders                                     | 2 (2%)          |        |        |        |        |        | 2 (2%)   |                   |        | 1 (1%) |        |        |        | 1 (1%) |
| Nervous system disorders                                                                | Headache disorders                                   | 3 (3%)          |        |        |        |        |        | 3 (3%)   |                   | 1 (1%) |        | 1 (1%) |        |        | 2 (2%) |
|                                                                                         | Neurological disorders of the central nervous system |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 1 (1%)            | 1 (1%) |        |        |        |        | 2 (2%) |
|                                                                                         | Peripheral neuropathies                              |                 | 1 (1%) |        |        |        |        | 1 (1%)   |                   | 1 (1%) |        |        |        |        | 1 (1%) |
|                                                                                         | Seizure disorders                                    |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 2 (2%)            |        |        |        |        |        | 2 (2%) |
| Investigations                                                                          | Blood analyses                                       | 2 (2%)          |        | 1 (1%) |        |        |        | 3 (3%)   |                   |        |        |        |        |        |        |
|                                                                                         | Cardiovascular assessments                           | 1 (1%)          |        |        |        |        |        | 1 (1%)   | 1 (1%)            |        | 1 (1%) |        |        |        | 2 (2%) |
|                                                                                         | Imaging studies                                      |                 | 1 (1%) |        |        |        |        | 1 (1%)   |                   |        | 1 (1%) |        |        |        | 1 (1%) |
|                                                                                         | Liver function analyses                              | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
| Metabolism and nutrition disorders                                                      | Fluid and electrolyte disorders                      |                 |        |        |        |        |        |          | 2 (2%)            |        |        |        |        |        | 2 (2%) |
|                                                                                         | Lipid metabolism disorders                           | 2 (2%)          |        |        |        |        |        | 2 (2%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Nutritional disorders                                | 2 (2%)          |        |        |        |        |        | 2 (2%)   |                   | 1 (1%) |        |        |        |        | 1 (1%) |
|                                                                                         | Vitamin deficiencies                                 |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 2 (2%)            |        |        |        |        |        | 2 (2%) |
| Blood and lymphatic system disorders                                                    | Bone marrow disorders                                |                 |        |        | 1 (1%) |        |        | 1 (1%)   |                   |        |        |        |        |        |        |
|                                                                                         | Coagulation and bleeding analyses                    |                 |        | 1 (1%) |        |        |        | 1 (1%)   |                   |        |        |        |        |        |        |
|                                                                                         | Hematologic neoplasms                                |                 |        |        |        |        |        |          |                   |        | 1 (1%) |        |        |        | 1 (1%) |
|                                                                                         | Red blood cell disorders                             |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 3 (3%)            | 2 (2%) | 1 (1%) |        |        |        | 6 (6%) |
| Skin and subcutaneous tissue disorders                                                  | Dermatitis                                           | 2 (2%)          | 1 (1%) |        |        |        |        | 3 (3%)   |                   |        |        |        |        |        |        |
|                                                                                         | Skin and subcutaneous tissue injuries                |                 |        |        |        |        |        |          | 1 (1%)            | 1 (1%) |        |        |        |        | 2 (2%) |
|                                                                                         | Skin infections                                      |                 |        |        |        |        |        |          | 2 (2%)            |        |        |        |        |        | 2 (2%) |
|                                                                                         | Skin pigmentation disorders                          |                 |        |        | 1 (1%) |        |        | 1 (1%)   | 1 (1%)            | 1 (1%) |        |        |        |        | 2 (2%) |
| General disorders and administration site conditions                                    | General physical health deterioration                |                 | 2 (2%) |        |        |        |        | 2 (2%)   |                   | 1 (1%) |        |        |        |        | 1 (1%) |
|                                                                                         | Injection site reactions                             |                 | 1 (1%) | 2 (2%) |        |        |        | 3 (3%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Pain and discomfort                                  |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
| Gastrointestinal disorders                                                              | Esophageal disorders                                 | 1 (1%)          |        |        | 1 (1%) |        |        | 2 (2%)   |                   |        |        |        |        |        |        |
|                                                                                         | Gastric disorders                                    | 1 (1%)          |        |        |        |        |        | 1 (1%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Intestinal disorders                                 |                 | 1 (1%) |        |        |        |        | 1 (1%)   | 2 (2%)            |        |        |        |        |        | 2 (2%) |
| Renal and urinary disorders                                                             | Bladder disorders                                    |                 |        |        |        |        |        |          |                   |        |        | 1 (1%) |        |        | 1 (1%) |
|                                                                                         | Kidney disorders                                     | 2 (2%)          |        |        |        |        |        | 2 (2%)   |                   |        |        |        |        |        |        |
|                                                                                         | Urethral disorders                                   |                 |        | 1 (1%) |        |        |        | 1 (1%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Urinary tract disorders                              | 1 (1%)          |        |        |        |        |        | 1 (1%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
| Reproductive system and breast disorders                                                | Breast disorders                                     |                 |        |        |        |        |        |          |                   |        | 1 (1%) |        |        |        | 1 (1%) |
|                                                                                         | Female reproductive disorders                        |                 |        | 1 (1%) |        |        |        | 1 (1%)   | 1 (1%)            |        |        |        |        |        | 1 (1%) |
|                                                                                         | Male reproductive disorders                          | 1 (1%)          | 1 (1%) |        |        |        |        | 2 (2%)   |                   | 1 (1%) |        |        |        |        | 1 (1%) |
|                                                                                         | Menstrual disorders                                  |                 |        |        |        |        |        |          | 1 (1%)            |        |        |        |        |        | 1 (1%) |
| No Declared AE                                                                          |                                                      |                 |        |        |        |        | 3 (3%) | 3 (3%)   |                   |        |        |        |        | 5 (5%) | 5 (5%) |
| In the header, N represents the number of patients.                                     |                                                      |                 |        |        |        |        |        |          |                   |        |        |        |        |        |        |
| Percentages reflect the proportion of patients whose maximum AE grade was as indicated. |                                                      |                 |        |        |        |        |        |          |                   |        |        |        |        |        |        |
