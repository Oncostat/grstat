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


.cl-6a5a31a8{table-layout:auto;}.cl-6a523e80{font-family:'DejaVu Sans';font-size:8pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-6a523e94{font-family:'DejaVu Sans';font-size:8pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-6a5569e8{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-6a5569fc{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-6a5569fd{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-6a556a06{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:0;padding-top:0;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-6a556a07{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:0;padding-top:0;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-6a558d06{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-6a558d10{background-color:rgba(242, 220, 219, 1.00);vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-6a558d11{background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-6a558d1a{background-color:rgba(242, 220, 219, 1.00);vertical-align: middle;border-bottom: 1pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-6a558d1b{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-6a558d24{background-color:rgba(242, 220, 219, 1.00);vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-6a558d2e{background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-6a558d38{background-color:rgba(242, 220, 219, 1.00);vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}


```
