# ae_table_grade() works

    Code
      tm = grstat_example()
      attach(tm)
      ae_table_grade(ae, df_enrol = enrolres)
    Output
      # A tibble: 18 x 4
         .id           label                                   variable       `All patients`
         <fct>         <fct>                                   <fct>          <chr>         
       1 max_grade     "Patient maximum AE grade"              No declared AE 1 (2%)        
       2 max_grade     "Patient maximum AE grade"              Grade 1        4 (8%)        
       3 max_grade     "Patient maximum AE grade"              Grade 2        11 (22%)      
       4 max_grade     "Patient maximum AE grade"              Grade 3        15 (30%)      
       5 max_grade     "Patient maximum AE grade"              Grade 4        17 (34%)      
       6 max_grade     "Patient maximum AE grade"              Grade 5        2 (4%)        
       7 any_grade_sup "Patient had at least one AE of grade"  No declared AE 1 (2%)        
       8 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1      49 (98%)      
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2      45 (90%)      
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3      34 (68%)      
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4      19 (38%)      
      12 any_grade_sup "Patient had at least one AE of grade"  Grade = 5      2 (4%)        
      13 any_grade_eq  "Patient had at least one AE of grade " No declared AE 1 (2%)        
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1        35 (70%)      
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2        29 (58%)      
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3        22 (44%)      
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4        17 (34%)      
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5        2 (4%)        
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM")
    Output
      # A tibble: 18 x 6
         .id           label                                   variable       Control   Treatment Total   
         <fct>         <fct>                                   <fct>          <chr>     <chr>     <chr>   
       1 max_grade     "Patient maximum AE grade"              No declared AE 0 (0%)    1 (4%)    1 (2%)  
       2 max_grade     "Patient maximum AE grade"              Grade 1        2 (8%)    2 (8%)    4 (8%)  
       3 max_grade     "Patient maximum AE grade"              Grade 2        4 (16%)   7 (28%)   11 (22%)
       4 max_grade     "Patient maximum AE grade"              Grade 3        8 (32%)   7 (28%)   15 (30%)
       5 max_grade     "Patient maximum AE grade"              Grade 4        9 (36%)   8 (32%)   17 (34%)
       6 max_grade     "Patient maximum AE grade"              Grade 5        2 (8%)    0 (0%)    2 (4%)  
       7 any_grade_sup "Patient had at least one AE of grade"  No declared AE 0 (0%)    1 (4%)    1 (2%)  
       8 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1      25 (100%) 24 (96%)  49 (98%)
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2      23 (92%)  22 (88%)  45 (90%)
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3      19 (76%)  15 (60%)  34 (68%)
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4      11 (44%)  8 (32%)   19 (38%)
      12 any_grade_sup "Patient had at least one AE of grade"  Grade = 5      2 (8%)    0 (0%)    2 (4%)  
      13 any_grade_eq  "Patient had at least one AE of grade " No declared AE 0 (0%)    1 (4%)    1 (2%)  
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1        18 (72%)  17 (68%)  35 (70%)
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2        16 (64%)  13 (52%)  29 (58%)
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3        13 (52%)  9 (36%)   22 (44%)
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4        9 (36%)   8 (32%)   17 (34%)
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5        2 (8%)    0 (0%)    2 (4%)  
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM", variant = c("eq", "max"))
    Output
      # A tibble: 12 x 6
         .id          label                                   variable       Control  Treatment Total   
         <fct>        <fct>                                   <fct>          <chr>    <chr>     <chr>   
       1 any_grade_eq "Patient had at least one AE of grade " No declared AE 0 (0%)   1 (4%)    1 (2%)  
       2 any_grade_eq "Patient had at least one AE of grade " Grade 1        18 (72%) 17 (68%)  35 (70%)
       3 any_grade_eq "Patient had at least one AE of grade " Grade 2        16 (64%) 13 (52%)  29 (58%)
       4 any_grade_eq "Patient had at least one AE of grade " Grade 3        13 (52%) 9 (36%)   22 (44%)
       5 any_grade_eq "Patient had at least one AE of grade " Grade 4        9 (36%)  8 (32%)   17 (34%)
       6 any_grade_eq "Patient had at least one AE of grade " Grade 5        2 (8%)   0 (0%)    2 (4%)  
       7 max_grade    "Patient maximum AE grade"              No declared AE 0 (0%)   1 (4%)    1 (2%)  
       8 max_grade    "Patient maximum AE grade"              Grade 1        2 (8%)   2 (8%)    4 (8%)  
       9 max_grade    "Patient maximum AE grade"              Grade 2        4 (16%)  7 (28%)   11 (22%)
      10 max_grade    "Patient maximum AE grade"              Grade 3        8 (32%)  7 (28%)   15 (30%)
      11 max_grade    "Patient maximum AE grade"              Grade 4        9 (36%)  8 (32%)   17 (34%)
      12 max_grade    "Patient maximum AE grade"              Grade 5        2 (8%)   0 (0%)    2 (4%)  
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM", percent = FALSE, total = FALSE)
    Output
      # A tibble: 18 x 5
         .id           label                                   variable       Control Treatment
         <fct>         <fct>                                   <fct>          <chr>   <chr>    
       1 max_grade     "Patient maximum AE grade"              No declared AE 0       1        
       2 max_grade     "Patient maximum AE grade"              Grade 1        2       2        
       3 max_grade     "Patient maximum AE grade"              Grade 2        4       7        
       4 max_grade     "Patient maximum AE grade"              Grade 3        8       7        
       5 max_grade     "Patient maximum AE grade"              Grade 4        9       8        
       6 max_grade     "Patient maximum AE grade"              Grade 5        2       0        
       7 any_grade_sup "Patient had at least one AE of grade"  No declared AE 0       1        
       8 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1      25      24       
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2      23      22       
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3      19      15       
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4      11      8        
      12 any_grade_sup "Patient had at least one AE of grade"  Grade = 5      2       0        
      13 any_grade_eq  "Patient had at least one AE of grade " No declared AE 0       1        
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1        18      17       
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2        16      13       
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3        13      9        
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4        9       8        
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5        2       0        

# ae_table_soc() works

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
       1 Investigations                                       3 (6%)          4 (8%)          2 (4%)          2 (4%)         
       2 Immune system disorders                              3 (6%)          2 (4%)          3 (6%)          2 (4%)         
       3 General disorders and administration site conditions 4 (8%)          1 (2%)          <NA>            2 (4%)         
       4 Infections and infestations                          2 (4%)          4 (8%)          2 (4%)          <NA>           
       5 Congenital, familial and genetic disorders           3 (6%)          3 (6%)          1 (2%)          <NA>           
       6 Pregnancy, puerperium and perinatal conditions       3 (6%)          <NA>            3 (6%)          1 (2%)         
       7 Psychiatric disorders                                2 (4%)          5 (10%)         <NA>            <NA>           
       8 Social circumstances                                 4 (8%)          1 (2%)          2 (4%)          <NA>           
       9 Cardiac disorders                                    3 (6%)          2 (4%)          <NA>            1 (2%)         
      10 Endocrine disorders                                  1 (2%)          3 (6%)          2 (4%)          <NA>           
      11 Gastrointestinal disorders                           1 (2%)          1 (2%)          1 (2%)          3 (6%)         
      12 Reproductive system and breast disorders             5 (10%)         <NA>            1 (2%)          <NA>           
      13 Blood and lymphatic system disorders                 2 (4%)          2 (4%)          <NA>            1 (2%)         
      14 Metabolism and nutrition disorders                   2 (4%)          1 (2%)          1 (2%)          1 (2%)         
      15 Neoplasms benign, malignant, and unspecified         3 (6%)          <NA>            <NA>            2 (4%)         
      16 Respiratory, thoracic and mediastinal disorders      1 (2%)          2 (4%)          1 (2%)          1 (2%)         
      17 Surgical and medical procedures                      2 (4%)          3 (6%)          <NA>            <NA>           
      18 Musculoskeletal and connective tissue disorders      <NA>            2 (4%)          2 (4%)          <NA>           
      19 Eye disorders                                        <NA>            2 (4%)          <NA>            1 (2%)         
      20 Hepatobiliary disorders                              2 (4%)          1 (2%)          <NA>            <NA>           
      21 Injury, poisoning and procedural complications       1 (2%)          2 (4%)          <NA>            <NA>           
      22 Nervous system disorders                             1 (2%)          <NA>            1 (2%)          1 (2%)         
      23 Renal and urinary disorders                          2 (4%)          <NA>            1 (2%)          <NA>           
      24 Skin and subcutaneous tissue disorders               2 (4%)          <NA>            1 (2%)          <NA>           
      25 Vascular disorders                                   <NA>            1 (2%)          <NA>            1 (2%)         
      26 Ear and labyrinth disorders                          <NA>            <NA>            <NA>            1 (2%)         
      27 No Declared AE                                       <NA>            <NA>            <NA>            <NA>           
         all_patients_G5 all_patients_NA all_patients_Tot
         <glue>          <glue>          <glue>          
       1 1 (2%)          <NA>            12 (24%)        
       2 <NA>            <NA>            10 (20%)        
       3 1 (2%)          <NA>            8 (16%)         
       4 <NA>            <NA>            8 (16%)         
       5 <NA>            <NA>            7 (14%)         
       6 <NA>            <NA>            7 (14%)         
       7 <NA>            <NA>            7 (14%)         
       8 <NA>            <NA>            7 (14%)         
       9 <NA>            <NA>            6 (12%)         
      10 <NA>            <NA>            6 (12%)         
      11 <NA>            <NA>            6 (12%)         
      12 <NA>            <NA>            6 (12%)         
      13 <NA>            <NA>            5 (10%)         
      14 <NA>            <NA>            5 (10%)         
      15 <NA>            <NA>            5 (10%)         
      16 <NA>            <NA>            5 (10%)         
      17 <NA>            <NA>            5 (10%)         
      18 <NA>            <NA>            4 (8%)          
      19 <NA>            <NA>            3 (6%)          
      20 <NA>            <NA>            3 (6%)          
      21 <NA>            <NA>            3 (6%)          
      22 <NA>            <NA>            3 (6%)          
      23 <NA>            <NA>            3 (6%)          
      24 <NA>            <NA>            3 (6%)          
      25 <NA>            <NA>            2 (4%)          
      26 <NA>            <NA>            1 (2%)          
      27 <NA>            1 (2%)          1 (2%)          
    Code
      ae_table_soc(ae, df_enrol = enrolres, sort_by_count = FALSE)
    Output
      # A tibble: 27 x 8
         soc                                                  all_patients_G1 all_patients_G2 all_patients_G3 all_patients_G4
         <chr>                                                <glue>          <glue>          <glue>          <glue>         
       1 Blood and lymphatic system disorders                 2 (4%)          2 (4%)          <NA>            1 (2%)         
       2 Cardiac disorders                                    3 (6%)          2 (4%)          <NA>            1 (2%)         
       3 Congenital, familial and genetic disorders           3 (6%)          3 (6%)          1 (2%)          <NA>           
       4 Ear and labyrinth disorders                          <NA>            <NA>            <NA>            1 (2%)         
       5 Endocrine disorders                                  1 (2%)          3 (6%)          2 (4%)          <NA>           
       6 Eye disorders                                        <NA>            2 (4%)          <NA>            1 (2%)         
       7 Gastrointestinal disorders                           1 (2%)          1 (2%)          1 (2%)          3 (6%)         
       8 General disorders and administration site conditions 4 (8%)          1 (2%)          <NA>            2 (4%)         
       9 Hepatobiliary disorders                              2 (4%)          1 (2%)          <NA>            <NA>           
      10 Immune system disorders                              3 (6%)          2 (4%)          3 (6%)          2 (4%)         
      11 Infections and infestations                          2 (4%)          4 (8%)          2 (4%)          <NA>           
      12 Injury, poisoning and procedural complications       1 (2%)          2 (4%)          <NA>            <NA>           
      13 Investigations                                       3 (6%)          4 (8%)          2 (4%)          2 (4%)         
      14 Metabolism and nutrition disorders                   2 (4%)          1 (2%)          1 (2%)          1 (2%)         
      15 Musculoskeletal and connective tissue disorders      <NA>            2 (4%)          2 (4%)          <NA>           
      16 Neoplasms benign, malignant, and unspecified         3 (6%)          <NA>            <NA>            2 (4%)         
      17 Nervous system disorders                             1 (2%)          <NA>            1 (2%)          1 (2%)         
      18 No Declared AE                                       <NA>            <NA>            <NA>            <NA>           
      19 Pregnancy, puerperium and perinatal conditions       3 (6%)          <NA>            3 (6%)          1 (2%)         
      20 Psychiatric disorders                                2 (4%)          5 (10%)         <NA>            <NA>           
      21 Renal and urinary disorders                          2 (4%)          <NA>            1 (2%)          <NA>           
      22 Reproductive system and breast disorders             5 (10%)         <NA>            1 (2%)          <NA>           
      23 Respiratory, thoracic and mediastinal disorders      1 (2%)          2 (4%)          1 (2%)          1 (2%)         
      24 Skin and subcutaneous tissue disorders               2 (4%)          <NA>            1 (2%)          <NA>           
      25 Social circumstances                                 4 (8%)          1 (2%)          2 (4%)          <NA>           
      26 Surgical and medical procedures                      2 (4%)          3 (6%)          <NA>            <NA>           
      27 Vascular disorders                                   <NA>            1 (2%)          <NA>            1 (2%)         
         all_patients_G5 all_patients_NA all_patients_Tot
         <glue>          <glue>          <glue>          
       1 <NA>            <NA>            5 (10%)         
       2 <NA>            <NA>            6 (12%)         
       3 <NA>            <NA>            7 (14%)         
       4 <NA>            <NA>            1 (2%)          
       5 <NA>            <NA>            6 (12%)         
       6 <NA>            <NA>            3 (6%)          
       7 <NA>            <NA>            6 (12%)         
       8 1 (2%)          <NA>            8 (16%)         
       9 <NA>            <NA>            3 (6%)          
      10 <NA>            <NA>            10 (20%)        
      11 <NA>            <NA>            8 (16%)         
      12 <NA>            <NA>            3 (6%)          
      13 1 (2%)          <NA>            12 (24%)        
      14 <NA>            <NA>            5 (10%)         
      15 <NA>            <NA>            4 (8%)          
      16 <NA>            <NA>            5 (10%)         
      17 <NA>            <NA>            3 (6%)          
      18 <NA>            1 (2%)          1 (2%)          
      19 <NA>            <NA>            7 (14%)         
      20 <NA>            <NA>            7 (14%)         
      21 <NA>            <NA>            3 (6%)          
      22 <NA>            <NA>            6 (12%)         
      23 <NA>            <NA>            5 (10%)         
      24 <NA>            <NA>            3 (6%)          
      25 <NA>            <NA>            7 (14%)         
      26 <NA>            <NA>            5 (10%)         
      27 <NA>            <NA>            2 (4%)          
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", digits = 1)
    Output
      # A tibble: 27 x 15
         soc                                                  control_G1 control_G2 control_G3 control_G4 control_G5 control_NA
         <fct>                                                <glue>     <glue>     <glue>     <glue>     <glue>     <glue>    
       1 Investigations                                       2 (8%)     3 (12%)    1 (4%)     2 (8%)     1 (4%)     <NA>      
       2 Immune system disorders                              2 (8%)     <NA>       2 (8%)     <NA>       <NA>       <NA>      
       3 General disorders and administration site conditions 2 (8%)     <NA>       <NA>       <NA>       1 (4%)     <NA>      
       4 Infections and infestations                          2 (8%)     2 (8%)     2 (8%)     <NA>       <NA>       <NA>      
       5 Congenital, familial and genetic disorders           2 (8%)     2 (8%)     1 (4%)     <NA>       <NA>       <NA>      
       6 Pregnancy, puerperium and perinatal conditions       1 (4%)     <NA>       3 (12%)    1 (4%)     <NA>       <NA>      
       7 Psychiatric disorders                                1 (4%)     2 (8%)     <NA>       <NA>       <NA>       <NA>      
       8 Social circumstances                                 2 (8%)     1 (4%)     1 (4%)     <NA>       <NA>       <NA>      
       9 Cardiac disorders                                    2 (8%)     2 (8%)     <NA>       1 (4%)     <NA>       <NA>      
      10 Endocrine disorders                                  1 (4%)     2 (8%)     <NA>       <NA>       <NA>       <NA>      
      11 Gastrointestinal disorders                           1 (4%)     1 (4%)     1 (4%)     3 (12%)    <NA>       <NA>      
      12 Reproductive system and breast disorders             4 (16%)    <NA>       1 (4%)     <NA>       <NA>       <NA>      
      13 Metabolism and nutrition disorders                   1 (4%)     <NA>       1 (4%)     <NA>       <NA>       <NA>      
      14 Respiratory, thoracic and mediastinal disorders      <NA>       1 (4%)     1 (4%)     <NA>       <NA>       <NA>      
      15 Surgical and medical procedures                      <NA>       1 (4%)     <NA>       <NA>       <NA>       <NA>      
      16 Musculoskeletal and connective tissue disorders      <NA>       2 (8%)     <NA>       <NA>       <NA>       <NA>      
      17 Eye disorders                                        <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>      
      18 Hepatobiliary disorders                              <NA>       1 (4%)     <NA>       <NA>       <NA>       <NA>      
      19 Injury, poisoning and procedural complications       1 (4%)     1 (4%)     <NA>       <NA>       <NA>       <NA>      
      20 Nervous system disorders                             <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>      
      21 Renal and urinary disorders                          1 (4%)     <NA>       <NA>       <NA>       <NA>       <NA>      
      22 Vascular disorders                                   <NA>       1 (4%)     <NA>       1 (4%)     <NA>       <NA>      
      23 Ear and labyrinth disorders                          <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>      
      24 Blood and lymphatic system disorders                 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      25 Neoplasms benign, malignant, and unspecified         <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      26 Skin and subcutaneous tissue disorders               <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      27 No Declared AE                                       <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
         control_Tot treatment_G1 treatment_G2 treatment_G3 treatment_G4 treatment_G5 treatment_NA treatment_Tot
         <glue>      <glue>       <glue>       <glue>       <glue>       <glue>       <glue>       <glue>       
       1 9 (36%)     1 (4%)       1 (4%)       1 (4%)       <NA>         <NA>         <NA>         3 (12%)      
       2 4 (16%)     1 (4%)       2 (8%)       1 (4%)       2 (8%)       <NA>         <NA>         6 (24%)      
       3 3 (12%)     2 (8%)       1 (4%)       <NA>         2 (8%)       <NA>         <NA>         5 (20%)      
       4 6 (24%)     <NA>         2 (8%)       <NA>         <NA>         <NA>         <NA>         2 (8%)       
       5 5 (20%)     1 (4%)       1 (4%)       <NA>         <NA>         <NA>         <NA>         2 (8%)       
       6 5 (20%)     2 (8%)       <NA>         <NA>         <NA>         <NA>         <NA>         2 (8%)       
       7 3 (12%)     1 (4%)       3 (12%)      <NA>         <NA>         <NA>         <NA>         4 (16%)      
       8 4 (16%)     2 (8%)       <NA>         1 (4%)       <NA>         <NA>         <NA>         3 (12%)      
       9 5 (20%)     1 (4%)       <NA>         <NA>         <NA>         <NA>         <NA>         1 (4%)       
      10 3 (12%)     <NA>         1 (4%)       2 (8%)       <NA>         <NA>         <NA>         3 (12%)      
      11 6 (24%)     <NA>         <NA>         <NA>         <NA>         <NA>         <NA>         <NA>         
      12 5 (20%)     1 (4%)       <NA>         <NA>         <NA>         <NA>         <NA>         1 (4%)       
      13 2 (8%)      1 (4%)       1 (4%)       <NA>         1 (4%)       <NA>         <NA>         3 (12%)      
      14 2 (8%)      1 (4%)       1 (4%)       <NA>         1 (4%)       <NA>         <NA>         3 (12%)      
      15 1 (4%)      2 (8%)       2 (8%)       <NA>         <NA>         <NA>         <NA>         4 (16%)      
      16 2 (8%)      <NA>         <NA>         2 (8%)       <NA>         <NA>         <NA>         2 (8%)       
      17 1 (4%)      <NA>         2 (8%)       <NA>         <NA>         <NA>         <NA>         2 (8%)       
      18 1 (4%)      2 (8%)       <NA>         <NA>         <NA>         <NA>         <NA>         2 (8%)       
      19 2 (8%)      <NA>         1 (4%)       <NA>         <NA>         <NA>         <NA>         1 (4%)       
      20 1 (4%)      1 (4%)       <NA>         1 (4%)       <NA>         <NA>         <NA>         2 (8%)       
      21 1 (4%)      1 (4%)       <NA>         1 (4%)       <NA>         <NA>         <NA>         2 (8%)       
      22 2 (8%)      <NA>         <NA>         <NA>         <NA>         <NA>         <NA>         <NA>         
      23 1 (4%)      <NA>         <NA>         <NA>         <NA>         <NA>         <NA>         <NA>         
      24 <NA>        2 (8%)       2 (8%)       <NA>         1 (4%)       <NA>         <NA>         5 (20%)      
      25 <NA>        3 (12%)      <NA>         <NA>         2 (8%)       <NA>         <NA>         5 (20%)      
      26 <NA>        2 (8%)       <NA>         1 (4%)       <NA>         <NA>         <NA>         3 (12%)      
      27 <NA>        <NA>         <NA>         <NA>         <NA>         <NA>         1 (4%)       1 (4%)       
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", showNA = FALSE, total = FALSE)
    Output
      # A tibble: 27 x 11
         soc                                                  control_G1 control_G2 control_G3 control_G4 control_G5 treatment_G1
         <fct>                                                <glue>     <glue>     <glue>     <glue>     <glue>     <glue>      
       1 Investigations                                       2 (8%)     3 (12%)    1 (4%)     2 (8%)     1 (4%)     1 (4%)      
       2 Immune system disorders                              2 (8%)     <NA>       2 (8%)     <NA>       <NA>       1 (4%)      
       3 General disorders and administration site conditions 2 (8%)     <NA>       <NA>       <NA>       1 (4%)     2 (8%)      
       4 Infections and infestations                          2 (8%)     2 (8%)     2 (8%)     <NA>       <NA>       <NA>        
       5 Congenital, familial and genetic disorders           2 (8%)     2 (8%)     1 (4%)     <NA>       <NA>       1 (4%)      
       6 Pregnancy, puerperium and perinatal conditions       1 (4%)     <NA>       3 (12%)    1 (4%)     <NA>       2 (8%)      
       7 Psychiatric disorders                                1 (4%)     2 (8%)     <NA>       <NA>       <NA>       1 (4%)      
       8 Social circumstances                                 2 (8%)     1 (4%)     1 (4%)     <NA>       <NA>       2 (8%)      
       9 Cardiac disorders                                    2 (8%)     2 (8%)     <NA>       1 (4%)     <NA>       1 (4%)      
      10 Endocrine disorders                                  1 (4%)     2 (8%)     <NA>       <NA>       <NA>       <NA>        
      11 Gastrointestinal disorders                           1 (4%)     1 (4%)     1 (4%)     3 (12%)    <NA>       <NA>        
      12 Reproductive system and breast disorders             4 (16%)    <NA>       1 (4%)     <NA>       <NA>       1 (4%)      
      13 Metabolism and nutrition disorders                   1 (4%)     <NA>       1 (4%)     <NA>       <NA>       1 (4%)      
      14 Respiratory, thoracic and mediastinal disorders      <NA>       1 (4%)     1 (4%)     <NA>       <NA>       1 (4%)      
      15 Surgical and medical procedures                      <NA>       1 (4%)     <NA>       <NA>       <NA>       2 (8%)      
      16 Musculoskeletal and connective tissue disorders      <NA>       2 (8%)     <NA>       <NA>       <NA>       <NA>        
      17 Eye disorders                                        <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>        
      18 Hepatobiliary disorders                              <NA>       1 (4%)     <NA>       <NA>       <NA>       2 (8%)      
      19 Injury, poisoning and procedural complications       1 (4%)     1 (4%)     <NA>       <NA>       <NA>       <NA>        
      20 Nervous system disorders                             <NA>       <NA>       <NA>       1 (4%)     <NA>       1 (4%)      
      21 Renal and urinary disorders                          1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      
      22 Vascular disorders                                   <NA>       1 (4%)     <NA>       1 (4%)     <NA>       <NA>        
      23 Ear and labyrinth disorders                          <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>        
      24 Blood and lymphatic system disorders                 <NA>       <NA>       <NA>       <NA>       <NA>       2 (8%)      
      25 Neoplasms benign, malignant, and unspecified         <NA>       <NA>       <NA>       <NA>       <NA>       3 (12%)     
      26 Skin and subcutaneous tissue disorders               <NA>       <NA>       <NA>       <NA>       <NA>       2 (8%)      
      27 No Declared AE                                       <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        
         treatment_G2 treatment_G3 treatment_G4 treatment_G5
         <glue>       <glue>       <glue>       <glue>      
       1 1 (4%)       1 (4%)       <NA>         <NA>        
       2 2 (8%)       1 (4%)       2 (8%)       <NA>        
       3 1 (4%)       <NA>         2 (8%)       <NA>        
       4 2 (8%)       <NA>         <NA>         <NA>        
       5 1 (4%)       <NA>         <NA>         <NA>        
       6 <NA>         <NA>         <NA>         <NA>        
       7 3 (12%)      <NA>         <NA>         <NA>        
       8 <NA>         1 (4%)       <NA>         <NA>        
       9 <NA>         <NA>         <NA>         <NA>        
      10 1 (4%)       2 (8%)       <NA>         <NA>        
      11 <NA>         <NA>         <NA>         <NA>        
      12 <NA>         <NA>         <NA>         <NA>        
      13 1 (4%)       <NA>         1 (4%)       <NA>        
      14 1 (4%)       <NA>         1 (4%)       <NA>        
      15 2 (8%)       <NA>         <NA>         <NA>        
      16 <NA>         2 (8%)       <NA>         <NA>        
      17 2 (8%)       <NA>         <NA>         <NA>        
      18 <NA>         <NA>         <NA>         <NA>        
      19 1 (4%)       <NA>         <NA>         <NA>        
      20 <NA>         1 (4%)       <NA>         <NA>        
      21 <NA>         1 (4%)       <NA>         <NA>        
      22 <NA>         <NA>         <NA>         <NA>        
      23 <NA>         <NA>         <NA>         <NA>        
      24 2 (8%)       <NA>         1 (4%)       <NA>        
      25 <NA>         <NA>         2 (8%)       <NA>        
      26 <NA>         1 (4%)       <NA>         <NA>        
      27 <NA>         <NA>         <NA>         <NA>        
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", variant = "sup")
    Condition
      Warning:
      Total has been set to `FALSE` as totals are not very interpretable when `variant` is "sup" or "eq". Set `total=TRUE` explicitly to silence this warning.
    Output
      # A tibble: 27 x 13
         soc                                                  control_G1 control_G2 control_G3 control_G4 control_G5 control_NA
         <fct>                                                <glue>     <glue>     <glue>     <glue>     <glue>     <glue>    
       1 Investigations                                       9 (36%)    7 (28%)    4 (16%)    3 (12%)    1 (4%)     <NA>      
       2 Immune system disorders                              4 (16%)    2 (8%)     2 (8%)     <NA>       <NA>       <NA>      
       3 General disorders and administration site conditions 3 (12%)    1 (4%)     1 (4%)     1 (4%)     1 (4%)     <NA>      
       4 Gastrointestinal disorders                           6 (24%)    5 (20%)    4 (16%)    3 (12%)    <NA>       <NA>      
       5 Infections and infestations                          6 (24%)    4 (16%)    2 (8%)     <NA>       <NA>       <NA>      
       6 Pregnancy, puerperium and perinatal conditions       5 (20%)    4 (16%)    4 (16%)    1 (4%)     <NA>       <NA>      
       7 Endocrine disorders                                  3 (12%)    2 (8%)     <NA>       <NA>       <NA>       <NA>      
       8 Congenital, familial and genetic disorders           5 (20%)    3 (12%)    1 (4%)     <NA>       <NA>       <NA>      
       9 Psychiatric disorders                                3 (12%)    2 (8%)     <NA>       <NA>       <NA>       <NA>      
      10 Respiratory, thoracic and mediastinal disorders      2 (8%)     2 (8%)     1 (4%)     <NA>       <NA>       <NA>      
      11 Social circumstances                                 4 (16%)    2 (8%)     1 (4%)     <NA>       <NA>       <NA>      
      12 Cardiac disorders                                    5 (20%)    3 (12%)    1 (4%)     1 (4%)     <NA>       <NA>      
      13 Metabolism and nutrition disorders                   2 (8%)     1 (4%)     1 (4%)     <NA>       <NA>       <NA>      
      14 Musculoskeletal and connective tissue disorders      2 (8%)     2 (8%)     <NA>       <NA>       <NA>       <NA>      
      15 Eye disorders                                        1 (4%)     1 (4%)     1 (4%)     1 (4%)     <NA>       <NA>      
      16 Nervous system disorders                             1 (4%)     1 (4%)     1 (4%)     1 (4%)     <NA>       <NA>      
      17 Reproductive system and breast disorders             5 (20%)    1 (4%)     1 (4%)     <NA>       <NA>       <NA>      
      18 Surgical and medical procedures                      1 (4%)     1 (4%)     <NA>       <NA>       <NA>       <NA>      
      19 Vascular disorders                                   2 (8%)     2 (8%)     1 (4%)     1 (4%)     <NA>       <NA>      
      20 Injury, poisoning and procedural complications       2 (8%)     1 (4%)     <NA>       <NA>       <NA>       <NA>      
      21 Renal and urinary disorders                          1 (4%)     <NA>       <NA>       <NA>       <NA>       <NA>      
      22 Ear and labyrinth disorders                          1 (4%)     1 (4%)     1 (4%)     1 (4%)     <NA>       <NA>      
      23 Hepatobiliary disorders                              1 (4%)     1 (4%)     <NA>       <NA>       <NA>       <NA>      
      24 Neoplasms benign, malignant, and unspecified         <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      25 Blood and lymphatic system disorders                 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      26 Skin and subcutaneous tissue disorders               <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      27 No Declared AE                                       <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
         treatment_G1 treatment_G2 treatment_G3 treatment_G4 treatment_G5 treatment_NA
         <glue>       <glue>       <glue>       <glue>       <glue>       <glue>      
       1 3 (12%)      2 (8%)       1 (4%)       <NA>         <NA>         <NA>        
       2 6 (24%)      5 (20%)      3 (12%)      2 (8%)       <NA>         <NA>        
       3 5 (20%)      3 (12%)      2 (8%)       2 (8%)       <NA>         <NA>        
       4 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
       5 2 (8%)       2 (8%)       <NA>         <NA>         <NA>         <NA>        
       6 2 (8%)       <NA>         <NA>         <NA>         <NA>         <NA>        
       7 3 (12%)      3 (12%)      2 (8%)       <NA>         <NA>         <NA>        
       8 2 (8%)       1 (4%)       <NA>         <NA>         <NA>         <NA>        
       9 4 (16%)      3 (12%)      <NA>         <NA>         <NA>         <NA>        
      10 3 (12%)      2 (8%)       1 (4%)       1 (4%)       <NA>         <NA>        
      11 3 (12%)      1 (4%)       1 (4%)       <NA>         <NA>         <NA>        
      12 1 (4%)       <NA>         <NA>         <NA>         <NA>         <NA>        
      13 3 (12%)      2 (8%)       1 (4%)       1 (4%)       <NA>         <NA>        
      14 2 (8%)       2 (8%)       2 (8%)       <NA>         <NA>         <NA>        
      15 2 (8%)       2 (8%)       <NA>         <NA>         <NA>         <NA>        
      16 2 (8%)       1 (4%)       1 (4%)       <NA>         <NA>         <NA>        
      17 1 (4%)       <NA>         <NA>         <NA>         <NA>         <NA>        
      18 4 (16%)      2 (8%)       <NA>         <NA>         <NA>         <NA>        
      19 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
      20 1 (4%)       1 (4%)       <NA>         <NA>         <NA>         <NA>        
      21 2 (8%)       1 (4%)       1 (4%)       <NA>         <NA>         <NA>        
      22 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
      23 2 (8%)       <NA>         <NA>         <NA>         <NA>         <NA>        
      24 5 (20%)      2 (8%)       2 (8%)       2 (8%)       <NA>         <NA>        
      25 5 (20%)      3 (12%)      1 (4%)       1 (4%)       <NA>         <NA>        
      26 3 (12%)      1 (4%)       1 (4%)       <NA>         <NA>         <NA>        
      27 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", variant = "eq")
    Condition
      Warning:
      Total has been set to `FALSE` as totals are not very interpretable when `variant` is "sup" or "eq". Set `total=TRUE` explicitly to silence this warning.
    Output
      # A tibble: 27 x 13
         soc                                                  control_G1 control_G2 control_G3 control_G4 control_G5 control_NA
         <fct>                                                <glue>     <glue>     <glue>     <glue>     <glue>     <glue>    
       1 Investigations                                       2 (8%)     3 (12%)    2 (8%)     2 (8%)     1 (4%)     <NA>      
       2 Immune system disorders                              2 (8%)     <NA>       2 (8%)     <NA>       <NA>       <NA>      
       3 Infections and infestations                          3 (12%)    2 (8%)     2 (8%)     <NA>       <NA>       <NA>      
       4 General disorders and administration site conditions 2 (8%)     <NA>       <NA>       <NA>       1 (4%)     <NA>      
       5 Pregnancy, puerperium and perinatal conditions       1 (4%)     <NA>       4 (16%)    1 (4%)     <NA>       <NA>      
       6 Congenital, familial and genetic disorders           2 (8%)     2 (8%)     1 (4%)     <NA>       <NA>       <NA>      
       7 Gastrointestinal disorders                           2 (8%)     1 (4%)     1 (4%)     3 (12%)    <NA>       <NA>      
       8 Psychiatric disorders                                1 (4%)     2 (8%)     <NA>       <NA>       <NA>       <NA>      
       9 Social circumstances                                 2 (8%)     1 (4%)     1 (4%)     <NA>       <NA>       <NA>      
      10 Cardiac disorders                                    2 (8%)     2 (8%)     <NA>       1 (4%)     <NA>       <NA>      
      11 Endocrine disorders                                  1 (4%)     2 (8%)     <NA>       <NA>       <NA>       <NA>      
      12 Reproductive system and breast disorders             4 (16%)    <NA>       1 (4%)     <NA>       <NA>       <NA>      
      13 Respiratory, thoracic and mediastinal disorders      <NA>       2 (8%)     1 (4%)     <NA>       <NA>       <NA>      
      14 Metabolism and nutrition disorders                   1 (4%)     <NA>       1 (4%)     <NA>       <NA>       <NA>      
      15 Surgical and medical procedures                      <NA>       1 (4%)     <NA>       <NA>       <NA>       <NA>      
      16 Musculoskeletal and connective tissue disorders      <NA>       2 (8%)     <NA>       <NA>       <NA>       <NA>      
      17 Eye disorders                                        <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>      
      18 Hepatobiliary disorders                              <NA>       1 (4%)     <NA>       <NA>       <NA>       <NA>      
      19 Injury, poisoning and procedural complications       1 (4%)     1 (4%)     <NA>       <NA>       <NA>       <NA>      
      20 Nervous system disorders                             <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>      
      21 Renal and urinary disorders                          1 (4%)     <NA>       <NA>       <NA>       <NA>       <NA>      
      22 Vascular disorders                                   <NA>       1 (4%)     <NA>       1 (4%)     <NA>       <NA>      
      23 Ear and labyrinth disorders                          <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>      
      24 Blood and lymphatic system disorders                 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      25 Neoplasms benign, malignant, and unspecified         <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      26 Skin and subcutaneous tissue disorders               <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      27 No Declared AE                                       <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
         treatment_G1 treatment_G2 treatment_G3 treatment_G4 treatment_G5 treatment_NA
         <glue>       <glue>       <glue>       <glue>       <glue>       <glue>      
       1 1 (4%)       1 (4%)       1 (4%)       <NA>         <NA>         <NA>        
       2 1 (4%)       2 (8%)       1 (4%)       2 (8%)       <NA>         <NA>        
       3 <NA>         2 (8%)       <NA>         <NA>         <NA>         <NA>        
       4 2 (8%)       1 (4%)       <NA>         2 (8%)       <NA>         <NA>        
       5 2 (8%)       <NA>         <NA>         <NA>         <NA>         <NA>        
       6 1 (4%)       1 (4%)       <NA>         <NA>         <NA>         <NA>        
       7 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
       8 1 (4%)       3 (12%)      <NA>         <NA>         <NA>         <NA>        
       9 2 (8%)       <NA>         1 (4%)       <NA>         <NA>         <NA>        
      10 1 (4%)       <NA>         <NA>         <NA>         <NA>         <NA>        
      11 <NA>         1 (4%)       2 (8%)       <NA>         <NA>         <NA>        
      12 1 (4%)       <NA>         <NA>         <NA>         <NA>         <NA>        
      13 1 (4%)       1 (4%)       <NA>         1 (4%)       <NA>         <NA>        
      14 1 (4%)       1 (4%)       <NA>         1 (4%)       <NA>         <NA>        
      15 2 (8%)       2 (8%)       <NA>         <NA>         <NA>         <NA>        
      16 <NA>         <NA>         2 (8%)       <NA>         <NA>         <NA>        
      17 <NA>         2 (8%)       <NA>         <NA>         <NA>         <NA>        
      18 2 (8%)       <NA>         <NA>         <NA>         <NA>         <NA>        
      19 <NA>         1 (4%)       <NA>         <NA>         <NA>         <NA>        
      20 1 (4%)       <NA>         1 (4%)       <NA>         <NA>         <NA>        
      21 1 (4%)       <NA>         1 (4%)       <NA>         <NA>         <NA>        
      22 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
      23 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
      24 2 (8%)       2 (8%)       <NA>         1 (4%)       <NA>         <NA>        
      25 3 (12%)      <NA>         <NA>         2 (8%)       <NA>         <NA>        
      26 2 (8%)       <NA>         1 (4%)       <NA>         <NA>         <NA>        
      27 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        

