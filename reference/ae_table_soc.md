# Summary tables for AE by SOC

**\[stable\]**  
The function `ae_table_soc()` creates a summary table of AE grades for
each patient according to term and SOC CTCAE. The resulting dataframe
can be piped to
[`as_flextable()`](https://davidgohel.github.io/flextable/reference/as_flextable.html)
to get a nicely formatted flextable.

## Usage

``` r
ae_table_soc(
  df_ae,
  ...,
  df_enrol,
  variant = c("max", "sup", "eq"),
  arm = NULL,
  term = NULL,
  sort_by_count = TRUE,
  total = TRUE,
  showNA = TRUE,
  digits = 0,
  warn_miss = FALSE,
  grade = "AEGR",
  soc = "AESOC",
  subjid = "SUBJID"
)

# S3 method for class 'ae_table_soc'
as_flextable(
  x,
  ...,
  arm_colors = c("#f2dcdb", "#dbe5f1", "#ebf1dd", "#e5e0ec"),
  padding_v = NULL
)
```

## Arguments

- df_ae:

  adverse event dataset, one row per AE, containing subjid, soc, and
  grade.

- ...:

  unused

- df_enrol:

  enrollment dataset, one row per patient, containing subjid (and arm if
  needed). All patients should be in this dataset.

- variant:

  one or several of `c("max", "sup", "eq")`. `max` computes the maximum
  AE grade per patient, `sup` computes the number of patients having
  experienced at least one AE of grade higher or equal to X, and `eq`
  computes the number of patients having experienced at least one AE of
  grade equal to X.

- arm:

  name of the treatment column in `df_enrol`. Case-insensitive. Can be
  set to `NULL`.

- term:

  name of the the CTCAE term column in `df_ae`. Case-insensitive. Can be
  set to `NULL`.

- sort_by_count:

  should the table be sorted by the number of AE or by SOC
  alphabetically.

- total:

  whether to add a `total` column for each arm.

- showNA:

  whether to display missing grades.

- digits:

  significant digits for percentages.

- warn_miss:

  whether to warn for missing values.

- grade:

  name of the AE grade column in `df_ae`. Case-insensitive.

- soc:

  name of the SOC column in `df_ae`. Case-insensitive. Grade will be
  considered 0 if missing (e.g. if patient if absent from `df_ae`).

- subjid:

  name of the patient ID in both `df_ae` and `df_enrol`.
  Case-insensitive.

- x:

  a dataframe, resulting of `ae_table_soc()`

- arm_colors:

  colors for the arm groups

- padding_v:

  a numeric of lenght up to 2, giving the vertical padding of body (1)
  and header (2)

## Value

a dataframe (`ae_table_soc()`) or a flextable
([`as_flextable()`](https://davidgohel.github.io/flextable/reference/as_flextable.html)).

a formatted flextable

## See also

[`ae_table_grade()`](https://oncostat.github.io/grstat/reference/ae_table_grade.md),
`ae_table_soc()`,
[`ae_plot_grade()`](https://oncostat.github.io/grstat/reference/ae_plot_grade.md),
[`ae_plot_grade_sum()`](https://oncostat.github.io/grstat/reference/ae_plot_grade_sum.md),
[`butterfly_plot()`](https://oncostat.github.io/grstat/reference/butterfly_plot.md)

## Examples

``` r
tm = grstat_example()
attach(tm, warn.conflicts=FALSE)

ae_table_soc(df_ae=ae, df_enrol=enrolres)
#> # A tibble: 27 × 8
#>    soc           all_patients_G1 all_patients_G2 all_patients_G3 all_patients_G4
#>    <fct>         <glue>          <glue>          <glue>          <glue>         
#>  1 Eye disorders 21 (10%)        16 (8%)         9 (4%)          3 (2%)         
#>  2 Social circu… 27 (14%)        12 (6%)         6 (3%)          4 (2%)         
#>  3 Congenital, … 23 (12%)        10 (5%)         4 (2%)          5 (2%)         
#>  4 Injury, pois… 17 (8%)         13 (6%)         3 (2%)          2 (1%)         
#>  5 Immune syste… 15 (8%)         9 (4%)          7 (4%)          3 (2%)         
#>  6 Pregnancy, p… 14 (7%)         12 (6%)         4 (2%)          3 (2%)         
#>  7 Neoplasms be… 12 (6%)         12 (6%)         4 (2%)          2 (1%)         
#>  8 Hepatobiliar… 17 (8%)         8 (4%)          1 (0%)          2 (1%)         
#>  9 Surgical and… 13 (6%)         10 (5%)         4 (2%)          1 (0%)         
#> 10 Cardiac diso… 11 (6%)         4 (2%)          7 (4%)          4 (2%)         
#> # ℹ 17 more rows
#> # ℹ 3 more variables: all_patients_G5 <glue>, all_patients_NA <glue>,
#> #   all_patients_Tot <glue>
ae_table_soc(df_ae=ae, df_enrol=enrolres, arm="arm")
#> # A tibble: 27 × 15
#>    soc         control_G1 control_G2 control_G3 control_G4 control_G5 control_NA
#>    <fct>       <glue>     <glue>     <glue>     <glue>     <glue>     <glue>    
#>  1 Eye disord… 14 (14%)   11 (11%)   4 (4%)     2 (2%)     NA         NA        
#>  2 Social cir… 16 (16%)   8 (8%)     3 (3%)     NA         NA         NA        
#>  3 Congenital… 10 (10%)   7 (7%)     2 (2%)     1 (1%)     NA         NA        
#>  4 Injury, po… 12 (12%)   8 (8%)     1 (1%)     1 (1%)     NA         NA        
#>  5 Immune sys… 8 (8%)     4 (4%)     4 (4%)     2 (2%)     NA         NA        
#>  6 Pregnancy,… 7 (7%)     5 (5%)     2 (2%)     2 (2%)     NA         NA        
#>  7 Neoplasms … 6 (6%)     7 (7%)     3 (3%)     1 (1%)     NA         NA        
#>  8 Hepatobili… 9 (9%)     3 (3%)     NA         2 (2%)     NA         NA        
#>  9 Surgical a… 6 (6%)     5 (5%)     2 (2%)     NA         NA         NA        
#> 10 Cardiac di… 7 (7%)     3 (3%)     4 (4%)     NA         NA         NA        
#> # ℹ 17 more rows
#> # ℹ 8 more variables: control_Tot <glue>, treatment_G1 <glue>,
#> #   treatment_G2 <glue>, treatment_G3 <glue>, treatment_G4 <glue>,
#> #   treatment_G5 <glue>, treatment_NA <glue>, treatment_Tot <glue>

#sub population
ae_table_soc(df_ae=ae, df_enrol=head(enrolres, 10), arm="arm")
#> # A tibble: 16 × 15
#>    soc         control_G1 control_G2 control_G3 control_G4 control_G5 control_NA
#>    <fct>       <glue>     <glue>     <glue>     <glue>     <glue>     <glue>    
#>  1 Eye disord… 3 (60%)    NA         1 (20%)    NA         NA         NA        
#>  2 Pregnancy,… 3 (60%)    1 (20%)    NA         NA         NA         NA        
#>  3 Psychiatri… 1 (20%)    NA         NA         NA         NA         NA        
#>  4 Social cir… 1 (20%)    NA         NA         NA         NA         NA        
#>  5 Cardiac di… NA         1 (20%)    NA         NA         NA         NA        
#>  6 Metabolism… 1 (20%)    NA         NA         NA         NA         NA        
#>  7 Neoplasms … NA         NA         2 (40%)    NA         NA         NA        
#>  8 Surgical a… NA         NA         NA         NA         NA         NA        
#>  9 Congenital… 1 (20%)    NA         NA         NA         NA         NA        
#> 10 Ear and la… 1 (20%)    NA         NA         NA         NA         NA        
#> 11 Infections… 1 (20%)    NA         NA         NA         NA         NA        
#> 12 Injury, po… NA         1 (20%)    NA         NA         NA         NA        
#> 13 Investigat… 1 (20%)    NA         NA         NA         NA         NA        
#> 14 Musculoske… NA         NA         1 (20%)    NA         NA         NA        
#> 15 Respirator… NA         NA         NA         NA         NA         NA        
#> 16 Vascular d… 1 (20%)    NA         NA         NA         NA         NA        
#> # ℹ 8 more variables: control_Tot <glue>, treatment_G1 <glue>,
#> #   treatment_G2 <glue>, treatment_G3 <glue>, treatment_G4 <glue>,
#> #   treatment_G5 <glue>, treatment_NA <glue>, treatment_Tot <glue>

#the resulting flextable can be customized using the flextable package
library(flextable)
ae_table_soc(ae, df_enrol=enrolres, total=FALSE) %>%
  as_flextable() %>%
  hline(i=~soc=="" & soc!=dplyr::lead(soc))


.cl-db74e96c{table-layout:auto;}.cl-db6cd3da{font-family:'DejaVu Sans';font-size:8pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-db6cd3e4{font-family:'DejaVu Sans';font-size:8pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-db700da2{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-db700db6{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-db700dc0{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-db700dc1{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:0;padding-top:0;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-db700dca{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:0;padding-top:0;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-db702fa8{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-db702fbc{background-color:rgba(242, 220, 219, 1.00);vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-db702fbd{background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-db702fc6{background-color:rgba(242, 220, 219, 1.00);vertical-align: middle;border-bottom: 1pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-db702fc7{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-db702fc8{background-color:rgba(242, 220, 219, 1.00);vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-db702fd0{background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-db702fda{background-color:rgba(242, 220, 219, 1.00);vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}


```

All patients (N=200)

CTCAE SOC

G1

G2

G3

G4

G5

NA

Eye disorders

21 (10%)

16 (8%)

9 (4%)

3 (2%)

Social circumstances

27 (14%)

12 (6%)

6 (3%)

4 (2%)

Congenital, familial and genetic disorders

23 (12%)

10 (5%)

4 (2%)

5 (2%)

Injury, poisoning and procedural complications

17 (8%)

13 (6%)

3 (2%)

2 (1%)

Immune system disorders

15 (8%)

9 (4%)

7 (4%)

3 (2%)

Pregnancy, puerperium and perinatal conditions

14 (7%)

12 (6%)

4 (2%)

3 (2%)

Neoplasms benign, malignant, and unspecified

12 (6%)

12 (6%)

4 (2%)

2 (1%)

Hepatobiliary disorders

17 (8%)

8 (4%)

1 (0%)

2 (1%)

Surgical and medical procedures

13 (6%)

10 (5%)

4 (2%)

1 (0%)

Cardiac disorders

11 (6%)

4 (2%)

7 (4%)

4 (2%)

Respiratory, thoracic and mediastinal disorders

11 (6%)

6 (3%)

5 (2%)

1 (0%)

1 (0%)

Ear and labyrinth disorders

7 (4%)

7 (4%)

4 (2%)

Endocrine disorders

11 (6%)

2 (1%)

2 (1%)

1 (0%)

Psychiatric disorders

10 (5%)

2 (1%)

3 (2%)

1 (0%)

Vascular disorders

10 (5%)

3 (2%)

1 (0%)

2 (1%)

Infections and infestations

10 (5%)

3 (2%)

1 (0%)

1 (0%)

Musculoskeletal and connective tissue disorders

5 (2%)

3 (2%)

4 (2%)

1 (0%)

2 (1%)

Nervous system disorders

5 (2%)

6 (3%)

1 (0%)

Investigations

7 (4%)

1 (0%)

3 (2%)

Blood and lymphatic system disorders

3 (2%)

3 (2%)

3 (2%)

1 (0%)

Metabolism and nutrition disorders

8 (4%)

2 (1%)

Skin and subcutaneous tissue disorders

6 (3%)

3 (2%)

1 (0%)

General disorders and administration site conditions

2 (1%)

5 (2%)

2 (1%)

Gastrointestinal disorders

5 (2%)

1 (0%)

1 (0%)

Renal and urinary disorders

5 (2%)

1 (0%)

1 (0%)

Reproductive system and breast disorders

3 (2%)

2 (1%)

2 (1%)

No Declared AE

8 (4%)

ae_table_soc(ae, df_enrol=enrolres, term=NULL, sort_by_count=FALSE)
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
[as_flextable](https://davidgohel.github.io/flextable/reference/as_flextable.html)()
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
[bold](https://davidgohel.github.io/flextable/reference/bold.html)(i=~soc=="Eye
disorders")

|                                                      | All patients (N=200) |         |        |        |        |        |          |
|------------------------------------------------------|----------------------|---------|--------|--------|--------|--------|----------|
| CTCAE SOC                                            | G1                   | G2      | G3     | G4     | G5     | NA     | Tot      |
| Blood and lymphatic system disorders                 | 3 (2%)               | 3 (2%)  | 3 (2%) | 1 (0%) |        |        | 10 (5%)  |
| Cardiac disorders                                    | 11 (6%)              | 4 (2%)  | 7 (4%) | 4 (2%) |        |        | 26 (13%) |
| Congenital, familial and genetic disorders           | 23 (12%)             | 10 (5%) | 4 (2%) | 5 (2%) |        |        | 42 (21%) |
| Ear and labyrinth disorders                          | 7 (4%)               | 7 (4%)  | 4 (2%) |        |        |        | 18 (9%)  |
| Endocrine disorders                                  | 11 (6%)              | 2 (1%)  | 2 (1%) | 1 (0%) |        |        | 16 (8%)  |
| Eye disorders                                        | 21 (10%)             | 16 (8%) | 9 (4%) | 3 (2%) |        |        | 49 (24%) |
| Gastrointestinal disorders                           | 5 (2%)               | 1 (0%)  |        | 1 (0%) |        |        | 7 (4%)   |
| General disorders and administration site conditions | 2 (1%)               | 5 (2%)  | 2 (1%) |        |        |        | 9 (4%)   |
| Hepatobiliary disorders                              | 17 (8%)              | 8 (4%)  | 1 (0%) | 2 (1%) |        |        | 28 (14%) |
| Immune system disorders                              | 15 (8%)              | 9 (4%)  | 7 (4%) | 3 (2%) |        |        | 34 (17%) |
| Infections and infestations                          | 10 (5%)              | 3 (2%)  | 1 (0%) |        | 1 (0%) |        | 15 (8%)  |
| Injury, poisoning and procedural complications       | 17 (8%)              | 13 (6%) | 3 (2%) | 2 (1%) |        |        | 35 (18%) |
| Investigations                                       | 7 (4%)               | 1 (0%)  | 3 (2%) |        |        |        | 11 (6%)  |
| Metabolism and nutrition disorders                   | 8 (4%)               | 2 (1%)  |        |        |        |        | 10 (5%)  |
| Musculoskeletal and connective tissue disorders      | 5 (2%)               | 3 (2%)  | 4 (2%) | 1 (0%) | 2 (1%) |        | 15 (8%)  |
| Neoplasms benign, malignant, and unspecified         | 12 (6%)              | 12 (6%) | 4 (2%) | 2 (1%) |        |        | 30 (15%) |
| Nervous system disorders                             | 5 (2%)               | 6 (3%)  |        | 1 (0%) |        |        | 12 (6%)  |
| Pregnancy, puerperium and perinatal conditions       | 14 (7%)              | 12 (6%) | 4 (2%) | 3 (2%) |        |        | 33 (16%) |
| Psychiatric disorders                                | 10 (5%)              | 2 (1%)  | 3 (2%) | 1 (0%) |        |        | 16 (8%)  |
| Renal and urinary disorders                          | 5 (2%)               |         | 1 (0%) | 1 (0%) |        |        | 7 (4%)   |
| Reproductive system and breast disorders             | 3 (2%)               | 2 (1%)  | 2 (1%) |        |        |        | 7 (4%)   |
| Respiratory, thoracic and mediastinal disorders      | 11 (6%)              | 6 (3%)  | 5 (2%) | 1 (0%) | 1 (0%) |        | 24 (12%) |
| Skin and subcutaneous tissue disorders               | 6 (3%)               | 3 (2%)  |        | 1 (0%) |        |        | 10 (5%)  |
| Social circumstances                                 | 27 (14%)             | 12 (6%) | 6 (3%) | 4 (2%) |        |        | 49 (24%) |
| Surgical and medical procedures                      | 13 (6%)              | 10 (5%) | 4 (2%) | 1 (0%) |        |        | 28 (14%) |
| Vascular disorders                                   | 10 (5%)              | 3 (2%)  | 1 (0%) | 2 (1%) |        |        | 16 (8%)  |
| No Declared AE                                       |                      |         |        |        |        | 8 (4%) | 8 (4%)   |

ae_table_soc(ae, df_enrol=enrolres, term="aeterm", arm=NULL)
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
[as_flextable](https://davidgohel.github.io/flextable/reference/as_flextable.html)()
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
[highlight](https://davidgohel.github.io/flextable/reference/highlight.html)(i=~soc=="Hepatobiliary
disorders", j="all_patients_Tot")

|                                                      |                                                      | All patients (N=200) |        |        |        |        |        |          |
|------------------------------------------------------|------------------------------------------------------|----------------------|--------|--------|--------|--------|--------|----------|
| CTCAE SOC                                            | CTCAE v4.0 Term                                      | G1                   | G2     | G3     | G4     | G5     | NA     | Tot      |
| Social circumstances                                 | Cultural issues                                      | 11 (6%)              | 3 (2%) | 3 (2%) | 2 (1%) |        |        | 19 (10%) |
|                                                      | Economic conditions affecting care                   | 2 (1%)               | 4 (2%) |        | 1 (0%) |        |        | 7 (4%)   |
|                                                      | Family support issues                                | 14 (7%)              | 4 (2%) | 2 (1%) |        |        |        | 20 (10%) |
|                                                      | Social and environmental issues                      | 7 (4%)               | 2 (1%) | 2 (1%) | 1 (0%) |        |        | 12 (6%)  |
| Eye disorders                                        | Corneal disorders                                    | 8 (4%)               | 3 (2%) | 1 (0%) |        |        |        | 12 (6%)  |
|                                                      | Eyelid disorders                                     | 5 (2%)               | 3 (2%) | 2 (1%) |        |        |        | 10 (5%)  |
|                                                      | Retinal disorders                                    | 6 (3%)               | 6 (3%) | 4 (2%) | 2 (1%) |        |        | 18 (9%)  |
|                                                      | Vision disorders                                     | 6 (3%)               | 4 (2%) | 2 (1%) | 1 (0%) |        |        | 13 (6%)  |
| Congenital, familial and genetic disorders           | Chromosomal abnormalities                            | 5 (2%)               | 2 (1%) | 2 (1%) | 3 (2%) |        |        | 12 (6%)  |
|                                                      | Congenital nervous system disorders                  | 10 (5%)              | 4 (2%) |        |        |        |        | 14 (7%)  |
|                                                      | Familial hematologic disorders                       | 5 (2%)               | 2 (1%) |        | 1 (0%) |        |        | 8 (4%)   |
|                                                      | Hereditary connective tissue disorders               | 8 (4%)               | 2 (1%) | 2 (1%) | 1 (0%) |        |        | 13 (6%)  |
| Injury, poisoning and procedural complications       | Poisonings                                           | 4 (2%)               | 4 (2%) | 1 (0%) |        |        |        | 9 (4%)   |
|                                                      | Procedural complications                             | 12 (6%)              | 1 (0%) | 2 (1%) | 1 (0%) |        |        | 16 (8%)  |
|                                                      | Radiation-related toxicities                         | 2 (1%)               | 4 (2%) |        | 1 (0%) |        |        | 7 (4%)   |
|                                                      | Traumatic injuries                                   | 3 (2%)               | 4 (2%) |        |        |        |        | 7 (4%)   |
| Immune system disorders                              | Autoimmune disorders                                 | 3 (2%)               | 1 (0%) | 1 (0%) | 1 (0%) |        |        | 6 (3%)   |
|                                                      | Hypersensitivity conditions                          | 7 (4%)               | 4 (2%) | 2 (1%) | 1 (0%) |        |        | 14 (7%)  |
|                                                      | Immunodeficiency                                     | 2 (1%)               | 2 (1%) | 2 (1%) |        |        |        | 6 (3%)   |
|                                                      | Inflammatory responses                               | 4 (2%)               | 4 (2%) | 2 (1%) | 1 (0%) |        |        | 11 (6%)  |
| Pregnancy, puerperium and perinatal conditions       | Breastfeeding issues                                 | 3 (2%)               | 2 (1%) |        |        |        |        | 5 (2%)   |
|                                                      | Fetal complications                                  | 2 (1%)               | 7 (4%) | 1 (0%) | 2 (1%) |        |        | 12 (6%)  |
|                                                      | Labor and delivery complications                     | 6 (3%)               | 1 (0%) | 2 (1%) | 1 (0%) |        |        | 10 (5%)  |
|                                                      | Pregnancy complications                              | 4 (2%)               | 2 (1%) | 1 (0%) |        |        |        | 7 (4%)   |
| Neoplasms benign, malignant, and unspecified         | Benign neoplasms                                     | 4 (2%)               | 7 (4%) | 1 (0%) | 1 (0%) |        |        | 13 (6%)  |
|                                                      | Malignant neoplasms                                  | 2 (1%)               | 1 (0%) |        |        |        |        | 3 (2%)   |
|                                                      | Neoplasms unspecified                                | 1 (0%)               | 2 (1%) | 2 (1%) |        |        |        | 5 (2%)   |
|                                                      | Tumor progression                                    | 5 (2%)               | 3 (2%) | 1 (0%) | 1 (0%) |        |        | 10 (5%)  |
| Hepatobiliary disorders                              | Bile duct disorders                                  | 4 (2%)               | 4 (2%) |        | 1 (0%) |        |        | 9 (4%)   |
|                                                      | Gallbladder disorders                                | 4 (2%)               | 1 (0%) |        | 1 (0%) |        |        | 6 (3%)   |
|                                                      | Hepatic failure                                      | 5 (2%)               | 2 (1%) |        |        |        |        | 7 (4%)   |
|                                                      | Liver disorders                                      | 6 (3%)               | 1 (0%) | 1 (0%) |        |        |        | 8 (4%)   |
| Surgical and medical procedures                      | Device implantation procedures                       | 5 (2%)               | 1 (0%) | 1 (0%) |        |        |        | 7 (4%)   |
|                                                      | Diagnostic procedures                                | 3 (2%)               | 3 (2%) | 1 (0%) |        |        |        | 7 (4%)   |
|                                                      | Surgical complications                               | 3 (2%)               | 3 (2%) | 2 (1%) |        |        |        | 8 (4%)   |
|                                                      | Therapeutic procedures                               | 3 (2%)               | 3 (2%) | 1 (0%) | 1 (0%) |        |        | 8 (4%)   |
| Cardiac disorders                                    | Cardiac arrhythmias                                  | 5 (2%)               | 2 (1%) | 1 (0%) | 1 (0%) |        |        | 9 (4%)   |
|                                                      | Cardiac valve disorders                              | 3 (2%)               | 1 (0%) | 5 (2%) | 2 (1%) |        |        | 11 (6%)  |
|                                                      | Coronary artery disorders                            | 3 (2%)               |        |        | 1 (0%) |        |        | 4 (2%)   |
|                                                      | Heart failures                                       | 2 (1%)               | 1 (0%) | 1 (0%) |        |        |        | 4 (2%)   |
| Respiratory, thoracic and mediastinal disorders      | Lung function disorders                              | 2 (1%)               | 2 (1%) | 3 (2%) |        |        |        | 7 (4%)   |
|                                                      | Pleural disorders                                    | 3 (2%)               |        | 1 (0%) |        | 1 (0%) |        | 5 (2%)   |
|                                                      | Pulmonary vascular disorders                         | 5 (2%)               | 1 (0%) |        | 1 (0%) |        |        | 7 (4%)   |
|                                                      | Respiratory infections                               | 2 (1%)               | 3 (2%) | 2 (1%) |        |        |        | 7 (4%)   |
| Ear and labyrinth disorders                          | Hearing disorders                                    | 2 (1%)               | 1 (0%) | 1 (0%) |        |        |        | 4 (2%)   |
|                                                      | Labyrinth disorders                                  | 1 (0%)               | 2 (1%) | 1 (0%) |        |        |        | 4 (2%)   |
|                                                      | Tinnitus                                             | 2 (1%)               | 2 (1%) | 2 (1%) |        |        |        | 6 (3%)   |
|                                                      | Vertigo and balance disorders                        | 2 (1%)               | 2 (1%) |        |        |        |        | 4 (2%)   |
| Endocrine disorders                                  | Adrenal gland disorders                              | 3 (2%)               |        |        |        |        |        | 3 (2%)   |
|                                                      | Parathyroid gland disorders                          | 3 (2%)               |        |        |        |        |        | 3 (2%)   |
|                                                      | Pituitary gland disorders                            | 4 (2%)               | 1 (0%) |        |        |        |        | 5 (2%)   |
|                                                      | Thyroid gland disorders                              | 2 (1%)               | 1 (0%) | 2 (1%) | 1 (0%) |        |        | 6 (3%)   |
| Psychiatric disorders                                | Anxiety disorders                                    | 2 (1%)               | 2 (1%) | 1 (0%) |        |        |        | 5 (2%)   |
|                                                      | Mood disorders                                       | 2 (1%)               |        | 2 (1%) |        |        |        | 4 (2%)   |
|                                                      | Sleep disorders                                      | 4 (2%)               |        |        | 1 (0%) |        |        | 5 (2%)   |
|                                                      | Substance-related disorders                          | 3 (2%)               |        |        |        |        |        | 3 (2%)   |
| Infections and infestations                          | Bacterial infectious disorders                       | 2 (1%)               |        |        |        |        |        | 2 (1%)   |
|                                                      | Fungal infectious disorders                          | 1 (0%)               |        |        |        | 1 (0%) |        | 2 (1%)   |
|                                                      | Parasitic infectious disorders                       | 5 (2%)               | 2 (1%) | 1 (0%) |        |        |        | 8 (4%)   |
|                                                      | Viral infectious disorders                           | 3 (2%)               | 1 (0%) |        |        |        |        | 4 (2%)   |
| Vascular disorders                                   | Hypertension-related conditions                      |                      | 2 (1%) | 1 (0%) |        |        |        | 3 (2%)   |
|                                                      | Hypotension-related conditions                       | 3 (2%)               |        |        |        |        |        | 3 (2%)   |
|                                                      | Vascular hemorrhagic disorders                       | 5 (2%)               |        |        | 1 (0%) |        |        | 6 (3%)   |
|                                                      | Venous thromboembolic events                         | 2 (1%)               | 1 (0%) |        | 1 (0%) |        |        | 4 (2%)   |
| Musculoskeletal and connective tissue disorders      | Arthritis and joint disorders                        |                      | 2 (1%) |        |        | 1 (0%) |        | 3 (2%)   |
|                                                      | Bone disorders                                       |                      | 1 (0%) | 2 (1%) |        | 1 (0%) |        | 4 (2%)   |
|                                                      | Connective tissue disorders                          | 3 (2%)               |        | 1 (0%) | 1 (0%) |        |        | 5 (2%)   |
|                                                      | Muscle disorders                                     | 2 (1%)               |        | 1 (0%) |        |        |        | 3 (2%)   |
| Nervous system disorders                             | Headache disorders                                   | 3 (2%)               | 1 (0%) |        | 1 (0%) |        |        | 5 (2%)   |
|                                                      | Neurological disorders of the central nervous system | 1 (0%)               | 2 (1%) |        |        |        |        | 3 (2%)   |
|                                                      | Peripheral neuropathies                              |                      | 2 (1%) |        |        |        |        | 2 (1%)   |
|                                                      | Seizure disorders                                    | 2 (1%)               | 1 (0%) |        |        |        |        | 3 (2%)   |
| Investigations                                       | Blood analyses                                       | 2 (1%)               |        | 1 (0%) |        |        |        | 3 (2%)   |
|                                                      | Cardiovascular assessments                           | 2 (1%)               |        | 1 (0%) |        |        |        | 3 (2%)   |
|                                                      | Imaging studies                                      |                      | 1 (0%) | 1 (0%) |        |        |        | 2 (1%)   |
|                                                      | Liver function analyses                              | 3 (2%)               |        |        |        |        |        | 3 (2%)   |
| Metabolism and nutrition disorders                   | Fluid and electrolyte disorders                      | 2 (1%)               |        |        |        |        |        | 2 (1%)   |
|                                                      | Lipid metabolism disorders                           | 3 (2%)               |        |        |        |        |        | 3 (2%)   |
|                                                      | Nutritional disorders                                | 2 (1%)               | 1 (0%) |        |        |        |        | 3 (2%)   |
|                                                      | Vitamin deficiencies                                 | 2 (1%)               | 1 (0%) |        |        |        |        | 3 (2%)   |
| Blood and lymphatic system disorders                 | Bone marrow disorders                                |                      |        |        | 1 (0%) |        |        | 1 (0%)   |
|                                                      | Coagulation and bleeding analyses                    |                      |        | 1 (0%) |        |        |        | 1 (0%)   |
|                                                      | Hematologic neoplasms                                |                      |        | 1 (0%) |        |        |        | 1 (0%)   |
|                                                      | Red blood cell disorders                             | 3 (2%)               | 3 (2%) | 1 (0%) |        |        |        | 7 (4%)   |
| Skin and subcutaneous tissue disorders               | Dermatitis                                           | 2 (1%)               | 1 (0%) |        |        |        |        | 3 (2%)   |
|                                                      | Skin and subcutaneous tissue injuries                | 1 (0%)               | 1 (0%) |        |        |        |        | 2 (1%)   |
|                                                      | Skin infections                                      | 2 (1%)               |        |        |        |        |        | 2 (1%)   |
|                                                      | Skin pigmentation disorders                          | 1 (0%)               | 1 (0%) |        | 1 (0%) |        |        | 3 (2%)   |
| General disorders and administration site conditions | General physical health deterioration                |                      | 3 (2%) |        |        |        |        | 3 (2%)   |
|                                                      | Injection site reactions                             | 1 (0%)               | 1 (0%) | 2 (1%) |        |        |        | 4 (2%)   |
|                                                      | Pain and discomfort                                  | 1 (0%)               | 1 (0%) |        |        |        |        | 2 (1%)   |
| Gastrointestinal disorders                           | Esophageal disorders                                 | 1 (0%)               |        |        | 1 (0%) |        |        | 2 (1%)   |
|                                                      | Gastric disorders                                    | 2 (1%)               |        |        |        |        |        | 2 (1%)   |
|                                                      | Intestinal disorders                                 | 2 (1%)               | 1 (0%) |        |        |        |        | 3 (2%)   |
| Renal and urinary disorders                          | Bladder disorders                                    |                      |        |        | 1 (0%) |        |        | 1 (0%)   |
|                                                      | Kidney disorders                                     | 2 (1%)               |        |        |        |        |        | 2 (1%)   |
|                                                      | Urethral disorders                                   | 1 (0%)               |        | 1 (0%) |        |        |        | 2 (1%)   |
|                                                      | Urinary tract disorders                              | 2 (1%)               |        |        |        |        |        | 2 (1%)   |
| Reproductive system and breast disorders             | Breast disorders                                     |                      |        | 1 (0%) |        |        |        | 1 (0%)   |
|                                                      | Female reproductive disorders                        | 1 (0%)               |        | 1 (0%) |        |        |        | 2 (1%)   |
|                                                      | Male reproductive disorders                          | 1 (0%)               | 2 (1%) |        |        |        |        | 3 (2%)   |
|                                                      | Menstrual disorders                                  | 1 (0%)               |        |        |        |        |        | 1 (0%)   |
| No Declared AE                                       |                                                      |                      |        |        |        |        | 8 (4%) | 8 (4%)   |
