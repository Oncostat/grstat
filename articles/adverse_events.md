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

tm = grstat_example(p_na=0.1)
attach(tm, warn.conflicts=FALSE)

head(ae, 4)
```

    ## # A tibble: 4 × 7
    ##   subjid aesoc                                  aeterm  aegr sae   aerel crfname
    ##    <int> <chr>                                  <chr>  <dbl> <fct> <chr> <chr>  
    ## 1      1 Psychiatric disorders                  Subst…     1 No    Stan… ae     
    ## 2      1 Social circumstances                   Cultu…     1 No    Expe… ae     
    ## 3      1 Pregnancy, puerperium and perinatal c… Fetal…     2 Yes   Canc… ae     
    ## 4      1 Eye disorders                          NA         1 No    Radi… ae

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

The function
[`ae_table_grade()`](https://oncostat.github.io/grstat/reference/ae_table_grade.md)
summarises toxicity data at the patient level.

The `measure` argument controls how AE grades are summarised:

- **`measure = "max"`** summarises the worst reported AE grade observed
  for each patient. Rows are mutually exclusive.
- **`measure = "sup"`** summarises cumulative grade thresholds. For
  example, `Grade ≥ 3` counts patients with at least one AE of grade 3,
  4, or 5.
- **`measure = "eq"`** summarises exact-grade occurrence. For example,
  `Grade 3` counts patients with at least one grade 3 AE.

Percentages are calculated using the total number of patients as
denominator.

By default, all three summaries are returned in a single table. To
return only one summary, specify the corresponding `measure` value.

Use
[`as_flextable()`](https://davidgohel.github.io/flextable/reference/as_flextable.html)
to format the output as a `flextable` and add footnotes or other
formatting as needed.

Use cases are described below. See
[`help(ae_table_grade)`](https://oncostat.github.io/grstat/reference/ae_table_grade.md)
for the full list of arguments and some more examples.

### Default: AE Table Grades - incuding All Variants (Max, Sup, Eq)

``` r

ae_table_grade(data_ae=ae, data_pat=enrolres) %>% 
  as_flextable() %>% 
  fontsize(size = 8, part = "all") %>% 
  padding(padding.top=0, padding.bottom=0)
```

[TABLE]

### Alternative: Maximum AE grade per patient per arm

As an extra example of AE grade table, a table of maximum grade per
patient and per arm (i.e. variant = “max”) is also presented.

``` r

ae_table_grade(data_ae=ae, data_pat=enrolres, arm="arm", variant="max") %>% 
  as_flextable() %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum AE grade was as indicated per given arm.") %>% 
  fontsize(size = 8, part = "all") %>% 
  padding(padding.top=0, padding.bottom=0)
```

[TABLE]

## SOC’s tables: `ae_table_soc()`

The function
[`ae_table_soc()`](https://oncostat.github.io/grstat/reference/ae_table_soc.md)
summarises AE grades by event group at the patient level.

The main grouping variable is defined by `group1`, which is typically
the System Organ Class (SOC). An optional second grouping variable,
`group2`, can be used for more detailed summaries, for example by
preferred term within SOC.

It uses the same `measure` argument as
[`ae_table_grade()`](https://oncostat.github.io/grstat/reference/ae_table_grade.md),
but only one is used. By default, `measure = "max"`, as this is the most
common summary for safety tables. For each group, patients are then
classified according to the maximum reported AE grade observed within
that group.

The resulting table contains one row per `group1` level and one column
per grade. The `tot` column reports the number of patients with at least
one AE in the corresponding group. The `na` column reports patients with
at least one AE in the group but no available grade for the
maximum-grade assessment.

The resulting data frame can be piped to
[`as_flextable()`](https://davidgohel.github.io/flextable/reference/as_flextable.html)
to produce a formatted table. In the header, `N` is the total number of
patients. Percentages are calculated using this total as denominator.

### Default: AE maximum grades by SOC

``` r

ae_table_soc(data_ae=ae, data_pat=enrolres, group1="aesoc") %>% 
  as_flextable() %>% 
  delete_rows(i=11:27) %>% 
  add_footer_lines("In the header, N represents the number of patients.") %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum AE grade was as indicated.") 
```

|  | All patients (N=200) |  |  |  |  |  |  |
|----|----|----|----|----|----|----|----|
| AE SOC | G1 | G2 | G3 | G4 | G5 | NA | Tot |
| Social circumstances | 21 (10%) | 10 (5%) | 6 (3%) | 4 (2%) |  | 3 (2%) | 44 (22%) |
| Eye disorders | 17 (8%) | 12 (6%) | 6 (3%) | 2 (1%) |  | 6 (3%) | 43 (22%) |
| Congenital, familial and genetic disorders | 20 (10%) | 10 (5%) | 4 (2%) | 5 (2%) |  | 3 (2%) | 42 (21%) |
| Pregnancy, puerperium and perinatal conditions | 11 (6%) | 9 (4%) | 2 (1%) | 2 (1%) |  | 7 (4%) | 31 (16%) |
| Immune system disorders | 13 (6%) | 6 (3%) | 6 (3%) | 2 (1%) |  | 3 (2%) | 30 (15%) |
| Injury, poisoning and procedural complications | 13 (6%) | 8 (4%) | 3 (2%) | 2 (1%) |  | 4 (2%) | 30 (15%) |
| Neoplasms benign, malignant, and unspecified | 11 (6%) | 10 (5%) | 1 (0%) | 1 (0%) |  | 5 (2%) | 28 (14%) |
| Hepatobiliary disorders | 14 (7%) | 7 (4%) | 1 (0%) | 1 (0%) |  | 3 (2%) | 26 (13%) |
| Cardiac disorders | 7 (4%) | 3 (2%) | 7 (4%) | 4 (2%) |  | 2 (1%) | 23 (12%) |
| Respiratory, thoracic and mediastinal disorders | 9 (4%) | 5 (2%) | 6 (3%) | 1 (0%) |  | 2 (1%) | 23 (12%) |
| No Declared AE |  |  |  |  |  | 8 (4%) | 8 (4%) |
| Figures represent the number of patients who experienced an AE of maximum grade, for a given AE SOC. |  |  |  |  |  |  |  |
| For example, for AE with AE SOC "Social circumstances", the maximum grade was G2 for 10 (5%) patients. |  |  |  |  |  |  |  |
| In the header, N represents the number of patients. |  |  |  |  |  |  |  |
| Percentages reflect the proportion of patients whose maximum AE grade was as indicated. |  |  |  |  |  |  |  |

### Alternative: AE maximum grades by SOC and term, stratified by arm

``` r

ae_table_soc(data_ae=ae, data_pat=enrolres, arm="arm", group1="aesoc", group2="aeterm") %>%
  as_flextable() %>% 
  delete_rows(i=11:165) %>% 
  add_footer_lines("In the header, N represents the number of patients.") %>% 
  add_footer_lines("Percentages reflect the proportion of patients whose maximum AE grade was as indicated.")
```

|  |  | Control (N=100) |  |  |  |  |  |  | Treatment (N=100) |  |  |  |  |  |  |
|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| AE SOC | AE Term (HLGT) | G1 | G2 | G3 | G4 | G5 | NA | Tot | G1 | G2 | G3 | G4 | G5 | NA | Tot |
| Social circumstances | Cultural issues | 5 (5%) | 2 (2%) | 2 (2%) |  |  | 1 (1%) | 10 (10%) | 3 (3%) | 1 (1%) |  | 2 (2%) |  | 1 (1%) | 7 (7%) |
|  | Economic conditions affecting care |  | 1 (1%) |  |  |  | 1 (1%) | 2 (2%) | 1 (1%) | 1 (1%) |  | 1 (1%) |  |  | 3 (3%) |
|  | Family support issues | 7 (7%) | 3 (3%) |  |  |  |  | 10 (10%) | 2 (2%) | 1 (1%) | 2 (2%) |  |  |  | 5 (5%) |
|  | Social and environmental issues | 2 (2%) | 1 (1%) | 1 (1%) |  |  |  | 4 (4%) | 2 (2%) | 1 (1%) | 1 (1%) | 1 (1%) |  | 1 (1%) | 6 (6%) |
|  |  | 2 (2%) |  |  |  |  |  | 2 (2%) | 2 (2%) |  |  |  |  |  | 2 (2%) |
| Eye disorders | Corneal disorders | 3 (3%) | 1 (1%) |  |  |  | 2 (2%) | 6 (6%) | 1 (1%) | 1 (1%) | 1 (1%) |  |  |  | 3 (3%) |
|  | Eyelid disorders | 3 (3%) |  | 1 (1%) |  |  |  | 4 (4%) | 1 (1%) | 1 (1%) | 1 (1%) |  |  |  | 3 (3%) |
|  | Retinal disorders | 3 (3%) | 4 (4%) | 2 (2%) | 2 (2%) |  | 1 (1%) | 12 (12%) | 1 (1%) |  |  |  |  | 2 (2%) | 3 (3%) |
|  | Vision disorders | 3 (3%) | 1 (1%) |  |  |  | 1 (1%) | 5 (5%) | 1 (1%) | 2 (2%) | 1 (1%) |  |  |  | 4 (4%) |
|  |  | 3 (3%) | 1 (1%) |  |  |  | 1 (1%) | 5 (5%) | 1 (1%) | 1 (1%) |  |  |  |  | 2 (2%) |
| Figures represent the number of patients who experienced an AE of maximum grade, for a given arm, AE SOC, and AE Term (HLGT). |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| For example, for AE in Control arm, with AE SOC "Social circumstances", and AE Term (HLGT) "Cultural issues", the maximum grade was G2 for 2 (2%) patients. |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| In the header, N represents the number of patients. |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
| Percentages reflect the proportion of patients whose maximum AE grade was as indicated. |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |

### Alternative 2: AE minimum grades by SOC and term, stratified by arm

The function handles many more arguments. For example, you can use
`sort_by_count=FALSE` to sort alphabetically by `group1` instead of by
count, and `total=FALSE` and `showNA=FALSE` to remove the “Total” and
“NA” columns.

``` r

ae_table_soc(data_ae=ae, data_pat=enrolres, measure="sup", arm="arm", group1="aeterm", 
             sort_by_count=FALSE, total=FALSE, showNA=FALSE) %>%
  as_flextable() %>% 
  delete_rows(i=11:103) %>% 
  add_footer_lines("In the header, N represents the number of patients.") %>% 
  add_footer_lines("Percentages reflect the proportion of patients who had at least one AE higher or equal to the indicated grade.")
```

|  | Control (N=100) |  |  |  |  | Treatment (N=100) |  |  |  |  |
|----|----|----|----|----|----|----|----|----|----|----|
| AE Term (HLGT) | G1 | G2 | G3 | G4 | G5 | G1 | G2 | G3 | G4 | G5 |
| Adrenal gland disorders | 2 (2%) |  |  |  |  | 1 (1%) |  |  |  |  |
| Anxiety disorders | 1 (1%) |  |  |  |  | 3 (3%) | 2 (2%) | 1 (1%) |  |  |
| Arthritis and joint disorders | 3 (3%) | 3 (3%) | 1 (1%) | 1 (1%) | 1 (1%) |  |  |  |  |  |
| Autoimmune disorders | 1 (1%) |  |  |  |  | 4 (4%) | 3 (3%) | 2 (2%) | 1 (1%) |  |
| Bacterial infectious disorders | 2 (2%) |  |  |  |  |  |  |  |  |  |
| Benign neoplasms | 8 (8%) | 6 (6%) | 1 (1%) | 1 (1%) |  | 2 (2%) | 2 (2%) |  |  |  |
| Bile duct disorders | 3 (3%) | 1 (1%) |  |  |  | 4 (4%) | 2 (2%) |  |  |  |
| Bladder disorders |  |  |  |  |  | 1 (1%) | 1 (1%) | 1 (1%) | 1 (1%) |  |
| Blood analyses | 3 (3%) | 1 (1%) | 1 (1%) |  |  |  |  |  |  |  |
| Bone disorders | 2 (2%) | 2 (2%) | 2 (2%) | 1 (1%) | 1 (1%) | 2 (2%) | 2 (2%) | 1 (1%) |  |  |
| No Declared AE |  |  |  |  |  |  |  |  |  |  |
| Figures represent the number of patients who experienced at least one AE of grade ≥ X, for a given arm and AE Term (HLGT). |  |  |  |  |  |  |  |  |  |  |
| For example, for AE in Control arm and with AE Term (HLGT) "Arthritis and joint disorders", at least one AE of grade ≥ G2 was reported for 3 (3%) patients. |  |  |  |  |  |  |  |  |  |  |
| In the header, N represents the number of patients. |  |  |  |  |  |  |  |  |  |  |
| Percentages reflect the proportion of patients who had at least one AE higher or equal to the indicated grade. |  |  |  |  |  |  |  |  |  |  |

## Troubleshooting

These functions rely on labels to show the correct header in the
flextable. This means that functions such as
[`head()`](https://rdrr.io/r/utils/head.html) or sometimes
[`filter()`](https://dplyr.tidyverse.org/reference/filter.html) can
cause issues as they remove the labels.

If you want to use these functions, make sure to re-assign the labels to
the resulting data frame.
