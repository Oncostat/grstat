# Summary tables for AE

**\[stable\]**  
The function `ae_table_grade()` creates a summary table of maximum AE
grades for each patient according to the CTCAE grade. The resulting
dataframe can be piped to
[`as_flextable()`](https://davidgohel.github.io/flextable/reference/as_flextable.html)
to get a nicely formatted flextable.

## Usage

``` r
ae_table_grade(
  df_ae,
  ...,
  df_enrol,
  variant = c("max", "sup", "eq"),
  arm = NULL,
  grade = "AEGR",
  subjid = "SUBJID",
  ae_label = "AE",
  percent = TRUE,
  digits = 2,
  total = TRUE
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

- grade:

  name of the AE grade column in `df_ae`. Case-insensitive.

- subjid:

  name of the patient ID in both `df_ae` and `df_enrol`.
  Case-insensitive.

- ae_label:

  the label of adverse events, usually "AE" or "SAE".

- percent:

  whether to show percentages with counts. Defaults to TRUE. Can also be
  "only" to not show counts.

- digits:

  significant digits for percentages.

- total:

  whether to add a `total` column for each arm.

## Value

a crosstable

## See also

`ae_table_grade()`,
[`ae_table_soc()`](https://oncostat.github.io/grstat/reference/ae_table_soc.md),
[`ae_plot_grade()`](https://oncostat.github.io/grstat/reference/ae_plot_grade.md),
[`ae_plot_grade_sum()`](https://oncostat.github.io/grstat/reference/ae_plot_grade_sum.md),
[`butterfly_plot()`](https://oncostat.github.io/grstat/reference/butterfly_plot.md)

## Examples

``` r
tm = grstat_example()
attach(tm, warn.conflicts=FALSE)

ae_table_grade(df_ae=ae, df_enrol=enrolres, arm=NULL) %>%
  as_flextable(header_show_n=TRUE)


.cl-4a508ac8{table-layout:auto;}.cl-4a4668fe{font-family:'DejaVu Sans';font-size:11pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-4a46691c{font-family:'DejaVu Sans';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-4a4a04aa{margin:0;text-align:center;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-4a4a04be{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-4a4a3a42{background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(0, 0, 0, 1.00);border-top: 1.5pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-4a4a3a4c{background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 1.5pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-4a4a3a56{background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-4a4a3a60{background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-4a4a3a6a{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-4a4a3a6b{background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-4a4a3a6c{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-4a4a3a74{background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-4a4a3a7e{background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}



label
```

variable

Treatment arm

All patients (N=200)

Patient maximum AE grade

No declared AE

8 (4%)

Grade 1

38 (19%)

Grade 2

62 (31%)

Grade 3

54 (27%)

Grade 4

34 (17%)

Grade 5

4 (2%)

Patient had at least one AE of grade

No declared AE

8 (4%)

Grade ≥ 1

192 (96%)

Grade ≥ 2

154 (77%)

Grade ≥ 3

92 (46%)

Grade ≥ 4

38 (19%)

Grade = 5

4 (2%)

Patient had at least one AE of grade

No declared AE

8 (4%)

Grade 1

164 (82%)

Grade 2

110 (55%)

Grade 3

62 (31%)

Grade 4

36 (18%)

Grade 5

4 (2%)

ae_table_grade(df_ae=ae, df_enrol=enrolres, arm="arm")
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
[as_flextable](https://davidgohel.github.io/flextable/reference/as_flextable.html)(header_show_n=TRUE)

| label                                 | variable       | Treatment arm   |                   | Total     |
|---------------------------------------|----------------|-----------------|-------------------|-----------|
|                                       |                | Control (N=100) | Treatment (N=100) |           |
| Patient maximum AE grade              | No declared AE | 3 (3%)          | 5 (5%)            | 8 (4%)    |
|                                       | Grade 1        | 23 (23%)        | 15 (15%)          | 38 (19%)  |
|                                       | Grade 2        | 32 (32%)        | 30 (30%)          | 62 (31%)  |
|                                       | Grade 3        | 27 (27%)        | 27 (27%)          | 54 (27%)  |
|                                       | Grade 4        | 13 (13%)        | 21 (21%)          | 34 (17%)  |
|                                       | Grade 5        | 2 (2%)          | 2 (2%)            | 4 (2%)    |
| Patient had at least one AE of grade  | No declared AE | 3 (3%)          | 5 (5%)            | 8 (4%)    |
|                                       | Grade ≥ 1      | 97 (97%)        | 95 (95%)          | 192 (96%) |
|                                       | Grade ≥ 2      | 74 (74%)        | 80 (80%)          | 154 (77%) |
|                                       | Grade ≥ 3      | 42 (42%)        | 50 (50%)          | 92 (46%)  |
|                                       | Grade ≥ 4      | 15 (15%)        | 23 (23%)          | 38 (19%)  |
|                                       | Grade = 5      | 2 (2%)          | 2 (2%)            | 4 (2%)    |
| Patient had at least one AE of grade  | No declared AE | 3 (3%)          | 5 (5%)            | 8 (4%)    |
|                                       | Grade 1        | 85 (85%)        | 79 (79%)          | 164 (82%) |
|                                       | Grade 2        | 59 (59%)        | 51 (51%)          | 110 (55%) |
|                                       | Grade 3        | 30 (30%)        | 32 (32%)          | 62 (31%)  |
|                                       | Grade 4        | 14 (14%)        | 22 (22%)          | 36 (18%)  |
|                                       | Grade 5        | 2 (2%)          | 2 (2%)            | 4 (2%)    |

\#To get SAE only, filter df_ae first ae
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
dplyr::[filter](https://dplyr.tidyverse.org/reference/filter.html)(sae=="Yes")
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
ae_table_grade(df_enrol=enrolres, arm="arm", ae_label="SAE")
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
[as_flextable](https://davidgohel.github.io/flextable/reference/as_flextable.html)(header_show_n=TRUE)

| label                                  | variable        | Treatment arm   |                   | Total     |
|----------------------------------------|-----------------|-----------------|-------------------|-----------|
|                                        |                 | Control (N=100) | Treatment (N=100) |           |
| Patient maximum SAE grade              | No declared SAE | 73 (73%)        | 71 (71%)          | 144 (72%) |
|                                        | Grade 1         | 9 (9%)          | 8 (8%)            | 17 (8%)   |
|                                        | Grade 2         | 8 (8%)          | 8 (8%)            | 16 (8%)   |
|                                        | Grade 3         | 5 (5%)          | 6 (6%)            | 11 (6%)   |
|                                        | Grade 4         | 5 (5%)          | 6 (6%)            | 11 (6%)   |
|                                        | Grade 5         | 0 (0%)          | 1 (1%)            | 1 (0%)    |
| Patient had at least one SAE of grade  | No declared SAE | 73 (73%)        | 71 (71%)          | 144 (72%) |
|                                        | Grade ≥ 1       | 27 (27%)        | 29 (29%)          | 56 (28%)  |
|                                        | Grade ≥ 2       | 18 (18%)        | 21 (21%)          | 39 (20%)  |
|                                        | Grade ≥ 3       | 10 (10%)        | 13 (13%)          | 23 (12%)  |
|                                        | Grade ≥ 4       | 5 (5%)          | 7 (7%)            | 12 (6%)   |
|                                        | Grade = 5       | 0 (0%)          | 1 (1%)            | 1 (0%)    |
| Patient had at least one SAE of grade  | No declared SAE | 73 (73%)        | 71 (71%)          | 144 (72%) |
|                                        | Grade 1         | 10 (10%)        | 8 (8%)            | 18 (9%)   |
|                                        | Grade 2         | 11 (11%)        | 8 (8%)            | 19 (10%)  |
|                                        | Grade 3         | 5 (5%)          | 8 (8%)            | 13 (6%)   |
|                                        | Grade 4         | 5 (5%)          | 6 (6%)            | 11 (6%)   |
|                                        | Grade 5         | 0 (0%)          | 1 (1%)            | 1 (0%)    |

\#To describe a sub-population, filter df_enrol first enrolres2 =
enrolres [%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
dplyr::[filter](https://dplyr.tidyverse.org/reference/filter.html)(arm=="Control")
ae [%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
ae_table_grade(df_enrol=enrolres2, arm="arm")
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
[as_flextable](https://davidgohel.github.io/flextable/reference/as_flextable.html)(header_show_n=TRUE)

| label                                 | variable       | Treatment arm   |                 | Total    |
|---------------------------------------|----------------|-----------------|-----------------|----------|
|                                       |                | Control (N=100) | Treatment (N=0) |          |
| Patient maximum AE grade              | No declared AE | 3 (3%)          | 0 (NA)          | 3 (3%)   |
|                                       | Grade 1        | 23 (23%)        | 0 (NA)          | 23 (23%) |
|                                       | Grade 2        | 32 (32%)        | 0 (NA)          | 32 (32%) |
|                                       | Grade 3        | 27 (27%)        | 0 (NA)          | 27 (27%) |
|                                       | Grade 4        | 13 (13%)        | 0 (NA)          | 13 (13%) |
|                                       | Grade 5        | 2 (2%)          | 0 (NA)          | 2 (2%)   |
| Patient had at least one AE of grade  | No declared AE | 3 (3%)          | 0 (NA)          | 3 (3%)   |
|                                       | Grade ≥ 1      | 97 (97%)        | 0 (NA)          | 97 (97%) |
|                                       | Grade ≥ 2      | 74 (74%)        | 0 (NA)          | 74 (74%) |
|                                       | Grade ≥ 3      | 42 (42%)        | 0 (NA)          | 42 (42%) |
|                                       | Grade ≥ 4      | 15 (15%)        | 0 (NA)          | 15 (15%) |
|                                       | Grade = 5      | 2 (2%)          | 0 (NA)          | 2 (2%)   |
| Patient had at least one AE of grade  | No declared AE | 3 (3%)          | 0 (NA)          | 3 (3%)   |
|                                       | Grade 1        | 85 (85%)        | 0 (NA)          | 85 (85%) |
|                                       | Grade 2        | 59 (59%)        | 0 (NA)          | 59 (59%) |
|                                       | Grade 3        | 30 (30%)        | 0 (NA)          | 30 (30%) |
|                                       | Grade 4        | 14 (14%)        | 0 (NA)          | 14 (14%) |
|                                       | Grade 5        | 2 (2%)          | 0 (NA)          | 2 (2%)   |

\#You can also filter the AE table ae
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
ae_table_grade(df_enrol=enrolres, arm="arm")
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
dplyr::[filter](https://dplyr.tidyverse.org/reference/filter.html)(!variable
[%in%](https://rdrr.io/r/base/match.html)
[c](https://rdrr.io/r/base/c.html)("Grade 1", "Grade 2"))
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
[as_flextable](https://davidgohel.github.io/flextable/reference/as_flextable.html)(header_show_n=TRUE)

| label                                 | variable       | Treatment arm   |                   | Total     |
|---------------------------------------|----------------|-----------------|-------------------|-----------|
|                                       |                | Control (N=100) | Treatment (N=100) |           |
| Patient maximum AE grade              | No declared AE | 3 (3%)          | 5 (5%)            | 8 (4%)    |
|                                       | Grade 3        | 27 (27%)        | 27 (27%)          | 54 (27%)  |
|                                       | Grade 4        | 13 (13%)        | 21 (21%)          | 34 (17%)  |
|                                       | Grade 5        | 2 (2%)          | 2 (2%)            | 4 (2%)    |
| Patient had at least one AE of grade  | No declared AE | 3 (3%)          | 5 (5%)            | 8 (4%)    |
|                                       | Grade ≥ 1      | 97 (97%)        | 95 (95%)          | 192 (96%) |
|                                       | Grade ≥ 2      | 74 (74%)        | 80 (80%)          | 154 (77%) |
|                                       | Grade ≥ 3      | 42 (42%)        | 50 (50%)          | 92 (46%)  |
|                                       | Grade ≥ 4      | 15 (15%)        | 23 (23%)          | 38 (19%)  |
|                                       | Grade = 5      | 2 (2%)          | 2 (2%)            | 4 (2%)    |
| Patient had at least one AE of grade  | No declared AE | 3 (3%)          | 5 (5%)            | 8 (4%)    |
|                                       | Grade 3        | 30 (30%)        | 32 (32%)          | 62 (31%)  |
|                                       | Grade 4        | 14 (14%)        | 22 (22%)          | 36 (18%)  |
|                                       | Grade 5        | 2 (2%)          | 2 (2%)            | 4 (2%)    |
