# Summary tables for AE by SOC

**\[stable\]**  
The function `ae_table_soc()` creates a summary table of AE grades for
each patient by group (usually according CTCAE SOC or term). The
resulting dataframe can be piped to
[`as_flextable()`](https://davidgohel.github.io/flextable/reference/as_flextable.html)
to get a nicely formatted flextable.

## Usage

``` r
ae_table_soc(
  data_ae,
  ...,
  data_pat,
  measure = c("max", "sup", "eq"),
  group1 = "AESOC",
  group2 = NULL,
  arm = NULL,
  cols = c(grade = "AEGR", subjid = "SUBJID"),
  ae_groups = NULL,
  sort_by_count = TRUE,
  total = TRUE,
  showNA = TRUE,
  digits = 0,
  warn_miss = FALSE
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

- data_ae:

  adverse event dataset, one row per AE, containing `subjid`, `grade`,
  `group1`, and potentially `group2`.

- ...:

  unused

- data_pat:

  enrollment dataset, one row per patient, containing `subjid` (and
  `arm` if needed). All patients should be in this dataset.

- measure:

  one or several of `c("max", "sup", "eq")`. `max` computes the maximum
  AE grade per patient, `sup` computes the number of patients having
  experienced at least one AE of grade higher or equal to X, and `eq`
  computes the number of patients having experienced at least one AE of
  grade equal to X.

- group1, group2:

  name of the 1st and 2nd order grouping columns in `data_ae`.
  Case-insensitive. Use labels for the flextable output. Usually,
  `group1` is the SOC and `group2` the term, but it can be any other
  grouping variable. `group2` can be set to `NULL` if not needed.

- arm:

  name of the treatment column in `data_pat`. Case-insensitive. Can be
  set to `NULL`.

- cols:

  a named character vector mapping column names. Should contain at least
  `grade` and `subjid`. Case-insensitive.

- ae_groups:

  a named list specifying the grade values for each group.

- sort_by_count:

  whether to sort by the number of AE or by `group1` alphabetically.

- total:

  whether to add a `total` column for each arm.

- showNA:

  whether to display missing grades. Only relevant if `ae_groups` is not
  used.

- digits:

  significant digits for percentages.

- warn_miss:

  whether to warn for missing values.

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

ae_table_soc(data_ae=ae, data_pat=enrolres)
#> # A tibble: 27 × 8
#>    group1    all_patients__g1 all_patients__g2 all_patients__g3 all_patients__g4
#>    <fct>     <glue>           <glue>           <glue>           <glue>          
#>  1 Eye diso… 21 (10%)         16 (8%)          9 (4%)           3 (2%)          
#>  2 Social c… 27 (14%)         12 (6%)          6 (3%)           4 (2%)          
#>  3 Congenit… 23 (12%)         10 (5%)          4 (2%)           5 (2%)          
#>  4 Injury, … 17 (8%)          13 (6%)          3 (2%)           2 (1%)          
#>  5 Immune s… 15 (8%)          9 (4%)           7 (4%)           3 (2%)          
#>  6 Pregnanc… 14 (7%)          12 (6%)          4 (2%)           3 (2%)          
#>  7 Neoplasm… 12 (6%)          12 (6%)          4 (2%)           2 (1%)          
#>  8 Hepatobi… 17 (8%)          8 (4%)           1 (0%)           2 (1%)          
#>  9 Surgical… 13 (6%)          10 (5%)          4 (2%)           1 (0%)          
#> 10 Cardiac … 11 (6%)          4 (2%)           7 (4%)           4 (2%)          
#> # ℹ 17 more rows
#> # ℹ 3 more variables: all_patients__g5 <glue>, all_patients__na <glue>,
#> #   all_patients__tot <glue>
ae_table_soc(data_ae=ae, data_pat=enrolres, arm="arm")
#> # A tibble: 27 × 15
#>    group1            control__g1 control__g2 control__g3 control__g4 control__g5
#>    <fct>             <glue>      <glue>      <glue>      <glue>      <glue>     
#>  1 Eye disorders     14 (14%)    11 (11%)    4 (4%)      2 (2%)      NA         
#>  2 Social circumsta… 16 (16%)    8 (8%)      3 (3%)      NA          NA         
#>  3 Congenital, fami… 10 (10%)    7 (7%)      2 (2%)      1 (1%)      NA         
#>  4 Injury, poisonin… 12 (12%)    8 (8%)      1 (1%)      1 (1%)      NA         
#>  5 Immune system di… 8 (8%)      4 (4%)      4 (4%)      2 (2%)      NA         
#>  6 Pregnancy, puerp… 7 (7%)      5 (5%)      2 (2%)      2 (2%)      NA         
#>  7 Neoplasms benign… 6 (6%)      7 (7%)      3 (3%)      1 (1%)      NA         
#>  8 Hepatobiliary di… 9 (9%)      3 (3%)      NA          2 (2%)      NA         
#>  9 Surgical and med… 6 (6%)      5 (5%)      2 (2%)      NA          NA         
#> 10 Cardiac disorders 7 (7%)      3 (3%)      4 (4%)      NA          NA         
#> # ℹ 17 more rows
#> # ℹ 9 more variables: control__na <glue>, control__tot <glue>,
#> #   treatment__g1 <glue>, treatment__g2 <glue>, treatment__g3 <glue>,
#> #   treatment__g4 <glue>, treatment__g5 <glue>, treatment__na <glue>,
#> #   treatment__tot <glue>

#sub population
ae_table_soc(data_ae=ae, data_pat=head(enrolres, 10), arm="arm")
#> # A tibble: 16 × 15
#>    group1            control__g1 control__g2 control__g3 control__g4 control__g5
#>    <fct>             <glue>      <glue>      <glue>      <glue>      <glue>     
#>  1 Eye disorders     3 (60%)     NA          1 (20%)     NA          NA         
#>  2 Pregnancy, puerp… 3 (60%)     1 (20%)     NA          NA          NA         
#>  3 Psychiatric diso… 1 (20%)     NA          NA          NA          NA         
#>  4 Social circumsta… 1 (20%)     NA          NA          NA          NA         
#>  5 Cardiac disorders NA          1 (20%)     NA          NA          NA         
#>  6 Metabolism and n… 1 (20%)     NA          NA          NA          NA         
#>  7 Neoplasms benign… NA          NA          2 (40%)     NA          NA         
#>  8 Surgical and med… NA          NA          NA          NA          NA         
#>  9 Congenital, fami… 1 (20%)     NA          NA          NA          NA         
#> 10 Ear and labyrint… 1 (20%)     NA          NA          NA          NA         
#> 11 Infections and i… 1 (20%)     NA          NA          NA          NA         
#> 12 Injury, poisonin… NA          1 (20%)     NA          NA          NA         
#> 13 Investigations    1 (20%)     NA          NA          NA          NA         
#> 14 Musculoskeletal … NA          NA          1 (20%)     NA          NA         
#> 15 Respiratory, tho… NA          NA          NA          NA          NA         
#> 16 Vascular disorde… 1 (20%)     NA          NA          NA          NA         
#> # ℹ 9 more variables: control__na <glue>, control__tot <glue>,
#> #   treatment__g1 <glue>, treatment__g2 <glue>, treatment__g3 <glue>,
#> #   treatment__g4 <glue>, treatment__g5 <glue>, treatment__na <glue>,
#> #   treatment__tot <glue>

#the resulting flextable can be customized using the flextable package
library(flextable)
ae_table_soc(ae, data_pat=enrolres, total=FALSE) %>%
  as_flextable() %>%
  hline(i=~group1=="" & group1!=dplyr::lead(group1))


.cl-afb7a634{table-layout:auto;}.cl-afafc8c4{font-family:'DejaVu Sans';font-size:8pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-afafc8d8{font-family:'DejaVu Sans';font-size:8pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-afb2e78e{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-afb2e7a2{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-afb2e7ac{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-afb2e7b6{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:0;padding-top:0;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-afb2e7b7{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:0;padding-top:0;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-afb309da{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-afb309db{background-color:rgba(242, 220, 219, 1.00);vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-afb309e4{background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-afb309ee{background-color:rgba(242, 220, 219, 1.00);vertical-align: middle;border-bottom: 1pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-afb309ef{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-afb309f0{background-color:rgba(242, 220, 219, 1.00);vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-afb309f8{background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-afb309f9{background-color:rgba(242, 220, 219, 1.00);vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}


```
