# Calculation of RECIST Best Overall Response in grstat

## Introduction

This vignette illustrates the calculation of RECIST endpoints in R using
the `grstat` package.

### RECIST definition

RECIST (Response Evaluation Criteria in Solid Tumors) is a standardized
way to quantify how solid tumors respond to therapy by comparing changes
in tumor burden on imaging. The four possible responses are:

- Complete Response (CR): disappearance of all target lesions,
- Partial Response (PR): ≥ 30% decrease in the sum of longest diameters
  from baseline,
- Stable Disease (SD): neither sufficient shrinkage for PR nor
  sufficient increase for progression,
- Progressive Disease (PD): ≥ 20% increase in the sum from the smallest
  measured value (the “nadir”) or the appearance of new lesions.

We follow the RECIST 1.1 guideline, DOI: 10.1016/j.ejca.2008.10.026,
available
[here](https://project.eortc.org/recist/wp-content/uploads/sites/4/2015/03/RECISTGuidelines.pdf).

### Endpoint definition

The Best Overall Response (BOR) is defined as the best response observed
for a patient during follow-up. BOR captures the maximum tumor shrinkage
achieved under treatment, reflecting the patient’s best observed
benefit, although it does not account for its duration.

Several summary endpoints are then defined as proportions derived from
BOR:

- Objective Response Rate (ORR): proportion of patients with BOR equal
  to complete response (CR) or partial response (PR).
- Clinical Benefit Rate (CBR): proportion of patients with BOR equal to
  CR, PR, or stable disease (SD) lasting at least a predefined duration
  (e.g., 6 months).
- Disease Control Rate (DCR): proportion of patients with BOR equal to
  CR, PR, or SD.

Note that ORR is sometimes defined at a specific time point rather than
based on BOR. Such definitions depend on follow-up duration and may
introduce ambiguity due to censoring and incomplete assessments.

### Confirmed and Unconfirmed Response

Most of the time, BOR is calculated based on the unconfirmed response,
but sometimes a confirmed response is required. We define unconfirmed
and confirmed responses as follows:

- An unconfirmed best response is defined as the best categorical
  response observed from treatment start until progression or end of
  follow-up.
- A confirmed best response is defined as the best categorical
  consecutive response (with a minimum delay of 28 days) observed from
  treatment start until progression or end of follow-up. For example:
  - A CR-CR-SD-PD sequence corresponds to a confirmed CR best response;
  - A PR-SD-SD-PR sequence corresponds to a confirmed SD best response;
  - A single NE (and a single SD if you follow the [PharmaSUG
    recommendation](https://pharmasug.org/proceedings/2023/QT/PharmaSUG-2023-QT-047.pdf))
    between two CR or two PR responses does not prevent confirmation.

See the RECIST 1.1 guidelines for more information.

## Data Preparation

To calculate BOR, we need a RECIST dataset in long format (one row per
patient assessment) containing at least the following columns:

- `subjid`, patient ID
- `rcdt`, evaluation date
- `rcresp`, global response
- `rctlsum`, sum of target lesions

In this vignette, we use
[`grstat_example()`](https://oncostat.github.io/grstat/reference/grstat_example.md)
to simulate such data.

Note that warnings about your RECIST data may appear, so be sure to take
them into account.

``` r
library(grstat)
library(tidyverse)
library(flextable)

db = grstat_example(N=200)
recist = db$recist %>% select(subjid, rcdt, rctlsum, rcresp)
recist %>% filter(subjid < 4)
```

    ## # A tibble: 10 × 4
    ##    subjid rcdt       rctlsum rcresp             
    ##     <int> <date>       <dbl> <fct>              
    ##  1      1 2023-01-22    91.1 NA                 
    ##  2      1 2023-03-07    46.2 Partial response   
    ##  3      1 2023-04-16     0   Complete response  
    ##  4      1 2023-05-31     0   Complete response  
    ##  5      1 2023-07-04     0   Complete response  
    ##  6      2 2023-03-12    17.4 NA                 
    ##  7      2 2023-04-23    40.6 Progressive disease
    ##  8      3 2023-03-30    70.4 NA                 
    ##  9      3 2023-05-13    79   Stable disease     
    ## 10      3 2023-06-29   144.  Progressive disease

## Calculation of BOR

The calculation of the Best Overall Response is performed using
[`calc_best_response()`](https://oncostat.github.io/grstat/reference/calc_best_response.md),
which takes the following parameters:

- `data_recist`, the RECIST data.frame
- `confirmed`, for a confirmed or unconfirmed response
- `cols`, a vector with column names (`subjid`, `rc_resp`, `rc_date`,
  and `rc_sum`, corresponding respectively to patient ID, global
  response, evaluation date, and sum of target lesions)

### Unconfirmed response

``` r
best_resp = calc_best_response(recist)
```

    ## Warning: Target Lesions Length Sum is missing at baseline. (2 patients:
    ## #72 and #193)

``` r
head(best_resp, n= 7L)
```

    ## # A tibble: 7 × 7
    ##   subjid best_response       date       target_sum target_sum_diff_first
    ##    <int> <fct>               <date>          <dbl>                 <dbl>
    ## 1      1 Complete response   2023-04-16        0                  -1    
    ## 2      2 Progressive disease 2023-04-23       40.6                 1.33 
    ## 3      3 Stable disease      2023-05-13       79                   0.122
    ## 4      4 Complete response   2023-05-17        0                  -1    
    ## 5      5 Complete response   2023-07-05        0                  -1    
    ## 6      6 Complete response   2023-08-31        0                  -1    
    ## 7      7 Partial response    2023-09-16       50.5                -0.512
    ## # ℹ 2 more variables: target_sum_diff_min <dbl>, six_months_confirmation <lgl>

As you can see, warnings may appear. You can use
[`check_recist()`](https://oncostat.github.io/grstat/reference/check_recist.md)
for more information.

If your column names aren’t recognized, you can specify them using the
`cols` parameter :

``` r
best_resp = calc_best_response(recist, cols = c(rc_resp="Glb_resp", subjid="Pat_Num"),)
```

### Confirmed response

``` r
confirmed_best_resp = calc_best_response(recist, confirmed = TRUE)
```

    ## Warning: Target Lesions Length Sum is missing at baseline. (2 patients:
    ## #72 and #193)

``` r
head(confirmed_best_resp, n = 7L)
```

    ## # A tibble: 7 × 7
    ##   subjid best_response       date       target_sum target_sum_diff_first
    ##    <int> <fct>               <date>          <dbl>                 <dbl>
    ## 1      1 Complete response   2023-04-16        0                  -1    
    ## 2      2 Progressive disease 2023-04-23       40.6                 1.33 
    ## 3      3 Stable disease      2023-05-13       79                   0.122
    ## 4      4 Complete response   2023-05-17        0                  -1    
    ## 5      5 Complete response   2023-07-05        0                  -1    
    ## 6      6 Complete response   2023-08-31        0                  -1    
    ## 7      7 Stable disease      2023-08-04      119.                  0.148
    ## # ℹ 2 more variables: target_sum_diff_min <dbl>, six_months_confirmation <lgl>

``` r
#To illustrate the difference between confirmed and unconfirmed responses, let's focus on patient 7.
recist %>% filter(subjid ==7)
```

    ## # A tibble: 4 × 4
    ##   subjid rcdt       rctlsum rcresp             
    ##    <int> <date>       <dbl> <fct>              
    ## 1      7 2023-06-22   103.  NA                 
    ## 2      7 2023-08-04   119.  Stable disease     
    ## 3      7 2023-09-16    50.5 Partial response   
    ## 4      7 2023-11-01   134.  Progressive disease

With the confirmed method, patient 7’s best response becomes Stable
Disease instead of Partial Response. The reason is that patient 7 has
Progressive Disease after the Partial Response. According to the
definition, the Partial Response cannot be confirmed. Therefore, the
confirmed best response is Stable Disease rather than Partial Response

## Calculate the different RECIST rates

To summarize patient-level responses and compute derived rates, we use
the
[`aggregate_recist_rates()`](https://oncostat.github.io/grstat/reference/aggregate_recist_rates.md)
function which consists of two parameters:

- `data`, the data.frame containing the best response obtained after
  using the function
  [`calc_best_response()`](https://oncostat.github.io/grstat/reference/calc_best_response.md)
  (confirmed or unconfirmed)
- `derived_endpoints=c("ORR", "CBR", "DCR")`, to specify the endpoints
  to display

``` r
tbl = aggregate_recist_rates(best_resp, derived_endpoints=c("ORR", "CBR", "DCR"))
tbl
```

    ## # A tibble: 8 × 4
    ##   best_response                     n     p ic_95      
    ## * <chr>                         <int> <dbl> <glue>     
    ## 1 Complete response                98  49   [41.9;56.1]
    ## 2 Partial response                 27  13.5 [9.1;19]   
    ## 3 Stable disease                   16   8   [4.6;12.7] 
    ## 4 Progressive disease              59  29.5 [23.3;36.3]
    ## 5 Not evaluable                     0   0   [0;1.8]    
    ## 6 Objective Response Rate (ORR)   125  62.5 [55.4;69.2]
    ## 7 Clinical Benefit Rate (CBR)     125  62.5 [55.4;69.2]
    ## 8 Disease Control Rate (DCR)      141  70.5 [63.7;76.7]

Since
[`aggregate_recist_rates()`](https://oncostat.github.io/grstat/reference/aggregate_recist_rates.md)
returns a classed data frame, we can use
[`as_flextable()`](https://davidgohel.github.io/flextable/reference/as_flextable.html)
(instead of simply
[`flextable()`](https://davidgohel.github.io/flextable/reference/flextable.html))
to convert it into a formatted flextable, on which you can apply any
modifier. Here, for example, we apply bold formatting to row 4 and add a
footnote to the third row of the CI column.

``` r
#Exampel with flextable modification:
tbl %>% 
  as_flextable() %>% 
  bold(i=4)%>%
  footnote(i = 3, j = 4,
                value = as_paragraph("This is note number 8"),
                ref_symbols ="8", part = "body")
```

| Unconfirmed Best Response during treatment                                                                                                     | N=200 | %    | IC 95%\*      |
|------------------------------------------------------------------------------------------------------------------------------------------------|-------|------|---------------|
| Complete response                                                                                                                              | 98    | 49.0 | \[41.9;56.1\] |
| Partial response                                                                                                                               | 27    | 13.5 | \[9.1;19\]    |
| Stable disease                                                                                                                                 | 16    | 8.0  | \[4.6;12.7\]8 |
| Progressive disease                                                                                                                            | 59    | 29.5 | \[23.3;36.3\] |
| Not evaluable                                                                                                                                  | 0     | 0.0  | \[0;1.8\]     |
| Objective Response Rate (ORR)ORR                                                                                                               | 125   | 62.5 | \[55.4;69.2\] |
| Clinical Benefit Rate (CBR)CBR                                                                                                                 | 125   | 62.5 | \[55.4;69.2\] |
| Disease Control Rate (DCR)DCR                                                                                                                  | 141   | 70.5 | \[63.7;76.7\] |
| \*Clopper-Pearson (Exact) method was used for confidence interval                                                                              |       |      |               |
| ORRORR was defined as the presence of a partial response (PR) or a complete response (CR).                                                     |       |      |               |
| CBRCBR was defined as the presence of a partial response (PR), a complete response (CR), or a stable disease (SD) lasting at least six months. |       |      |               |
| DCRDCR was defined as the presence of a partial response (PR), a complete response (CR), or a stable disease (SD).                             |       |      |               |
| 8This is note number 8                                                                                                                         |       |      |               |
