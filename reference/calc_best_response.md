# Calculate Best RECIST Response

**\[experimental\]**  
Computes the best RECIST response per subject based on target lesion sum
and response categories. Ties are resolved using lesion sum, then by
date.

## Usage

``` r
calc_best_response(
  data_recist,
  ...,
  rc_sum = "RCTLSUM",
  rc_resp = "RCRESP",
  rc_date = "RCDT",
  subjid = "SUBJID",
  exclude_post_pd = TRUE,
  warnings = getOption("grstat_best_resp_warnings", TRUE)
)
```

## Arguments

- data_recist:

  A dataset containing longitudinal RECIST data in long format.

- ...:

  Not used. Ensures that only named arguments are passed.

- rc_sum:

  The column containing the sum of target lesions. Default is
  `"RCTLSUM"`.

- rc_resp:

  The column containing the RECIST response (e.g., `"CR"`, `"PR"`,
  `"SD"`, `"PD"`). Default is `"RCRESP"`.

- rc_date:

  The column containing the assessment date. Default is `"RCDT"`.

- subjid:

  The column containing the subject ID. Default is `"SUBJID"`.

- exclude_post_pd:

  Logical; if `TRUE` (default), assessments after the first PD are
  excluded.

- warnings:

  Logical; if `TRUE` (default is taken from
  `getOption("grstat_best_resp_warnings", TRUE)`), emits warnings during
  internal checks.

## Value

A tibble with one row per subject, containing:

- `subjid`: Subject ID

- `best_response`: The best RECIST response observed before progression

- `date`: The date corresponding to the best response

- `target_sum`: Sum of target lesions at that date

- `target_sum_diff_first`: Relative difference in target sum compared to
  baseline

- `target_sum_diff_min`: Relative difference in target sum compared to
  the minimum observed

## Details

The function identifies the best response using the following logic:

1.  Responses are ordered: `CR` \> `PR` \> `SD` \> `PD` \> `Missing`

2.  Among the best responses, the one with the smallest target lesion
    sum is selected

3.  If still tied, the earliest assessment date is selected

4.  Only subjects with at least two assessments and non-missing target
    sum are considered

5.  By default, all assessments after the first PD are excluded
    (`exclude_post_pd = TRUE`)

## Examples

``` r
db = grstat_example()
db$recist %>%
  calc_best_response()
#> Warning: Function `calc_best_response()` (`?grstat::calc_best_response()`) is not yet
#> validated and may produce incorrect results.
#> ! Always double-check the results using your own code.
#> ℹ Please send your feedback to the grstat team.
#> This warning is displayed once every 8 hours.
#> Warning: Target Lesions Length Sum is missing at baseline. (2 patients: #72 and #193)
#> # A tibble: 199 × 6
#>    subjid best_response       date       target_sum target_sum_diff_first
#>     <int> <fct>               <date>          <dbl>                 <dbl>
#>  1      1 Complete response   2023-04-16        0                  -1    
#>  2      2 Progressive disease 2023-04-23       40.6                 1.33 
#>  3      3 Stable disease      2023-05-13       79                   0.122
#>  4      4 Complete response   2023-05-17        0                  -1    
#>  5      5 Complete response   2023-07-05        0                  -1    
#>  6      6 Complete response   2023-08-31        0                  -1    
#>  7      7 Partial response    2023-09-16       50.5                -0.512
#>  8      8 Partial response    2023-09-10       17.9                -0.469
#>  9      9 Partial response    2024-01-12        0                  -1    
#> 10     10 Complete response   2024-01-11        0                  -1    
#> # ℹ 189 more rows
#> # ℹ 1 more variable: target_sum_diff_min <dbl>
```
