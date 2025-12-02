# Default mapping for RECIST dataset

**\[experimental\]**  
Generates the default mapping for a RECIST dataset. See sections below
for information on which columns are mandatory.

## Usage

``` r
gr_recist_mapping()
```

## Value

a named character vector

## Mandatory Columns

These columns **must** be present in the dataset for proper RECIST
assessment.

- **`subjid`**: Subject ID.

- **`rc_date`**: Date of response assessment.

- **`target_site`**: Site of the target lesion.

- **`target_diam`**: Diameter of the target lesion.

- **`target_resp`**: Response of the target lesion.

- **`nontarget_yn`**: Presence (`Yes/No`) of non-target lesions.

- **`nontarget_resp`**: Response of non-target lesions.

- **`new_lesions`**: Presence of new lesions (`Yes/No`).

- **`global_resp`**: Overall response assessment.

## Optional Columns

These columns are used for additional checks but are **not required**.

- **`target_is_node`**: Indicates whether the target lesion is a lymph
  node. If not set, it will be inferred based on the presence of the
  substring `"node"` in `target_site`

- **`target_method`**: Imaging method used for target lesion assessment.

- **`target_sum`**: Sum of diameters of target lesions.

- **`target_sum_bl`**: Baseline sum of target lesion diameters.

- **`target_sum_min`**: Minimum sum of target lesion diameters observed.

## Examples

``` r
gr_recist_mapping()
#>         subjid        rc_date    target_site    target_diam    target_resp 
#>       "SUBJID"         "RCDT"     "RCTLSITE"     "RCTLDIAM"     "RCTLRESP" 
#>   nontarget_yn nontarget_resp    new_lesions    global_resp target_is_node 
#>      "RCNTLYN"     "RCNTLRES"        "RCNEW"       "RCRESP"     "RCTLNODE" 
#>  target_method     target_sum  target_sum_bl target_sum_min 
#>      "RCTLMOD"      "RCTLSUM"       "RCTLBL"      "RCTLMIN" 
```
