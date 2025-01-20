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
         <fct>                                                <glue>          <glue>          <glue>          <glue>         
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
      18 Pregnancy, puerperium and perinatal conditions       3 (6%)          <NA>            3 (6%)          1 (2%)         
      19 Psychiatric disorders                                2 (4%)          5 (10%)         <NA>            <NA>           
      20 Renal and urinary disorders                          2 (4%)          <NA>            1 (2%)          <NA>           
      21 Reproductive system and breast disorders             5 (10%)         <NA>            1 (2%)          <NA>           
      22 Respiratory, thoracic and mediastinal disorders      1 (2%)          2 (4%)          1 (2%)          1 (2%)         
      23 Skin and subcutaneous tissue disorders               2 (4%)          <NA>            1 (2%)          <NA>           
      24 Social circumstances                                 4 (8%)          1 (2%)          2 (4%)          <NA>           
      25 Surgical and medical procedures                      2 (4%)          3 (6%)          <NA>            <NA>           
      26 Vascular disorders                                   <NA>            1 (2%)          <NA>            1 (2%)         
      27 No Declared AE                                       <NA>            <NA>            <NA>            <NA>           
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
      18 <NA>            <NA>            7 (14%)         
      19 <NA>            <NA>            7 (14%)         
      20 <NA>            <NA>            3 (6%)          
      21 <NA>            <NA>            6 (12%)         
      22 <NA>            <NA>            5 (10%)         
      23 <NA>            <NA>            3 (6%)          
      24 <NA>            <NA>            7 (14%)         
      25 <NA>            <NA>            5 (10%)         
      26 <NA>            <NA>            2 (4%)          
      27 <NA>            1 (2%)          1 (2%)          
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
      13 Blood and lymphatic system disorders                 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      14 Metabolism and nutrition disorders                   1 (4%)     <NA>       1 (4%)     <NA>       <NA>       <NA>      
      15 Neoplasms benign, malignant, and unspecified         <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      16 Respiratory, thoracic and mediastinal disorders      <NA>       1 (4%)     1 (4%)     <NA>       <NA>       <NA>      
      17 Surgical and medical procedures                      <NA>       1 (4%)     <NA>       <NA>       <NA>       <NA>      
      18 Musculoskeletal and connective tissue disorders      <NA>       2 (8%)     <NA>       <NA>       <NA>       <NA>      
      19 Eye disorders                                        <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>      
      20 Hepatobiliary disorders                              <NA>       1 (4%)     <NA>       <NA>       <NA>       <NA>      
      21 Injury, poisoning and procedural complications       1 (4%)     1 (4%)     <NA>       <NA>       <NA>       <NA>      
      22 Nervous system disorders                             <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>      
      23 Renal and urinary disorders                          1 (4%)     <NA>       <NA>       <NA>       <NA>       <NA>      
      24 Skin and subcutaneous tissue disorders               <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      25 Vascular disorders                                   <NA>       1 (4%)     <NA>       1 (4%)     <NA>       <NA>      
      26 Ear and labyrinth disorders                          <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>      
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
      13 <NA>        2 (8%)       2 (8%)       <NA>         1 (4%)       <NA>         <NA>         5 (20%)      
      14 2 (8%)      1 (4%)       1 (4%)       <NA>         1 (4%)       <NA>         <NA>         3 (12%)      
      15 <NA>        3 (12%)      <NA>         <NA>         2 (8%)       <NA>         <NA>         5 (20%)      
      16 2 (8%)      1 (4%)       1 (4%)       <NA>         1 (4%)       <NA>         <NA>         3 (12%)      
      17 1 (4%)      2 (8%)       2 (8%)       <NA>         <NA>         <NA>         <NA>         4 (16%)      
      18 2 (8%)      <NA>         <NA>         2 (8%)       <NA>         <NA>         <NA>         2 (8%)       
      19 1 (4%)      <NA>         2 (8%)       <NA>         <NA>         <NA>         <NA>         2 (8%)       
      20 1 (4%)      2 (8%)       <NA>         <NA>         <NA>         <NA>         <NA>         2 (8%)       
      21 2 (8%)      <NA>         1 (4%)       <NA>         <NA>         <NA>         <NA>         1 (4%)       
      22 1 (4%)      1 (4%)       <NA>         1 (4%)       <NA>         <NA>         <NA>         2 (8%)       
      23 1 (4%)      1 (4%)       <NA>         1 (4%)       <NA>         <NA>         <NA>         2 (8%)       
      24 <NA>        2 (8%)       <NA>         1 (4%)       <NA>         <NA>         <NA>         3 (12%)      
      25 2 (8%)      <NA>         <NA>         <NA>         <NA>         <NA>         <NA>         <NA>         
      26 1 (4%)      <NA>         <NA>         <NA>         <NA>         <NA>         <NA>         <NA>         
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
      13 Blood and lymphatic system disorders                 <NA>       <NA>       <NA>       <NA>       <NA>       2 (8%)      
      14 Metabolism and nutrition disorders                   1 (4%)     <NA>       1 (4%)     <NA>       <NA>       1 (4%)      
      15 Neoplasms benign, malignant, and unspecified         <NA>       <NA>       <NA>       <NA>       <NA>       3 (12%)     
      16 Respiratory, thoracic and mediastinal disorders      <NA>       1 (4%)     1 (4%)     <NA>       <NA>       1 (4%)      
      17 Surgical and medical procedures                      <NA>       1 (4%)     <NA>       <NA>       <NA>       2 (8%)      
      18 Musculoskeletal and connective tissue disorders      <NA>       2 (8%)     <NA>       <NA>       <NA>       <NA>        
      19 Eye disorders                                        <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>        
      20 Hepatobiliary disorders                              <NA>       1 (4%)     <NA>       <NA>       <NA>       2 (8%)      
      21 Injury, poisoning and procedural complications       1 (4%)     1 (4%)     <NA>       <NA>       <NA>       <NA>        
      22 Nervous system disorders                             <NA>       <NA>       <NA>       1 (4%)     <NA>       1 (4%)      
      23 Renal and urinary disorders                          1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      
      24 Skin and subcutaneous tissue disorders               <NA>       <NA>       <NA>       <NA>       <NA>       2 (8%)      
      25 Vascular disorders                                   <NA>       1 (4%)     <NA>       1 (4%)     <NA>       <NA>        
      26 Ear and labyrinth disorders                          <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>        
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
      13 2 (8%)       <NA>         1 (4%)       <NA>        
      14 1 (4%)       <NA>         1 (4%)       <NA>        
      15 <NA>         <NA>         2 (8%)       <NA>        
      16 1 (4%)       <NA>         1 (4%)       <NA>        
      17 2 (8%)       <NA>         <NA>         <NA>        
      18 <NA>         2 (8%)       <NA>         <NA>        
      19 2 (8%)       <NA>         <NA>         <NA>        
      20 <NA>         <NA>         <NA>         <NA>        
      21 1 (4%)       <NA>         <NA>         <NA>        
      22 <NA>         1 (4%)       <NA>         <NA>        
      23 <NA>         1 (4%)       <NA>         <NA>        
      24 <NA>         1 (4%)       <NA>         <NA>        
      25 <NA>         <NA>         <NA>         <NA>        
      26 <NA>         <NA>         <NA>         <NA>        
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
      14 Neoplasms benign, malignant, and unspecified         <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      15 Blood and lymphatic system disorders                 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      16 Musculoskeletal and connective tissue disorders      2 (8%)     2 (8%)     <NA>       <NA>       <NA>       <NA>      
      17 Eye disorders                                        1 (4%)     1 (4%)     1 (4%)     1 (4%)     <NA>       <NA>      
      18 Nervous system disorders                             1 (4%)     1 (4%)     1 (4%)     1 (4%)     <NA>       <NA>      
      19 Reproductive system and breast disorders             5 (20%)    1 (4%)     1 (4%)     <NA>       <NA>       <NA>      
      20 Surgical and medical procedures                      1 (4%)     1 (4%)     <NA>       <NA>       <NA>       <NA>      
      21 Vascular disorders                                   2 (8%)     2 (8%)     1 (4%)     1 (4%)     <NA>       <NA>      
      22 Injury, poisoning and procedural complications       2 (8%)     1 (4%)     <NA>       <NA>       <NA>       <NA>      
      23 Renal and urinary disorders                          1 (4%)     <NA>       <NA>       <NA>       <NA>       <NA>      
      24 Skin and subcutaneous tissue disorders               <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      25 Ear and labyrinth disorders                          1 (4%)     1 (4%)     1 (4%)     1 (4%)     <NA>       <NA>      
      26 Hepatobiliary disorders                              1 (4%)     1 (4%)     <NA>       <NA>       <NA>       <NA>      
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
      14 5 (20%)      2 (8%)       2 (8%)       2 (8%)       <NA>         <NA>        
      15 5 (20%)      3 (12%)      1 (4%)       1 (4%)       <NA>         <NA>        
      16 2 (8%)       2 (8%)       2 (8%)       <NA>         <NA>         <NA>        
      17 2 (8%)       2 (8%)       <NA>         <NA>         <NA>         <NA>        
      18 2 (8%)       1 (4%)       1 (4%)       <NA>         <NA>         <NA>        
      19 1 (4%)       <NA>         <NA>         <NA>         <NA>         <NA>        
      20 4 (16%)      2 (8%)       <NA>         <NA>         <NA>         <NA>        
      21 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
      22 1 (4%)       1 (4%)       <NA>         <NA>         <NA>         <NA>        
      23 2 (8%)       1 (4%)       1 (4%)       <NA>         <NA>         <NA>        
      24 3 (12%)      1 (4%)       1 (4%)       <NA>         <NA>         <NA>        
      25 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
      26 2 (8%)       <NA>         <NA>         <NA>         <NA>         <NA>        
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
      14 Blood and lymphatic system disorders                 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      15 Metabolism and nutrition disorders                   1 (4%)     <NA>       1 (4%)     <NA>       <NA>       <NA>      
      16 Neoplasms benign, malignant, and unspecified         <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      17 Surgical and medical procedures                      <NA>       1 (4%)     <NA>       <NA>       <NA>       <NA>      
      18 Musculoskeletal and connective tissue disorders      <NA>       2 (8%)     <NA>       <NA>       <NA>       <NA>      
      19 Eye disorders                                        <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>      
      20 Hepatobiliary disorders                              <NA>       1 (4%)     <NA>       <NA>       <NA>       <NA>      
      21 Injury, poisoning and procedural complications       1 (4%)     1 (4%)     <NA>       <NA>       <NA>       <NA>      
      22 Nervous system disorders                             <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>      
      23 Renal and urinary disorders                          1 (4%)     <NA>       <NA>       <NA>       <NA>       <NA>      
      24 Skin and subcutaneous tissue disorders               <NA>       <NA>       <NA>       <NA>       <NA>       <NA>      
      25 Vascular disorders                                   <NA>       1 (4%)     <NA>       1 (4%)     <NA>       <NA>      
      26 Ear and labyrinth disorders                          <NA>       <NA>       <NA>       1 (4%)     <NA>       <NA>      
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
      14 2 (8%)       2 (8%)       <NA>         1 (4%)       <NA>         <NA>        
      15 1 (4%)       1 (4%)       <NA>         1 (4%)       <NA>         <NA>        
      16 3 (12%)      <NA>         <NA>         2 (8%)       <NA>         <NA>        
      17 2 (8%)       2 (8%)       <NA>         <NA>         <NA>         <NA>        
      18 <NA>         <NA>         2 (8%)       <NA>         <NA>         <NA>        
      19 <NA>         2 (8%)       <NA>         <NA>         <NA>         <NA>        
      20 2 (8%)       <NA>         <NA>         <NA>         <NA>         <NA>        
      21 <NA>         1 (4%)       <NA>         <NA>         <NA>         <NA>        
      22 1 (4%)       <NA>         1 (4%)       <NA>         <NA>         <NA>        
      23 1 (4%)       <NA>         1 (4%)       <NA>         <NA>         <NA>        
      24 2 (8%)       <NA>         1 (4%)       <NA>         <NA>         <NA>        
      25 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
      26 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
      27 <NA>         <NA>         <NA>         <NA>         <NA>         <NA>        
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", term = "aeterm", sort_by_count = TRUE)
    Output
      # A tibble: 82 x 16
         soc                                                  term                                                control_G1
         <fct>                                                <chr>                                               <glue>    
       1 Investigations                                       Blood analyses                                      1 (4%)    
       2 Investigations                                       Cardiovascular assessments                          <NA>      
       3 Investigations                                       Imaging studies                                     <NA>      
       4 Investigations                                       Liver function analyses                             1 (4%)    
       5 Immune system disorders                              Alloimmune responses                                <NA>      
       6 Immune system disorders                              Autoimmune disorders                                1 (4%)    
       7 Immune system disorders                              Hypersensitivity conditions                         <NA>      
       8 Immune system disorders                              Immune system analysis disorders                    <NA>      
       9 Immune system disorders                              Immune-mediated adverse events                      <NA>      
      10 Immune system disorders                              Inflammatory responses                              1 (4%)    
      11 General disorders and administration site conditions Device issues                                       <NA>      
      12 General disorders and administration site conditions General physical health deterioration               1 (4%)    
      13 General disorders and administration site conditions Injection site reactions                            1 (4%)    
      14 General disorders and administration site conditions Pain and discomfort                                 <NA>      
      15 Infections and infestations                          Bacterial infectious disorders                      1 (4%)    
      16 Infections and infestations                          Fungal infectious disorders                         1 (4%)    
      17 Infections and infestations                          Parasitic infectious disorders                      <NA>      
      18 Infections and infestations                          Viral infectious disorders                          <NA>      
      19 Congenital, familial and genetic disorders           Chromosomal abnormalities                           <NA>      
      20 Congenital, familial and genetic disorders           Congenital nervous system disorders                 <NA>      
      21 Congenital, familial and genetic disorders           Familial hematologic disorders                      2 (8%)    
      22 Congenital, familial and genetic disorders           Hereditary connective tissue disorders              <NA>      
      23 Gastrointestinal disorders                           Esophageal disorders                                1 (4%)    
      24 Gastrointestinal disorders                           Gastrointestinal motility and defecation conditions <NA>      
      25 Gastrointestinal disorders                           Intestinal disorders                                1 (4%)    
      26 Pregnancy, puerperium and perinatal conditions       Breastfeeding issues                                <NA>      
      27 Pregnancy, puerperium and perinatal conditions       Fetal complications                                 1 (4%)    
      28 Pregnancy, puerperium and perinatal conditions       Labor and delivery complications                    <NA>      
      29 Pregnancy, puerperium and perinatal conditions       Pregnancy complications                             <NA>      
      30 Psychiatric disorders                                Anxiety disorders                                   1 (4%)    
      31 Psychiatric disorders                                Mood disorders                                      <NA>      
      32 Psychiatric disorders                                Substance-related disorders                         <NA>      
      33 Social circumstances                                 Cultural issues                                     <NA>      
      34 Social circumstances                                 Economic conditions affecting care                  1 (4%)    
      35 Social circumstances                                 Family support issues                               <NA>      
      36 Social circumstances                                 Social and environmental issues                     1 (4%)    
      37 Cardiac disorders                                    Coronary artery disorders                           <NA>      
      38 Cardiac disorders                                    Heart failures                                      2 (8%)    
      39 Endocrine disorders                                  Adrenal gland disorders                             1 (4%)    
      40 Endocrine disorders                                  Parathyroid gland disorders                         <NA>      
      41 Reproductive system and breast disorders             Breast disorders                                    1 (4%)    
      42 Reproductive system and breast disorders             Female reproductive disorders                       1 (4%)    
      43 Reproductive system and breast disorders             Male reproductive disorders                         1 (4%)    
      44 Reproductive system and breast disorders             Menstrual disorders                                 1 (4%)    
      45 Respiratory, thoracic and mediastinal disorders      Lung function disorders                             <NA>      
      46 Respiratory, thoracic and mediastinal disorders      Pleural disorders                                   <NA>      
      47 Respiratory, thoracic and mediastinal disorders      Respiratory infections                              <NA>      
      48 Surgical and medical procedures                      Device implantation procedures                      <NA>      
      49 Surgical and medical procedures                      Diagnostic procedures                               <NA>      
      50 Surgical and medical procedures                      Surgical complications                              <NA>      
      51 Surgical and medical procedures                      Therapeutic procedures                              <NA>      
      52 Blood and lymphatic system disorders                 Bone marrow disorders                               <NA>      
      53 Blood and lymphatic system disorders                 Coagulation and bleeding analyses                   <NA>      
      54 Blood and lymphatic system disorders                 Red blood cell disorders                            <NA>      
      55 Metabolism and nutrition disorders                   Lipid metabolism disorders                          1 (4%)    
      56 Metabolism and nutrition disorders                   Nutritional disorders                               <NA>      
      57 Metabolism and nutrition disorders                   Vitamin deficiencies                                <NA>      
      58 Neoplasms benign, malignant, and unspecified         Benign neoplasms                                    <NA>      
      59 Neoplasms benign, malignant, and unspecified         Malignant neoplasms                                 <NA>      
      60 Neoplasms benign, malignant, and unspecified         Neoplasms unspecified                               <NA>      
      61 Neoplasms benign, malignant, and unspecified         Tumor progression                                   <NA>      
      62 Eye disorders                                        Corneal disorders                                   <NA>      
      63 Eye disorders                                        Eyelid disorders                                    <NA>      
      64 Eye disorders                                        Vision disorders                                    <NA>      
      65 Musculoskeletal and connective tissue disorders      Arthritis and joint disorders                       <NA>      
      66 Musculoskeletal and connective tissue disorders      Bone disorders                                      <NA>      
      67 Musculoskeletal and connective tissue disorders      Muscle disorders                                    <NA>      
      68 Hepatobiliary disorders                              Bile duct disorders                                 <NA>      
      69 Hepatobiliary disorders                              Gallbladder disorders                               <NA>      
      70 Hepatobiliary disorders                              Hepatic failure                                     <NA>      
      71 Injury, poisoning and procedural complications       Procedural complications                            <NA>      
      72 Injury, poisoning and procedural complications       Radiation-related toxicities                        1 (4%)    
      73 Nervous system disorders                             Seizure disorders                                   <NA>      
      74 Renal and urinary disorders                          Bladder disorders                                   <NA>      
      75 Renal and urinary disorders                          Urethral disorders                                  <NA>      
      76 Renal and urinary disorders                          Urinary tract disorders                             1 (4%)    
      77 Skin and subcutaneous tissue disorders               Skin infections                                     <NA>      
      78 Skin and subcutaneous tissue disorders               Skin pigmentation disorders                         <NA>      
      79 Vascular disorders                                   Hypotension-related conditions                      <NA>      
      80 Vascular disorders                                   Vascular hemorrhagic disorders                      <NA>      
      81 Ear and labyrinth disorders                          Hearing disorders                                   <NA>      
      82 No Declared AE                                       <NA>                                                <NA>      
         control_G2 control_G3 control_G4 control_G5 control_NA control_Tot treatment_G1 treatment_G2 treatment_G3 treatment_G4
         <glue>     <glue>     <glue>     <glue>     <glue>     <glue>      <glue>       <glue>       <glue>       <glue>      
       1 <NA>       1 (4%)     <NA>       <NA>       <NA>       2 (8%)      1 (4%)       1 (4%)       1 (4%)       <NA>        
       2 1 (4%)     <NA>       1 (4%)     <NA>       <NA>       2 (8%)      <NA>         <NA>         <NA>         <NA>        
       3 2 (8%)     <NA>       <NA>       1 (4%)     <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
       4 <NA>       1 (4%)     1 (4%)     <NA>       <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
       5 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
       6 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
       7 <NA>       1 (4%)     <NA>       <NA>       <NA>       1 (4%)      <NA>         1 (4%)       <NA>         1 (4%)      
       8 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         <NA>         1 (4%)      
       9 <NA>       1 (4%)     <NA>       <NA>       <NA>       1 (4%)      1 (4%)       <NA>         1 (4%)       <NA>        
      10 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      11 <NA>       <NA>       <NA>       1 (4%)     <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      12 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         2 (8%)      
      13 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      1 (4%)       <NA>         <NA>         <NA>        
      14 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       1 (4%)       <NA>         <NA>        
      15 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      16 <NA>       1 (4%)     <NA>       <NA>       <NA>       2 (8%)      <NA>         1 (4%)       <NA>         <NA>        
      17 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      18 1 (4%)     1 (4%)     <NA>       <NA>       <NA>       2 (8%)      <NA>         1 (4%)       <NA>         <NA>        
      19 1 (4%)     1 (4%)     <NA>       <NA>       <NA>       2 (8%)      <NA>         <NA>         <NA>         <NA>        
      20 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
      21 1 (4%)     <NA>       <NA>       <NA>       <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
      22 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      23 <NA>       <NA>       2 (8%)     <NA>       <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
      24 <NA>       <NA>       1 (4%)     <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      25 1 (4%)     1 (4%)     <NA>       <NA>       <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
      26 <NA>       <NA>       1 (4%)     <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      27 <NA>       2 (8%)     <NA>       <NA>       <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
      28 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      29 <NA>       1 (4%)     <NA>       <NA>       <NA>       1 (4%)      1 (4%)       <NA>         <NA>         <NA>        
      30 1 (4%)     <NA>       <NA>       <NA>       <NA>       2 (8%)      <NA>         3 (12%)      <NA>         <NA>        
      31 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      32 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      33 <NA>       1 (4%)     <NA>       <NA>       <NA>       1 (4%)      2 (8%)       <NA>         <NA>         <NA>        
      34 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      35 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      36 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         1 (4%)       <NA>        
      37 2 (8%)     <NA>       1 (4%)     <NA>       <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
      38 <NA>       <NA>       <NA>       <NA>       <NA>       2 (8%)      1 (4%)       <NA>         <NA>         <NA>        
      39 1 (4%)     <NA>       <NA>       <NA>       <NA>       2 (8%)      <NA>         <NA>         <NA>         <NA>        
      40 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         1 (4%)       2 (8%)       <NA>        
      41 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      42 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      1 (4%)       <NA>         <NA>         <NA>        
      43 <NA>       1 (4%)     <NA>       <NA>       <NA>       2 (8%)      <NA>         <NA>         <NA>         <NA>        
      44 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      45 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         1 (4%)      
      46 <NA>       1 (4%)     <NA>       <NA>       <NA>       1 (4%)      1 (4%)       1 (4%)       <NA>         <NA>        
      47 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      48 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      49 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      50 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      51 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         2 (8%)       <NA>         <NA>        
      52 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
      53 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (8%)       <NA>         <NA>         1 (4%)      
      54 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
      55 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         1 (4%)      
      56 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      57 <NA>       1 (4%)     <NA>       <NA>       <NA>       1 (4%)      <NA>         1 (4%)       <NA>         <NA>        
      58 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      59 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      60 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         <NA>         1 (4%)      
      61 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         1 (4%)      
      62 <NA>       <NA>       1 (4%)     <NA>       <NA>       1 (4%)      <NA>         1 (4%)       <NA>         <NA>        
      63 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
      64 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
      65 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      66 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         1 (4%)       <NA>        
      67 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         1 (4%)       <NA>        
      68 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      69 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      70 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      71 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
      72 1 (4%)     <NA>       <NA>       <NA>       <NA>       2 (8%)      <NA>         <NA>         <NA>         <NA>        
      73 <NA>       <NA>       1 (4%)     <NA>       <NA>       1 (4%)      1 (4%)       <NA>         1 (4%)       <NA>        
      74 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         1 (4%)       <NA>        
      75 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      76 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      77 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         1 (4%)       <NA>        
      78 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (8%)       <NA>         <NA>         <NA>        
      79 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      80 <NA>       <NA>       1 (4%)     <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      81 <NA>       <NA>       1 (4%)     <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      82 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         <NA>         <NA>        
         treatment_G5 treatment_NA treatment_Tot
         <glue>       <glue>       <glue>       
       1 <NA>         <NA>         3 (12%)      
       2 <NA>         <NA>         <NA>         
       3 <NA>         <NA>         <NA>         
       4 <NA>         <NA>         <NA>         
       5 <NA>         <NA>         1 (4%)       
       6 <NA>         <NA>         <NA>         
       7 <NA>         <NA>         2 (8%)       
       8 <NA>         <NA>         1 (4%)       
       9 <NA>         <NA>         2 (8%)       
      10 <NA>         <NA>         <NA>         
      11 <NA>         <NA>         <NA>         
      12 <NA>         <NA>         2 (8%)       
      13 <NA>         <NA>         1 (4%)       
      14 <NA>         <NA>         2 (8%)       
      15 <NA>         <NA>         <NA>         
      16 <NA>         <NA>         1 (4%)       
      17 <NA>         <NA>         <NA>         
      18 <NA>         <NA>         1 (4%)       
      19 <NA>         <NA>         <NA>         
      20 <NA>         <NA>         1 (4%)       
      21 <NA>         <NA>         <NA>         
      22 <NA>         <NA>         1 (4%)       
      23 <NA>         <NA>         <NA>         
      24 <NA>         <NA>         <NA>         
      25 <NA>         <NA>         <NA>         
      26 <NA>         <NA>         <NA>         
      27 <NA>         <NA>         <NA>         
      28 <NA>         <NA>         1 (4%)       
      29 <NA>         <NA>         1 (4%)       
      30 <NA>         <NA>         3 (12%)      
      31 <NA>         <NA>         <NA>         
      32 <NA>         <NA>         1 (4%)       
      33 <NA>         <NA>         2 (8%)       
      34 <NA>         <NA>         <NA>         
      35 <NA>         <NA>         <NA>         
      36 <NA>         <NA>         1 (4%)       
      37 <NA>         <NA>         <NA>         
      38 <NA>         <NA>         1 (4%)       
      39 <NA>         <NA>         <NA>         
      40 <NA>         <NA>         3 (12%)      
      41 <NA>         <NA>         <NA>         
      42 <NA>         <NA>         1 (4%)       
      43 <NA>         <NA>         <NA>         
      44 <NA>         <NA>         <NA>         
      45 <NA>         <NA>         1 (4%)       
      46 <NA>         <NA>         2 (8%)       
      47 <NA>         <NA>         <NA>         
      48 <NA>         <NA>         <NA>         
      49 <NA>         <NA>         1 (4%)       
      50 <NA>         <NA>         1 (4%)       
      51 <NA>         <NA>         2 (8%)       
      52 <NA>         <NA>         1 (4%)       
      53 <NA>         <NA>         3 (12%)      
      54 <NA>         <NA>         1 (4%)       
      55 <NA>         <NA>         1 (4%)       
      56 <NA>         <NA>         1 (4%)       
      57 <NA>         <NA>         1 (4%)       
      58 <NA>         <NA>         1 (4%)       
      59 <NA>         <NA>         1 (4%)       
      60 <NA>         <NA>         1 (4%)       
      61 <NA>         <NA>         2 (8%)       
      62 <NA>         <NA>         1 (4%)       
      63 <NA>         <NA>         1 (4%)       
      64 <NA>         <NA>         1 (4%)       
      65 <NA>         <NA>         <NA>         
      66 <NA>         <NA>         1 (4%)       
      67 <NA>         <NA>         1 (4%)       
      68 <NA>         <NA>         <NA>         
      69 <NA>         <NA>         1 (4%)       
      70 <NA>         <NA>         1 (4%)       
      71 <NA>         <NA>         1 (4%)       
      72 <NA>         <NA>         <NA>         
      73 <NA>         <NA>         2 (8%)       
      74 <NA>         <NA>         1 (4%)       
      75 <NA>         <NA>         1 (4%)       
      76 <NA>         <NA>         <NA>         
      77 <NA>         <NA>         1 (4%)       
      78 <NA>         <NA>         2 (8%)       
      79 <NA>         <NA>         <NA>         
      80 <NA>         <NA>         <NA>         
      81 <NA>         <NA>         <NA>         
      82 <NA>         1 (4%)       1 (4%)       
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", term = "aeterm", sort_by_count = FALSE)
    Output
      # A tibble: 82 x 16
         soc                                                  term                                                control_G1
         <fct>                                                <fct>                                               <glue>    
       1 Blood and lymphatic system disorders                 Bone marrow disorders                               <NA>      
       2 Blood and lymphatic system disorders                 Coagulation and bleeding analyses                   <NA>      
       3 Blood and lymphatic system disorders                 Red blood cell disorders                            <NA>      
       4 Cardiac disorders                                    Coronary artery disorders                           <NA>      
       5 Cardiac disorders                                    Heart failures                                      2 (8%)    
       6 Congenital, familial and genetic disorders           Chromosomal abnormalities                           <NA>      
       7 Congenital, familial and genetic disorders           Congenital nervous system disorders                 <NA>      
       8 Congenital, familial and genetic disorders           Familial hematologic disorders                      2 (8%)    
       9 Congenital, familial and genetic disorders           Hereditary connective tissue disorders              <NA>      
      10 Ear and labyrinth disorders                          Hearing disorders                                   <NA>      
      11 Endocrine disorders                                  Adrenal gland disorders                             1 (4%)    
      12 Endocrine disorders                                  Parathyroid gland disorders                         <NA>      
      13 Eye disorders                                        Corneal disorders                                   <NA>      
      14 Eye disorders                                        Eyelid disorders                                    <NA>      
      15 Eye disorders                                        Vision disorders                                    <NA>      
      16 Gastrointestinal disorders                           Esophageal disorders                                1 (4%)    
      17 Gastrointestinal disorders                           Gastrointestinal motility and defecation conditions <NA>      
      18 Gastrointestinal disorders                           Intestinal disorders                                1 (4%)    
      19 General disorders and administration site conditions Device issues                                       <NA>      
      20 General disorders and administration site conditions General physical health deterioration               1 (4%)    
      21 General disorders and administration site conditions Injection site reactions                            1 (4%)    
      22 General disorders and administration site conditions Pain and discomfort                                 <NA>      
      23 Hepatobiliary disorders                              Bile duct disorders                                 <NA>      
      24 Hepatobiliary disorders                              Gallbladder disorders                               <NA>      
      25 Hepatobiliary disorders                              Hepatic failure                                     <NA>      
      26 Immune system disorders                              Alloimmune responses                                <NA>      
      27 Immune system disorders                              Autoimmune disorders                                1 (4%)    
      28 Immune system disorders                              Hypersensitivity conditions                         <NA>      
      29 Immune system disorders                              Immune system analysis disorders                    <NA>      
      30 Immune system disorders                              Immune-mediated adverse events                      <NA>      
      31 Immune system disorders                              Inflammatory responses                              1 (4%)    
      32 Infections and infestations                          Bacterial infectious disorders                      1 (4%)    
      33 Infections and infestations                          Fungal infectious disorders                         1 (4%)    
      34 Infections and infestations                          Parasitic infectious disorders                      <NA>      
      35 Infections and infestations                          Viral infectious disorders                          <NA>      
      36 Injury, poisoning and procedural complications       Procedural complications                            <NA>      
      37 Injury, poisoning and procedural complications       Radiation-related toxicities                        1 (4%)    
      38 Investigations                                       Blood analyses                                      1 (4%)    
      39 Investigations                                       Cardiovascular assessments                          <NA>      
      40 Investigations                                       Imaging studies                                     <NA>      
      41 Investigations                                       Liver function analyses                             1 (4%)    
      42 Metabolism and nutrition disorders                   Lipid metabolism disorders                          1 (4%)    
      43 Metabolism and nutrition disorders                   Nutritional disorders                               <NA>      
      44 Metabolism and nutrition disorders                   Vitamin deficiencies                                <NA>      
      45 Musculoskeletal and connective tissue disorders      Arthritis and joint disorders                       <NA>      
      46 Musculoskeletal and connective tissue disorders      Bone disorders                                      <NA>      
      47 Musculoskeletal and connective tissue disorders      Muscle disorders                                    <NA>      
      48 Neoplasms benign, malignant, and unspecified         Benign neoplasms                                    <NA>      
      49 Neoplasms benign, malignant, and unspecified         Malignant neoplasms                                 <NA>      
      50 Neoplasms benign, malignant, and unspecified         Neoplasms unspecified                               <NA>      
      51 Neoplasms benign, malignant, and unspecified         Tumor progression                                   <NA>      
      52 Nervous system disorders                             Seizure disorders                                   <NA>      
      53 Pregnancy, puerperium and perinatal conditions       Breastfeeding issues                                <NA>      
      54 Pregnancy, puerperium and perinatal conditions       Fetal complications                                 1 (4%)    
      55 Pregnancy, puerperium and perinatal conditions       Labor and delivery complications                    <NA>      
      56 Pregnancy, puerperium and perinatal conditions       Pregnancy complications                             <NA>      
      57 Psychiatric disorders                                Anxiety disorders                                   1 (4%)    
      58 Psychiatric disorders                                Mood disorders                                      <NA>      
      59 Psychiatric disorders                                Substance-related disorders                         <NA>      
      60 Renal and urinary disorders                          Bladder disorders                                   <NA>      
      61 Renal and urinary disorders                          Urethral disorders                                  <NA>      
      62 Renal and urinary disorders                          Urinary tract disorders                             1 (4%)    
      63 Reproductive system and breast disorders             Breast disorders                                    1 (4%)    
      64 Reproductive system and breast disorders             Female reproductive disorders                       1 (4%)    
      65 Reproductive system and breast disorders             Male reproductive disorders                         1 (4%)    
      66 Reproductive system and breast disorders             Menstrual disorders                                 1 (4%)    
      67 Respiratory, thoracic and mediastinal disorders      Lung function disorders                             <NA>      
      68 Respiratory, thoracic and mediastinal disorders      Pleural disorders                                   <NA>      
      69 Respiratory, thoracic and mediastinal disorders      Respiratory infections                              <NA>      
      70 Skin and subcutaneous tissue disorders               Skin infections                                     <NA>      
      71 Skin and subcutaneous tissue disorders               Skin pigmentation disorders                         <NA>      
      72 Social circumstances                                 Cultural issues                                     <NA>      
      73 Social circumstances                                 Economic conditions affecting care                  1 (4%)    
      74 Social circumstances                                 Family support issues                               <NA>      
      75 Social circumstances                                 Social and environmental issues                     1 (4%)    
      76 Surgical and medical procedures                      Device implantation procedures                      <NA>      
      77 Surgical and medical procedures                      Diagnostic procedures                               <NA>      
      78 Surgical and medical procedures                      Surgical complications                              <NA>      
      79 Surgical and medical procedures                      Therapeutic procedures                              <NA>      
      80 Vascular disorders                                   Hypotension-related conditions                      <NA>      
      81 Vascular disorders                                   Vascular hemorrhagic disorders                      <NA>      
      82 No Declared AE                                       <NA>                                                <NA>      
         control_G2 control_G3 control_G4 control_G5 control_NA control_Tot treatment_G1 treatment_G2 treatment_G3 treatment_G4
         <glue>     <glue>     <glue>     <glue>     <glue>     <glue>      <glue>       <glue>       <glue>       <glue>      
       1 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
       2 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (8%)       <NA>         <NA>         1 (4%)      
       3 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
       4 2 (8%)     <NA>       1 (4%)     <NA>       <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
       5 <NA>       <NA>       <NA>       <NA>       <NA>       2 (8%)      1 (4%)       <NA>         <NA>         <NA>        
       6 1 (4%)     1 (4%)     <NA>       <NA>       <NA>       2 (8%)      <NA>         <NA>         <NA>         <NA>        
       7 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
       8 1 (4%)     <NA>       <NA>       <NA>       <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
       9 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      10 <NA>       <NA>       1 (4%)     <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      11 1 (4%)     <NA>       <NA>       <NA>       <NA>       2 (8%)      <NA>         <NA>         <NA>         <NA>        
      12 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         1 (4%)       2 (8%)       <NA>        
      13 <NA>       <NA>       1 (4%)     <NA>       <NA>       1 (4%)      <NA>         1 (4%)       <NA>         <NA>        
      14 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
      15 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
      16 <NA>       <NA>       2 (8%)     <NA>       <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
      17 <NA>       <NA>       1 (4%)     <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      18 1 (4%)     1 (4%)     <NA>       <NA>       <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
      19 <NA>       <NA>       <NA>       1 (4%)     <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      20 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         2 (8%)      
      21 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      1 (4%)       <NA>         <NA>         <NA>        
      22 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       1 (4%)       <NA>         <NA>        
      23 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      24 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      25 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      26 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
      27 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      28 <NA>       1 (4%)     <NA>       <NA>       <NA>       1 (4%)      <NA>         1 (4%)       <NA>         1 (4%)      
      29 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         <NA>         1 (4%)      
      30 <NA>       1 (4%)     <NA>       <NA>       <NA>       1 (4%)      1 (4%)       <NA>         1 (4%)       <NA>        
      31 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      32 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      33 <NA>       1 (4%)     <NA>       <NA>       <NA>       2 (8%)      <NA>         1 (4%)       <NA>         <NA>        
      34 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      35 1 (4%)     1 (4%)     <NA>       <NA>       <NA>       2 (8%)      <NA>         1 (4%)       <NA>         <NA>        
      36 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         1 (4%)       <NA>         <NA>        
      37 1 (4%)     <NA>       <NA>       <NA>       <NA>       2 (8%)      <NA>         <NA>         <NA>         <NA>        
      38 <NA>       1 (4%)     <NA>       <NA>       <NA>       2 (8%)      1 (4%)       1 (4%)       1 (4%)       <NA>        
      39 1 (4%)     <NA>       1 (4%)     <NA>       <NA>       2 (8%)      <NA>         <NA>         <NA>         <NA>        
      40 2 (8%)     <NA>       <NA>       1 (4%)     <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
      41 <NA>       1 (4%)     1 (4%)     <NA>       <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
      42 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         1 (4%)      
      43 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      44 <NA>       1 (4%)     <NA>       <NA>       <NA>       1 (4%)      <NA>         1 (4%)       <NA>         <NA>        
      45 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      46 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         1 (4%)       <NA>        
      47 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         1 (4%)       <NA>        
      48 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      49 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      50 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         <NA>         1 (4%)      
      51 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         1 (4%)      
      52 <NA>       <NA>       1 (4%)     <NA>       <NA>       1 (4%)      1 (4%)       <NA>         1 (4%)       <NA>        
      53 <NA>       <NA>       1 (4%)     <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      54 <NA>       2 (8%)     <NA>       <NA>       <NA>       3 (12%)     <NA>         <NA>         <NA>         <NA>        
      55 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      56 <NA>       1 (4%)     <NA>       <NA>       <NA>       1 (4%)      1 (4%)       <NA>         <NA>         <NA>        
      57 1 (4%)     <NA>       <NA>       <NA>       <NA>       2 (8%)      <NA>         3 (12%)      <NA>         <NA>        
      58 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      59 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      60 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         1 (4%)       <NA>        
      61 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      62 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      63 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      64 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      1 (4%)       <NA>         <NA>         <NA>        
      65 <NA>       1 (4%)     <NA>       <NA>       <NA>       2 (8%)      <NA>         <NA>         <NA>         <NA>        
      66 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      67 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         1 (4%)      
      68 <NA>       1 (4%)     <NA>       <NA>       <NA>       1 (4%)      1 (4%)       1 (4%)       <NA>         <NA>        
      69 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      70 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         1 (4%)       <NA>        
      71 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        2 (8%)       <NA>         <NA>         <NA>        
      72 <NA>       1 (4%)     <NA>       <NA>       <NA>       1 (4%)      2 (8%)       <NA>         <NA>         <NA>        
      73 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      74 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      75 <NA>       <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         1 (4%)       <NA>        
      76 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      77 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      78 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        1 (4%)       <NA>         <NA>         <NA>        
      79 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         2 (8%)       <NA>         <NA>        
      80 1 (4%)     <NA>       <NA>       <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      81 <NA>       <NA>       1 (4%)     <NA>       <NA>       1 (4%)      <NA>         <NA>         <NA>         <NA>        
      82 <NA>       <NA>       <NA>       <NA>       <NA>       <NA>        <NA>         <NA>         <NA>         <NA>        
         treatment_G5 treatment_NA treatment_Tot
         <glue>       <glue>       <glue>       
       1 <NA>         <NA>         1 (4%)       
       2 <NA>         <NA>         3 (12%)      
       3 <NA>         <NA>         1 (4%)       
       4 <NA>         <NA>         <NA>         
       5 <NA>         <NA>         1 (4%)       
       6 <NA>         <NA>         <NA>         
       7 <NA>         <NA>         1 (4%)       
       8 <NA>         <NA>         <NA>         
       9 <NA>         <NA>         1 (4%)       
      10 <NA>         <NA>         <NA>         
      11 <NA>         <NA>         <NA>         
      12 <NA>         <NA>         3 (12%)      
      13 <NA>         <NA>         1 (4%)       
      14 <NA>         <NA>         1 (4%)       
      15 <NA>         <NA>         1 (4%)       
      16 <NA>         <NA>         <NA>         
      17 <NA>         <NA>         <NA>         
      18 <NA>         <NA>         <NA>         
      19 <NA>         <NA>         <NA>         
      20 <NA>         <NA>         2 (8%)       
      21 <NA>         <NA>         1 (4%)       
      22 <NA>         <NA>         2 (8%)       
      23 <NA>         <NA>         <NA>         
      24 <NA>         <NA>         1 (4%)       
      25 <NA>         <NA>         1 (4%)       
      26 <NA>         <NA>         1 (4%)       
      27 <NA>         <NA>         <NA>         
      28 <NA>         <NA>         2 (8%)       
      29 <NA>         <NA>         1 (4%)       
      30 <NA>         <NA>         2 (8%)       
      31 <NA>         <NA>         <NA>         
      32 <NA>         <NA>         <NA>         
      33 <NA>         <NA>         1 (4%)       
      34 <NA>         <NA>         <NA>         
      35 <NA>         <NA>         1 (4%)       
      36 <NA>         <NA>         1 (4%)       
      37 <NA>         <NA>         <NA>         
      38 <NA>         <NA>         3 (12%)      
      39 <NA>         <NA>         <NA>         
      40 <NA>         <NA>         <NA>         
      41 <NA>         <NA>         <NA>         
      42 <NA>         <NA>         1 (4%)       
      43 <NA>         <NA>         1 (4%)       
      44 <NA>         <NA>         1 (4%)       
      45 <NA>         <NA>         <NA>         
      46 <NA>         <NA>         1 (4%)       
      47 <NA>         <NA>         1 (4%)       
      48 <NA>         <NA>         1 (4%)       
      49 <NA>         <NA>         1 (4%)       
      50 <NA>         <NA>         1 (4%)       
      51 <NA>         <NA>         2 (8%)       
      52 <NA>         <NA>         2 (8%)       
      53 <NA>         <NA>         <NA>         
      54 <NA>         <NA>         <NA>         
      55 <NA>         <NA>         1 (4%)       
      56 <NA>         <NA>         1 (4%)       
      57 <NA>         <NA>         3 (12%)      
      58 <NA>         <NA>         <NA>         
      59 <NA>         <NA>         1 (4%)       
      60 <NA>         <NA>         1 (4%)       
      61 <NA>         <NA>         1 (4%)       
      62 <NA>         <NA>         <NA>         
      63 <NA>         <NA>         <NA>         
      64 <NA>         <NA>         1 (4%)       
      65 <NA>         <NA>         <NA>         
      66 <NA>         <NA>         <NA>         
      67 <NA>         <NA>         1 (4%)       
      68 <NA>         <NA>         2 (8%)       
      69 <NA>         <NA>         <NA>         
      70 <NA>         <NA>         1 (4%)       
      71 <NA>         <NA>         2 (8%)       
      72 <NA>         <NA>         2 (8%)       
      73 <NA>         <NA>         <NA>         
      74 <NA>         <NA>         <NA>         
      75 <NA>         <NA>         1 (4%)       
      76 <NA>         <NA>         <NA>         
      77 <NA>         <NA>         1 (4%)       
      78 <NA>         <NA>         1 (4%)       
      79 <NA>         <NA>         2 (8%)       
      80 <NA>         <NA>         <NA>         
      81 <NA>         <NA>         <NA>         
      82 <NA>         1 (4%)       1 (4%)       
    Code
      ctl = tm$enrolres %>% filter(arm == "Control") %>% pull(subjid)
      x = tm$ae %>% filter(aesoc == "Cardiac disorders" | !subjid %in% ctl) %>% ae_table_soc(df_enrol = tm$enrolres, arm = "ARM")

