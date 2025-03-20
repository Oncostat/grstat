# ae_tables simplest snapshot

    Code
      df_ae = tibble(subjid = rep(1:2, each = 5), aesoc = rep("Soc1", 10), aegr = c(1:4, NA, 2:5, NA))
      df_enrolres = tibble(subjid = 1:2, arm = "Foobar")
      ae_table_soc(df_ae = df_ae, df_enrol = df_enrolres, variant = "max")
    Output
      # A tibble: 1 x 8
        soc   all_patients_G1 all_patients_G2 all_patients_G3 all_patients_G4 all_patients_G5 all_patients_NA all_patients_Tot
        <fct> <glue>          <glue>          <glue>          <glue>          <glue>          <glue>          <glue>          
      1 Soc1  <NA>            <NA>            <NA>            1 (50%)         1 (50%)         <NA>            2 (100%)        
    Code
      ae_table_soc(df_ae = df_ae, df_enrol = df_enrolres, variant = "sup")
    Condition
      Warning:
      Total has been set to `FALSE` as totals are not very interpretable when `variant` is "sup" or "eq". Set `total=FALSE` explicitly to silence this warning.
    Output
      # A tibble: 1 x 7
        soc   all_patients_G1 all_patients_G2 all_patients_G3 all_patients_G4 all_patients_G5 all_patients_NA
        <fct> <glue>          <glue>          <glue>          <glue>          <glue>          <glue>         
      1 Soc1  2 (100%)        2 (100%)        2 (100%)        2 (100%)        1 (50%)         <NA>           
    Code
      ae_table_soc(df_ae = df_ae, df_enrol = df_enrolres, variant = "eq")
    Condition
      Warning:
      Total has been set to `FALSE` as totals are not very interpretable when `variant` is "sup" or "eq". Set `total=FALSE` explicitly to silence this warning.
    Output
      # A tibble: 1 x 7
        soc   all_patients_G1 all_patients_G2 all_patients_G3 all_patients_G4 all_patients_G5 all_patients_NA
        <fct> <glue>          <glue>          <glue>          <glue>          <glue>          <glue>         
      1 Soc1  1 (50%)         2 (100%)        2 (100%)        2 (100%)        1 (50%)         <NA>           
    Code
      ae_table_grade(df_ae = df_ae, df_enrol = df_enrolres, variant = "max")
    Output
      # A tibble: 2 x 4
        .id       label                    variable `All patients`
        <fct>     <fct>                    <fct>    <chr>         
      1 max_grade Patient maximum AE grade Grade 4  1 (50%)       
      2 max_grade Patient maximum AE grade Grade 5  1 (50%)       
    Code
      ae_table_grade(df_ae = df_ae, df_enrol = df_enrolres, variant = "sup")
    Output
      # A tibble: 6 x 4
        .id           label                                variable          `All patients`
        <fct>         <fct>                                <fct>             <chr>         
      1 any_grade_sup Patient had at least one AE of grade Grade ≥ 1         2 (100%)      
      2 any_grade_sup Patient had at least one AE of grade Grade ≥ 2         2 (100%)      
      3 any_grade_sup Patient had at least one AE of grade Grade ≥ 3         2 (100%)      
      4 any_grade_sup Patient had at least one AE of grade Grade ≥ 4         2 (100%)      
      5 any_grade_sup Patient had at least one AE of grade Grade = 5         1 (50%)       
      6 any_grade_sup Patient had at least one AE of grade Any missing grade 2 (100%)      
    Code
      ae_table_grade(df_ae = df_ae, df_enrol = df_enrolres, variant = "eq")
    Output
      # A tibble: 6 x 4
        .id          label                                   variable          `All patients`
        <fct>        <fct>                                   <fct>             <chr>         
      1 any_grade_eq "Patient had at least one AE of grade " Grade 1           1 (50%)       
      2 any_grade_eq "Patient had at least one AE of grade " Grade 2           2 (100%)      
      3 any_grade_eq "Patient had at least one AE of grade " Grade 3           2 (100%)      
      4 any_grade_eq "Patient had at least one AE of grade " Grade 4           2 (100%)      
      5 any_grade_eq "Patient had at least one AE of grade " Grade 5           1 (50%)       
      6 any_grade_eq "Patient had at least one AE of grade " Any missing grade 2 (100%)      

# ae_table_grade() default snapshot

    Code
      tm = grstat_example()
      attach(tm)
      ae_table_grade(ae, df_enrol = enrolres)
    Output
      # A tibble: 18 x 4
         .id           label                                   variable       `All patients`
         <fct>         <fct>                                   <fct>          <chr>         
       1 max_grade     "Patient maximum AE grade"              No declared AE 3 (2%)        
       2 max_grade     "Patient maximum AE grade"              Grade 1        35 (18%)      
       3 max_grade     "Patient maximum AE grade"              Grade 2        62 (31%)      
       4 max_grade     "Patient maximum AE grade"              Grade 3        51 (26%)      
       5 max_grade     "Patient maximum AE grade"              Grade 4        39 (20%)      
       6 max_grade     "Patient maximum AE grade"              Grade 5        10 (5%)       
       7 any_grade_sup "Patient had at least one AE of grade"  No declared AE 3 (2%)        
       8 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1      197 (98%)     
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2      162 (81%)     
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3      100 (50%)     
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4      49 (24%)      
      12 any_grade_sup "Patient had at least one AE of grade"  Grade = 5      10 (5%)       
      13 any_grade_eq  "Patient had at least one AE of grade " No declared AE 3 (2%)        
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1        164 (82%)     
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2        117 (58%)     
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3        62 (31%)      
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4        44 (22%)      
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5        10 (5%)       
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM")
    Output
      # A tibble: 18 x 6
         .id           label                                   variable       Control  Treatment  Total    
         <fct>         <fct>                                   <fct>          <chr>    <chr>      <chr>    
       1 max_grade     "Patient maximum AE grade"              No declared AE 3 (3%)   0 (0%)     3 (2%)   
       2 max_grade     "Patient maximum AE grade"              Grade 1        27 (27%) 8 (8%)     35 (18%) 
       3 max_grade     "Patient maximum AE grade"              Grade 2        32 (32%) 30 (30%)   62 (31%) 
       4 max_grade     "Patient maximum AE grade"              Grade 3        23 (23%) 28 (28%)   51 (26%) 
       5 max_grade     "Patient maximum AE grade"              Grade 4        14 (14%) 25 (25%)   39 (20%) 
       6 max_grade     "Patient maximum AE grade"              Grade 5        1 (1%)   9 (9%)     10 (5%)  
       7 any_grade_sup "Patient had at least one AE of grade"  No declared AE 3 (3%)   0 (0%)     3 (2%)   
       8 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1      97 (97%) 100 (100%) 197 (98%)
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2      70 (70%) 92 (92%)   162 (81%)
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3      38 (38%) 62 (62%)   100 (50%)
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4      15 (15%) 34 (34%)   49 (24%) 
      12 any_grade_sup "Patient had at least one AE of grade"  Grade = 5      1 (1%)   9 (9%)     10 (5%)  
      13 any_grade_eq  "Patient had at least one AE of grade " No declared AE 3 (3%)   0 (0%)     3 (2%)   
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1        83 (83%) 81 (81%)   164 (82%)
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2        53 (53%) 64 (64%)   117 (58%)
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3        25 (25%) 37 (37%)   62 (31%) 
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4        15 (15%) 29 (29%)   44 (22%) 
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5        1 (1%)   9 (9%)     10 (5%)  
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM", variant = c("eq", "max"))
    Output
      # A tibble: 12 x 6
         .id          label                                   variable       Control  Treatment Total    
         <fct>        <fct>                                   <fct>          <chr>    <chr>     <chr>    
       1 any_grade_eq "Patient had at least one AE of grade " No declared AE 3 (3%)   0 (0%)    3 (2%)   
       2 any_grade_eq "Patient had at least one AE of grade " Grade 1        83 (83%) 81 (81%)  164 (82%)
       3 any_grade_eq "Patient had at least one AE of grade " Grade 2        53 (53%) 64 (64%)  117 (58%)
       4 any_grade_eq "Patient had at least one AE of grade " Grade 3        25 (25%) 37 (37%)  62 (31%) 
       5 any_grade_eq "Patient had at least one AE of grade " Grade 4        15 (15%) 29 (29%)  44 (22%) 
       6 any_grade_eq "Patient had at least one AE of grade " Grade 5        1 (1%)   9 (9%)    10 (5%)  
       7 max_grade    "Patient maximum AE grade"              No declared AE 3 (3%)   0 (0%)    3 (2%)   
       8 max_grade    "Patient maximum AE grade"              Grade 1        27 (27%) 8 (8%)    35 (18%) 
       9 max_grade    "Patient maximum AE grade"              Grade 2        32 (32%) 30 (30%)  62 (31%) 
      10 max_grade    "Patient maximum AE grade"              Grade 3        23 (23%) 28 (28%)  51 (26%) 
      11 max_grade    "Patient maximum AE grade"              Grade 4        14 (14%) 25 (25%)  39 (20%) 
      12 max_grade    "Patient maximum AE grade"              Grade 5        1 (1%)   9 (9%)    10 (5%)  
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM", percent = FALSE, total = FALSE)
    Output
      # A tibble: 18 x 5
         .id           label                                   variable       Control Treatment
         <fct>         <fct>                                   <fct>          <chr>   <chr>    
       1 max_grade     "Patient maximum AE grade"              No declared AE 3       0        
       2 max_grade     "Patient maximum AE grade"              Grade 1        27      8        
       3 max_grade     "Patient maximum AE grade"              Grade 2        32      30       
       4 max_grade     "Patient maximum AE grade"              Grade 3        23      28       
       5 max_grade     "Patient maximum AE grade"              Grade 4        14      25       
       6 max_grade     "Patient maximum AE grade"              Grade 5        1       9        
       7 any_grade_sup "Patient had at least one AE of grade"  No declared AE 3       0        
       8 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1      97      100      
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2      70      92       
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3      38      62       
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4      15      34       
      12 any_grade_sup "Patient had at least one AE of grade"  Grade = 5      1       9        
      13 any_grade_eq  "Patient had at least one AE of grade " No declared AE 3       0        
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1        83      81       
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2        53      64       
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3        25      37       
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4        15      29       
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5        1       9        

# ae_table_soc() default snapshot

    Code
      tm = grstat_example()
      attach(tm)
    Message
      The following objects are masked from tm (pos = 3):
      
          ae, date_extraction, datetime_extraction, enrolres
      
    Code
      ae_table_soc(ae, df_enrol = enrolres)
    Output
      # A tibble: 27 x 8
         soc                                                  all_patients_G1 all_patients_G2 all_patients_G3 all_patients_G4
         <fct>                                                <glue>          <glue>          <glue>          <glue>         
       1 Congenital, familial and genetic disorders           27 (14%)        15 (8%)         6 (3%)          3 (2%)         
       2 Social circumstances                                 19 (10%)        14 (7%)         7 (4%)          5 (2%)         
       3 Surgical and medical procedures                      26 (13%)        5 (2%)          8 (4%)          3 (2%)         
       4 Neoplasms benign, malignant, and unspecified         17 (8%)         11 (6%)         2 (1%)          7 (4%)         
       5 Eye disorders                                        19 (10%)        7 (4%)          7 (4%)          2 (1%)         
       6 Pregnancy, puerperium and perinatal conditions       18 (9%)         8 (4%)          7 (4%)          <NA>           
       7 Cardiac disorders                                    11 (6%)         8 (4%)          4 (2%)          5 (2%)         
       8 Injury, poisoning and procedural complications       11 (6%)         9 (4%)          8 (4%)          1 (0%)         
       9 Immune system disorders                              15 (8%)         7 (4%)          3 (2%)          2 (1%)         
      10 Endocrine disorders                                  10 (5%)         7 (4%)          4 (2%)          3 (2%)         
      11 Hepatobiliary disorders                              13 (6%)         9 (4%)          1 (0%)          1 (0%)         
      12 Psychiatric disorders                                16 (8%)         3 (2%)          2 (1%)          2 (1%)         
      13 Vascular disorders                                   12 (6%)         5 (2%)          2 (1%)          2 (1%)         
      14 Musculoskeletal and connective tissue disorders      9 (4%)          5 (2%)          2 (1%)          5 (2%)         
      15 Respiratory, thoracic and mediastinal disorders      8 (4%)          6 (3%)          2 (1%)          1 (0%)         
      16 Ear and labyrinth disorders                          10 (5%)         5 (2%)          1 (0%)          <NA>           
      17 Metabolism and nutrition disorders                   7 (4%)          3 (2%)          4 (2%)          <NA>           
      18 General disorders and administration site conditions 8 (4%)          3 (2%)          <NA>            1 (0%)         
      19 Nervous system disorders                             7 (4%)          4 (2%)          <NA>            1 (0%)         
      20 Skin and subcutaneous tissue disorders               4 (2%)          5 (2%)          1 (0%)          2 (1%)         
      21 Infections and infestations                          6 (3%)          3 (2%)          <NA>            1 (0%)         
      22 Blood and lymphatic system disorders                 6 (3%)          1 (0%)          1 (0%)          <NA>           
      23 Gastrointestinal disorders                           2 (1%)          2 (1%)          4 (2%)          1 (0%)         
      24 Reproductive system and breast disorders             7 (4%)          2 (1%)          <NA>            <NA>           
      25 Investigations                                       4 (2%)          2 (1%)          1 (0%)          1 (0%)         
      26 Renal and urinary disorders                          1 (0%)          3 (2%)          1 (0%)          1 (0%)         
      27 No Declared AE                                       <NA>            <NA>            <NA>            <NA>           
         all_patients_G5 all_patients_NA all_patients_Tot
         <glue>          <glue>          <glue>          
       1 <NA>            <NA>            51 (26%)        
       2 <NA>            <NA>            45 (22%)        
       3 1 (0%)          <NA>            43 (22%)        
       4 2 (1%)          <NA>            39 (20%)        
       5 <NA>            <NA>            35 (18%)        
       6 <NA>            <NA>            33 (16%)        
       7 2 (1%)          <NA>            30 (15%)        
       8 1 (0%)          <NA>            30 (15%)        
       9 <NA>            <NA>            27 (14%)        
      10 <NA>            <NA>            24 (12%)        
      11 <NA>            <NA>            24 (12%)        
      12 1 (0%)          <NA>            24 (12%)        
      13 1 (0%)          <NA>            22 (11%)        
      14 <NA>            <NA>            21 (10%)        
      15 1 (0%)          <NA>            18 (9%)         
      16 <NA>            <NA>            16 (8%)         
      17 <NA>            <NA>            14 (7%)         
      18 <NA>            <NA>            12 (6%)         
      19 <NA>            <NA>            12 (6%)         
      20 <NA>            <NA>            12 (6%)         
      21 <NA>            <NA>            10 (5%)         
      22 1 (0%)          <NA>            9 (4%)          
      23 <NA>            <NA>            9 (4%)          
      24 <NA>            <NA>            9 (4%)          
      25 <NA>            <NA>            8 (4%)          
      26 <NA>            <NA>            6 (3%)          
      27 <NA>            3 (2%)          3 (2%)          
    Code
      ae_table_soc(ae, df_enrol = enrolres, sort_by_count = FALSE)
    Output
      # A tibble: 27 x 8
         soc                                                  all_patients_G1 all_patients_G2 all_patients_G3 all_patients_G4
         <fct>                                                <glue>          <glue>          <glue>          <glue>         
       1 Blood and lymphatic system disorders                 6 (3%)          1 (0%)          1 (0%)          <NA>           
       2 Cardiac disorders                                    11 (6%)         8 (4%)          4 (2%)          5 (2%)         
       3 Congenital, familial and genetic disorders           27 (14%)        15 (8%)         6 (3%)          3 (2%)         
       4 Ear and labyrinth disorders                          10 (5%)         5 (2%)          1 (0%)          <NA>           
       5 Endocrine disorders                                  10 (5%)         7 (4%)          4 (2%)          3 (2%)         
       6 Eye disorders                                        19 (10%)        7 (4%)          7 (4%)          2 (1%)         
       7 Gastrointestinal disorders                           2 (1%)          2 (1%)          4 (2%)          1 (0%)         
       8 General disorders and administration site conditions 8 (4%)          3 (2%)          <NA>            1 (0%)         
       9 Hepatobiliary disorders                              13 (6%)         9 (4%)          1 (0%)          1 (0%)         
      10 Immune system disorders                              15 (8%)         7 (4%)          3 (2%)          2 (1%)         
      11 Infections and infestations                          6 (3%)          3 (2%)          <NA>            1 (0%)         
      12 Injury, poisoning and procedural complications       11 (6%)         9 (4%)          8 (4%)          1 (0%)         
      13 Investigations                                       4 (2%)          2 (1%)          1 (0%)          1 (0%)         
      14 Metabolism and nutrition disorders                   7 (4%)          3 (2%)          4 (2%)          <NA>           
      15 Musculoskeletal and connective tissue disorders      9 (4%)          5 (2%)          2 (1%)          5 (2%)         
      16 Neoplasms benign, malignant, and unspecified         17 (8%)         11 (6%)         2 (1%)          7 (4%)         
      17 Nervous system disorders                             7 (4%)          4 (2%)          <NA>            1 (0%)         
      18 Pregnancy, puerperium and perinatal conditions       18 (9%)         8 (4%)          7 (4%)          <NA>           
      19 Psychiatric disorders                                16 (8%)         3 (2%)          2 (1%)          2 (1%)         
      20 Renal and urinary disorders                          1 (0%)          3 (2%)          1 (0%)          1 (0%)         
      21 Reproductive system and breast disorders             7 (4%)          2 (1%)          <NA>            <NA>           
      22 Respiratory, thoracic and mediastinal disorders      8 (4%)          6 (3%)          2 (1%)          1 (0%)         
      23 Skin and subcutaneous tissue disorders               4 (2%)          5 (2%)          1 (0%)          2 (1%)         
      24 Social circumstances                                 19 (10%)        14 (7%)         7 (4%)          5 (2%)         
      25 Surgical and medical procedures                      26 (13%)        5 (2%)          8 (4%)          3 (2%)         
      26 Vascular disorders                                   12 (6%)         5 (2%)          2 (1%)          2 (1%)         
      27 No Declared AE                                       <NA>            <NA>            <NA>            <NA>           
         all_patients_G5 all_patients_NA all_patients_Tot
         <glue>          <glue>          <glue>          
       1 1 (0%)          <NA>            9 (4%)          
       2 2 (1%)          <NA>            30 (15%)        
       3 <NA>            <NA>            51 (26%)        
       4 <NA>            <NA>            16 (8%)         
       5 <NA>            <NA>            24 (12%)        
       6 <NA>            <NA>            35 (18%)        
       7 <NA>            <NA>            9 (4%)          
       8 <NA>            <NA>            12 (6%)         
       9 <NA>            <NA>            24 (12%)        
      10 <NA>            <NA>            27 (14%)        
      11 <NA>            <NA>            10 (5%)         
      12 1 (0%)          <NA>            30 (15%)        
      13 <NA>            <NA>            8 (4%)          
      14 <NA>            <NA>            14 (7%)         
      15 <NA>            <NA>            21 (10%)        
      16 2 (1%)          <NA>            39 (20%)        
      17 <NA>            <NA>            12 (6%)         
      18 <NA>            <NA>            33 (16%)        
      19 1 (0%)          <NA>            24 (12%)        
      20 <NA>            <NA>            6 (3%)          
      21 <NA>            <NA>            9 (4%)          
      22 1 (0%)          <NA>            18 (9%)         
      23 <NA>            <NA>            12 (6%)         
      24 <NA>            <NA>            45 (22%)        
      25 1 (0%)          <NA>            43 (22%)        
      26 1 (0%)          <NA>            22 (11%)        
      27 <NA>            3 (2%)          3 (2%)          
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", digits = 1)
    Output
      # A tibble: 27 x 15
         soc                                                  control_G1 control_G2 control_G3 control_G4 control_G5 control_NA
         <fct>                                                <glue>     <glue>     <glue>     <glue>     <glue>     <glue>    
       1 Congenital, familial and genetic disorders           18 (18%)   7 (7%)     2 (2%)     2 (2%)     <NA>       <NA>      
       2 Social circumstances                                 13 (13%)   5 (5%)     3 (3%)     <NA>       <NA>       <NA>      
       3 Surgical and medical procedures                      18 (18%)   2 (2%)     2 (2%)     <NA>       <NA>       <NA>      
       4 Neoplasms benign, malignant, and unspecified         9 (9%)     5 (5%)     <NA>       3 (3%)     1 (1%)     <NA>      
       5 Eye disorders                                        7 (7%)     2 (2%)     3 (3%)     2 (2%)     <NA>       <NA>      
       6 Pregnancy, puerperium and perinatal conditions       10 (10%)   2 (2%)     3 (3%)     <NA>       <NA>       <NA>      
       7 Cardiac disorders                                    7 (7%)     5 (5%)     3 (3%)     2 (2%)     <NA>       <NA>      
       8 Injury, poisoning and procedural complications       6 (6%)     7 (7%)     4 (4%)     <NA>       <NA>       <NA>      
       9 Immune system disorders                              10 (10%)   3 (3%)     2 (2%)     <NA>       <NA>       <NA>      
      10 Endocrine disorders                                  4 (4%)     4 (4%)     2 (2%)     1 (1%)     <NA>       <NA>      
      11 Hepatobiliary disorders                              2 (2%)     6 (6%)     <NA>       1 (1%)     <NA>       <NA>      
      12 Psychiatric disorders                                9 (9%)     2 (2%)     1 (1%)     <NA>       <NA>       <NA>      
      13 Vascular disorders                                   10 (10%)   2 (2%)     1 (1%)     1 (1%)     <NA>       <NA>      
      14 Musculoskeletal and connective tissue disorders      6 (6%)     1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>      
      15 Respiratory, thoracic and mediastinal disorders      2 (2%)     4 (4%)     2 (2%)     <NA>       <NA>       <NA>      
      16 Ear and labyrinth disorders                          5 (5%)     3 (3%)     <NA>       <NA>       <NA>       <NA>      
      17 Metabolism and nutrition disorders                   4 (4%)     1 (1%)     1 (1%)     <NA>       <NA>       <NA>      
      18 General disorders and administration site conditions 4 (4%)     1 (1%)     <NA>       1 (1%)     <NA>       <NA>      
      19 Nervous system disorders                             3 (3%)     <NA>       <NA>       1 (1%)     <NA>       <NA>      
      20 Skin and subcutaneous tissue disorders               3 (3%)     2 (2%)     <NA>       <NA>       <NA>       <NA>      
      21 Infections and infestations                          5 (5%)     2 (2%)     <NA>       <NA>       <NA>       <NA>      
      22 Blood and lymphatic system disorders                 3 (3%)     1 (1%)     <NA>       <NA>       <NA>       <NA>      
      23 Gastrointestinal disorders                           <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      24 Reproductive system and breast disorders             3 (3%)     1 (1%)     <NA>       <NA>       <NA>       <NA>      
      25 Investigations                                       1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>       <NA>      
      26 Renal and urinary disorders                          <NA>       3 (3%)     <NA>       <NA>       <NA>       <NA>      
      27 No Declared AE                                       <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)    
         control_Tot treatment_G1 treatment_G2 treatment_G3 treatment_G4 treatment_G5 treatment_NA treatment_Tot
         <glue>      <glue>       <glue>       <glue>       <glue>       <glue>       <glue>       <glue>       
       1 29 (29%)    9 (9%)       8 (8%)       4 (4%)       1 (1%)       <NA>         <NA>         22 (22%)     
       2 21 (21%)    6 (6%)       9 (9%)       4 (4%)       5 (5%)       <NA>         <NA>         24 (24%)     
       3 22 (22%)    8 (8%)       3 (3%)       6 (6%)       3 (3%)       1 (1%)       <NA>         21 (21%)     
       4 18 (18%)    8 (8%)       6 (6%)       2 (2%)       4 (4%)       1 (1%)       <NA>         21 (21%)     
       5 14 (14%)    12 (12%)     5 (5%)       4 (4%)       <NA>         <NA>         <NA>         21 (21%)     
       6 15 (15%)    8 (8%)       6 (6%)       4 (4%)       <NA>         <NA>         <NA>         18 (18%)     
       7 17 (17%)    4 (4%)       3 (3%)       1 (1%)       3 (3%)       2 (2%)       <NA>         13 (13%)     
       8 17 (17%)    5 (5%)       2 (2%)       4 (4%)       1 (1%)       1 (1%)       <NA>         13 (13%)     
       9 15 (15%)    5 (5%)       4 (4%)       1 (1%)       2 (2%)       <NA>         <NA>         12 (12%)     
      10 11 (11%)    6 (6%)       3 (3%)       2 (2%)       2 (2%)       <NA>         <NA>         13 (13%)     
      11 9 (9%)      11 (11%)     3 (3%)       1 (1%)       <NA>         <NA>         <NA>         15 (15%)     
      12 12 (12%)    7 (7%)       1 (1%)       1 (1%)       2 (2%)       1 (1%)       <NA>         12 (12%)     
      13 14 (14%)    2 (2%)       3 (3%)       1 (1%)       1 (1%)       1 (1%)       <NA>         8 (8%)       
      14 9 (9%)      3 (3%)       4 (4%)       1 (1%)       4 (4%)       <NA>         <NA>         12 (12%)     
      15 8 (8%)      6 (6%)       2 (2%)       <NA>         1 (1%)       1 (1%)       <NA>         10 (10%)     
      16 8 (8%)      5 (5%)       2 (2%)       1 (1%)       <NA>         <NA>         <NA>         8 (8%)       
      17 6 (6%)      3 (3%)       2 (2%)       3 (3%)       <NA>         <NA>         <NA>         8 (8%)       
      18 6 (6%)      4 (4%)       2 (2%)       <NA>         <NA>         <NA>         <NA>         6 (6%)       
      19 4 (4%)      4 (4%)       4 (4%)       <NA>         <NA>         <NA>         <NA>         8 (8%)       
      20 5 (5%)      1 (1%)       3 (3%)       1 (1%)       2 (2%)       <NA>         <NA>         7 (7%)       
      21 7 (7%)      1 (1%)       1 (1%)       <NA>         1 (1%)       <NA>         <NA>         3 (3%)       
      22 4 (4%)      3 (3%)       <NA>         1 (1%)       <NA>         1 (1%)       <NA>         5 (5%)       
      23 <NA>        2 (2%)       2 (2%)       4 (4%)       1 (1%)       <NA>         <NA>         9 (9%)       
      24 4 (4%)      4 (4%)       1 (1%)       <NA>         <NA>         <NA>         <NA>         5 (5%)       
      25 3 (3%)      3 (3%)       1 (1%)       <NA>         1 (1%)       <NA>         <NA>         5 (5%)       
      26 3 (3%)      1 (1%)       <NA>         1 (1%)       1 (1%)       <NA>         <NA>         3 (3%)       
      27 3 (3%)      <NA>         <NA>         <NA>         <NA>         <NA>         <NA>         <NA>         
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", showNA = FALSE, total = FALSE)
    Output
      # A tibble: 27 x 11
         soc                                                  control_G1 control_G2 control_G3 control_G4 control_G5 treatment_G1
         <fct>                                                <glue>     <glue>     <glue>     <glue>     <glue>     <glue>      
       1 Congenital, familial and genetic disorders           18 (18%)   7 (7%)     2 (2%)     2 (2%)     <NA>       9 (9%)      
       2 Social circumstances                                 13 (13%)   5 (5%)     3 (3%)     <NA>       <NA>       6 (6%)      
       3 Surgical and medical procedures                      18 (18%)   2 (2%)     2 (2%)     <NA>       <NA>       8 (8%)      
       4 Neoplasms benign, malignant, and unspecified         9 (9%)     5 (5%)     <NA>       3 (3%)     1 (1%)     8 (8%)      
       5 Eye disorders                                        7 (7%)     2 (2%)     3 (3%)     2 (2%)     <NA>       12 (12%)    
       6 Pregnancy, puerperium and perinatal conditions       10 (10%)   2 (2%)     3 (3%)     <NA>       <NA>       8 (8%)      
       7 Cardiac disorders                                    7 (7%)     5 (5%)     3 (3%)     2 (2%)     <NA>       4 (4%)      
       8 Injury, poisoning and procedural complications       6 (6%)     7 (7%)     4 (4%)     <NA>       <NA>       5 (5%)      
       9 Immune system disorders                              10 (10%)   3 (3%)     2 (2%)     <NA>       <NA>       5 (5%)      
      10 Endocrine disorders                                  4 (4%)     4 (4%)     2 (2%)     1 (1%)     <NA>       6 (6%)      
      11 Hepatobiliary disorders                              2 (2%)     6 (6%)     <NA>       1 (1%)     <NA>       11 (11%)    
      12 Psychiatric disorders                                9 (9%)     2 (2%)     1 (1%)     <NA>       <NA>       7 (7%)      
      13 Vascular disorders                                   10 (10%)   2 (2%)     1 (1%)     1 (1%)     <NA>       2 (2%)      
      14 Musculoskeletal and connective tissue disorders      6 (6%)     1 (1%)     1 (1%)     1 (1%)     <NA>       3 (3%)      
      15 Respiratory, thoracic and mediastinal disorders      2 (2%)     4 (4%)     2 (2%)     <NA>       <NA>       6 (6%)      
      16 Ear and labyrinth disorders                          5 (5%)     3 (3%)     <NA>       <NA>       <NA>       5 (5%)      
      17 Metabolism and nutrition disorders                   4 (4%)     1 (1%)     1 (1%)     <NA>       <NA>       3 (3%)      
      18 General disorders and administration site conditions 4 (4%)     1 (1%)     <NA>       1 (1%)     <NA>       4 (4%)      
      19 Nervous system disorders                             3 (3%)     <NA>       <NA>       1 (1%)     <NA>       4 (4%)      
      20 Skin and subcutaneous tissue disorders               3 (3%)     2 (2%)     <NA>       <NA>       <NA>       1 (1%)      
      21 Infections and infestations                          5 (5%)     2 (2%)     <NA>       <NA>       <NA>       1 (1%)      
      22 Blood and lymphatic system disorders                 3 (3%)     1 (1%)     <NA>       <NA>       <NA>       3 (3%)      
      23 Gastrointestinal disorders                           <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      
      24 Reproductive system and breast disorders             3 (3%)     1 (1%)     <NA>       <NA>       <NA>       4 (4%)      
      25 Investigations                                       1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>       3 (3%)      
      26 Renal and urinary disorders                          <NA>       3 (3%)     <NA>       <NA>       <NA>       1 (1%)      
      27 No Declared AE                                       <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        
         treatment_G2 treatment_G3 treatment_G4 treatment_G5
         <glue>       <glue>       <glue>       <glue>      
       1 8 (8%)       4 (4%)       1 (1%)       <NA>        
       2 9 (9%)       4 (4%)       5 (5%)       <NA>        
       3 3 (3%)       6 (6%)       3 (3%)       1 (1%)      
       4 6 (6%)       2 (2%)       4 (4%)       1 (1%)      
       5 5 (5%)       4 (4%)       <NA>         <NA>        
       6 6 (6%)       4 (4%)       <NA>         <NA>        
       7 3 (3%)       1 (1%)       3 (3%)       2 (2%)      
       8 2 (2%)       4 (4%)       1 (1%)       1 (1%)      
       9 4 (4%)       1 (1%)       2 (2%)       <NA>        
      10 3 (3%)       2 (2%)       2 (2%)       <NA>        
      11 3 (3%)       1 (1%)       <NA>         <NA>        
      12 1 (1%)       1 (1%)       2 (2%)       1 (1%)      
      13 3 (3%)       1 (1%)       1 (1%)       1 (1%)      
      14 4 (4%)       1 (1%)       4 (4%)       <NA>        
      15 2 (2%)       <NA>         1 (1%)       1 (1%)      
      16 2 (2%)       1 (1%)       <NA>         <NA>        
      17 2 (2%)       3 (3%)       <NA>         <NA>        
      18 2 (2%)       <NA>         <NA>         <NA>        
      19 4 (4%)       <NA>         <NA>         <NA>        
      20 3 (3%)       1 (1%)       2 (2%)       <NA>        
      21 1 (1%)       <NA>         1 (1%)       <NA>        
      22 <NA>         1 (1%)       <NA>         1 (1%)      
      23 2 (2%)       4 (4%)       1 (1%)       <NA>        
      24 1 (1%)       <NA>         <NA>         <NA>        
      25 1 (1%)       <NA>         1 (1%)       <NA>        
      26 <NA>         1 (1%)       1 (1%)       <NA>        
      27 <NA>         <NA>         <NA>         <NA>        
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", variant = "sup")
    Condition
      Warning:
      Total has been set to `FALSE` as totals are not very interpretable when `variant` is "sup" or "eq". Set `total=FALSE` explicitly to silence this warning.
    Output
      # A tibble: 27 x 13
         soc                                                  control_G1 control_G2 control_G3 control_G4 control_G5 control_NA
         <fct>                                                <glue>     <glue>     <glue>     <glue>     <glue>     <glue>    
       1 Social circumstances                                 21 (21%)   8 (8%)     3 (3%)     <NA>       <NA>       <NA>      
       2 Congenital, familial and genetic disorders           29 (29%)   11 (11%)   4 (4%)     2 (2%)     <NA>       <NA>      
       3 Neoplasms benign, malignant, and unspecified         18 (18%)   9 (9%)     4 (4%)     4 (4%)     1 (1%)     <NA>      
       4 Surgical and medical procedures                      22 (22%)   4 (4%)     2 (2%)     <NA>       <NA>       <NA>      
       5 Cardiac disorders                                    17 (17%)   10 (10%)   5 (5%)     2 (2%)     <NA>       <NA>      
       6 Eye disorders                                        14 (14%)   7 (7%)     5 (5%)     2 (2%)     <NA>       <NA>      
       7 Injury, poisoning and procedural complications       17 (17%)   11 (11%)   4 (4%)     <NA>       <NA>       <NA>      
       8 Pregnancy, puerperium and perinatal conditions       15 (15%)   5 (5%)     3 (3%)     <NA>       <NA>       <NA>      
       9 Endocrine disorders                                  11 (11%)   7 (7%)     3 (3%)     1 (1%)     <NA>       <NA>      
      10 Immune system disorders                              15 (15%)   5 (5%)     2 (2%)     <NA>       <NA>       <NA>      
      11 Musculoskeletal and connective tissue disorders      9 (9%)     3 (3%)     2 (2%)     1 (1%)     <NA>       <NA>      
      12 Psychiatric disorders                                12 (12%)   3 (3%)     1 (1%)     <NA>       <NA>       <NA>      
      13 Vascular disorders                                   14 (14%)   4 (4%)     2 (2%)     1 (1%)     <NA>       <NA>      
      14 Hepatobiliary disorders                              9 (9%)     7 (7%)     1 (1%)     1 (1%)     <NA>       <NA>      
      15 Respiratory, thoracic and mediastinal disorders      8 (8%)     6 (6%)     2 (2%)     <NA>       <NA>       <NA>      
      16 Metabolism and nutrition disorders                   6 (6%)     2 (2%)     1 (1%)     <NA>       <NA>       <NA>      
      17 Skin and subcutaneous tissue disorders               5 (5%)     2 (2%)     <NA>       <NA>       <NA>       <NA>      
      18 Ear and labyrinth disorders                          8 (8%)     3 (3%)     <NA>       <NA>       <NA>       <NA>      
      19 Gastrointestinal disorders                           <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      20 Nervous system disorders                             4 (4%)     1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>      
      21 General disorders and administration site conditions 6 (6%)     2 (2%)     1 (1%)     1 (1%)     <NA>       <NA>      
      22 Blood and lymphatic system disorders                 4 (4%)     1 (1%)     <NA>       <NA>       <NA>       <NA>      
      23 Infections and infestations                          7 (7%)     2 (2%)     <NA>       <NA>       <NA>       <NA>      
      24 Investigations                                       3 (3%)     2 (2%)     1 (1%)     <NA>       <NA>       <NA>      
      25 Renal and urinary disorders                          3 (3%)     3 (3%)     <NA>       <NA>       <NA>       <NA>      
      26 Reproductive system and breast disorders             4 (4%)     1 (1%)     <NA>       <NA>       <NA>       <NA>      
      27 No Declared AE                                       <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
         treatment_G1 treatment_G2 treatment_G3 treatment_G4 treatment_G5 treatment_NA
         <glue>       <glue>       <glue>       <glue>       <glue>       <glue>      
       1 24 (24%)     18 (18%)     9 (9%)       5 (5%)       <NA>         <NA>        
       2 22 (22%)     13 (13%)     5 (5%)       1 (1%)       <NA>         <NA>        
       3 21 (21%)     13 (13%)     7 (7%)       5 (5%)       1 (1%)       <NA>        
       4 21 (21%)     13 (13%)     10 (10%)     4 (4%)       1 (1%)       <NA>        
       5 13 (13%)     9 (9%)       6 (6%)       5 (5%)       2 (2%)       <NA>        
       6 21 (21%)     9 (9%)       4 (4%)       <NA>         <NA>         <NA>        
       7 13 (13%)     8 (8%)       6 (6%)       2 (2%)       1 (1%)       <NA>        
       8 18 (18%)     10 (10%)     4 (4%)       <NA>         <NA>         <NA>        
       9 13 (13%)     7 (7%)       4 (4%)       2 (2%)       <NA>         <NA>        
      10 12 (12%)     7 (7%)       3 (3%)       2 (2%)       <NA>         <NA>        
      11 12 (12%)     9 (9%)       5 (5%)       4 (4%)       <NA>         <NA>        
      12 12 (12%)     5 (5%)       4 (4%)       3 (3%)       1 (1%)       <NA>        
      13 8 (8%)       6 (6%)       3 (3%)       2 (2%)       1 (1%)       <NA>        
      14 15 (15%)     4 (4%)       1 (1%)       <NA>         <NA>         <NA>        
      15 10 (10%)     4 (4%)       2 (2%)       2 (2%)       1 (1%)       <NA>        
      16 8 (8%)       5 (5%)       3 (3%)       <NA>         <NA>         <NA>        
      17 7 (7%)       6 (6%)       3 (3%)       2 (2%)       <NA>         <NA>        
      18 8 (8%)       3 (3%)       1 (1%)       <NA>         <NA>         <NA>        
      19 9 (9%)       7 (7%)       5 (5%)       1 (1%)       <NA>         <NA>        
      20 8 (8%)       4 (4%)       <NA>         <NA>         <NA>         <NA>        
      21 6 (6%)       2 (2%)       <NA>         <NA>         <NA>         <NA>        
      22 5 (5%)       2 (2%)       2 (2%)       1 (1%)       1 (1%)       <NA>        
      23 3 (3%)       2 (2%)       1 (1%)       1 (1%)       <NA>         <NA>        
      24 5 (5%)       2 (2%)       1 (1%)       1 (1%)       <NA>         <NA>        
      25 3 (3%)       2 (2%)       2 (2%)       1 (1%)       <NA>         <NA>        
      26 5 (5%)       1 (1%)       <NA>         <NA>         <NA>         <NA>        
      27 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", variant = "eq")
    Condition
      Warning:
      Total has been set to `FALSE` as totals are not very interpretable when `variant` is "sup" or "eq". Set `total=FALSE` explicitly to silence this warning.
    Output
      # A tibble: 27 x 13
         soc                                                  control_G1 control_G2 control_G3 control_G4 control_G5 control_NA
         <fct>                                                <glue>     <glue>     <glue>     <glue>     <glue>     <glue>    
       1 Congenital, familial and genetic disorders           22 (22%)   7 (7%)     2 (2%)     2 (2%)     <NA>       <NA>      
       2 Social circumstances                                 13 (13%)   5 (5%)     3 (3%)     <NA>       <NA>       <NA>      
       3 Surgical and medical procedures                      19 (19%)   2 (2%)     2 (2%)     <NA>       <NA>       <NA>      
       4 Neoplasms benign, malignant, and unspecified         9 (9%)     5 (5%)     <NA>       3 (3%)     1 (1%)     <NA>      
       5 Eye disorders                                        8 (8%)     2 (2%)     3 (3%)     2 (2%)     <NA>       <NA>      
       6 Injury, poisoning and procedural complications       7 (7%)     9 (9%)     4 (4%)     <NA>       <NA>       <NA>      
       7 Pregnancy, puerperium and perinatal conditions       10 (10%)   2 (2%)     3 (3%)     <NA>       <NA>       <NA>      
       8 Cardiac disorders                                    9 (9%)     5 (5%)     3 (3%)     2 (2%)     <NA>       <NA>      
       9 Immune system disorders                              10 (10%)   3 (3%)     2 (2%)     <NA>       <NA>       <NA>      
      10 Endocrine disorders                                  6 (6%)     4 (4%)     2 (2%)     1 (1%)     <NA>       <NA>      
      11 Psychiatric disorders                                9 (9%)     2 (2%)     1 (1%)     <NA>       <NA>       <NA>      
      12 Hepatobiliary disorders                              2 (2%)     6 (6%)     <NA>       1 (1%)     <NA>       <NA>      
      13 Vascular disorders                                   11 (11%)   2 (2%)     1 (1%)     1 (1%)     <NA>       <NA>      
      14 Musculoskeletal and connective tissue disorders      6 (6%)     1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>      
      15 Ear and labyrinth disorders                          6 (6%)     3 (3%)     <NA>       <NA>       <NA>       <NA>      
      16 Respiratory, thoracic and mediastinal disorders      2 (2%)     4 (4%)     2 (2%)     <NA>       <NA>       <NA>      
      17 Metabolism and nutrition disorders                   4 (4%)     1 (1%)     1 (1%)     <NA>       <NA>       <NA>      
      18 Nervous system disorders                             4 (4%)     <NA>       <NA>       1 (1%)     <NA>       <NA>      
      19 General disorders and administration site conditions 4 (4%)     1 (1%)     <NA>       1 (1%)     <NA>       <NA>      
      20 Skin and subcutaneous tissue disorders               3 (3%)     2 (2%)     <NA>       <NA>       <NA>       <NA>      
      21 Infections and infestations                          5 (5%)     2 (2%)     <NA>       <NA>       <NA>       <NA>      
      22 Blood and lymphatic system disorders                 3 (3%)     1 (1%)     <NA>       <NA>       <NA>       <NA>      
      23 Gastrointestinal disorders                           <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      24 Reproductive system and breast disorders             3 (3%)     1 (1%)     <NA>       <NA>       <NA>       <NA>      
      25 Investigations                                       1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>       <NA>      
      26 Renal and urinary disorders                          <NA>       3 (3%)     <NA>       <NA>       <NA>       <NA>      
      27 No Declared AE                                       <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
         treatment_G1 treatment_G2 treatment_G3 treatment_G4 treatment_G5 treatment_NA
         <glue>       <glue>       <glue>       <glue>       <glue>       <glue>      
       1 11 (11%)     8 (8%)       4 (4%)       1 (1%)       <NA>         <NA>        
       2 8 (8%)       9 (9%)       4 (4%)       5 (5%)       <NA>         <NA>        
       3 9 (9%)       3 (3%)       6 (6%)       3 (3%)       1 (1%)       <NA>        
       4 9 (9%)       6 (6%)       2 (2%)       4 (4%)       1 (1%)       <NA>        
       5 12 (12%)     5 (5%)       4 (4%)       <NA>         <NA>         <NA>        
       6 7 (7%)       2 (2%)       4 (4%)       1 (1%)       1 (1%)       <NA>        
       7 8 (8%)       6 (6%)       4 (4%)       <NA>         <NA>         <NA>        
       8 4 (4%)       3 (3%)       1 (1%)       3 (3%)       2 (2%)       <NA>        
       9 5 (5%)       5 (5%)       1 (1%)       2 (2%)       <NA>         <NA>        
      10 6 (6%)       4 (4%)       2 (2%)       2 (2%)       <NA>         <NA>        
      11 8 (8%)       1 (1%)       1 (1%)       2 (2%)       1 (1%)       <NA>        
      12 11 (11%)     3 (3%)       1 (1%)       <NA>         <NA>         <NA>        
      13 2 (2%)       4 (4%)       1 (1%)       1 (1%)       1 (1%)       <NA>        
      14 3 (3%)       5 (5%)       1 (1%)       4 (4%)       <NA>         <NA>        
      15 6 (6%)       2 (2%)       1 (1%)       <NA>         <NA>         <NA>        
      16 6 (6%)       2 (2%)       <NA>         1 (1%)       1 (1%)       <NA>        
      17 3 (3%)       2 (2%)       3 (3%)       <NA>         <NA>         <NA>        
      18 4 (4%)       4 (4%)       <NA>         <NA>         <NA>         <NA>        
      19 4 (4%)       2 (2%)       <NA>         <NA>         <NA>         <NA>        
      20 1 (1%)       3 (3%)       1 (1%)       2 (2%)       <NA>         <NA>        
      21 1 (1%)       1 (1%)       <NA>         1 (1%)       <NA>         <NA>        
      22 3 (3%)       <NA>         1 (1%)       <NA>         1 (1%)       <NA>        
      23 2 (2%)       2 (2%)       4 (4%)       1 (1%)       <NA>         <NA>        
      24 4 (4%)       1 (1%)       <NA>         <NA>         <NA>         <NA>        
      25 3 (3%)       1 (1%)       <NA>         1 (1%)       <NA>         <NA>        
      26 1 (1%)       <NA>         1 (1%)       1 (1%)       <NA>         <NA>        
      27 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", term = "aeterm", sort_by_count = TRUE)
    Output
      # A tibble: 102 x 16
          soc                                                  term                                                 control_G1
          <fct>                                                <chr>                                                <glue>    
        1 Congenital, familial and genetic disorders           Chromosomal abnormalities                            9 (9%)    
        2 Congenital, familial and genetic disorders           Congenital nervous system disorders                  3 (3%)    
        3 Congenital, familial and genetic disorders           Familial hematologic disorders                       6 (6%)    
        4 Congenital, familial and genetic disorders           Hereditary connective tissue disorders               4 (4%)    
        5 Social circumstances                                 Cultural issues                                      3 (3%)    
        6 Social circumstances                                 Economic conditions affecting care                   2 (2%)    
        7 Social circumstances                                 Family support issues                                3 (3%)    
        8 Social circumstances                                 Social and environmental issues                      5 (5%)    
        9 Surgical and medical procedures                      Device implantation procedures                       10 (10%)  
       10 Surgical and medical procedures                      Diagnostic procedures                                5 (5%)    
       11 Surgical and medical procedures                      Surgical complications                               2 (2%)    
       12 Surgical and medical procedures                      Therapeutic procedures                               1 (1%)    
       13 Neoplasms benign, malignant, and unspecified         Benign neoplasms                                     3 (3%)    
       14 Neoplasms benign, malignant, and unspecified         Malignant neoplasms                                  3 (3%)    
       15 Neoplasms benign, malignant, and unspecified         Neoplasms unspecified                                3 (3%)    
       16 Neoplasms benign, malignant, and unspecified         Tumor progression                                    <NA>      
       17 Eye disorders                                        Corneal disorders                                    3 (3%)    
       18 Eye disorders                                        Eyelid disorders                                     2 (2%)    
       19 Eye disorders                                        Retinal disorders                                    1 (1%)    
       20 Eye disorders                                        Vision disorders                                     2 (2%)    
       21 Pregnancy, puerperium and perinatal conditions       Breastfeeding issues                                 4 (4%)    
       22 Pregnancy, puerperium and perinatal conditions       Fetal complications                                  3 (3%)    
       23 Pregnancy, puerperium and perinatal conditions       Labor and delivery complications                     2 (2%)    
       24 Pregnancy, puerperium and perinatal conditions       Pregnancy complications                              2 (2%)    
       25 Injury, poisoning and procedural complications       Poisonings                                           1 (1%)    
       26 Injury, poisoning and procedural complications       Procedural complications                             2 (2%)    
       27 Injury, poisoning and procedural complications       Radiation-related toxicities                         1 (1%)    
       28 Injury, poisoning and procedural complications       Traumatic injuries                                   2 (2%)    
       29 Cardiac disorders                                    Cardiac arrhythmias                                  3 (3%)    
       30 Cardiac disorders                                    Cardiac valve disorders                              1 (1%)    
       31 Cardiac disorders                                    Coronary artery disorders                            1 (1%)    
       32 Cardiac disorders                                    Heart failures                                       4 (4%)    
       33 Immune system disorders                              Autoimmune disorders                                 5 (5%)    
       34 Immune system disorders                              Hypersensitivity conditions                          2 (2%)    
       35 Immune system disorders                              Immunodeficiency                                     3 (3%)    
       36 Immune system disorders                              Inflammatory responses                               2 (2%)    
       37 Endocrine disorders                                  Adrenal gland disorders                              1 (1%)    
       38 Endocrine disorders                                  Parathyroid gland disorders                          1 (1%)    
       39 Endocrine disorders                                  Pituitary gland disorders                            3 (3%)    
       40 Endocrine disorders                                  Thyroid gland disorders                              1 (1%)    
       41 Psychiatric disorders                                Anxiety disorders                                    3 (3%)    
       42 Psychiatric disorders                                Mood disorders                                       2 (2%)    
       43 Psychiatric disorders                                Sleep disorders                                      4 (4%)    
       44 Psychiatric disorders                                Substance-related disorders                          <NA>      
       45 Hepatobiliary disorders                              Bile duct disorders                                  2 (2%)    
       46 Hepatobiliary disorders                              Gallbladder disorders                                <NA>      
       47 Hepatobiliary disorders                              Hepatic failure                                      <NA>      
       48 Hepatobiliary disorders                              Liver disorders                                      <NA>      
       49 Vascular disorders                                   Hypertension-related conditions                      3 (3%)    
       50 Vascular disorders                                   Hypotension-related conditions                       3 (3%)    
       51 Vascular disorders                                   Vascular hemorrhagic disorders                       1 (1%)    
       52 Vascular disorders                                   Venous thromboembolic events                         3 (3%)    
       53 Musculoskeletal and connective tissue disorders      Arthritis and joint disorders                        4 (4%)    
       54 Musculoskeletal and connective tissue disorders      Bone disorders                                       1 (1%)    
       55 Musculoskeletal and connective tissue disorders      Connective tissue disorders                          1 (1%)    
       56 Musculoskeletal and connective tissue disorders      Muscle disorders                                     <NA>      
       57 Ear and labyrinth disorders                          Hearing disorders                                    1 (1%)    
       58 Ear and labyrinth disorders                          Labyrinth disorders                                  1 (1%)    
       59 Ear and labyrinth disorders                          Tinnitus                                             4 (4%)    
       60 Ear and labyrinth disorders                          Vertigo and balance disorders                        <NA>      
       61 Respiratory, thoracic and mediastinal disorders      Lung function disorders                              1 (1%)    
       62 Respiratory, thoracic and mediastinal disorders      Pleural disorders                                    1 (1%)    
       63 Respiratory, thoracic and mediastinal disorders      Pulmonary vascular disorders                         <NA>      
       64 Respiratory, thoracic and mediastinal disorders      Respiratory infections                               <NA>      
       65 Metabolism and nutrition disorders                   Fluid and electrolyte disorders                      1 (1%)    
       66 Metabolism and nutrition disorders                   Lipid metabolism disorders                           <NA>      
       67 Metabolism and nutrition disorders                   Nutritional disorders                                3 (3%)    
       68 Metabolism and nutrition disorders                   Vitamin deficiencies                                 <NA>      
       69 Nervous system disorders                             Headache disorders                                   1 (1%)    
       70 Nervous system disorders                             Neurological disorders of the central nervous system 1 (1%)    
       71 Nervous system disorders                             Peripheral neuropathies                              <NA>      
       72 Nervous system disorders                             Seizure disorders                                    2 (2%)    
       73 General disorders and administration site conditions Device issues                                        2 (2%)    
       74 General disorders and administration site conditions General physical health deterioration                1 (1%)    
       75 General disorders and administration site conditions Injection site reactions                             1 (1%)    
       76 General disorders and administration site conditions Pain and discomfort                                  <NA>      
       77 Skin and subcutaneous tissue disorders               Dermatitis                                           1 (1%)    
       78 Skin and subcutaneous tissue disorders               Skin and subcutaneous tissue injuries                1 (1%)    
       79 Skin and subcutaneous tissue disorders               Skin infections                                      1 (1%)    
       80 Skin and subcutaneous tissue disorders               Skin pigmentation disorders                          <NA>      
       81 Infections and infestations                          Bacterial infectious disorders                       1 (1%)    
       82 Infections and infestations                          Fungal infectious disorders                          <NA>      
       83 Infections and infestations                          Parasitic infectious disorders                       1 (1%)    
       84 Infections and infestations                          Viral infectious disorders                           3 (3%)    
       85 Blood and lymphatic system disorders                 Bone marrow disorders                                1 (1%)    
       86 Blood and lymphatic system disorders                 Hematologic neoplasms                                2 (2%)    
       87 Blood and lymphatic system disorders                 Red blood cell disorders                             <NA>      
       88 Gastrointestinal disorders                           Esophageal disorders                                 <NA>      
       89 Gastrointestinal disorders                           Gastric disorders                                    <NA>      
       90 Gastrointestinal disorders                           Intestinal disorders                                 <NA>      
       91 Reproductive system and breast disorders             Breast disorders                                     <NA>      
       92 Reproductive system and breast disorders             Female reproductive disorders                        1 (1%)    
       93 Reproductive system and breast disorders             Male reproductive disorders                          1 (1%)    
       94 Reproductive system and breast disorders             Menstrual disorders                                  1 (1%)    
       95 Investigations                                       Blood analyses                                       <NA>      
       96 Investigations                                       Cardiovascular assessments                           1 (1%)    
       97 Investigations                                       Imaging studies                                      <NA>      
       98 Investigations                                       Liver function analyses                              <NA>      
       99 Renal and urinary disorders                          Bladder disorders                                    <NA>      
      100 Renal and urinary disorders                          Kidney disorders                                     <NA>      
      101 Renal and urinary disorders                          Urinary tract disorders                              <NA>      
      102 No Declared AE                                       <NA>                                                 <NA>      
          control_G2 control_G3 control_G4 control_G5 control_NA control_Tot treatment_G1 treatment_G2 treatment_G3 treatment_G4
          <glue>     <glue>     <glue>     <glue>     <glue>     <glue>      <glue>       <glue>       <glue>       <glue>      
        1 2 (2%)     <NA>       1 (1%)     <NA>       <NA>       12 (12%)    2 (2%)       3 (3%)       1 (1%)       <NA>        
        2 3 (3%)     <NA>       <NA>       <NA>       <NA>       6 (6%)      3 (3%)       <NA>         <NA>         <NA>        
        3 <NA>       <NA>       1 (1%)     <NA>       <NA>       7 (7%)      1 (1%)       1 (1%)       3 (3%)       1 (1%)      
        4 2 (2%)     2 (2%)     <NA>       <NA>       <NA>       8 (8%)      5 (5%)       4 (4%)       <NA>         <NA>        
        5 1 (1%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      2 (2%)       1 (1%)       2 (2%)       1 (1%)      
        6 2 (2%)     1 (1%)     <NA>       <NA>       <NA>       5 (5%)      1 (1%)       2 (2%)       <NA>         1 (1%)      
        7 <NA>       1 (1%)     <NA>       <NA>       <NA>       4 (4%)      3 (3%)       3 (3%)       2 (2%)       2 (2%)      
        8 2 (2%)     1 (1%)     <NA>       <NA>       <NA>       8 (8%)      2 (2%)       3 (3%)       <NA>         1 (1%)      
        9 <NA>       <NA>       <NA>       <NA>       <NA>       10 (10%)    3 (3%)       <NA>         1 (1%)       2 (2%)      
       10 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       7 (7%)      5 (5%)       <NA>         4 (4%)       <NA>        
       11 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      1 (1%)       3 (3%)       1 (1%)       1 (1%)      
       12 <NA>       1 (1%)     <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         <NA>         <NA>        
       13 1 (1%)     <NA>       1 (1%)     <NA>       <NA>       5 (5%)      2 (2%)       3 (3%)       1 (1%)       2 (2%)      
       14 2 (2%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      3 (3%)       2 (2%)       1 (1%)       2 (2%)      
       15 <NA>       <NA>       1 (1%)     1 (1%)     <NA>       5 (5%)      2 (2%)       <NA>         <NA>         <NA>        
       16 2 (2%)     <NA>       1 (1%)     <NA>       <NA>       3 (3%)      2 (2%)       1 (1%)       <NA>         <NA>        
       17 <NA>       <NA>       2 (2%)     <NA>       <NA>       5 (5%)      1 (1%)       <NA>         2 (2%)       <NA>        
       18 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      4 (4%)       <NA>         1 (1%)       <NA>        
       19 <NA>       1 (1%)     <NA>       <NA>       <NA>       2 (2%)      4 (4%)       2 (2%)       1 (1%)       <NA>        
       20 1 (1%)     2 (2%)     <NA>       <NA>       <NA>       5 (5%)      5 (5%)       3 (3%)       <NA>         <NA>        
       21 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       6 (6%)      <NA>         <NA>         1 (1%)       <NA>        
       22 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      <NA>         2 (2%)       2 (2%)       <NA>        
       23 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       4 (4%)      5 (5%)       3 (3%)       <NA>         <NA>        
       24 <NA>       1 (1%)     <NA>       <NA>       <NA>       3 (3%)      3 (3%)       1 (1%)       1 (1%)       <NA>        
       25 3 (3%)     1 (1%)     <NA>       <NA>       <NA>       5 (5%)      2 (2%)       <NA>         <NA>         1 (1%)      
       26 3 (3%)     1 (1%)     <NA>       <NA>       <NA>       6 (6%)      <NA>         <NA>         1 (1%)       <NA>        
       27 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       2 (2%)       2 (2%)       <NA>        
       28 1 (1%)     2 (2%)     <NA>       <NA>       <NA>       5 (5%)      4 (4%)       <NA>         1 (1%)       <NA>        
       29 2 (2%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      2 (2%)       <NA>         <NA>         2 (2%)      
       30 <NA>       1 (1%)     <NA>       <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       1 (1%)       1 (1%)      
       31 2 (2%)     1 (1%)     1 (1%)     <NA>       <NA>       5 (5%)      <NA>         2 (2%)       <NA>         <NA>        
       32 1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>       7 (7%)      1 (1%)       <NA>         <NA>         <NA>        
       33 <NA>       <NA>       <NA>       <NA>       <NA>       5 (5%)      1 (1%)       1 (1%)       <NA>         1 (1%)      
       34 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      2 (2%)       1 (1%)       1 (1%)       1 (1%)      
       35 1 (1%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      <NA>         <NA>         <NA>         <NA>        
       36 2 (2%)     2 (2%)     <NA>       <NA>       <NA>       6 (6%)      2 (2%)       3 (3%)       <NA>         <NA>        
       37 3 (3%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      1 (1%)       2 (2%)       <NA>         <NA>        
       38 <NA>       1 (1%)     <NA>       <NA>       <NA>       2 (2%)      <NA>         <NA>         2 (2%)       1 (1%)      
       39 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       5 (5%)      3 (3%)       1 (1%)       <NA>         <NA>        
       40 <NA>       <NA>       1 (1%)     <NA>       <NA>       2 (2%)      2 (2%)       1 (1%)       <NA>         1 (1%)      
       41 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      2 (2%)       <NA>         <NA>         <NA>        
       42 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         <NA>         <NA>         1 (1%)      
       43 1 (1%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      4 (4%)       <NA>         <NA>         <NA>        
       44 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       2 (2%)      2 (2%)       1 (1%)       1 (1%)       1 (1%)      
       45 2 (2%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      2 (2%)       1 (1%)       <NA>         <NA>        
       46 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      3 (3%)       1 (1%)       <NA>         <NA>        
       47 1 (1%)     <NA>       1 (1%)     <NA>       <NA>       2 (2%)      3 (3%)       1 (1%)       1 (1%)       <NA>        
       48 2 (2%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      3 (3%)       <NA>         <NA>         <NA>        
       49 1 (1%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      1 (1%)       1 (1%)       1 (1%)       <NA>        
       50 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      1 (1%)       1 (1%)       <NA>         <NA>        
       51 <NA>       1 (1%)     1 (1%)     <NA>       <NA>       3 (3%)      <NA>         2 (2%)       <NA>         <NA>        
       52 1 (1%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      <NA>         <NA>         <NA>         1 (1%)      
       53 <NA>       <NA>       <NA>       <NA>       <NA>       4 (4%)      2 (2%)       1 (1%)       1 (1%)       <NA>        
       54 <NA>       <NA>       1 (1%)     <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       <NA>         1 (1%)      
       55 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       3 (3%)      <NA>         1 (1%)       <NA>         2 (2%)      
       56 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         2 (2%)       <NA>         1 (1%)      
       57 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         1 (1%)       <NA>        
       58 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       59 1 (1%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      2 (2%)       <NA>         <NA>         <NA>        
       60 2 (2%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      3 (3%)       2 (2%)       <NA>         <NA>        
       61 2 (2%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      2 (2%)       1 (1%)       <NA>         <NA>        
       62 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       3 (3%)      <NA>         <NA>         <NA>         1 (1%)      
       63 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      3 (3%)       1 (1%)       <NA>         <NA>        
       64 <NA>       1 (1%)     <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       65 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       1 (1%)       1 (1%)       <NA>        
       66 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       2 (2%)      <NA>         <NA>         <NA>         <NA>        
       67 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      1 (1%)       <NA>         <NA>         <NA>        
       68 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (1%)       1 (1%)       2 (2%)       <NA>        
       69 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       2 (2%)       <NA>         <NA>        
       70 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       1 (1%)       <NA>         <NA>        
       71 <NA>       <NA>       1 (1%)     <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       72 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         1 (1%)       <NA>         <NA>        
       73 <NA>       <NA>       1 (1%)     <NA>       <NA>       3 (3%)      2 (2%)       <NA>         <NA>         <NA>        
       74 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         <NA>         <NA>        
       75 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         1 (1%)       <NA>         <NA>        
       76 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         1 (1%)       <NA>         <NA>        
       77 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         1 (1%)       1 (1%)      
       78 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         2 (2%)       <NA>         <NA>        
       79 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       <NA>         1 (1%)      
       80 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       81 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       82 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       83 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         1 (1%)      
       84 1 (1%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      <NA>         1 (1%)       <NA>         <NA>        
       85 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       86 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      2 (2%)       <NA>         <NA>         <NA>        
       87 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (1%)       <NA>         1 (1%)       <NA>        
       88 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         <NA>         1 (1%)      
       89 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (2%)       1 (1%)       2 (2%)       <NA>        
       90 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (1%)       2 (2%)       <NA>        
       91 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (2%)       <NA>         <NA>         <NA>        
       92 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       93 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       <NA>         <NA>        
       94 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       95 <NA>       1 (1%)     <NA>       <NA>       <NA>       1 (1%)      <NA>         1 (1%)       <NA>         <NA>        
       96 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       97 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       98 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (1%)       <NA>         <NA>         1 (1%)      
       99 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         1 (1%)       <NA>        
      100 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         1 (1%)      
      101 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
      102 <NA>       <NA>       <NA>       <NA>       3 (3%)     3 (3%)      <NA>         <NA>         <NA>         <NA>        
          treatment_G5 treatment_NA treatment_Tot
          <glue>       <glue>       <glue>       
        1 <NA>         <NA>         6 (6%)       
        2 <NA>         <NA>         3 (3%)       
        3 <NA>         <NA>         6 (6%)       
        4 <NA>         <NA>         9 (9%)       
        5 <NA>         <NA>         6 (6%)       
        6 <NA>         <NA>         4 (4%)       
        7 <NA>         <NA>         10 (10%)     
        8 <NA>         <NA>         6 (6%)       
        9 1 (1%)       <NA>         7 (7%)       
       10 <NA>         <NA>         9 (9%)       
       11 <NA>         <NA>         6 (6%)       
       12 <NA>         <NA>         1 (1%)       
       13 <NA>         <NA>         8 (8%)       
       14 <NA>         <NA>         8 (8%)       
       15 <NA>         <NA>         2 (2%)       
       16 1 (1%)       <NA>         4 (4%)       
       17 <NA>         <NA>         3 (3%)       
       18 <NA>         <NA>         5 (5%)       
       19 <NA>         <NA>         7 (7%)       
       20 <NA>         <NA>         8 (8%)       
       21 <NA>         <NA>         1 (1%)       
       22 <NA>         <NA>         4 (4%)       
       23 <NA>         <NA>         8 (8%)       
       24 <NA>         <NA>         5 (5%)       
       25 1 (1%)       <NA>         4 (4%)       
       26 <NA>         <NA>         1 (1%)       
       27 <NA>         <NA>         5 (5%)       
       28 <NA>         <NA>         5 (5%)       
       29 <NA>         <NA>         4 (4%)       
       30 2 (2%)       <NA>         6 (6%)       
       31 <NA>         <NA>         2 (2%)       
       32 <NA>         <NA>         1 (1%)       
       33 <NA>         <NA>         3 (3%)       
       34 <NA>         <NA>         5 (5%)       
       35 <NA>         <NA>         <NA>         
       36 <NA>         <NA>         5 (5%)       
       37 <NA>         <NA>         3 (3%)       
       38 <NA>         <NA>         3 (3%)       
       39 <NA>         <NA>         4 (4%)       
       40 <NA>         <NA>         4 (4%)       
       41 <NA>         <NA>         2 (2%)       
       42 <NA>         <NA>         1 (1%)       
       43 <NA>         <NA>         4 (4%)       
       44 1 (1%)       <NA>         6 (6%)       
       45 <NA>         <NA>         3 (3%)       
       46 <NA>         <NA>         4 (4%)       
       47 <NA>         <NA>         5 (5%)       
       48 <NA>         <NA>         3 (3%)       
       49 <NA>         <NA>         3 (3%)       
       50 1 (1%)       <NA>         3 (3%)       
       51 <NA>         <NA>         2 (2%)       
       52 <NA>         <NA>         1 (1%)       
       53 <NA>         <NA>         4 (4%)       
       54 <NA>         <NA>         3 (3%)       
       55 <NA>         <NA>         3 (3%)       
       56 <NA>         <NA>         3 (3%)       
       57 <NA>         <NA>         2 (2%)       
       58 <NA>         <NA>         <NA>         
       59 <NA>         <NA>         2 (2%)       
       60 <NA>         <NA>         5 (5%)       
       61 <NA>         <NA>         3 (3%)       
       62 <NA>         <NA>         1 (1%)       
       63 1 (1%)       <NA>         5 (5%)       
       64 <NA>         <NA>         1 (1%)       
       65 <NA>         <NA>         3 (3%)       
       66 <NA>         <NA>         <NA>         
       67 <NA>         <NA>         1 (1%)       
       68 <NA>         <NA>         4 (4%)       
       69 <NA>         <NA>         4 (4%)       
       70 <NA>         <NA>         3 (3%)       
       71 <NA>         <NA>         <NA>         
       72 <NA>         <NA>         1 (1%)       
       73 <NA>         <NA>         2 (2%)       
       74 <NA>         <NA>         2 (2%)       
       75 <NA>         <NA>         1 (1%)       
       76 <NA>         <NA>         1 (1%)       
       77 <NA>         <NA>         2 (2%)       
       78 <NA>         <NA>         2 (2%)       
       79 <NA>         <NA>         3 (3%)       
       80 <NA>         <NA>         <NA>         
       81 <NA>         <NA>         <NA>         
       82 <NA>         <NA>         <NA>         
       83 <NA>         <NA>         2 (2%)       
       84 <NA>         <NA>         1 (1%)       
       85 <NA>         <NA>         <NA>         
       86 1 (1%)       <NA>         3 (3%)       
       87 <NA>         <NA>         2 (2%)       
       88 <NA>         <NA>         1 (1%)       
       89 <NA>         <NA>         5 (5%)       
       90 <NA>         <NA>         3 (3%)       
       91 <NA>         <NA>         2 (2%)       
       92 <NA>         <NA>         1 (1%)       
       93 <NA>         <NA>         2 (2%)       
       94 <NA>         <NA>         <NA>         
       95 <NA>         <NA>         1 (1%)       
       96 <NA>         <NA>         1 (1%)       
       97 <NA>         <NA>         1 (1%)       
       98 <NA>         <NA>         2 (2%)       
       99 <NA>         <NA>         1 (1%)       
      100 <NA>         <NA>         2 (2%)       
      101 <NA>         <NA>         <NA>         
      102 <NA>         <NA>         <NA>         
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", term = "aeterm", sort_by_count = FALSE)
    Output
      # A tibble: 102 x 16
          soc                                                  term                                                 control_G1
          <fct>                                                <fct>                                                <glue>    
        1 Blood and lymphatic system disorders                 Bone marrow disorders                                1 (1%)    
        2 Blood and lymphatic system disorders                 Hematologic neoplasms                                2 (2%)    
        3 Blood and lymphatic system disorders                 Red blood cell disorders                             <NA>      
        4 Cardiac disorders                                    Cardiac arrhythmias                                  3 (3%)    
        5 Cardiac disorders                                    Cardiac valve disorders                              1 (1%)    
        6 Cardiac disorders                                    Coronary artery disorders                            1 (1%)    
        7 Cardiac disorders                                    Heart failures                                       4 (4%)    
        8 Congenital, familial and genetic disorders           Chromosomal abnormalities                            9 (9%)    
        9 Congenital, familial and genetic disorders           Congenital nervous system disorders                  3 (3%)    
       10 Congenital, familial and genetic disorders           Familial hematologic disorders                       6 (6%)    
       11 Congenital, familial and genetic disorders           Hereditary connective tissue disorders               4 (4%)    
       12 Ear and labyrinth disorders                          Hearing disorders                                    1 (1%)    
       13 Ear and labyrinth disorders                          Labyrinth disorders                                  1 (1%)    
       14 Ear and labyrinth disorders                          Tinnitus                                             4 (4%)    
       15 Ear and labyrinth disorders                          Vertigo and balance disorders                        <NA>      
       16 Endocrine disorders                                  Adrenal gland disorders                              1 (1%)    
       17 Endocrine disorders                                  Parathyroid gland disorders                          1 (1%)    
       18 Endocrine disorders                                  Pituitary gland disorders                            3 (3%)    
       19 Endocrine disorders                                  Thyroid gland disorders                              1 (1%)    
       20 Eye disorders                                        Corneal disorders                                    3 (3%)    
       21 Eye disorders                                        Eyelid disorders                                     2 (2%)    
       22 Eye disorders                                        Retinal disorders                                    1 (1%)    
       23 Eye disorders                                        Vision disorders                                     2 (2%)    
       24 Gastrointestinal disorders                           Esophageal disorders                                 <NA>      
       25 Gastrointestinal disorders                           Gastric disorders                                    <NA>      
       26 Gastrointestinal disorders                           Intestinal disorders                                 <NA>      
       27 General disorders and administration site conditions Device issues                                        2 (2%)    
       28 General disorders and administration site conditions General physical health deterioration                1 (1%)    
       29 General disorders and administration site conditions Injection site reactions                             1 (1%)    
       30 General disorders and administration site conditions Pain and discomfort                                  <NA>      
       31 Hepatobiliary disorders                              Bile duct disorders                                  2 (2%)    
       32 Hepatobiliary disorders                              Gallbladder disorders                                <NA>      
       33 Hepatobiliary disorders                              Hepatic failure                                      <NA>      
       34 Hepatobiliary disorders                              Liver disorders                                      <NA>      
       35 Immune system disorders                              Autoimmune disorders                                 5 (5%)    
       36 Immune system disorders                              Hypersensitivity conditions                          2 (2%)    
       37 Immune system disorders                              Immunodeficiency                                     3 (3%)    
       38 Immune system disorders                              Inflammatory responses                               2 (2%)    
       39 Infections and infestations                          Bacterial infectious disorders                       1 (1%)    
       40 Infections and infestations                          Fungal infectious disorders                          <NA>      
       41 Infections and infestations                          Parasitic infectious disorders                       1 (1%)    
       42 Infections and infestations                          Viral infectious disorders                           3 (3%)    
       43 Injury, poisoning and procedural complications       Poisonings                                           1 (1%)    
       44 Injury, poisoning and procedural complications       Procedural complications                             2 (2%)    
       45 Injury, poisoning and procedural complications       Radiation-related toxicities                         1 (1%)    
       46 Injury, poisoning and procedural complications       Traumatic injuries                                   2 (2%)    
       47 Investigations                                       Blood analyses                                       <NA>      
       48 Investigations                                       Cardiovascular assessments                           1 (1%)    
       49 Investigations                                       Imaging studies                                      <NA>      
       50 Investigations                                       Liver function analyses                              <NA>      
       51 Metabolism and nutrition disorders                   Fluid and electrolyte disorders                      1 (1%)    
       52 Metabolism and nutrition disorders                   Lipid metabolism disorders                           <NA>      
       53 Metabolism and nutrition disorders                   Nutritional disorders                                3 (3%)    
       54 Metabolism and nutrition disorders                   Vitamin deficiencies                                 <NA>      
       55 Musculoskeletal and connective tissue disorders      Arthritis and joint disorders                        4 (4%)    
       56 Musculoskeletal and connective tissue disorders      Bone disorders                                       1 (1%)    
       57 Musculoskeletal and connective tissue disorders      Connective tissue disorders                          1 (1%)    
       58 Musculoskeletal and connective tissue disorders      Muscle disorders                                     <NA>      
       59 Neoplasms benign, malignant, and unspecified         Benign neoplasms                                     3 (3%)    
       60 Neoplasms benign, malignant, and unspecified         Malignant neoplasms                                  3 (3%)    
       61 Neoplasms benign, malignant, and unspecified         Neoplasms unspecified                                3 (3%)    
       62 Neoplasms benign, malignant, and unspecified         Tumor progression                                    <NA>      
       63 Nervous system disorders                             Headache disorders                                   1 (1%)    
       64 Nervous system disorders                             Neurological disorders of the central nervous system 1 (1%)    
       65 Nervous system disorders                             Peripheral neuropathies                              <NA>      
       66 Nervous system disorders                             Seizure disorders                                    2 (2%)    
       67 Pregnancy, puerperium and perinatal conditions       Breastfeeding issues                                 4 (4%)    
       68 Pregnancy, puerperium and perinatal conditions       Fetal complications                                  3 (3%)    
       69 Pregnancy, puerperium and perinatal conditions       Labor and delivery complications                     2 (2%)    
       70 Pregnancy, puerperium and perinatal conditions       Pregnancy complications                              2 (2%)    
       71 Psychiatric disorders                                Anxiety disorders                                    3 (3%)    
       72 Psychiatric disorders                                Mood disorders                                       2 (2%)    
       73 Psychiatric disorders                                Sleep disorders                                      4 (4%)    
       74 Psychiatric disorders                                Substance-related disorders                          <NA>      
       75 Renal and urinary disorders                          Bladder disorders                                    <NA>      
       76 Renal and urinary disorders                          Kidney disorders                                     <NA>      
       77 Renal and urinary disorders                          Urinary tract disorders                              <NA>      
       78 Reproductive system and breast disorders             Breast disorders                                     <NA>      
       79 Reproductive system and breast disorders             Female reproductive disorders                        1 (1%)    
       80 Reproductive system and breast disorders             Male reproductive disorders                          1 (1%)    
       81 Reproductive system and breast disorders             Menstrual disorders                                  1 (1%)    
       82 Respiratory, thoracic and mediastinal disorders      Lung function disorders                              1 (1%)    
       83 Respiratory, thoracic and mediastinal disorders      Pleural disorders                                    1 (1%)    
       84 Respiratory, thoracic and mediastinal disorders      Pulmonary vascular disorders                         <NA>      
       85 Respiratory, thoracic and mediastinal disorders      Respiratory infections                               <NA>      
       86 Skin and subcutaneous tissue disorders               Dermatitis                                           1 (1%)    
       87 Skin and subcutaneous tissue disorders               Skin and subcutaneous tissue injuries                1 (1%)    
       88 Skin and subcutaneous tissue disorders               Skin infections                                      1 (1%)    
       89 Skin and subcutaneous tissue disorders               Skin pigmentation disorders                          <NA>      
       90 Social circumstances                                 Cultural issues                                      3 (3%)    
       91 Social circumstances                                 Economic conditions affecting care                   2 (2%)    
       92 Social circumstances                                 Family support issues                                3 (3%)    
       93 Social circumstances                                 Social and environmental issues                      5 (5%)    
       94 Surgical and medical procedures                      Device implantation procedures                       10 (10%)  
       95 Surgical and medical procedures                      Diagnostic procedures                                5 (5%)    
       96 Surgical and medical procedures                      Surgical complications                               2 (2%)    
       97 Surgical and medical procedures                      Therapeutic procedures                               1 (1%)    
       98 Vascular disorders                                   Hypertension-related conditions                      3 (3%)    
       99 Vascular disorders                                   Hypotension-related conditions                       3 (3%)    
      100 Vascular disorders                                   Vascular hemorrhagic disorders                       1 (1%)    
      101 Vascular disorders                                   Venous thromboembolic events                         3 (3%)    
      102 No Declared AE                                       <NA>                                                 <NA>      
          control_G2 control_G3 control_G4 control_G5 control_NA control_Tot treatment_G1 treatment_G2 treatment_G3 treatment_G4
          <glue>     <glue>     <glue>     <glue>     <glue>     <glue>      <glue>       <glue>       <glue>       <glue>      
        1 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
        2 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      2 (2%)       <NA>         <NA>         <NA>        
        3 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (1%)       <NA>         1 (1%)       <NA>        
        4 2 (2%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      2 (2%)       <NA>         <NA>         2 (2%)      
        5 <NA>       1 (1%)     <NA>       <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       1 (1%)       1 (1%)      
        6 2 (2%)     1 (1%)     1 (1%)     <NA>       <NA>       5 (5%)      <NA>         2 (2%)       <NA>         <NA>        
        7 1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>       7 (7%)      1 (1%)       <NA>         <NA>         <NA>        
        8 2 (2%)     <NA>       1 (1%)     <NA>       <NA>       12 (12%)    2 (2%)       3 (3%)       1 (1%)       <NA>        
        9 3 (3%)     <NA>       <NA>       <NA>       <NA>       6 (6%)      3 (3%)       <NA>         <NA>         <NA>        
       10 <NA>       <NA>       1 (1%)     <NA>       <NA>       7 (7%)      1 (1%)       1 (1%)       3 (3%)       1 (1%)      
       11 2 (2%)     2 (2%)     <NA>       <NA>       <NA>       8 (8%)      5 (5%)       4 (4%)       <NA>         <NA>        
       12 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         1 (1%)       <NA>        
       13 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       14 1 (1%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      2 (2%)       <NA>         <NA>         <NA>        
       15 2 (2%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      3 (3%)       2 (2%)       <NA>         <NA>        
       16 3 (3%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      1 (1%)       2 (2%)       <NA>         <NA>        
       17 <NA>       1 (1%)     <NA>       <NA>       <NA>       2 (2%)      <NA>         <NA>         2 (2%)       1 (1%)      
       18 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       5 (5%)      3 (3%)       1 (1%)       <NA>         <NA>        
       19 <NA>       <NA>       1 (1%)     <NA>       <NA>       2 (2%)      2 (2%)       1 (1%)       <NA>         1 (1%)      
       20 <NA>       <NA>       2 (2%)     <NA>       <NA>       5 (5%)      1 (1%)       <NA>         2 (2%)       <NA>        
       21 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      4 (4%)       <NA>         1 (1%)       <NA>        
       22 <NA>       1 (1%)     <NA>       <NA>       <NA>       2 (2%)      4 (4%)       2 (2%)       1 (1%)       <NA>        
       23 1 (1%)     2 (2%)     <NA>       <NA>       <NA>       5 (5%)      5 (5%)       3 (3%)       <NA>         <NA>        
       24 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         <NA>         1 (1%)      
       25 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (2%)       1 (1%)       2 (2%)       <NA>        
       26 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (1%)       2 (2%)       <NA>        
       27 <NA>       <NA>       1 (1%)     <NA>       <NA>       3 (3%)      2 (2%)       <NA>         <NA>         <NA>        
       28 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         <NA>         <NA>        
       29 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         1 (1%)       <NA>         <NA>        
       30 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         1 (1%)       <NA>         <NA>        
       31 2 (2%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      2 (2%)       1 (1%)       <NA>         <NA>        
       32 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      3 (3%)       1 (1%)       <NA>         <NA>        
       33 1 (1%)     <NA>       1 (1%)     <NA>       <NA>       2 (2%)      3 (3%)       1 (1%)       1 (1%)       <NA>        
       34 2 (2%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      3 (3%)       <NA>         <NA>         <NA>        
       35 <NA>       <NA>       <NA>       <NA>       <NA>       5 (5%)      1 (1%)       1 (1%)       <NA>         1 (1%)      
       36 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      2 (2%)       1 (1%)       1 (1%)       1 (1%)      
       37 1 (1%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      <NA>         <NA>         <NA>         <NA>        
       38 2 (2%)     2 (2%)     <NA>       <NA>       <NA>       6 (6%)      2 (2%)       3 (3%)       <NA>         <NA>        
       39 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       40 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       41 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         1 (1%)      
       42 1 (1%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      <NA>         1 (1%)       <NA>         <NA>        
       43 3 (3%)     1 (1%)     <NA>       <NA>       <NA>       5 (5%)      2 (2%)       <NA>         <NA>         1 (1%)      
       44 3 (3%)     1 (1%)     <NA>       <NA>       <NA>       6 (6%)      <NA>         <NA>         1 (1%)       <NA>        
       45 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       2 (2%)       2 (2%)       <NA>        
       46 1 (1%)     2 (2%)     <NA>       <NA>       <NA>       5 (5%)      4 (4%)       <NA>         1 (1%)       <NA>        
       47 <NA>       1 (1%)     <NA>       <NA>       <NA>       1 (1%)      <NA>         1 (1%)       <NA>         <NA>        
       48 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       49 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       50 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (1%)       <NA>         <NA>         1 (1%)      
       51 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       1 (1%)       1 (1%)       <NA>        
       52 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       2 (2%)      <NA>         <NA>         <NA>         <NA>        
       53 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      1 (1%)       <NA>         <NA>         <NA>        
       54 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (1%)       1 (1%)       2 (2%)       <NA>        
       55 <NA>       <NA>       <NA>       <NA>       <NA>       4 (4%)      2 (2%)       1 (1%)       1 (1%)       <NA>        
       56 <NA>       <NA>       1 (1%)     <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       <NA>         1 (1%)      
       57 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       3 (3%)      <NA>         1 (1%)       <NA>         2 (2%)      
       58 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         2 (2%)       <NA>         1 (1%)      
       59 1 (1%)     <NA>       1 (1%)     <NA>       <NA>       5 (5%)      2 (2%)       3 (3%)       1 (1%)       2 (2%)      
       60 2 (2%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      3 (3%)       2 (2%)       1 (1%)       2 (2%)      
       61 <NA>       <NA>       1 (1%)     1 (1%)     <NA>       5 (5%)      2 (2%)       <NA>         <NA>         <NA>        
       62 2 (2%)     <NA>       1 (1%)     <NA>       <NA>       3 (3%)      2 (2%)       1 (1%)       <NA>         <NA>        
       63 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       2 (2%)       <NA>         <NA>        
       64 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       1 (1%)       <NA>         <NA>        
       65 <NA>       <NA>       1 (1%)     <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       66 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         1 (1%)       <NA>         <NA>        
       67 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       6 (6%)      <NA>         <NA>         1 (1%)       <NA>        
       68 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      <NA>         2 (2%)       2 (2%)       <NA>        
       69 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       4 (4%)      5 (5%)       3 (3%)       <NA>         <NA>        
       70 <NA>       1 (1%)     <NA>       <NA>       <NA>       3 (3%)      3 (3%)       1 (1%)       1 (1%)       <NA>        
       71 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      2 (2%)       <NA>         <NA>         <NA>        
       72 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         <NA>         <NA>         1 (1%)      
       73 1 (1%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      4 (4%)       <NA>         <NA>         <NA>        
       74 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       2 (2%)      2 (2%)       1 (1%)       1 (1%)       1 (1%)      
       75 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         1 (1%)       <NA>        
       76 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         1 (1%)      
       77 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       78 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (2%)       <NA>         <NA>         <NA>        
       79 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       80 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       <NA>         <NA>        
       81 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       82 2 (2%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      2 (2%)       1 (1%)       <NA>         <NA>        
       83 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       3 (3%)      <NA>         <NA>         <NA>         1 (1%)      
       84 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      3 (3%)       1 (1%)       <NA>         <NA>        
       85 <NA>       1 (1%)     <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       86 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         1 (1%)       1 (1%)      
       87 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         2 (2%)       <NA>         <NA>        
       88 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       <NA>         1 (1%)      
       89 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       90 1 (1%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      2 (2%)       1 (1%)       2 (2%)       1 (1%)      
       91 2 (2%)     1 (1%)     <NA>       <NA>       <NA>       5 (5%)      1 (1%)       2 (2%)       <NA>         1 (1%)      
       92 <NA>       1 (1%)     <NA>       <NA>       <NA>       4 (4%)      3 (3%)       3 (3%)       2 (2%)       2 (2%)      
       93 2 (2%)     1 (1%)     <NA>       <NA>       <NA>       8 (8%)      2 (2%)       3 (3%)       <NA>         1 (1%)      
       94 <NA>       <NA>       <NA>       <NA>       <NA>       10 (10%)    3 (3%)       <NA>         1 (1%)       2 (2%)      
       95 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       7 (7%)      5 (5%)       <NA>         4 (4%)       <NA>        
       96 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      1 (1%)       3 (3%)       1 (1%)       1 (1%)      
       97 <NA>       1 (1%)     <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         <NA>         <NA>        
       98 1 (1%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      1 (1%)       1 (1%)       1 (1%)       <NA>        
       99 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      1 (1%)       1 (1%)       <NA>         <NA>        
      100 <NA>       1 (1%)     1 (1%)     <NA>       <NA>       3 (3%)      <NA>         2 (2%)       <NA>         <NA>        
      101 1 (1%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      <NA>         <NA>         <NA>         1 (1%)      
      102 <NA>       <NA>       <NA>       <NA>       3 (3%)     3 (3%)      <NA>         <NA>         <NA>         <NA>        
          treatment_G5 treatment_NA treatment_Tot
          <glue>       <glue>       <glue>       
        1 <NA>         <NA>         <NA>         
        2 1 (1%)       <NA>         3 (3%)       
        3 <NA>         <NA>         2 (2%)       
        4 <NA>         <NA>         4 (4%)       
        5 2 (2%)       <NA>         6 (6%)       
        6 <NA>         <NA>         2 (2%)       
        7 <NA>         <NA>         1 (1%)       
        8 <NA>         <NA>         6 (6%)       
        9 <NA>         <NA>         3 (3%)       
       10 <NA>         <NA>         6 (6%)       
       11 <NA>         <NA>         9 (9%)       
       12 <NA>         <NA>         2 (2%)       
       13 <NA>         <NA>         <NA>         
       14 <NA>         <NA>         2 (2%)       
       15 <NA>         <NA>         5 (5%)       
       16 <NA>         <NA>         3 (3%)       
       17 <NA>         <NA>         3 (3%)       
       18 <NA>         <NA>         4 (4%)       
       19 <NA>         <NA>         4 (4%)       
       20 <NA>         <NA>         3 (3%)       
       21 <NA>         <NA>         5 (5%)       
       22 <NA>         <NA>         7 (7%)       
       23 <NA>         <NA>         8 (8%)       
       24 <NA>         <NA>         1 (1%)       
       25 <NA>         <NA>         5 (5%)       
       26 <NA>         <NA>         3 (3%)       
       27 <NA>         <NA>         2 (2%)       
       28 <NA>         <NA>         2 (2%)       
       29 <NA>         <NA>         1 (1%)       
       30 <NA>         <NA>         1 (1%)       
       31 <NA>         <NA>         3 (3%)       
       32 <NA>         <NA>         4 (4%)       
       33 <NA>         <NA>         5 (5%)       
       34 <NA>         <NA>         3 (3%)       
       35 <NA>         <NA>         3 (3%)       
       36 <NA>         <NA>         5 (5%)       
       37 <NA>         <NA>         <NA>         
       38 <NA>         <NA>         5 (5%)       
       39 <NA>         <NA>         <NA>         
       40 <NA>         <NA>         <NA>         
       41 <NA>         <NA>         2 (2%)       
       42 <NA>         <NA>         1 (1%)       
       43 1 (1%)       <NA>         4 (4%)       
       44 <NA>         <NA>         1 (1%)       
       45 <NA>         <NA>         5 (5%)       
       46 <NA>         <NA>         5 (5%)       
       47 <NA>         <NA>         1 (1%)       
       48 <NA>         <NA>         1 (1%)       
       49 <NA>         <NA>         1 (1%)       
       50 <NA>         <NA>         2 (2%)       
       51 <NA>         <NA>         3 (3%)       
       52 <NA>         <NA>         <NA>         
       53 <NA>         <NA>         1 (1%)       
       54 <NA>         <NA>         4 (4%)       
       55 <NA>         <NA>         4 (4%)       
       56 <NA>         <NA>         3 (3%)       
       57 <NA>         <NA>         3 (3%)       
       58 <NA>         <NA>         3 (3%)       
       59 <NA>         <NA>         8 (8%)       
       60 <NA>         <NA>         8 (8%)       
       61 <NA>         <NA>         2 (2%)       
       62 1 (1%)       <NA>         4 (4%)       
       63 <NA>         <NA>         4 (4%)       
       64 <NA>         <NA>         3 (3%)       
       65 <NA>         <NA>         <NA>         
       66 <NA>         <NA>         1 (1%)       
       67 <NA>         <NA>         1 (1%)       
       68 <NA>         <NA>         4 (4%)       
       69 <NA>         <NA>         8 (8%)       
       70 <NA>         <NA>         5 (5%)       
       71 <NA>         <NA>         2 (2%)       
       72 <NA>         <NA>         1 (1%)       
       73 <NA>         <NA>         4 (4%)       
       74 1 (1%)       <NA>         6 (6%)       
       75 <NA>         <NA>         1 (1%)       
       76 <NA>         <NA>         2 (2%)       
       77 <NA>         <NA>         <NA>         
       78 <NA>         <NA>         2 (2%)       
       79 <NA>         <NA>         1 (1%)       
       80 <NA>         <NA>         2 (2%)       
       81 <NA>         <NA>         <NA>         
       82 <NA>         <NA>         3 (3%)       
       83 <NA>         <NA>         1 (1%)       
       84 1 (1%)       <NA>         5 (5%)       
       85 <NA>         <NA>         1 (1%)       
       86 <NA>         <NA>         2 (2%)       
       87 <NA>         <NA>         2 (2%)       
       88 <NA>         <NA>         3 (3%)       
       89 <NA>         <NA>         <NA>         
       90 <NA>         <NA>         6 (6%)       
       91 <NA>         <NA>         4 (4%)       
       92 <NA>         <NA>         10 (10%)     
       93 <NA>         <NA>         6 (6%)       
       94 1 (1%)       <NA>         7 (7%)       
       95 <NA>         <NA>         9 (9%)       
       96 <NA>         <NA>         6 (6%)       
       97 <NA>         <NA>         1 (1%)       
       98 <NA>         <NA>         3 (3%)       
       99 1 (1%)       <NA>         3 (3%)       
      100 <NA>         <NA>         2 (2%)       
      101 <NA>         <NA>         1 (1%)       
      102 <NA>         <NA>         <NA>         
    Code
      ctl = tm$enrolres %>% filter(arm == "Control") %>% pull(subjid)
      x = tm$ae %>% filter(aesoc == "Cardiac disorders" | !subjid %in% ctl) %>% ae_table_soc(df_enrol = tm$enrolres, arm = "ARM")

