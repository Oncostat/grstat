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
      # A tibble: 5 x 4
        .id       label                    variable `All patients`
        <fct>     <fct>                    <fct>    <chr>         
      1 max_grade Patient maximum AE grade Grade 1  0             
      2 max_grade Patient maximum AE grade Grade 2  0             
      3 max_grade Patient maximum AE grade Grade 3  0             
      4 max_grade Patient maximum AE grade Grade 4  1 (50%)       
      5 max_grade Patient maximum AE grade Grade 5  1 (50%)       
    Code
      ae_table_grade(df_ae = df_ae, df_enrol = df_enrolres, variant = "sup")
    Output
      # A tibble: 6 x 4
        .id           label                                variable            `All patients`
        <fct>         <fct>                                <fct>               <chr>         
      1 any_grade_sup Patient had at least one AE of grade Grade ≥ 1           2 (100%)      
      2 any_grade_sup Patient had at least one AE of grade Grade ≥ 2           2 (100%)      
      3 any_grade_sup Patient had at least one AE of grade Grade ≥ 3           2 (100%)      
      4 any_grade_sup Patient had at least one AE of grade Grade ≥ 4           2 (100%)      
      5 any_grade_sup Patient had at least one AE of grade Grade = 5           1 (50%)       
      6 any_grade_sup Patient had at least one AE of grade Some grades missing 2 (100%)      
    Code
      ae_table_grade(df_ae = df_ae, df_enrol = df_enrolres, variant = "eq")
    Output
      # A tibble: 6 x 4
        .id          label                                   variable            `All patients`
        <fct>        <fct>                                   <fct>               <chr>         
      1 any_grade_eq "Patient had at least one AE of grade " Grade 1             1 (50%)       
      2 any_grade_eq "Patient had at least one AE of grade " Grade 2             2 (100%)      
      3 any_grade_eq "Patient had at least one AE of grade " Grade 3             2 (100%)      
      4 any_grade_eq "Patient had at least one AE of grade " Grade 4             2 (100%)      
      5 any_grade_eq "Patient had at least one AE of grade " Grade 5             1 (50%)       
      6 any_grade_eq "Patient had at least one AE of grade " Some grades missing 2 (100%)      

# ae_table_grade() default snapshot

    Code
      tm = grstat_example()
      ae = tm$ae
      enrolres = tm$enrolres
      ae_table_grade(ae, df_enrol = enrolres)
    Output
      # A tibble: 18 x 4
         .id           label                                   variable       `All patients`
         <fct>         <fct>                                   <fct>          <chr>         
       1 max_grade     "Patient maximum AE grade"              No AE reported 8 (4%)        
       2 max_grade     "Patient maximum AE grade"              Grade 1        38 (19%)      
       3 max_grade     "Patient maximum AE grade"              Grade 2        62 (31%)      
       4 max_grade     "Patient maximum AE grade"              Grade 3        54 (27%)      
       5 max_grade     "Patient maximum AE grade"              Grade 4        34 (17%)      
       6 max_grade     "Patient maximum AE grade"              Grade 5        4 (2%)        
       7 any_grade_sup "Patient had at least one AE of grade"  No AE reported 8 (4%)        
       8 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1      192 (96%)     
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2      154 (77%)     
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3      92 (46%)      
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4      38 (19%)      
      12 any_grade_sup "Patient had at least one AE of grade"  Grade = 5      4 (2%)        
      13 any_grade_eq  "Patient had at least one AE of grade " No AE reported 8 (4%)        
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1        164 (82%)     
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2        110 (55%)     
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3        62 (31%)      
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4        36 (18%)      
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5        4 (2%)        
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM")
    Output
      # A tibble: 18 x 6
         .id           label                                   variable       Control  Treatment Total    
         <fct>         <fct>                                   <fct>          <chr>    <chr>     <chr>    
       1 max_grade     "Patient maximum AE grade"              No AE reported 3 (3%)   5 (5%)    8 (4%)   
       2 max_grade     "Patient maximum AE grade"              Grade 1        23 (23%) 15 (15%)  38 (19%) 
       3 max_grade     "Patient maximum AE grade"              Grade 2        32 (32%) 30 (30%)  62 (31%) 
       4 max_grade     "Patient maximum AE grade"              Grade 3        27 (27%) 27 (27%)  54 (27%) 
       5 max_grade     "Patient maximum AE grade"              Grade 4        13 (13%) 21 (21%)  34 (17%) 
       6 max_grade     "Patient maximum AE grade"              Grade 5        2 (2%)   2 (2%)    4 (2%)   
       7 any_grade_sup "Patient had at least one AE of grade"  No AE reported 3 (3%)   5 (5%)    8 (4%)   
       8 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1      97 (97%) 95 (95%)  192 (96%)
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2      74 (74%) 80 (80%)  154 (77%)
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3      42 (42%) 50 (50%)  92 (46%) 
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4      15 (15%) 23 (23%)  38 (19%) 
      12 any_grade_sup "Patient had at least one AE of grade"  Grade = 5      2 (2%)   2 (2%)    4 (2%)   
      13 any_grade_eq  "Patient had at least one AE of grade " No AE reported 3 (3%)   5 (5%)    8 (4%)   
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1        85 (85%) 79 (79%)  164 (82%)
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2        59 (59%) 51 (51%)  110 (55%)
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3        30 (30%) 32 (32%)  62 (31%) 
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4        14 (14%) 22 (22%)  36 (18%) 
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5        2 (2%)   2 (2%)    4 (2%)   
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM", variant = c("eq", "max"))
    Output
      # A tibble: 12 x 6
         .id          label                                   variable       Control  Treatment Total    
         <fct>        <fct>                                   <fct>          <chr>    <chr>     <chr>    
       1 any_grade_eq "Patient had at least one AE of grade " No AE reported 3 (3%)   5 (5%)    8 (4%)   
       2 any_grade_eq "Patient had at least one AE of grade " Grade 1        85 (85%) 79 (79%)  164 (82%)
       3 any_grade_eq "Patient had at least one AE of grade " Grade 2        59 (59%) 51 (51%)  110 (55%)
       4 any_grade_eq "Patient had at least one AE of grade " Grade 3        30 (30%) 32 (32%)  62 (31%) 
       5 any_grade_eq "Patient had at least one AE of grade " Grade 4        14 (14%) 22 (22%)  36 (18%) 
       6 any_grade_eq "Patient had at least one AE of grade " Grade 5        2 (2%)   2 (2%)    4 (2%)   
       7 max_grade    "Patient maximum AE grade"              No AE reported 3 (3%)   5 (5%)    8 (4%)   
       8 max_grade    "Patient maximum AE grade"              Grade 1        23 (23%) 15 (15%)  38 (19%) 
       9 max_grade    "Patient maximum AE grade"              Grade 2        32 (32%) 30 (30%)  62 (31%) 
      10 max_grade    "Patient maximum AE grade"              Grade 3        27 (27%) 27 (27%)  54 (27%) 
      11 max_grade    "Patient maximum AE grade"              Grade 4        13 (13%) 21 (21%)  34 (17%) 
      12 max_grade    "Patient maximum AE grade"              Grade 5        2 (2%)   2 (2%)    4 (2%)   
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM", percent = FALSE, total = FALSE)
    Output
      # A tibble: 18 x 5
         .id           label                                   variable       Control Treatment
         <fct>         <fct>                                   <fct>          <chr>   <chr>    
       1 max_grade     "Patient maximum AE grade"              No AE reported 3       5        
       2 max_grade     "Patient maximum AE grade"              Grade 1        23      15       
       3 max_grade     "Patient maximum AE grade"              Grade 2        32      30       
       4 max_grade     "Patient maximum AE grade"              Grade 3        27      27       
       5 max_grade     "Patient maximum AE grade"              Grade 4        13      21       
       6 max_grade     "Patient maximum AE grade"              Grade 5        2       2        
       7 any_grade_sup "Patient had at least one AE of grade"  No AE reported 3       5        
       8 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1      97      95       
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2      74      80       
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3      42      50       
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4      15      23       
      12 any_grade_sup "Patient had at least one AE of grade"  Grade = 5      2       2        
      13 any_grade_eq  "Patient had at least one AE of grade " No AE reported 3       5        
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1        85      79       
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2        59      51       
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3        30      32       
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4        14      22       
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5        2       2        

# ae_table_grade() with missing and grade>2

    Code
      tm = grstat_example(p_na = 0.1)
      ae = tm$ae
      enrolres = tm$enrolres
      ae %>% filter(is.na(aegr) | aegr > 2) %>% ae_table_grade(df_enrol = enrolres, arm = "ARM")
    Output
      # A tibble: 21 x 6
         .id           label                                   variable            Control  Treatment Total   
         <fct>         <fct>                                   <fct>               <chr>    <chr>     <chr>   
       1 max_grade     "Patient maximum AE grade"              No AE reported      47 (47%) 35 (35%)  82 (41%)
       2 max_grade     "Patient maximum AE grade"              Grade 1             0        0         0       
       3 max_grade     "Patient maximum AE grade"              Grade 2             0        0         0       
       4 max_grade     "Patient maximum AE grade"              Grade 3             25 (25%) 25 (25%)  50 (25%)
       5 max_grade     "Patient maximum AE grade"              Grade 4             11 (11%) 20 (20%)  31 (16%)
       6 max_grade     "Patient maximum AE grade"              Grade 5             2 (2%)   1 (1%)    3 (2%)  
       7 max_grade     "Patient maximum AE grade"              All grades missing  15 (15%) 19 (19%)  34 (17%)
       8 any_grade_sup "Patient had at least one AE of grade"  No AE reported      47 (47%) 35 (35%)  82 (41%)
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1           38 (38%) 46 (46%)  84 (42%)
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2           38 (38%) 46 (46%)  84 (42%)
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3           38 (38%) 46 (46%)  84 (42%)
      12 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4           13 (13%) 21 (21%)  34 (17%)
      13 any_grade_sup "Patient had at least one AE of grade"  Grade = 5           2 (2%)   1 (1%)    3 (2%)  
      14 any_grade_sup "Patient had at least one AE of grade"  Some grades missing 25 (25%) 34 (34%)  59 (29%)
      15 any_grade_eq  "Patient had at least one AE of grade " No AE reported      47 (47%) 35 (35%)  82 (41%)
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 1             0        0         0       
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 2             0        0         0       
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 3             27 (27%) 29 (29%)  56 (28%)
      19 any_grade_eq  "Patient had at least one AE of grade " Grade 4             12 (12%) 21 (21%)  33 (16%)
      20 any_grade_eq  "Patient had at least one AE of grade " Grade 5             2 (2%)   1 (1%)    3 (2%)  
      21 any_grade_eq  "Patient had at least one AE of grade " Some grades missing 25 (25%) 34 (34%)  59 (29%)

# ae_table_soc() default snapshot

    Code
      tm = grstat_example()
      ae = tm$ae
      enrolres = tm$enrolres
      ae_table_soc(ae, df_enrol = enrolres)
    Output
      # A tibble: 27 x 8
         soc                                                  all_patients_G1 all_patients_G2 all_patients_G3 all_patients_G4
         <fct>                                                <glue>          <glue>          <glue>          <glue>         
       1 Eye disorders                                        21 (10%)        16 (8%)         9 (4%)          3 (2%)         
       2 Social circumstances                                 27 (14%)        12 (6%)         6 (3%)          4 (2%)         
       3 Congenital, familial and genetic disorders           23 (12%)        10 (5%)         4 (2%)          5 (2%)         
       4 Injury, poisoning and procedural complications       17 (8%)         13 (6%)         3 (2%)          2 (1%)         
       5 Immune system disorders                              15 (8%)         9 (4%)          7 (4%)          3 (2%)         
       6 Pregnancy, puerperium and perinatal conditions       14 (7%)         12 (6%)         4 (2%)          3 (2%)         
       7 Neoplasms benign, malignant, and unspecified         12 (6%)         12 (6%)         4 (2%)          2 (1%)         
       8 Hepatobiliary disorders                              17 (8%)         8 (4%)          1 (0%)          2 (1%)         
       9 Surgical and medical procedures                      13 (6%)         10 (5%)         4 (2%)          1 (0%)         
      10 Cardiac disorders                                    11 (6%)         4 (2%)          7 (4%)          4 (2%)         
      11 Respiratory, thoracic and mediastinal disorders      11 (6%)         6 (3%)          5 (2%)          1 (0%)         
      12 Ear and labyrinth disorders                          7 (4%)          7 (4%)          4 (2%)          <NA>           
      13 Endocrine disorders                                  11 (6%)         2 (1%)          2 (1%)          1 (0%)         
      14 Psychiatric disorders                                10 (5%)         2 (1%)          3 (2%)          1 (0%)         
      15 Vascular disorders                                   10 (5%)         3 (2%)          1 (0%)          2 (1%)         
      16 Infections and infestations                          10 (5%)         3 (2%)          1 (0%)          <NA>           
      17 Musculoskeletal and connective tissue disorders      5 (2%)          3 (2%)          4 (2%)          1 (0%)         
      18 Nervous system disorders                             5 (2%)          6 (3%)          <NA>            1 (0%)         
      19 Investigations                                       7 (4%)          1 (0%)          3 (2%)          <NA>           
      20 Blood and lymphatic system disorders                 3 (2%)          3 (2%)          3 (2%)          1 (0%)         
      21 Metabolism and nutrition disorders                   8 (4%)          2 (1%)          <NA>            <NA>           
      22 Skin and subcutaneous tissue disorders               6 (3%)          3 (2%)          <NA>            1 (0%)         
      23 General disorders and administration site conditions 2 (1%)          5 (2%)          2 (1%)          <NA>           
      24 Gastrointestinal disorders                           5 (2%)          1 (0%)          <NA>            1 (0%)         
      25 Renal and urinary disorders                          5 (2%)          <NA>            1 (0%)          1 (0%)         
      26 Reproductive system and breast disorders             3 (2%)          2 (1%)          2 (1%)          <NA>           
      27 No Declared AE                                       <NA>            <NA>            <NA>            <NA>           
         all_patients_G5 all_patients_NA all_patients_Tot
         <glue>          <glue>          <glue>          
       1 <NA>            <NA>            49 (24%)        
       2 <NA>            <NA>            49 (24%)        
       3 <NA>            <NA>            42 (21%)        
       4 <NA>            <NA>            35 (18%)        
       5 <NA>            <NA>            34 (17%)        
       6 <NA>            <NA>            33 (16%)        
       7 <NA>            <NA>            30 (15%)        
       8 <NA>            <NA>            28 (14%)        
       9 <NA>            <NA>            28 (14%)        
      10 <NA>            <NA>            26 (13%)        
      11 1 (0%)          <NA>            24 (12%)        
      12 <NA>            <NA>            18 (9%)         
      13 <NA>            <NA>            16 (8%)         
      14 <NA>            <NA>            16 (8%)         
      15 <NA>            <NA>            16 (8%)         
      16 1 (0%)          <NA>            15 (8%)         
      17 2 (1%)          <NA>            15 (8%)         
      18 <NA>            <NA>            12 (6%)         
      19 <NA>            <NA>            11 (6%)         
      20 <NA>            <NA>            10 (5%)         
      21 <NA>            <NA>            10 (5%)         
      22 <NA>            <NA>            10 (5%)         
      23 <NA>            <NA>            9 (4%)          
      24 <NA>            <NA>            7 (4%)          
      25 <NA>            <NA>            7 (4%)          
      26 <NA>            <NA>            7 (4%)          
      27 <NA>            8 (4%)          8 (4%)          
    Code
      ae_table_soc(ae, df_enrol = enrolres, sort_by_count = FALSE)
    Output
      # A tibble: 27 x 8
         soc                                                  all_patients_G1 all_patients_G2 all_patients_G3 all_patients_G4
         <fct>                                                <glue>          <glue>          <glue>          <glue>         
       1 Blood and lymphatic system disorders                 3 (2%)          3 (2%)          3 (2%)          1 (0%)         
       2 Cardiac disorders                                    11 (6%)         4 (2%)          7 (4%)          4 (2%)         
       3 Congenital, familial and genetic disorders           23 (12%)        10 (5%)         4 (2%)          5 (2%)         
       4 Ear and labyrinth disorders                          7 (4%)          7 (4%)          4 (2%)          <NA>           
       5 Endocrine disorders                                  11 (6%)         2 (1%)          2 (1%)          1 (0%)         
       6 Eye disorders                                        21 (10%)        16 (8%)         9 (4%)          3 (2%)         
       7 Gastrointestinal disorders                           5 (2%)          1 (0%)          <NA>            1 (0%)         
       8 General disorders and administration site conditions 2 (1%)          5 (2%)          2 (1%)          <NA>           
       9 Hepatobiliary disorders                              17 (8%)         8 (4%)          1 (0%)          2 (1%)         
      10 Immune system disorders                              15 (8%)         9 (4%)          7 (4%)          3 (2%)         
      11 Infections and infestations                          10 (5%)         3 (2%)          1 (0%)          <NA>           
      12 Injury, poisoning and procedural complications       17 (8%)         13 (6%)         3 (2%)          2 (1%)         
      13 Investigations                                       7 (4%)          1 (0%)          3 (2%)          <NA>           
      14 Metabolism and nutrition disorders                   8 (4%)          2 (1%)          <NA>            <NA>           
      15 Musculoskeletal and connective tissue disorders      5 (2%)          3 (2%)          4 (2%)          1 (0%)         
      16 Neoplasms benign, malignant, and unspecified         12 (6%)         12 (6%)         4 (2%)          2 (1%)         
      17 Nervous system disorders                             5 (2%)          6 (3%)          <NA>            1 (0%)         
      18 Pregnancy, puerperium and perinatal conditions       14 (7%)         12 (6%)         4 (2%)          3 (2%)         
      19 Psychiatric disorders                                10 (5%)         2 (1%)          3 (2%)          1 (0%)         
      20 Renal and urinary disorders                          5 (2%)          <NA>            1 (0%)          1 (0%)         
      21 Reproductive system and breast disorders             3 (2%)          2 (1%)          2 (1%)          <NA>           
      22 Respiratory, thoracic and mediastinal disorders      11 (6%)         6 (3%)          5 (2%)          1 (0%)         
      23 Skin and subcutaneous tissue disorders               6 (3%)          3 (2%)          <NA>            1 (0%)         
      24 Social circumstances                                 27 (14%)        12 (6%)         6 (3%)          4 (2%)         
      25 Surgical and medical procedures                      13 (6%)         10 (5%)         4 (2%)          1 (0%)         
      26 Vascular disorders                                   10 (5%)         3 (2%)          1 (0%)          2 (1%)         
      27 No Declared AE                                       <NA>            <NA>            <NA>            <NA>           
         all_patients_G5 all_patients_NA all_patients_Tot
         <glue>          <glue>          <glue>          
       1 <NA>            <NA>            10 (5%)         
       2 <NA>            <NA>            26 (13%)        
       3 <NA>            <NA>            42 (21%)        
       4 <NA>            <NA>            18 (9%)         
       5 <NA>            <NA>            16 (8%)         
       6 <NA>            <NA>            49 (24%)        
       7 <NA>            <NA>            7 (4%)          
       8 <NA>            <NA>            9 (4%)          
       9 <NA>            <NA>            28 (14%)        
      10 <NA>            <NA>            34 (17%)        
      11 1 (0%)          <NA>            15 (8%)         
      12 <NA>            <NA>            35 (18%)        
      13 <NA>            <NA>            11 (6%)         
      14 <NA>            <NA>            10 (5%)         
      15 2 (1%)          <NA>            15 (8%)         
      16 <NA>            <NA>            30 (15%)        
      17 <NA>            <NA>            12 (6%)         
      18 <NA>            <NA>            33 (16%)        
      19 <NA>            <NA>            16 (8%)         
      20 <NA>            <NA>            7 (4%)          
      21 <NA>            <NA>            7 (4%)          
      22 1 (0%)          <NA>            24 (12%)        
      23 <NA>            <NA>            10 (5%)         
      24 <NA>            <NA>            49 (24%)        
      25 <NA>            <NA>            28 (14%)        
      26 <NA>            <NA>            16 (8%)         
      27 <NA>            8 (4%)          8 (4%)          
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", digits = 1)
    Output
      # A tibble: 27 x 15
         soc                                                  control_G1 control_G2 control_G3 control_G4 control_G5 control_NA
         <fct>                                                <glue>     <glue>     <glue>     <glue>     <glue>     <glue>    
       1 Eye disorders                                        14 (14%)   11 (11%)   4 (4%)     2 (2%)     <NA>       <NA>      
       2 Social circumstances                                 16 (16%)   8 (8%)     3 (3%)     <NA>       <NA>       <NA>      
       3 Congenital, familial and genetic disorders           10 (10%)   7 (7%)     2 (2%)     1 (1%)     <NA>       <NA>      
       4 Injury, poisoning and procedural complications       12 (12%)   8 (8%)     1 (1%)     1 (1%)     <NA>       <NA>      
       5 Immune system disorders                              8 (8%)     4 (4%)     4 (4%)     2 (2%)     <NA>       <NA>      
       6 Pregnancy, puerperium and perinatal conditions       7 (7%)     5 (5%)     2 (2%)     2 (2%)     <NA>       <NA>      
       7 Neoplasms benign, malignant, and unspecified         6 (6%)     7 (7%)     3 (3%)     1 (1%)     <NA>       <NA>      
       8 Hepatobiliary disorders                              9 (9%)     3 (3%)     <NA>       2 (2%)     <NA>       <NA>      
       9 Surgical and medical procedures                      6 (6%)     5 (5%)     2 (2%)     <NA>       <NA>       <NA>      
      10 Cardiac disorders                                    7 (7%)     3 (3%)     4 (4%)     <NA>       <NA>       <NA>      
      11 Respiratory, thoracic and mediastinal disorders      7 (7%)     3 (3%)     1 (1%)     <NA>       <NA>       <NA>      
      12 Ear and labyrinth disorders                          4 (4%)     2 (2%)     2 (2%)     <NA>       <NA>       <NA>      
      13 Endocrine disorders                                  9 (9%)     <NA>       1 (1%)     1 (1%)     <NA>       <NA>      
      14 Psychiatric disorders                                4 (4%)     1 (1%)     1 (1%)     <NA>       <NA>       <NA>      
      15 Vascular disorders                                   6 (6%)     1 (1%)     <NA>       <NA>       <NA>       <NA>      
      16 Infections and infestations                          8 (8%)     3 (3%)     <NA>       <NA>       <NA>       <NA>      
      17 Musculoskeletal and connective tissue disorders      4 (4%)     2 (2%)     2 (2%)     1 (1%)     2 (2%)     <NA>      
      18 Nervous system disorders                             2 (2%)     3 (3%)     <NA>       <NA>       <NA>       <NA>      
      19 Investigations                                       5 (5%)     1 (1%)     1 (1%)     <NA>       <NA>       <NA>      
      20 Blood and lymphatic system disorders                 <NA>       1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>      
      21 Metabolism and nutrition disorders                   4 (4%)     1 (1%)     <NA>       <NA>       <NA>       <NA>      
      22 Skin and subcutaneous tissue disorders               2 (2%)     1 (1%)     <NA>       1 (1%)     <NA>       <NA>      
      23 General disorders and administration site conditions <NA>       4 (4%)     2 (2%)     <NA>       <NA>       <NA>      
      24 Gastrointestinal disorders                           2 (2%)     1 (1%)     <NA>       1 (1%)     <NA>       <NA>      
      25 Renal and urinary disorders                          3 (3%)     <NA>       1 (1%)     <NA>       <NA>       <NA>      
      26 Reproductive system and breast disorders             1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>       <NA>      
      27 No Declared AE                                       <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)    
         control_Tot treatment_G1 treatment_G2 treatment_G3 treatment_G4 treatment_G5 treatment_NA treatment_Tot
         <glue>      <glue>       <glue>       <glue>       <glue>       <glue>       <glue>       <glue>       
       1 31 (31%)    7 (7%)       5 (5%)       5 (5%)       1 (1%)       <NA>         <NA>         18 (18%)     
       2 27 (27%)    11 (11%)     4 (4%)       3 (3%)       4 (4%)       <NA>         <NA>         22 (22%)     
       3 20 (20%)    13 (13%)     3 (3%)       2 (2%)       4 (4%)       <NA>         <NA>         22 (22%)     
       4 22 (22%)    5 (5%)       5 (5%)       2 (2%)       1 (1%)       <NA>         <NA>         13 (13%)     
       5 18 (18%)    7 (7%)       5 (5%)       3 (3%)       1 (1%)       <NA>         <NA>         16 (16%)     
       6 16 (16%)    7 (7%)       7 (7%)       2 (2%)       1 (1%)       <NA>         <NA>         17 (17%)     
       7 17 (17%)    6 (6%)       5 (5%)       1 (1%)       1 (1%)       <NA>         <NA>         13 (13%)     
       8 14 (14%)    8 (8%)       5 (5%)       1 (1%)       <NA>         <NA>         <NA>         14 (14%)     
       9 13 (13%)    7 (7%)       5 (5%)       2 (2%)       1 (1%)       <NA>         <NA>         15 (15%)     
      10 14 (14%)    4 (4%)       1 (1%)       3 (3%)       4 (4%)       <NA>         <NA>         12 (12%)     
      11 11 (11%)    4 (4%)       3 (3%)       4 (4%)       1 (1%)       1 (1%)       <NA>         13 (13%)     
      12 8 (8%)      3 (3%)       5 (5%)       2 (2%)       <NA>         <NA>         <NA>         10 (10%)     
      13 11 (11%)    2 (2%)       2 (2%)       1 (1%)       <NA>         <NA>         <NA>         5 (5%)       
      14 6 (6%)      6 (6%)       1 (1%)       2 (2%)       1 (1%)       <NA>         <NA>         10 (10%)     
      15 7 (7%)      4 (4%)       2 (2%)       1 (1%)       2 (2%)       <NA>         <NA>         9 (9%)       
      16 11 (11%)    2 (2%)       <NA>         1 (1%)       <NA>         1 (1%)       <NA>         4 (4%)       
      17 11 (11%)    1 (1%)       1 (1%)       2 (2%)       <NA>         <NA>         <NA>         4 (4%)       
      18 5 (5%)      3 (3%)       3 (3%)       <NA>         1 (1%)       <NA>         <NA>         7 (7%)       
      19 7 (7%)      2 (2%)       <NA>         2 (2%)       <NA>         <NA>         <NA>         4 (4%)       
      20 3 (3%)      3 (3%)       2 (2%)       2 (2%)       <NA>         <NA>         <NA>         7 (7%)       
      21 5 (5%)      4 (4%)       1 (1%)       <NA>         <NA>         <NA>         <NA>         5 (5%)       
      22 4 (4%)      4 (4%)       2 (2%)       <NA>         <NA>         <NA>         <NA>         6 (6%)       
      23 6 (6%)      2 (2%)       1 (1%)       <NA>         <NA>         <NA>         <NA>         3 (3%)       
      24 4 (4%)      3 (3%)       <NA>         <NA>         <NA>         <NA>         <NA>         3 (3%)       
      25 4 (4%)      2 (2%)       <NA>         <NA>         1 (1%)       <NA>         <NA>         3 (3%)       
      26 3 (3%)      2 (2%)       1 (1%)       1 (1%)       <NA>         <NA>         <NA>         4 (4%)       
      27 3 (3%)      <NA>         <NA>         <NA>         <NA>         <NA>         5 (5%)       5 (5%)       
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", showNA = FALSE, total = FALSE)
    Output
      # A tibble: 27 x 11
         soc                                                  control_G1 control_G2 control_G3 control_G4 control_G5 treatment_G1
         <fct>                                                <glue>     <glue>     <glue>     <glue>     <glue>     <glue>      
       1 Eye disorders                                        14 (14%)   11 (11%)   4 (4%)     2 (2%)     <NA>       7 (7%)      
       2 Social circumstances                                 16 (16%)   8 (8%)     3 (3%)     <NA>       <NA>       11 (11%)    
       3 Congenital, familial and genetic disorders           10 (10%)   7 (7%)     2 (2%)     1 (1%)     <NA>       13 (13%)    
       4 Injury, poisoning and procedural complications       12 (12%)   8 (8%)     1 (1%)     1 (1%)     <NA>       5 (5%)      
       5 Immune system disorders                              8 (8%)     4 (4%)     4 (4%)     2 (2%)     <NA>       7 (7%)      
       6 Pregnancy, puerperium and perinatal conditions       7 (7%)     5 (5%)     2 (2%)     2 (2%)     <NA>       7 (7%)      
       7 Neoplasms benign, malignant, and unspecified         6 (6%)     7 (7%)     3 (3%)     1 (1%)     <NA>       6 (6%)      
       8 Hepatobiliary disorders                              9 (9%)     3 (3%)     <NA>       2 (2%)     <NA>       8 (8%)      
       9 Surgical and medical procedures                      6 (6%)     5 (5%)     2 (2%)     <NA>       <NA>       7 (7%)      
      10 Cardiac disorders                                    7 (7%)     3 (3%)     4 (4%)     <NA>       <NA>       4 (4%)      
      11 Respiratory, thoracic and mediastinal disorders      7 (7%)     3 (3%)     1 (1%)     <NA>       <NA>       4 (4%)      
      12 Ear and labyrinth disorders                          4 (4%)     2 (2%)     2 (2%)     <NA>       <NA>       3 (3%)      
      13 Endocrine disorders                                  9 (9%)     <NA>       1 (1%)     1 (1%)     <NA>       2 (2%)      
      14 Psychiatric disorders                                4 (4%)     1 (1%)     1 (1%)     <NA>       <NA>       6 (6%)      
      15 Vascular disorders                                   6 (6%)     1 (1%)     <NA>       <NA>       <NA>       4 (4%)      
      16 Infections and infestations                          8 (8%)     3 (3%)     <NA>       <NA>       <NA>       2 (2%)      
      17 Musculoskeletal and connective tissue disorders      4 (4%)     2 (2%)     2 (2%)     1 (1%)     2 (2%)     1 (1%)      
      18 Nervous system disorders                             2 (2%)     3 (3%)     <NA>       <NA>       <NA>       3 (3%)      
      19 Investigations                                       5 (5%)     1 (1%)     1 (1%)     <NA>       <NA>       2 (2%)      
      20 Blood and lymphatic system disorders                 <NA>       1 (1%)     1 (1%)     1 (1%)     <NA>       3 (3%)      
      21 Metabolism and nutrition disorders                   4 (4%)     1 (1%)     <NA>       <NA>       <NA>       4 (4%)      
      22 Skin and subcutaneous tissue disorders               2 (2%)     1 (1%)     <NA>       1 (1%)     <NA>       4 (4%)      
      23 General disorders and administration site conditions <NA>       4 (4%)     2 (2%)     <NA>       <NA>       2 (2%)      
      24 Gastrointestinal disorders                           2 (2%)     1 (1%)     <NA>       1 (1%)     <NA>       3 (3%)      
      25 Renal and urinary disorders                          3 (3%)     <NA>       1 (1%)     <NA>       <NA>       2 (2%)      
      26 Reproductive system and breast disorders             1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>       2 (2%)      
      27 No Declared AE                                       <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        
         treatment_G2 treatment_G3 treatment_G4 treatment_G5
         <glue>       <glue>       <glue>       <glue>      
       1 5 (5%)       5 (5%)       1 (1%)       <NA>        
       2 4 (4%)       3 (3%)       4 (4%)       <NA>        
       3 3 (3%)       2 (2%)       4 (4%)       <NA>        
       4 5 (5%)       2 (2%)       1 (1%)       <NA>        
       5 5 (5%)       3 (3%)       1 (1%)       <NA>        
       6 7 (7%)       2 (2%)       1 (1%)       <NA>        
       7 5 (5%)       1 (1%)       1 (1%)       <NA>        
       8 5 (5%)       1 (1%)       <NA>         <NA>        
       9 5 (5%)       2 (2%)       1 (1%)       <NA>        
      10 1 (1%)       3 (3%)       4 (4%)       <NA>        
      11 3 (3%)       4 (4%)       1 (1%)       1 (1%)      
      12 5 (5%)       2 (2%)       <NA>         <NA>        
      13 2 (2%)       1 (1%)       <NA>         <NA>        
      14 1 (1%)       2 (2%)       1 (1%)       <NA>        
      15 2 (2%)       1 (1%)       2 (2%)       <NA>        
      16 <NA>         1 (1%)       <NA>         1 (1%)      
      17 1 (1%)       2 (2%)       <NA>         <NA>        
      18 3 (3%)       <NA>         1 (1%)       <NA>        
      19 <NA>         2 (2%)       <NA>         <NA>        
      20 2 (2%)       2 (2%)       <NA>         <NA>        
      21 1 (1%)       <NA>         <NA>         <NA>        
      22 2 (2%)       <NA>         <NA>         <NA>        
      23 1 (1%)       <NA>         <NA>         <NA>        
      24 <NA>         <NA>         <NA>         <NA>        
      25 <NA>         <NA>         1 (1%)       <NA>        
      26 1 (1%)       1 (1%)       <NA>         <NA>        
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
       1 Eye disorders                                        31 (31%)   17 (17%)   6 (6%)     2 (2%)     <NA>       <NA>      
       2 Social circumstances                                 27 (27%)   11 (11%)   3 (3%)     <NA>       <NA>       <NA>      
       3 Congenital, familial and genetic disorders           20 (20%)   10 (10%)   3 (3%)     1 (1%)     <NA>       <NA>      
       4 Immune system disorders                              18 (18%)   10 (10%)   6 (6%)     2 (2%)     <NA>       <NA>      
       5 Pregnancy, puerperium and perinatal conditions       16 (16%)   9 (9%)     4 (4%)     2 (2%)     <NA>       <NA>      
       6 Injury, poisoning and procedural complications       22 (22%)   10 (10%)   2 (2%)     1 (1%)     <NA>       <NA>      
       7 Cardiac disorders                                    14 (14%)   7 (7%)     4 (4%)     <NA>       <NA>       <NA>      
       8 Neoplasms benign, malignant, and unspecified         17 (17%)   11 (11%)   4 (4%)     1 (1%)     <NA>       <NA>      
       9 Surgical and medical procedures                      13 (13%)   7 (7%)     2 (2%)     <NA>       <NA>       <NA>      
      10 Respiratory, thoracic and mediastinal disorders      11 (11%)   4 (4%)     1 (1%)     <NA>       <NA>       <NA>      
      11 Hepatobiliary disorders                              14 (14%)   5 (5%)     2 (2%)     2 (2%)     <NA>       <NA>      
      12 Musculoskeletal and connective tissue disorders      11 (11%)   7 (7%)     5 (5%)     3 (3%)     2 (2%)     <NA>      
      13 Ear and labyrinth disorders                          8 (8%)     4 (4%)     2 (2%)     <NA>       <NA>       <NA>      
      14 Psychiatric disorders                                6 (6%)     2 (2%)     1 (1%)     <NA>       <NA>       <NA>      
      15 Vascular disorders                                   7 (7%)     1 (1%)     <NA>       <NA>       <NA>       <NA>      
      16 Endocrine disorders                                  11 (11%)   2 (2%)     2 (2%)     1 (1%)     <NA>       <NA>      
      17 Infections and infestations                          11 (11%)   3 (3%)     <NA>       <NA>       <NA>       <NA>      
      18 Blood and lymphatic system disorders                 3 (3%)     3 (3%)     2 (2%)     1 (1%)     <NA>       <NA>      
      19 Nervous system disorders                             5 (5%)     3 (3%)     <NA>       <NA>       <NA>       <NA>      
      20 General disorders and administration site conditions 6 (6%)     6 (6%)     2 (2%)     <NA>       <NA>       <NA>      
      21 Investigations                                       7 (7%)     2 (2%)     1 (1%)     <NA>       <NA>       <NA>      
      22 Skin and subcutaneous tissue disorders               4 (4%)     2 (2%)     1 (1%)     1 (1%)     <NA>       <NA>      
      23 Reproductive system and breast disorders             3 (3%)     2 (2%)     1 (1%)     <NA>       <NA>       <NA>      
      24 Metabolism and nutrition disorders                   5 (5%)     1 (1%)     <NA>       <NA>       <NA>       <NA>      
      25 Renal and urinary disorders                          4 (4%)     1 (1%)     1 (1%)     <NA>       <NA>       <NA>      
      26 Gastrointestinal disorders                           4 (4%)     2 (2%)     1 (1%)     1 (1%)     <NA>       <NA>      
      27 No Declared AE                                       <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
         treatment_G1 treatment_G2 treatment_G3 treatment_G4 treatment_G5 treatment_NA
         <glue>       <glue>       <glue>       <glue>       <glue>       <glue>      
       1 18 (18%)     11 (11%)     6 (6%)       1 (1%)       <NA>         <NA>        
       2 22 (22%)     11 (11%)     7 (7%)       4 (4%)       <NA>         <NA>        
       3 22 (22%)     9 (9%)       6 (6%)       4 (4%)       <NA>         <NA>        
       4 16 (16%)     9 (9%)       4 (4%)       1 (1%)       <NA>         <NA>        
       5 17 (17%)     10 (10%)     3 (3%)       1 (1%)       <NA>         <NA>        
       6 13 (13%)     8 (8%)       3 (3%)       1 (1%)       <NA>         <NA>        
       7 12 (12%)     8 (8%)       7 (7%)       4 (4%)       <NA>         <NA>        
       8 13 (13%)     7 (7%)       2 (2%)       1 (1%)       <NA>         <NA>        
       9 15 (15%)     8 (8%)       3 (3%)       1 (1%)       <NA>         <NA>        
      10 13 (13%)     9 (9%)       6 (6%)       2 (2%)       1 (1%)       <NA>        
      11 14 (14%)     6 (6%)       1 (1%)       <NA>         <NA>         <NA>        
      12 4 (4%)       3 (3%)       2 (2%)       <NA>         <NA>         <NA>        
      13 10 (10%)     7 (7%)       2 (2%)       <NA>         <NA>         <NA>        
      14 10 (10%)     4 (4%)       3 (3%)       1 (1%)       <NA>         <NA>        
      15 9 (9%)       5 (5%)       3 (3%)       2 (2%)       <NA>         <NA>        
      16 5 (5%)       3 (3%)       1 (1%)       <NA>         <NA>         <NA>        
      17 4 (4%)       2 (2%)       2 (2%)       1 (1%)       1 (1%)       <NA>        
      18 7 (7%)       4 (4%)       2 (2%)       <NA>         <NA>         <NA>        
      19 7 (7%)       4 (4%)       1 (1%)       1 (1%)       <NA>         <NA>        
      20 3 (3%)       1 (1%)       <NA>         <NA>         <NA>         <NA>        
      21 4 (4%)       2 (2%)       2 (2%)       <NA>         <NA>         <NA>        
      22 6 (6%)       2 (2%)       <NA>         <NA>         <NA>         <NA>        
      23 4 (4%)       2 (2%)       1 (1%)       <NA>         <NA>         <NA>        
      24 5 (5%)       1 (1%)       <NA>         <NA>         <NA>         <NA>        
      25 3 (3%)       1 (1%)       1 (1%)       1 (1%)       <NA>         <NA>        
      26 3 (3%)       <NA>         <NA>         <NA>         <NA>         <NA>        
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
       1 Eye disorders                                        18 (18%)   11 (11%)   4 (4%)     2 (2%)     <NA>       <NA>      
       2 Social circumstances                                 19 (19%)   8 (8%)     3 (3%)     <NA>       <NA>       <NA>      
       3 Congenital, familial and genetic disorders           12 (12%)   7 (7%)     2 (2%)     1 (1%)     <NA>       <NA>      
       4 Injury, poisoning and procedural complications       14 (14%)   8 (8%)     1 (1%)     1 (1%)     <NA>       <NA>      
       5 Immune system disorders                              8 (8%)     4 (4%)     4 (4%)     2 (2%)     <NA>       <NA>      
       6 Pregnancy, puerperium and perinatal conditions       7 (7%)     5 (5%)     2 (2%)     2 (2%)     <NA>       <NA>      
       7 Neoplasms benign, malignant, and unspecified         6 (6%)     7 (7%)     3 (3%)     1 (1%)     <NA>       <NA>      
       8 Cardiac disorders                                    8 (8%)     3 (3%)     4 (4%)     <NA>       <NA>       <NA>      
       9 Surgical and medical procedures                      7 (7%)     5 (5%)     2 (2%)     <NA>       <NA>       <NA>      
      10 Hepatobiliary disorders                              9 (9%)     3 (3%)     <NA>       2 (2%)     <NA>       <NA>      
      11 Respiratory, thoracic and mediastinal disorders      8 (8%)     3 (3%)     1 (1%)     <NA>       <NA>       <NA>      
      12 Ear and labyrinth disorders                          4 (4%)     2 (2%)     2 (2%)     <NA>       <NA>       <NA>      
      13 Endocrine disorders                                  9 (9%)     <NA>       1 (1%)     1 (1%)     <NA>       <NA>      
      14 Musculoskeletal and connective tissue disorders      5 (5%)     2 (2%)     2 (2%)     1 (1%)     2 (2%)     <NA>      
      15 Psychiatric disorders                                4 (4%)     1 (1%)     1 (1%)     <NA>       <NA>       <NA>      
      16 Vascular disorders                                   6 (6%)     1 (1%)     <NA>       <NA>       <NA>       <NA>      
      17 Infections and infestations                          8 (8%)     3 (3%)     <NA>       <NA>       <NA>       <NA>      
      18 Nervous system disorders                             3 (3%)     3 (3%)     <NA>       <NA>       <NA>       <NA>      
      19 Investigations                                       5 (5%)     1 (1%)     1 (1%)     <NA>       <NA>       <NA>      
      20 Metabolism and nutrition disorders                   4 (4%)     1 (1%)     <NA>       <NA>       <NA>       <NA>      
      21 Blood and lymphatic system disorders                 <NA>       1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>      
      22 Skin and subcutaneous tissue disorders               2 (2%)     1 (1%)     <NA>       1 (1%)     <NA>       <NA>      
      23 General disorders and administration site conditions <NA>       4 (4%)     2 (2%)     <NA>       <NA>       <NA>      
      24 Gastrointestinal disorders                           2 (2%)     1 (1%)     <NA>       1 (1%)     <NA>       <NA>      
      25 Renal and urinary disorders                          3 (3%)     <NA>       1 (1%)     <NA>       <NA>       <NA>      
      26 Reproductive system and breast disorders             1 (1%)     1 (1%)     1 (1%)     <NA>       <NA>       <NA>      
      27 No Declared AE                                       <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
         treatment_G1 treatment_G2 treatment_G3 treatment_G4 treatment_G5 treatment_NA
         <glue>       <glue>       <glue>       <glue>       <glue>       <glue>      
       1 8 (8%)       5 (5%)       5 (5%)       1 (1%)       <NA>         <NA>        
       2 13 (13%)     4 (4%)       3 (3%)       4 (4%)       <NA>         <NA>        
       3 15 (15%)     4 (4%)       2 (2%)       4 (4%)       <NA>         <NA>        
       4 7 (7%)       5 (5%)       2 (2%)       1 (1%)       <NA>         <NA>        
       5 9 (9%)       7 (7%)       3 (3%)       1 (1%)       <NA>         <NA>        
       6 8 (8%)       7 (7%)       2 (2%)       1 (1%)       <NA>         <NA>        
       7 6 (6%)       5 (5%)       1 (1%)       1 (1%)       <NA>         <NA>        
       8 6 (6%)       1 (1%)       3 (3%)       4 (4%)       <NA>         <NA>        
       9 7 (7%)       5 (5%)       2 (2%)       1 (1%)       <NA>         <NA>        
      10 8 (8%)       5 (5%)       1 (1%)       <NA>         <NA>         <NA>        
      11 4 (4%)       3 (3%)       5 (5%)       1 (1%)       1 (1%)       <NA>        
      12 4 (4%)       5 (5%)       2 (2%)       <NA>         <NA>         <NA>        
      13 2 (2%)       2 (2%)       1 (1%)       <NA>         <NA>         <NA>        
      14 1 (1%)       1 (1%)       2 (2%)       <NA>         <NA>         <NA>        
      15 6 (6%)       1 (1%)       2 (2%)       1 (1%)       <NA>         <NA>        
      16 4 (4%)       2 (2%)       1 (1%)       2 (2%)       <NA>         <NA>        
      17 2 (2%)       <NA>         1 (1%)       <NA>         1 (1%)       <NA>        
      18 3 (3%)       3 (3%)       <NA>         1 (1%)       <NA>         <NA>        
      19 3 (3%)       <NA>         2 (2%)       <NA>         <NA>         <NA>        
      20 5 (5%)       1 (1%)       <NA>         <NA>         <NA>         <NA>        
      21 3 (3%)       2 (2%)       2 (2%)       <NA>         <NA>         <NA>        
      22 4 (4%)       2 (2%)       <NA>         <NA>         <NA>         <NA>        
      23 2 (2%)       1 (1%)       <NA>         <NA>         <NA>         <NA>        
      24 3 (3%)       <NA>         <NA>         <NA>         <NA>         <NA>        
      25 2 (2%)       <NA>         <NA>         1 (1%)       <NA>         <NA>        
      26 2 (2%)       1 (1%)       1 (1%)       <NA>         <NA>         <NA>        
      27 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", term = "aeterm", sort_by_count = TRUE)
    Output
      # A tibble: 103 x 16
          soc                                                  term                                                 control_G1
          <fct>                                                <chr>                                                <glue>    
        1 Social circumstances                                 Cultural issues                                      7 (7%)    
        2 Social circumstances                                 Economic conditions affecting care                   <NA>      
        3 Social circumstances                                 Family support issues                                9 (9%)    
        4 Social circumstances                                 Social and environmental issues                      2 (2%)    
        5 Eye disorders                                        Corneal disorders                                    7 (7%)    
        6 Eye disorders                                        Eyelid disorders                                     3 (3%)    
        7 Eye disorders                                        Retinal disorders                                    4 (4%)    
        8 Eye disorders                                        Vision disorders                                     4 (4%)    
        9 Congenital, familial and genetic disorders           Chromosomal abnormalities                            2 (2%)    
       10 Congenital, familial and genetic disorders           Congenital nervous system disorders                  4 (4%)    
       11 Congenital, familial and genetic disorders           Familial hematologic disorders                       1 (1%)    
       12 Congenital, familial and genetic disorders           Hereditary connective tissue disorders               6 (6%)    
       13 Injury, poisoning and procedural complications       Poisonings                                           4 (4%)    
       14 Injury, poisoning and procedural complications       Procedural complications                             7 (7%)    
       15 Injury, poisoning and procedural complications       Radiation-related toxicities                         2 (2%)    
       16 Injury, poisoning and procedural complications       Traumatic injuries                                   1 (1%)    
       17 Immune system disorders                              Autoimmune disorders                                 2 (2%)    
       18 Immune system disorders                              Hypersensitivity conditions                          5 (5%)    
       19 Immune system disorders                              Immunodeficiency                                     <NA>      
       20 Immune system disorders                              Inflammatory responses                               1 (1%)    
       21 Pregnancy, puerperium and perinatal conditions       Breastfeeding issues                                 3 (3%)    
       22 Pregnancy, puerperium and perinatal conditions       Fetal complications                                  1 (1%)    
       23 Pregnancy, puerperium and perinatal conditions       Labor and delivery complications                     3 (3%)    
       24 Pregnancy, puerperium and perinatal conditions       Pregnancy complications                              <NA>      
       25 Neoplasms benign, malignant, and unspecified         Benign neoplasms                                     2 (2%)    
       26 Neoplasms benign, malignant, and unspecified         Malignant neoplasms                                  <NA>      
       27 Neoplasms benign, malignant, and unspecified         Neoplasms unspecified                                1 (1%)    
       28 Neoplasms benign, malignant, and unspecified         Tumor progression                                    3 (3%)    
       29 Hepatobiliary disorders                              Bile duct disorders                                  2 (2%)    
       30 Hepatobiliary disorders                              Gallbladder disorders                                2 (2%)    
       31 Hepatobiliary disorders                              Hepatic failure                                      4 (4%)    
       32 Hepatobiliary disorders                              Liver disorders                                      1 (1%)    
       33 Surgical and medical procedures                      Device implantation procedures                       2 (2%)    
       34 Surgical and medical procedures                      Diagnostic procedures                                3 (3%)    
       35 Surgical and medical procedures                      Surgical complications                               1 (1%)    
       36 Surgical and medical procedures                      Therapeutic procedures                               1 (1%)    
       37 Cardiac disorders                                    Cardiac arrhythmias                                  2 (2%)    
       38 Cardiac disorders                                    Cardiac valve disorders                              3 (3%)    
       39 Cardiac disorders                                    Coronary artery disorders                            1 (1%)    
       40 Cardiac disorders                                    Heart failures                                       1 (1%)    
       41 Respiratory, thoracic and mediastinal disorders      Lung function disorders                              2 (2%)    
       42 Respiratory, thoracic and mediastinal disorders      Pleural disorders                                    2 (2%)    
       43 Respiratory, thoracic and mediastinal disorders      Pulmonary vascular disorders                         2 (2%)    
       44 Respiratory, thoracic and mediastinal disorders      Respiratory infections                               2 (2%)    
       45 Ear and labyrinth disorders                          Hearing disorders                                    <NA>      
       46 Ear and labyrinth disorders                          Labyrinth disorders                                  1 (1%)    
       47 Ear and labyrinth disorders                          Tinnitus                                             2 (2%)    
       48 Ear and labyrinth disorders                          Vertigo and balance disorders                        1 (1%)    
       49 Endocrine disorders                                  Adrenal gland disorders                              2 (2%)    
       50 Endocrine disorders                                  Parathyroid gland disorders                          3 (3%)    
       51 Endocrine disorders                                  Pituitary gland disorders                            3 (3%)    
       52 Endocrine disorders                                  Thyroid gland disorders                              2 (2%)    
       53 Psychiatric disorders                                Anxiety disorders                                    1 (1%)    
       54 Psychiatric disorders                                Mood disorders                                       <NA>      
       55 Psychiatric disorders                                Sleep disorders                                      1 (1%)    
       56 Psychiatric disorders                                Substance-related disorders                          2 (2%)    
       57 Infections and infestations                          Bacterial infectious disorders                       2 (2%)    
       58 Infections and infestations                          Fungal infectious disorders                          1 (1%)    
       59 Infections and infestations                          Parasitic infectious disorders                       3 (3%)    
       60 Infections and infestations                          Viral infectious disorders                           3 (3%)    
       61 Vascular disorders                                   Hypertension-related conditions                      <NA>      
       62 Vascular disorders                                   Hypotension-related conditions                       2 (2%)    
       63 Vascular disorders                                   Vascular hemorrhagic disorders                       2 (2%)    
       64 Vascular disorders                                   Venous thromboembolic events                         2 (2%)    
       65 Musculoskeletal and connective tissue disorders      Arthritis and joint disorders                        <NA>      
       66 Musculoskeletal and connective tissue disorders      Bone disorders                                       <NA>      
       67 Musculoskeletal and connective tissue disorders      Connective tissue disorders                          2 (2%)    
       68 Musculoskeletal and connective tissue disorders      Muscle disorders                                     2 (2%)    
       69 Nervous system disorders                             Headache disorders                                   3 (3%)    
       70 Nervous system disorders                             Neurological disorders of the central nervous system <NA>      
       71 Nervous system disorders                             Peripheral neuropathies                              <NA>      
       72 Nervous system disorders                             Seizure disorders                                    <NA>      
       73 Investigations                                       Blood analyses                                       2 (2%)    
       74 Investigations                                       Cardiovascular assessments                           1 (1%)    
       75 Investigations                                       Imaging studies                                      <NA>      
       76 Investigations                                       Liver function analyses                              2 (2%)    
       77 Metabolism and nutrition disorders                   Fluid and electrolyte disorders                      <NA>      
       78 Metabolism and nutrition disorders                   Lipid metabolism disorders                           2 (2%)    
       79 Metabolism and nutrition disorders                   Nutritional disorders                                2 (2%)    
       80 Metabolism and nutrition disorders                   Vitamin deficiencies                                 <NA>      
       81 Blood and lymphatic system disorders                 Bone marrow disorders                                <NA>      
       82 Blood and lymphatic system disorders                 Coagulation and bleeding analyses                    <NA>      
       83 Blood and lymphatic system disorders                 Hematologic neoplasms                                <NA>      
       84 Blood and lymphatic system disorders                 Red blood cell disorders                             <NA>      
       85 Skin and subcutaneous tissue disorders               Dermatitis                                           2 (2%)    
       86 Skin and subcutaneous tissue disorders               Skin and subcutaneous tissue injuries                <NA>      
       87 Skin and subcutaneous tissue disorders               Skin infections                                      <NA>      
       88 Skin and subcutaneous tissue disorders               Skin pigmentation disorders                          <NA>      
       89 General disorders and administration site conditions General physical health deterioration                <NA>      
       90 General disorders and administration site conditions Injection site reactions                             <NA>      
       91 General disorders and administration site conditions Pain and discomfort                                  <NA>      
       92 Gastrointestinal disorders                           Esophageal disorders                                 1 (1%)    
       93 Gastrointestinal disorders                           Gastric disorders                                    1 (1%)    
       94 Gastrointestinal disorders                           Intestinal disorders                                 <NA>      
       95 Renal and urinary disorders                          Bladder disorders                                    <NA>      
       96 Renal and urinary disorders                          Kidney disorders                                     2 (2%)    
       97 Renal and urinary disorders                          Urethral disorders                                   <NA>      
       98 Renal and urinary disorders                          Urinary tract disorders                              1 (1%)    
       99 Reproductive system and breast disorders             Breast disorders                                     <NA>      
      100 Reproductive system and breast disorders             Female reproductive disorders                        <NA>      
      101 Reproductive system and breast disorders             Male reproductive disorders                          1 (1%)    
      102 Reproductive system and breast disorders             Menstrual disorders                                  <NA>      
      103 No Declared AE                                       <NA>                                                 <NA>      
          control_G2 control_G3 control_G4 control_G5 control_NA control_Tot treatment_G1 treatment_G2 treatment_G3 treatment_G4
          <glue>     <glue>     <glue>     <glue>     <glue>     <glue>      <glue>       <glue>       <glue>       <glue>      
        1 2 (2%)     2 (2%)     <NA>       <NA>       <NA>       11 (11%)    4 (4%)       1 (1%)       1 (1%)       2 (2%)      
        2 3 (3%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      2 (2%)       1 (1%)       <NA>         1 (1%)      
        3 3 (3%)     <NA>       <NA>       <NA>       <NA>       12 (12%)    5 (5%)       1 (1%)       2 (2%)       <NA>        
        4 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       4 (4%)      5 (5%)       1 (1%)       1 (1%)       1 (1%)      
        5 2 (2%)     <NA>       <NA>       <NA>       <NA>       9 (9%)      1 (1%)       1 (1%)       1 (1%)       <NA>        
        6 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       5 (5%)      2 (2%)       2 (2%)       1 (1%)       <NA>        
        7 6 (6%)     3 (3%)     2 (2%)     <NA>       <NA>       15 (15%)    2 (2%)       <NA>         1 (1%)       <NA>        
        8 2 (2%)     <NA>       <NA>       <NA>       <NA>       6 (6%)      2 (2%)       2 (2%)       2 (2%)       1 (1%)      
        9 2 (2%)     1 (1%)     <NA>       <NA>       <NA>       5 (5%)      3 (3%)       <NA>         1 (1%)       3 (3%)      
       10 2 (2%)     <NA>       <NA>       <NA>       <NA>       6 (6%)      6 (6%)       2 (2%)       <NA>         <NA>        
       11 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      4 (4%)       1 (1%)       <NA>         1 (1%)      
       12 2 (2%)     1 (1%)     1 (1%)     <NA>       <NA>       10 (10%)    2 (2%)       <NA>         1 (1%)       <NA>        
       13 2 (2%)     <NA>       <NA>       <NA>       <NA>       6 (6%)      <NA>         2 (2%)       1 (1%)       <NA>        
       14 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       9 (9%)      5 (5%)       <NA>         1 (1%)       1 (1%)      
       15 2 (2%)     <NA>       1 (1%)     <NA>       <NA>       5 (5%)      <NA>         2 (2%)       <NA>         <NA>        
       16 3 (3%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      2 (2%)       1 (1%)       <NA>         <NA>        
       17 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       1 (1%)       1 (1%)      
       18 2 (2%)     2 (2%)     1 (1%)     <NA>       <NA>       10 (10%)    2 (2%)       2 (2%)       <NA>         <NA>        
       19 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       1 (1%)       2 (2%)       <NA>        
       20 1 (1%)     2 (2%)     1 (1%)     <NA>       <NA>       5 (5%)      3 (3%)       3 (3%)       <NA>         <NA>        
       21 2 (2%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      <NA>         <NA>         <NA>         <NA>        
       22 2 (2%)     <NA>       1 (1%)     <NA>       <NA>       4 (4%)      1 (1%)       5 (5%)       1 (1%)       1 (1%)      
       23 1 (1%)     2 (2%)     1 (1%)     <NA>       <NA>       7 (7%)      3 (3%)       <NA>         <NA>         <NA>        
       24 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        4 (4%)       2 (2%)       1 (1%)       <NA>        
       25 5 (5%)     1 (1%)     1 (1%)     <NA>       <NA>       9 (9%)      2 (2%)       2 (2%)       <NA>         <NA>        
       26 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         <NA>         <NA>        
       27 <NA>       2 (2%)     <NA>       <NA>       <NA>       3 (3%)      <NA>         2 (2%)       <NA>         <NA>        
       28 2 (2%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      2 (2%)       1 (1%)       1 (1%)       1 (1%)      
       29 2 (2%)     <NA>       1 (1%)     <NA>       <NA>       5 (5%)      2 (2%)       2 (2%)       <NA>         <NA>        
       30 <NA>       <NA>       1 (1%)     <NA>       <NA>       3 (3%)      2 (2%)       1 (1%)       <NA>         <NA>        
       31 <NA>       <NA>       <NA>       <NA>       <NA>       4 (4%)      1 (1%)       2 (2%)       <NA>         <NA>        
       32 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      5 (5%)       <NA>         1 (1%)       <NA>        
       33 <NA>       1 (1%)     <NA>       <NA>       <NA>       3 (3%)      3 (3%)       1 (1%)       <NA>         <NA>        
       34 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       5 (5%)      <NA>         2 (2%)       <NA>         <NA>        
       35 3 (3%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      2 (2%)       <NA>         2 (2%)       <NA>        
       36 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      2 (2%)       2 (2%)       1 (1%)       1 (1%)      
       37 2 (2%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      3 (3%)       <NA>         1 (1%)       1 (1%)      
       38 1 (1%)     4 (4%)     <NA>       <NA>       <NA>       8 (8%)      <NA>         <NA>         1 (1%)       2 (2%)      
       39 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         <NA>         1 (1%)      
       40 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       1 (1%)       1 (1%)       <NA>        
       41 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      <NA>         1 (1%)       3 (3%)       <NA>        
       42 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         1 (1%)       <NA>        
       43 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      3 (3%)       <NA>         <NA>         1 (1%)      
       44 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       4 (4%)      <NA>         2 (2%)       1 (1%)       <NA>        
       45 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (2%)       1 (1%)       1 (1%)       <NA>        
       46 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         1 (1%)       1 (1%)       <NA>        
       47 <NA>       2 (2%)     <NA>       <NA>       <NA>       4 (4%)      <NA>         2 (2%)       <NA>         <NA>        
       48 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       <NA>         <NA>        
       49 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         <NA>         <NA>        
       50 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      <NA>         <NA>         <NA>         <NA>        
       51 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      1 (1%)       1 (1%)       <NA>         <NA>        
       52 <NA>       1 (1%)     1 (1%)     <NA>       <NA>       4 (4%)      <NA>         1 (1%)       1 (1%)       <NA>        
       53 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       1 (1%)       <NA>        
       54 <NA>       1 (1%)     <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         1 (1%)       <NA>        
       55 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      3 (3%)       <NA>         <NA>         1 (1%)      
       56 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         <NA>         <NA>        
       57 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         <NA>         <NA>         <NA>        
       58 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       59 2 (2%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      2 (2%)       <NA>         1 (1%)       <NA>        
       60 1 (1%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      <NA>         <NA>         <NA>         <NA>        
       61 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         2 (2%)       1 (1%)       <NA>        
       62 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         <NA>         <NA>        
       63 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      3 (3%)       <NA>         <NA>         1 (1%)      
       64 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      <NA>         <NA>         <NA>         1 (1%)      
       65 2 (2%)     <NA>       <NA>       1 (1%)     <NA>       3 (3%)      <NA>         <NA>         <NA>         <NA>        
       66 <NA>       1 (1%)     <NA>       1 (1%)     <NA>       2 (2%)      <NA>         1 (1%)       1 (1%)       <NA>        
       67 <NA>       1 (1%)     1 (1%)     <NA>       <NA>       4 (4%)      1 (1%)       <NA>         <NA>         <NA>        
       68 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         <NA>         1 (1%)       <NA>        
       69 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      <NA>         1 (1%)       <NA>         1 (1%)      
       70 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       1 (1%)       <NA>         <NA>        
       71 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         1 (1%)       <NA>         <NA>        
       72 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         <NA>         <NA>        
       73 <NA>       1 (1%)     <NA>       <NA>       <NA>       3 (3%)      <NA>         <NA>         <NA>         <NA>        
       74 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         1 (1%)       <NA>        
       75 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         1 (1%)       <NA>        
       76 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         <NA>         <NA>        
       77 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (2%)       <NA>         <NA>         <NA>        
       78 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         <NA>         <NA>        
       79 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         1 (1%)       <NA>         <NA>        
       80 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         <NA>         <NA>        
       81 <NA>       <NA>       1 (1%)     <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       82 <NA>       1 (1%)     <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       83 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         1 (1%)       <NA>        
       84 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      3 (3%)       2 (2%)       1 (1%)       <NA>        
       85 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      <NA>         <NA>         <NA>         <NA>        
       86 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (1%)       1 (1%)       <NA>         <NA>        
       87 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (2%)       <NA>         <NA>         <NA>        
       88 <NA>       <NA>       1 (1%)     <NA>       <NA>       1 (1%)      1 (1%)       1 (1%)       <NA>         <NA>        
       89 2 (2%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         1 (1%)       <NA>         <NA>        
       90 1 (1%)     2 (2%)     <NA>       <NA>       <NA>       3 (3%)      1 (1%)       <NA>         <NA>         <NA>        
       91 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       92 <NA>       <NA>       1 (1%)     <NA>       <NA>       2 (2%)      <NA>         <NA>         <NA>         <NA>        
       93 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       94 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         <NA>         <NA>        
       95 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         <NA>         1 (1%)      
       96 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         <NA>         <NA>         <NA>        
       97 <NA>       1 (1%)     <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       98 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       99 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         1 (1%)       <NA>        
      100 <NA>       1 (1%)     <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
      101 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         1 (1%)       <NA>         <NA>        
      102 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (1%)       <NA>         <NA>         <NA>        
      103 <NA>       <NA>       <NA>       <NA>       3 (3%)     3 (3%)      <NA>         <NA>         <NA>         <NA>        
          treatment_G5 treatment_NA treatment_Tot
          <glue>       <glue>       <glue>       
        1 <NA>         <NA>         8 (8%)       
        2 <NA>         <NA>         4 (4%)       
        3 <NA>         <NA>         8 (8%)       
        4 <NA>         <NA>         8 (8%)       
        5 <NA>         <NA>         3 (3%)       
        6 <NA>         <NA>         5 (5%)       
        7 <NA>         <NA>         3 (3%)       
        8 <NA>         <NA>         7 (7%)       
        9 <NA>         <NA>         7 (7%)       
       10 <NA>         <NA>         8 (8%)       
       11 <NA>         <NA>         6 (6%)       
       12 <NA>         <NA>         3 (3%)       
       13 <NA>         <NA>         3 (3%)       
       14 <NA>         <NA>         7 (7%)       
       15 <NA>         <NA>         2 (2%)       
       16 <NA>         <NA>         3 (3%)       
       17 <NA>         <NA>         4 (4%)       
       18 <NA>         <NA>         4 (4%)       
       19 <NA>         <NA>         5 (5%)       
       20 <NA>         <NA>         6 (6%)       
       21 <NA>         <NA>         <NA>         
       22 <NA>         <NA>         8 (8%)       
       23 <NA>         <NA>         3 (3%)       
       24 <NA>         <NA>         7 (7%)       
       25 <NA>         <NA>         4 (4%)       
       26 <NA>         <NA>         2 (2%)       
       27 <NA>         <NA>         2 (2%)       
       28 <NA>         <NA>         5 (5%)       
       29 <NA>         <NA>         4 (4%)       
       30 <NA>         <NA>         3 (3%)       
       31 <NA>         <NA>         3 (3%)       
       32 <NA>         <NA>         6 (6%)       
       33 <NA>         <NA>         4 (4%)       
       34 <NA>         <NA>         2 (2%)       
       35 <NA>         <NA>         4 (4%)       
       36 <NA>         <NA>         6 (6%)       
       37 <NA>         <NA>         5 (5%)       
       38 <NA>         <NA>         3 (3%)       
       39 <NA>         <NA>         3 (3%)       
       40 <NA>         <NA>         3 (3%)       
       41 <NA>         <NA>         4 (4%)       
       42 1 (1%)       <NA>         3 (3%)       
       43 <NA>         <NA>         4 (4%)       
       44 <NA>         <NA>         3 (3%)       
       45 <NA>         <NA>         4 (4%)       
       46 <NA>         <NA>         2 (2%)       
       47 <NA>         <NA>         2 (2%)       
       48 <NA>         <NA>         2 (2%)       
       49 <NA>         <NA>         1 (1%)       
       50 <NA>         <NA>         <NA>         
       51 <NA>         <NA>         2 (2%)       
       52 <NA>         <NA>         2 (2%)       
       53 <NA>         <NA>         3 (3%)       
       54 <NA>         <NA>         3 (3%)       
       55 <NA>         <NA>         4 (4%)       
       56 <NA>         <NA>         1 (1%)       
       57 <NA>         <NA>         <NA>         
       58 1 (1%)       <NA>         1 (1%)       
       59 <NA>         <NA>         3 (3%)       
       60 <NA>         <NA>         <NA>         
       61 <NA>         <NA>         3 (3%)       
       62 <NA>         <NA>         1 (1%)       
       63 <NA>         <NA>         4 (4%)       
       64 <NA>         <NA>         1 (1%)       
       65 <NA>         <NA>         <NA>         
       66 <NA>         <NA>         2 (2%)       
       67 <NA>         <NA>         1 (1%)       
       68 <NA>         <NA>         1 (1%)       
       69 <NA>         <NA>         2 (2%)       
       70 <NA>         <NA>         2 (2%)       
       71 <NA>         <NA>         1 (1%)       
       72 <NA>         <NA>         2 (2%)       
       73 <NA>         <NA>         <NA>         
       74 <NA>         <NA>         2 (2%)       
       75 <NA>         <NA>         1 (1%)       
       76 <NA>         <NA>         1 (1%)       
       77 <NA>         <NA>         2 (2%)       
       78 <NA>         <NA>         1 (1%)       
       79 <NA>         <NA>         1 (1%)       
       80 <NA>         <NA>         2 (2%)       
       81 <NA>         <NA>         <NA>         
       82 <NA>         <NA>         <NA>         
       83 <NA>         <NA>         1 (1%)       
       84 <NA>         <NA>         6 (6%)       
       85 <NA>         <NA>         <NA>         
       86 <NA>         <NA>         2 (2%)       
       87 <NA>         <NA>         2 (2%)       
       88 <NA>         <NA>         2 (2%)       
       89 <NA>         <NA>         1 (1%)       
       90 <NA>         <NA>         1 (1%)       
       91 <NA>         <NA>         1 (1%)       
       92 <NA>         <NA>         <NA>         
       93 <NA>         <NA>         1 (1%)       
       94 <NA>         <NA>         2 (2%)       
       95 <NA>         <NA>         1 (1%)       
       96 <NA>         <NA>         <NA>         
       97 <NA>         <NA>         1 (1%)       
       98 <NA>         <NA>         1 (1%)       
       99 <NA>         <NA>         1 (1%)       
      100 <NA>         <NA>         1 (1%)       
      101 <NA>         <NA>         1 (1%)       
      102 <NA>         <NA>         1 (1%)       
      103 <NA>         5 (5%)       5 (5%)       
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", term = "aeterm", sort_by_count = FALSE)
    Output
      # A tibble: 103 x 16
          soc                                                  term                                                 control_G1
          <fct>                                                <fct>                                                <glue>    
        1 Blood and lymphatic system disorders                 Bone marrow disorders                                <NA>      
        2 Blood and lymphatic system disorders                 Coagulation and bleeding analyses                    <NA>      
        3 Blood and lymphatic system disorders                 Hematologic neoplasms                                <NA>      
        4 Blood and lymphatic system disorders                 Red blood cell disorders                             <NA>      
        5 Cardiac disorders                                    Cardiac arrhythmias                                  2 (2%)    
        6 Cardiac disorders                                    Cardiac valve disorders                              3 (3%)    
        7 Cardiac disorders                                    Coronary artery disorders                            1 (1%)    
        8 Cardiac disorders                                    Heart failures                                       1 (1%)    
        9 Congenital, familial and genetic disorders           Chromosomal abnormalities                            2 (2%)    
       10 Congenital, familial and genetic disorders           Congenital nervous system disorders                  4 (4%)    
       11 Congenital, familial and genetic disorders           Familial hematologic disorders                       1 (1%)    
       12 Congenital, familial and genetic disorders           Hereditary connective tissue disorders               6 (6%)    
       13 Ear and labyrinth disorders                          Hearing disorders                                    <NA>      
       14 Ear and labyrinth disorders                          Labyrinth disorders                                  1 (1%)    
       15 Ear and labyrinth disorders                          Tinnitus                                             2 (2%)    
       16 Ear and labyrinth disorders                          Vertigo and balance disorders                        1 (1%)    
       17 Endocrine disorders                                  Adrenal gland disorders                              2 (2%)    
       18 Endocrine disorders                                  Parathyroid gland disorders                          3 (3%)    
       19 Endocrine disorders                                  Pituitary gland disorders                            3 (3%)    
       20 Endocrine disorders                                  Thyroid gland disorders                              2 (2%)    
       21 Eye disorders                                        Corneal disorders                                    7 (7%)    
       22 Eye disorders                                        Eyelid disorders                                     3 (3%)    
       23 Eye disorders                                        Retinal disorders                                    4 (4%)    
       24 Eye disorders                                        Vision disorders                                     4 (4%)    
       25 Gastrointestinal disorders                           Esophageal disorders                                 1 (1%)    
       26 Gastrointestinal disorders                           Gastric disorders                                    1 (1%)    
       27 Gastrointestinal disorders                           Intestinal disorders                                 <NA>      
       28 General disorders and administration site conditions General physical health deterioration                <NA>      
       29 General disorders and administration site conditions Injection site reactions                             <NA>      
       30 General disorders and administration site conditions Pain and discomfort                                  <NA>      
       31 Hepatobiliary disorders                              Bile duct disorders                                  2 (2%)    
       32 Hepatobiliary disorders                              Gallbladder disorders                                2 (2%)    
       33 Hepatobiliary disorders                              Hepatic failure                                      4 (4%)    
       34 Hepatobiliary disorders                              Liver disorders                                      1 (1%)    
       35 Immune system disorders                              Autoimmune disorders                                 2 (2%)    
       36 Immune system disorders                              Hypersensitivity conditions                          5 (5%)    
       37 Immune system disorders                              Immunodeficiency                                     <NA>      
       38 Immune system disorders                              Inflammatory responses                               1 (1%)    
       39 Infections and infestations                          Bacterial infectious disorders                       2 (2%)    
       40 Infections and infestations                          Fungal infectious disorders                          1 (1%)    
       41 Infections and infestations                          Parasitic infectious disorders                       3 (3%)    
       42 Infections and infestations                          Viral infectious disorders                           3 (3%)    
       43 Injury, poisoning and procedural complications       Poisonings                                           4 (4%)    
       44 Injury, poisoning and procedural complications       Procedural complications                             7 (7%)    
       45 Injury, poisoning and procedural complications       Radiation-related toxicities                         2 (2%)    
       46 Injury, poisoning and procedural complications       Traumatic injuries                                   1 (1%)    
       47 Investigations                                       Blood analyses                                       2 (2%)    
       48 Investigations                                       Cardiovascular assessments                           1 (1%)    
       49 Investigations                                       Imaging studies                                      <NA>      
       50 Investigations                                       Liver function analyses                              2 (2%)    
       51 Metabolism and nutrition disorders                   Fluid and electrolyte disorders                      <NA>      
       52 Metabolism and nutrition disorders                   Lipid metabolism disorders                           2 (2%)    
       53 Metabolism and nutrition disorders                   Nutritional disorders                                2 (2%)    
       54 Metabolism and nutrition disorders                   Vitamin deficiencies                                 <NA>      
       55 Musculoskeletal and connective tissue disorders      Arthritis and joint disorders                        <NA>      
       56 Musculoskeletal and connective tissue disorders      Bone disorders                                       <NA>      
       57 Musculoskeletal and connective tissue disorders      Connective tissue disorders                          2 (2%)    
       58 Musculoskeletal and connective tissue disorders      Muscle disorders                                     2 (2%)    
       59 Neoplasms benign, malignant, and unspecified         Benign neoplasms                                     2 (2%)    
       60 Neoplasms benign, malignant, and unspecified         Malignant neoplasms                                  <NA>      
       61 Neoplasms benign, malignant, and unspecified         Neoplasms unspecified                                1 (1%)    
       62 Neoplasms benign, malignant, and unspecified         Tumor progression                                    3 (3%)    
       63 Nervous system disorders                             Headache disorders                                   3 (3%)    
       64 Nervous system disorders                             Neurological disorders of the central nervous system <NA>      
       65 Nervous system disorders                             Peripheral neuropathies                              <NA>      
       66 Nervous system disorders                             Seizure disorders                                    <NA>      
       67 Pregnancy, puerperium and perinatal conditions       Breastfeeding issues                                 3 (3%)    
       68 Pregnancy, puerperium and perinatal conditions       Fetal complications                                  1 (1%)    
       69 Pregnancy, puerperium and perinatal conditions       Labor and delivery complications                     3 (3%)    
       70 Pregnancy, puerperium and perinatal conditions       Pregnancy complications                              <NA>      
       71 Psychiatric disorders                                Anxiety disorders                                    1 (1%)    
       72 Psychiatric disorders                                Mood disorders                                       <NA>      
       73 Psychiatric disorders                                Sleep disorders                                      1 (1%)    
       74 Psychiatric disorders                                Substance-related disorders                          2 (2%)    
       75 Renal and urinary disorders                          Bladder disorders                                    <NA>      
       76 Renal and urinary disorders                          Kidney disorders                                     2 (2%)    
       77 Renal and urinary disorders                          Urethral disorders                                   <NA>      
       78 Renal and urinary disorders                          Urinary tract disorders                              1 (1%)    
       79 Reproductive system and breast disorders             Breast disorders                                     <NA>      
       80 Reproductive system and breast disorders             Female reproductive disorders                        <NA>      
       81 Reproductive system and breast disorders             Male reproductive disorders                          1 (1%)    
       82 Reproductive system and breast disorders             Menstrual disorders                                  <NA>      
       83 Respiratory, thoracic and mediastinal disorders      Lung function disorders                              2 (2%)    
       84 Respiratory, thoracic and mediastinal disorders      Pleural disorders                                    2 (2%)    
       85 Respiratory, thoracic and mediastinal disorders      Pulmonary vascular disorders                         2 (2%)    
       86 Respiratory, thoracic and mediastinal disorders      Respiratory infections                               2 (2%)    
       87 Skin and subcutaneous tissue disorders               Dermatitis                                           2 (2%)    
       88 Skin and subcutaneous tissue disorders               Skin and subcutaneous tissue injuries                <NA>      
       89 Skin and subcutaneous tissue disorders               Skin infections                                      <NA>      
       90 Skin and subcutaneous tissue disorders               Skin pigmentation disorders                          <NA>      
       91 Social circumstances                                 Cultural issues                                      7 (7%)    
       92 Social circumstances                                 Economic conditions affecting care                   <NA>      
       93 Social circumstances                                 Family support issues                                9 (9%)    
       94 Social circumstances                                 Social and environmental issues                      2 (2%)    
       95 Surgical and medical procedures                      Device implantation procedures                       2 (2%)    
       96 Surgical and medical procedures                      Diagnostic procedures                                3 (3%)    
       97 Surgical and medical procedures                      Surgical complications                               1 (1%)    
       98 Surgical and medical procedures                      Therapeutic procedures                               1 (1%)    
       99 Vascular disorders                                   Hypertension-related conditions                      <NA>      
      100 Vascular disorders                                   Hypotension-related conditions                       2 (2%)    
      101 Vascular disorders                                   Vascular hemorrhagic disorders                       2 (2%)    
      102 Vascular disorders                                   Venous thromboembolic events                         2 (2%)    
      103 No Declared AE                                       <NA>                                                 <NA>      
          control_G2 control_G3 control_G4 control_G5 control_NA control_Tot treatment_G1 treatment_G2 treatment_G3 treatment_G4
          <glue>     <glue>     <glue>     <glue>     <glue>     <glue>      <glue>       <glue>       <glue>       <glue>      
        1 <NA>       <NA>       1 (1%)     <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
        2 <NA>       1 (1%)     <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
        3 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         1 (1%)       <NA>        
        4 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      3 (3%)       2 (2%)       1 (1%)       <NA>        
        5 2 (2%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      3 (3%)       <NA>         1 (1%)       1 (1%)      
        6 1 (1%)     4 (4%)     <NA>       <NA>       <NA>       8 (8%)      <NA>         <NA>         1 (1%)       2 (2%)      
        7 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         <NA>         1 (1%)      
        8 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       1 (1%)       1 (1%)       <NA>        
        9 2 (2%)     1 (1%)     <NA>       <NA>       <NA>       5 (5%)      3 (3%)       <NA>         1 (1%)       3 (3%)      
       10 2 (2%)     <NA>       <NA>       <NA>       <NA>       6 (6%)      6 (6%)       2 (2%)       <NA>         <NA>        
       11 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      4 (4%)       1 (1%)       <NA>         1 (1%)      
       12 2 (2%)     1 (1%)     1 (1%)     <NA>       <NA>       10 (10%)    2 (2%)       <NA>         1 (1%)       <NA>        
       13 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (2%)       1 (1%)       1 (1%)       <NA>        
       14 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         1 (1%)       1 (1%)       <NA>        
       15 <NA>       2 (2%)     <NA>       <NA>       <NA>       4 (4%)      <NA>         2 (2%)       <NA>         <NA>        
       16 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       <NA>         <NA>        
       17 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         <NA>         <NA>        
       18 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      <NA>         <NA>         <NA>         <NA>        
       19 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      1 (1%)       1 (1%)       <NA>         <NA>        
       20 <NA>       1 (1%)     1 (1%)     <NA>       <NA>       4 (4%)      <NA>         1 (1%)       1 (1%)       <NA>        
       21 2 (2%)     <NA>       <NA>       <NA>       <NA>       9 (9%)      1 (1%)       1 (1%)       1 (1%)       <NA>        
       22 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       5 (5%)      2 (2%)       2 (2%)       1 (1%)       <NA>        
       23 6 (6%)     3 (3%)     2 (2%)     <NA>       <NA>       15 (15%)    2 (2%)       <NA>         1 (1%)       <NA>        
       24 2 (2%)     <NA>       <NA>       <NA>       <NA>       6 (6%)      2 (2%)       2 (2%)       2 (2%)       1 (1%)      
       25 <NA>       <NA>       1 (1%)     <NA>       <NA>       2 (2%)      <NA>         <NA>         <NA>         <NA>        
       26 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       27 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         <NA>         <NA>        
       28 2 (2%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         1 (1%)       <NA>         <NA>        
       29 1 (1%)     2 (2%)     <NA>       <NA>       <NA>       3 (3%)      1 (1%)       <NA>         <NA>         <NA>        
       30 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       31 2 (2%)     <NA>       1 (1%)     <NA>       <NA>       5 (5%)      2 (2%)       2 (2%)       <NA>         <NA>        
       32 <NA>       <NA>       1 (1%)     <NA>       <NA>       3 (3%)      2 (2%)       1 (1%)       <NA>         <NA>        
       33 <NA>       <NA>       <NA>       <NA>       <NA>       4 (4%)      1 (1%)       2 (2%)       <NA>         <NA>        
       34 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      5 (5%)       <NA>         1 (1%)       <NA>        
       35 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       1 (1%)       1 (1%)      
       36 2 (2%)     2 (2%)     1 (1%)     <NA>       <NA>       10 (10%)    2 (2%)       2 (2%)       <NA>         <NA>        
       37 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       1 (1%)       2 (2%)       <NA>        
       38 1 (1%)     2 (2%)     1 (1%)     <NA>       <NA>       5 (5%)      3 (3%)       3 (3%)       <NA>         <NA>        
       39 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         <NA>         <NA>         <NA>        
       40 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         <NA>         <NA>        
       41 2 (2%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      2 (2%)       <NA>         1 (1%)       <NA>        
       42 1 (1%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      <NA>         <NA>         <NA>         <NA>        
       43 2 (2%)     <NA>       <NA>       <NA>       <NA>       6 (6%)      <NA>         2 (2%)       1 (1%)       <NA>        
       44 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       9 (9%)      5 (5%)       <NA>         1 (1%)       1 (1%)      
       45 2 (2%)     <NA>       1 (1%)     <NA>       <NA>       5 (5%)      <NA>         2 (2%)       <NA>         <NA>        
       46 3 (3%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      2 (2%)       1 (1%)       <NA>         <NA>        
       47 <NA>       1 (1%)     <NA>       <NA>       <NA>       3 (3%)      <NA>         <NA>         <NA>         <NA>        
       48 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         1 (1%)       <NA>        
       49 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         <NA>         1 (1%)       <NA>        
       50 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         <NA>         <NA>        
       51 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (2%)       <NA>         <NA>         <NA>        
       52 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         <NA>         <NA>        
       53 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         1 (1%)       <NA>         <NA>        
       54 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         <NA>         <NA>        
       55 2 (2%)     <NA>       <NA>       1 (1%)     <NA>       3 (3%)      <NA>         <NA>         <NA>         <NA>        
       56 <NA>       1 (1%)     <NA>       1 (1%)     <NA>       2 (2%)      <NA>         1 (1%)       1 (1%)       <NA>        
       57 <NA>       1 (1%)     1 (1%)     <NA>       <NA>       4 (4%)      1 (1%)       <NA>         <NA>         <NA>        
       58 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         <NA>         1 (1%)       <NA>        
       59 5 (5%)     1 (1%)     1 (1%)     <NA>       <NA>       9 (9%)      2 (2%)       2 (2%)       <NA>         <NA>        
       60 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         <NA>         <NA>        
       61 <NA>       2 (2%)     <NA>       <NA>       <NA>       3 (3%)      <NA>         2 (2%)       <NA>         <NA>        
       62 2 (2%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      2 (2%)       1 (1%)       1 (1%)       1 (1%)      
       63 <NA>       <NA>       <NA>       <NA>       <NA>       3 (3%)      <NA>         1 (1%)       <NA>         1 (1%)      
       64 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       1 (1%)       <NA>         <NA>        
       65 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      <NA>         1 (1%)       <NA>         <NA>        
       66 1 (1%)     <NA>       <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         <NA>         <NA>        
       67 2 (2%)     <NA>       <NA>       <NA>       <NA>       5 (5%)      <NA>         <NA>         <NA>         <NA>        
       68 2 (2%)     <NA>       1 (1%)     <NA>       <NA>       4 (4%)      1 (1%)       5 (5%)       1 (1%)       1 (1%)      
       69 1 (1%)     2 (2%)     1 (1%)     <NA>       <NA>       7 (7%)      3 (3%)       <NA>         <NA>         <NA>        
       70 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        4 (4%)       2 (2%)       1 (1%)       <NA>        
       71 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       1 (1%)       1 (1%)       <NA>        
       72 <NA>       1 (1%)     <NA>       <NA>       <NA>       1 (1%)      2 (2%)       <NA>         1 (1%)       <NA>        
       73 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      3 (3%)       <NA>         <NA>         1 (1%)      
       74 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         <NA>         <NA>        
       75 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         <NA>         1 (1%)      
       76 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         <NA>         <NA>         <NA>        
       77 <NA>       1 (1%)     <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       78 <NA>       <NA>       <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       79 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         1 (1%)       <NA>        
       80 <NA>       1 (1%)     <NA>       <NA>       <NA>       1 (1%)      1 (1%)       <NA>         <NA>         <NA>        
       81 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      <NA>         1 (1%)       <NA>         <NA>        
       82 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (1%)       <NA>         <NA>         <NA>        
       83 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      <NA>         1 (1%)       3 (3%)       <NA>        
       84 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         1 (1%)       <NA>        
       85 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      3 (3%)       <NA>         <NA>         1 (1%)      
       86 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       4 (4%)      <NA>         2 (2%)       1 (1%)       <NA>        
       87 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      <NA>         <NA>         <NA>         <NA>        
       88 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (1%)       1 (1%)       <NA>         <NA>        
       89 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (2%)       <NA>         <NA>         <NA>        
       90 <NA>       <NA>       1 (1%)     <NA>       <NA>       1 (1%)      1 (1%)       1 (1%)       <NA>         <NA>        
       91 2 (2%)     2 (2%)     <NA>       <NA>       <NA>       11 (11%)    4 (4%)       1 (1%)       1 (1%)       2 (2%)      
       92 3 (3%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      2 (2%)       1 (1%)       <NA>         1 (1%)      
       93 3 (3%)     <NA>       <NA>       <NA>       <NA>       12 (12%)    5 (5%)       1 (1%)       2 (2%)       <NA>        
       94 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       4 (4%)      5 (5%)       1 (1%)       1 (1%)       1 (1%)      
       95 <NA>       1 (1%)     <NA>       <NA>       <NA>       3 (3%)      3 (3%)       1 (1%)       <NA>         <NA>        
       96 1 (1%)     1 (1%)     <NA>       <NA>       <NA>       5 (5%)      <NA>         2 (2%)       <NA>         <NA>        
       97 3 (3%)     <NA>       <NA>       <NA>       <NA>       4 (4%)      2 (2%)       <NA>         2 (2%)       <NA>        
       98 1 (1%)     <NA>       <NA>       <NA>       <NA>       2 (2%)      2 (2%)       2 (2%)       1 (1%)       1 (1%)      
       99 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         2 (2%)       1 (1%)       <NA>        
      100 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      1 (1%)       <NA>         <NA>         <NA>        
      101 <NA>       <NA>       <NA>       <NA>       <NA>       2 (2%)      3 (3%)       <NA>         <NA>         1 (1%)      
      102 1 (1%)     <NA>       <NA>       <NA>       <NA>       3 (3%)      <NA>         <NA>         <NA>         1 (1%)      
      103 <NA>       <NA>       <NA>       <NA>       3 (3%)     3 (3%)      <NA>         <NA>         <NA>         <NA>        
          treatment_G5 treatment_NA treatment_Tot
          <glue>       <glue>       <glue>       
        1 <NA>         <NA>         <NA>         
        2 <NA>         <NA>         <NA>         
        3 <NA>         <NA>         1 (1%)       
        4 <NA>         <NA>         6 (6%)       
        5 <NA>         <NA>         5 (5%)       
        6 <NA>         <NA>         3 (3%)       
        7 <NA>         <NA>         3 (3%)       
        8 <NA>         <NA>         3 (3%)       
        9 <NA>         <NA>         7 (7%)       
       10 <NA>         <NA>         8 (8%)       
       11 <NA>         <NA>         6 (6%)       
       12 <NA>         <NA>         3 (3%)       
       13 <NA>         <NA>         4 (4%)       
       14 <NA>         <NA>         2 (2%)       
       15 <NA>         <NA>         2 (2%)       
       16 <NA>         <NA>         2 (2%)       
       17 <NA>         <NA>         1 (1%)       
       18 <NA>         <NA>         <NA>         
       19 <NA>         <NA>         2 (2%)       
       20 <NA>         <NA>         2 (2%)       
       21 <NA>         <NA>         3 (3%)       
       22 <NA>         <NA>         5 (5%)       
       23 <NA>         <NA>         3 (3%)       
       24 <NA>         <NA>         7 (7%)       
       25 <NA>         <NA>         <NA>         
       26 <NA>         <NA>         1 (1%)       
       27 <NA>         <NA>         2 (2%)       
       28 <NA>         <NA>         1 (1%)       
       29 <NA>         <NA>         1 (1%)       
       30 <NA>         <NA>         1 (1%)       
       31 <NA>         <NA>         4 (4%)       
       32 <NA>         <NA>         3 (3%)       
       33 <NA>         <NA>         3 (3%)       
       34 <NA>         <NA>         6 (6%)       
       35 <NA>         <NA>         4 (4%)       
       36 <NA>         <NA>         4 (4%)       
       37 <NA>         <NA>         5 (5%)       
       38 <NA>         <NA>         6 (6%)       
       39 <NA>         <NA>         <NA>         
       40 1 (1%)       <NA>         1 (1%)       
       41 <NA>         <NA>         3 (3%)       
       42 <NA>         <NA>         <NA>         
       43 <NA>         <NA>         3 (3%)       
       44 <NA>         <NA>         7 (7%)       
       45 <NA>         <NA>         2 (2%)       
       46 <NA>         <NA>         3 (3%)       
       47 <NA>         <NA>         <NA>         
       48 <NA>         <NA>         2 (2%)       
       49 <NA>         <NA>         1 (1%)       
       50 <NA>         <NA>         1 (1%)       
       51 <NA>         <NA>         2 (2%)       
       52 <NA>         <NA>         1 (1%)       
       53 <NA>         <NA>         1 (1%)       
       54 <NA>         <NA>         2 (2%)       
       55 <NA>         <NA>         <NA>         
       56 <NA>         <NA>         2 (2%)       
       57 <NA>         <NA>         1 (1%)       
       58 <NA>         <NA>         1 (1%)       
       59 <NA>         <NA>         4 (4%)       
       60 <NA>         <NA>         2 (2%)       
       61 <NA>         <NA>         2 (2%)       
       62 <NA>         <NA>         5 (5%)       
       63 <NA>         <NA>         2 (2%)       
       64 <NA>         <NA>         2 (2%)       
       65 <NA>         <NA>         1 (1%)       
       66 <NA>         <NA>         2 (2%)       
       67 <NA>         <NA>         <NA>         
       68 <NA>         <NA>         8 (8%)       
       69 <NA>         <NA>         3 (3%)       
       70 <NA>         <NA>         7 (7%)       
       71 <NA>         <NA>         3 (3%)       
       72 <NA>         <NA>         3 (3%)       
       73 <NA>         <NA>         4 (4%)       
       74 <NA>         <NA>         1 (1%)       
       75 <NA>         <NA>         1 (1%)       
       76 <NA>         <NA>         <NA>         
       77 <NA>         <NA>         1 (1%)       
       78 <NA>         <NA>         1 (1%)       
       79 <NA>         <NA>         1 (1%)       
       80 <NA>         <NA>         1 (1%)       
       81 <NA>         <NA>         1 (1%)       
       82 <NA>         <NA>         1 (1%)       
       83 <NA>         <NA>         4 (4%)       
       84 1 (1%)       <NA>         3 (3%)       
       85 <NA>         <NA>         4 (4%)       
       86 <NA>         <NA>         3 (3%)       
       87 <NA>         <NA>         <NA>         
       88 <NA>         <NA>         2 (2%)       
       89 <NA>         <NA>         2 (2%)       
       90 <NA>         <NA>         2 (2%)       
       91 <NA>         <NA>         8 (8%)       
       92 <NA>         <NA>         4 (4%)       
       93 <NA>         <NA>         8 (8%)       
       94 <NA>         <NA>         8 (8%)       
       95 <NA>         <NA>         4 (4%)       
       96 <NA>         <NA>         2 (2%)       
       97 <NA>         <NA>         4 (4%)       
       98 <NA>         <NA>         6 (6%)       
       99 <NA>         <NA>         3 (3%)       
      100 <NA>         <NA>         1 (1%)       
      101 <NA>         <NA>         4 (4%)       
      102 <NA>         <NA>         1 (1%)       
      103 <NA>         5 (5%)       5 (5%)       
    Code
      ctl = tm$enrolres %>% filter(arm == "Control") %>% pull(subjid)
      x = tm$ae %>% filter(aesoc == "Cardiac disorders" | !subjid %in% ctl) %>% ae_table_soc(df_enrol = tm$enrolres, arm = "ARM")

