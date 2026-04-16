# Calculate BOR

**\[experimental\]**  
The function `aggregate_recist_rates()` creates a summary table of
recist for each possible response. The resulting dataframe can be piped
to
[`as_flextable()`](https://davidgohel.github.io/flextable/reference/as_flextable.html)
to get a nicely formatted flextable.

## Usage

``` r
aggregate_recist_rates(data, ..., derived_endpoints = c("ORR", "CBR", "DCR"))

# S3 method for class 'aggregate_recist_rates'
as_flextable(x, ...)
```

## Arguments

- data:

  A dataset containing longitudinal RECIST data in long format.

- ...:

  unused

- derived_endpoints:

  Character; Derived endpoints to compute from BOR. One or several of
  c("ORR", "CBR", "DCR"). See vignette("BOR") for endpoint definitions.

- x:

  a dataframe, resulting of `aggregate_recist_rates()`

## Value

a dataframe (`aggregate_recist_rates()`) or a flextable
([`as_flextable()`](https://davidgohel.github.io/flextable/reference/as_flextable.html)).

a formatted flextable

## Examples

``` r
recist = grstat_example()$recist
recist %>%
 calc_best_response(rc_resp = "rcresp", rc_date = "rcdt",
                    subjid = "subjid", rc_sum = "rctlsum", confirmed = FALSE) %>%
 aggregate_recist_rates(derived_endpoints=c("ORR", "CBR", "DCR")) %>%
 as_flextable()
#> Warning: Function `calc_best_response()` (`?grstat::calc_best_response()`) is not yet
#> validated and may produce incorrect results.
#> ! Always double-check the results using your own code.
#> ℹ Please send your feedback to the grstat team.
#> This warning is displayed once every 8 hours.
#> Warning: Target Lesions Length Sum is missing at baseline. (2 patients: #72 and #193)


.cl-e15bf602{table-layout:auto;}.cl-e154efa6{font-family:'DejaVu Sans';font-size:11pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-e154efba{font-family:'DejaVu Sans';font-size:6.6pt;font-weight:bold;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;vertical-align:super;}.cl-e154efc4{font-family:'DejaVu Sans';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-e154efc5{font-family:'DejaVu Sans';font-size:6.6pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;vertical-align:super;}.cl-e1580326{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e158033a{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e158033b{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e1580344{margin:0;text-align:right;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e1582388{background-color:transparent;vertical-align: bottom;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e1582392{background-color:transparent;vertical-align: bottom;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e158239c{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e158239d{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e15823a6{background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e15823a7{background-color:transparent;vertical-align: middle;border-bottom: 1pt solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e15823a8{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e15823b0{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 1pt solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e15823b1{background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e15823ba{background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e15823bb{background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(255, 255, 255, 0.00);border-top: 0 solid rgba(255, 255, 255, 0.00);border-left: 0 solid rgba(255, 255, 255, 0.00);border-right: 0 solid rgba(255, 255, 255, 0.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}


Unconfirmed Best Response during treatment
```

N=200

%

IC 95%\*

Complete response

98

49.0

\[41.9;56.1\]

Partial response

27

13.5

\[9.1;19\]

Stable disease

16

8.0

\[4.6;12.7\]

Progressive disease

59

29.5

\[23.3;36.3\]

Not evaluable

0

0.0

\[0;1.8\]

Objective Response Rate (ORR)ORR

125

62.5

\[55.4;69.2\]

Clinical Benefit Rate (CBR)CBR

125

62.5

\[55.4;69.2\]

Disease Control Rate (DCR)DCR

141

70.5

\[63.7;76.7\]

\*Clopper-Pearson (Exact) method was used for confidence interval

ORRORR was defined as the presence of a partial response (PR) or a
complete response (CR).

CBRCBR was defined as the presence of a partial response (PR), a
complete response (CR), or a stable disease (SD) lasting at least six
months.

DCRDCR was defined as the presence of a partial response (PR), a
complete response (CR), or a stable disease (SD).

\#It is also possible to use the confirmation method for the ORR recist
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
[calc_best_response](https://oncostat.github.io/grstat/reference/calc_best_response.md)(rc_resp
= "rcresp", rc_date = "rcdt", subjid = "subjid", rc_sum = "rctlsum",
confirmed = TRUE)
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
aggregate_recist_rates(derived_endpoints=[c](https://rdrr.io/r/base/c.html)("ORR"))
[%\>%](https://magrittr.tidyverse.org/reference/pipe.html)
[as_flextable](https://davidgohel.github.io/flextable/reference/as_flextable.html)()
\#\> Warning: Target Lesions Length Sum is missing at baseline. (2
patients: \#72 and \#193)

| Confirmed Best Response during treatment\*\*                                                                                                    | N=200 | %    | IC 95%\*      |
|-------------------------------------------------------------------------------------------------------------------------------------------------|-------|------|---------------|
| Complete response                                                                                                                               | 83    | 41.5 | \[34.6;48.7\] |
| Partial response                                                                                                                                | 18    | 9.0  | \[5.4;13.9\]  |
| Stable disease                                                                                                                                  | 40    | 20.0 | \[14.7;26.2\] |
| Progressive disease                                                                                                                             | 59    | 29.5 | \[23.3;36.3\] |
| Not evaluable                                                                                                                                   | 0     | 0.0  | \[0;1.8\]     |
| Objective Response Rate (ORR)ORR                                                                                                                | 101   | 50.5 | \[43.4;57.6\] |
| \*Clopper-Pearson (Exact) method was used for confidence interval                                                                               |       |      |               |
| \*\*For CR & PR, confirmation of response had to be be demonstrated with an assessment 4 weeks or later from the initial response for response. |       |      |               |
| ORRORR was defined as the presence of a partial response (PR) or a complete response (CR).                                                      |       |      |               |
