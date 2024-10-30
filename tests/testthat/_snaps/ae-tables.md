# ae_table_grade() works

    Code
      tm = grstat_example()
      attach(tm)
      ae_table_grade(ae, df_enrol = enrolres)
    Output
      # A tibble: 18 x 4
         .id           label                                   variable       `All patients`
         <fct>         <fct>                                   <fct>          <chr>         
       1 max_grade     "Patient maximum AE grade"              No declared AE 3 (6%)        
       2 max_grade     "Patient maximum AE grade"              Grade 1        4 (8%)        
       3 max_grade     "Patient maximum AE grade"              Grade 2        10 (20%)      
       4 max_grade     "Patient maximum AE grade"              Grade 3        18 (36%)      
       5 max_grade     "Patient maximum AE grade"              Grade 4        9 (18%)       
       6 max_grade     "Patient maximum AE grade"              Grade 5        6 (12%)       
       7 any_grade_sup "Patient had at least one AE of grade"  No declared AE 3 (6%)        
       8 any_grade_sup "Patient had at least one AE of grade"  Grade = 5      6 (12%)       
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1      47 (94%)      
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2      43 (86%)      
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3      33 (66%)      
      12 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4      15 (30%)      
      13 any_grade_eq  "Patient had at least one AE of grade " No declared AE 3 (6%)        
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1        28 (56%)      
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2        25 (50%)      
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3        27 (54%)      
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4        11 (22%)      
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5        6 (12%)       
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM")
    Output
      # A tibble: 18 x 6
         .id           label                                   variable       Ctl       Trt      Total   
         <fct>         <fct>                                   <fct>          <chr>     <chr>    <chr>   
       1 max_grade     "Patient maximum AE grade"              No declared AE 0 (0%)    3 (13%)  3 (6%)  
       2 max_grade     "Patient maximum AE grade"              Grade 1        3 (11%)   1 (4%)   4 (8%)  
       3 max_grade     "Patient maximum AE grade"              Grade 2        5 (19%)   5 (22%)  10 (20%)
       4 max_grade     "Patient maximum AE grade"              Grade 3        10 (37%)  8 (35%)  18 (36%)
       5 max_grade     "Patient maximum AE grade"              Grade 4        8 (30%)   1 (4%)   9 (18%) 
       6 max_grade     "Patient maximum AE grade"              Grade 5        1 (4%)    5 (22%)  6 (12%) 
       7 any_grade_sup "Patient had at least one AE of grade"  No declared AE 0 (0%)    3 (13%)  3 (6%)  
       8 any_grade_sup "Patient had at least one AE of grade"  Grade = 5      1 (4%)    5 (22%)  6 (12%) 
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1      27 (100%) 20 (87%) 47 (94%)
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2      24 (89%)  19 (83%) 43 (86%)
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3      19 (70%)  14 (61%) 33 (66%)
      12 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4      9 (33%)   6 (26%)  15 (30%)
      13 any_grade_eq  "Patient had at least one AE of grade " No declared AE 0 (0%)    3 (13%)  3 (6%)  
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1        15 (56%)  13 (57%) 28 (56%)
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2        17 (63%)  8 (35%)  25 (50%)
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3        14 (52%)  13 (57%) 27 (54%)
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4        8 (30%)   3 (13%)  11 (22%)
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5        1 (4%)    5 (22%)  6 (12%) 
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM", variant = c("eq", "max"))
    Output
      # A tibble: 12 x 6
         .id          label                                   variable       Ctl      Trt      Total   
         <fct>        <fct>                                   <fct>          <chr>    <chr>    <chr>   
       1 any_grade_eq "Patient had at least one AE of grade " No declared AE 0 (0%)   3 (13%)  3 (6%)  
       2 any_grade_eq "Patient had at least one AE of grade " Grade 1        15 (56%) 13 (57%) 28 (56%)
       3 any_grade_eq "Patient had at least one AE of grade " Grade 2        17 (63%) 8 (35%)  25 (50%)
       4 any_grade_eq "Patient had at least one AE of grade " Grade 3        14 (52%) 13 (57%) 27 (54%)
       5 any_grade_eq "Patient had at least one AE of grade " Grade 4        8 (30%)  3 (13%)  11 (22%)
       6 any_grade_eq "Patient had at least one AE of grade " Grade 5        1 (4%)   5 (22%)  6 (12%) 
       7 max_grade    "Patient maximum AE grade"              No declared AE 0 (0%)   3 (13%)  3 (6%)  
       8 max_grade    "Patient maximum AE grade"              Grade 1        3 (11%)  1 (4%)   4 (8%)  
       9 max_grade    "Patient maximum AE grade"              Grade 2        5 (19%)  5 (22%)  10 (20%)
      10 max_grade    "Patient maximum AE grade"              Grade 3        10 (37%) 8 (35%)  18 (36%)
      11 max_grade    "Patient maximum AE grade"              Grade 4        8 (30%)  1 (4%)   9 (18%) 
      12 max_grade    "Patient maximum AE grade"              Grade 5        1 (4%)   5 (22%)  6 (12%) 
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM", percent = FALSE, total = FALSE)
    Output
      # A tibble: 18 x 5
         .id           label                                   variable       Ctl   Trt  
         <fct>         <fct>                                   <fct>          <chr> <chr>
       1 max_grade     "Patient maximum AE grade"              No declared AE 0     3    
       2 max_grade     "Patient maximum AE grade"              Grade 1        3     1    
       3 max_grade     "Patient maximum AE grade"              Grade 2        5     5    
       4 max_grade     "Patient maximum AE grade"              Grade 3        10    8    
       5 max_grade     "Patient maximum AE grade"              Grade 4        8     1    
       6 max_grade     "Patient maximum AE grade"              Grade 5        1     5    
       7 any_grade_sup "Patient had at least one AE of grade"  No declared AE 0     3    
       8 any_grade_sup "Patient had at least one AE of grade"  Grade = 5      1     5    
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1      27    20   
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2      24    19   
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3      19    14   
      12 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4      9     6    
      13 any_grade_eq  "Patient had at least one AE of grade " No declared AE 0     3    
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1        15    13   
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2        17    8    
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3        14    13   
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4        8     3    
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5        1     5    

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
      # A tibble: 24 x 8
         soc                                                                 all_patients_G1 all_patients_G2 all_patients_G3
         <fct>                                                               <glue>          <glue>          <glue>         
       1 Injury, poisoning and procedural complications                      4 (8%)          1 (2%)          2 (4%)         
       2 Neoplasms benign, malignant and unspecified (incl cysts and polyps) 4 (8%)          1 (2%)          2 (4%)         
       3 Nervous system disorders                                            1 (2%)          1 (2%)          6 (12%)        
       4 Eye disorders                                                       3 (6%)          1 (2%)          2 (4%)         
       5 Hepatobiliary disorders                                             2 (4%)          3 (6%)          1 (2%)         
       6 Infections and infestations                                         2 (4%)          2 (4%)          2 (4%)         
       7 Skin and subcutaneous tissue disorders                              <NA>            2 (4%)          3 (6%)         
       8 Ear and labyrinth disorders                                         2 (4%)          1 (2%)          1 (2%)         
       9 Reproductive system and breast disorders                            2 (4%)          4 (8%)          <NA>           
      10 Respiratory, thoracic and mediastinal disorders                     2 (4%)          <NA>            3 (6%)         
      11 Blood and lymphatic system disorders                                3 (6%)          1 (2%)          <NA>           
      12 Cardiac disorders                                                   1 (2%)          2 (4%)          1 (2%)         
      13 Gastrointestinal disorders                                          <NA>            3 (6%)          1 (2%)         
      14 General disorders and administration site conditions                3 (6%)          1 (2%)          1 (2%)         
      15 Investigations                                                      2 (4%)          2 (4%)          <NA>           
      16 Musculoskeletal and connective tissue disorders                     3 (6%)          2 (4%)          <NA>           
      17 Psychiatric disorders                                               2 (4%)          1 (2%)          2 (4%)         
      18 Surgical and medical procedures                                     3 (6%)          1 (2%)          1 (2%)         
      19 Vascular disorders                                                  <NA>            2 (4%)          2 (4%)         
      20 Endocrine disorders                                                 <NA>            3 (6%)          <NA>           
      21 Immune system disorders                                             1 (2%)          <NA>            1 (2%)         
      22 Renal and urinary disorders                                         <NA>            1 (2%)          1 (2%)         
      23 Metabolism and nutrition disorders                                  <NA>            1 (2%)          <NA>           
      24 No Declared AE                                                      <NA>            <NA>            <NA>           
         all_patients_G4 all_patients_G5 all_patients_NA all_patients_Tot
         <glue>          <glue>          <glue>          <glue>          
       1 1 (2%)          1 (2%)          <NA>            9 (18%)         
       2 <NA>            1 (2%)          <NA>            8 (16%)         
       3 <NA>            <NA>            <NA>            8 (16%)         
       4 1 (2%)          <NA>            <NA>            7 (14%)         
       5 1 (2%)          <NA>            <NA>            7 (14%)         
       6 <NA>            1 (2%)          <NA>            7 (14%)         
       7 2 (4%)          <NA>            <NA>            7 (14%)         
       8 2 (4%)          <NA>            <NA>            6 (12%)         
       9 <NA>            <NA>            <NA>            6 (12%)         
      10 1 (2%)          <NA>            <NA>            6 (12%)         
      11 1 (2%)          <NA>            <NA>            5 (10%)         
      12 1 (2%)          <NA>            <NA>            5 (10%)         
      13 <NA>            1 (2%)          <NA>            5 (10%)         
      14 <NA>            <NA>            <NA>            5 (10%)         
      15 1 (2%)          <NA>            <NA>            5 (10%)         
      16 <NA>            <NA>            <NA>            5 (10%)         
      17 <NA>            <NA>            <NA>            5 (10%)         
      18 <NA>            <NA>            <NA>            5 (10%)         
      19 <NA>            1 (2%)          <NA>            5 (10%)         
      20 1 (2%)          <NA>            <NA>            4 (8%)          
      21 1 (2%)          1 (2%)          <NA>            4 (8%)          
      22 1 (2%)          <NA>            <NA>            3 (6%)          
      23 <NA>            <NA>            <NA>            1 (2%)          
      24 <NA>            <NA>            3 (6%)          3 (6%)          
    Code
      ae_table_soc(ae, df_enrol = enrolres, sort_by_count = FALSE)
    Output
      # A tibble: 24 x 8
         soc                                                                 all_patients_G1 all_patients_G2 all_patients_G3
         <chr>                                                               <glue>          <glue>          <glue>         
       1 Blood and lymphatic system disorders                                3 (6%)          1 (2%)          <NA>           
       2 Cardiac disorders                                                   1 (2%)          2 (4%)          1 (2%)         
       3 Ear and labyrinth disorders                                         2 (4%)          1 (2%)          1 (2%)         
       4 Endocrine disorders                                                 <NA>            3 (6%)          <NA>           
       5 Eye disorders                                                       3 (6%)          1 (2%)          2 (4%)         
       6 Gastrointestinal disorders                                          <NA>            3 (6%)          1 (2%)         
       7 General disorders and administration site conditions                3 (6%)          1 (2%)          1 (2%)         
       8 Hepatobiliary disorders                                             2 (4%)          3 (6%)          1 (2%)         
       9 Immune system disorders                                             1 (2%)          <NA>            1 (2%)         
      10 Infections and infestations                                         2 (4%)          2 (4%)          2 (4%)         
      11 Injury, poisoning and procedural complications                      4 (8%)          1 (2%)          2 (4%)         
      12 Investigations                                                      2 (4%)          2 (4%)          <NA>           
      13 Metabolism and nutrition disorders                                  <NA>            1 (2%)          <NA>           
      14 Musculoskeletal and connective tissue disorders                     3 (6%)          2 (4%)          <NA>           
      15 Neoplasms benign, malignant and unspecified (incl cysts and polyps) 4 (8%)          1 (2%)          2 (4%)         
      16 Nervous system disorders                                            1 (2%)          1 (2%)          6 (12%)        
      17 No Declared AE                                                      <NA>            <NA>            <NA>           
      18 Psychiatric disorders                                               2 (4%)          1 (2%)          2 (4%)         
      19 Renal and urinary disorders                                         <NA>            1 (2%)          1 (2%)         
      20 Reproductive system and breast disorders                            2 (4%)          4 (8%)          <NA>           
      21 Respiratory, thoracic and mediastinal disorders                     2 (4%)          <NA>            3 (6%)         
      22 Skin and subcutaneous tissue disorders                              <NA>            2 (4%)          3 (6%)         
      23 Surgical and medical procedures                                     3 (6%)          1 (2%)          1 (2%)         
      24 Vascular disorders                                                  <NA>            2 (4%)          2 (4%)         
         all_patients_G4 all_patients_G5 all_patients_NA all_patients_Tot
         <glue>          <glue>          <glue>          <glue>          
       1 1 (2%)          <NA>            <NA>            5 (10%)         
       2 1 (2%)          <NA>            <NA>            5 (10%)         
       3 2 (4%)          <NA>            <NA>            6 (12%)         
       4 1 (2%)          <NA>            <NA>            4 (8%)          
       5 1 (2%)          <NA>            <NA>            7 (14%)         
       6 <NA>            1 (2%)          <NA>            5 (10%)         
       7 <NA>            <NA>            <NA>            5 (10%)         
       8 1 (2%)          <NA>            <NA>            7 (14%)         
       9 1 (2%)          1 (2%)          <NA>            4 (8%)          
      10 <NA>            1 (2%)          <NA>            7 (14%)         
      11 1 (2%)          1 (2%)          <NA>            9 (18%)         
      12 1 (2%)          <NA>            <NA>            5 (10%)         
      13 <NA>            <NA>            <NA>            1 (2%)          
      14 <NA>            <NA>            <NA>            5 (10%)         
      15 <NA>            1 (2%)          <NA>            8 (16%)         
      16 <NA>            <NA>            <NA>            8 (16%)         
      17 <NA>            <NA>            3 (6%)          3 (6%)          
      18 <NA>            <NA>            <NA>            5 (10%)         
      19 1 (2%)          <NA>            <NA>            3 (6%)          
      20 <NA>            <NA>            <NA>            6 (12%)         
      21 1 (2%)          <NA>            <NA>            6 (12%)         
      22 2 (4%)          <NA>            <NA>            7 (14%)         
      23 <NA>            <NA>            <NA>            5 (10%)         
      24 <NA>            1 (2%)          <NA>            5 (10%)         
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", digits = 1)
    Output
      # A tibble: 24 x 15
         soc                                                                 ctl_G1    ctl_G2    ctl_G3    ctl_G4   ctl_G5   ctl_NA
         <fct>                                                               <glue>    <glue>    <glue>    <glue>   <glue>   <glue>
       1 Injury, poisoning and procedural complications                      1 (3.7%)  <NA>      1 (3.7%)  1 (3.7%) <NA>     <NA>  
       2 Neoplasms benign, malignant and unspecified (incl cysts and polyps) 2 (7.4%)  1 (3.7%)  <NA>      <NA>     <NA>     <NA>  
       3 Nervous system disorders                                            1 (3.7%)  1 (3.7%)  3 (11.1%) <NA>     <NA>     <NA>  
       4 Eye disorders                                                       2 (7.4%)  <NA>      2 (7.4%)  1 (3.7%) <NA>     <NA>  
       5 Hepatobiliary disorders                                             <NA>      2 (7.4%)  <NA>      1 (3.7%) <NA>     <NA>  
       6 Infections and infestations                                         2 (7.4%)  2 (7.4%)  1 (3.7%)  <NA>     <NA>     <NA>  
       7 Skin and subcutaneous tissue disorders                              <NA>      <NA>      1 (3.7%)  1 (3.7%) <NA>     <NA>  
       8 Ear and labyrinth disorders                                         1 (3.7%)  <NA>      <NA>      <NA>     <NA>     <NA>  
       9 Reproductive system and breast disorders                            2 (7.4%)  4 (14.8%) <NA>      <NA>     <NA>     <NA>  
      10 Respiratory, thoracic and mediastinal disorders                     2 (7.4%)  <NA>      1 (3.7%)  1 (3.7%) <NA>     <NA>  
      11 Blood and lymphatic system disorders                                2 (7.4%)  1 (3.7%)  <NA>      <NA>     <NA>     <NA>  
      12 Cardiac disorders                                                   1 (3.7%)  1 (3.7%)  1 (3.7%)  1 (3.7%) <NA>     <NA>  
      13 Gastrointestinal disorders                                          <NA>      2 (7.4%)  1 (3.7%)  <NA>     1 (3.7%) <NA>  
      14 General disorders and administration site conditions                3 (11.1%) <NA>      1 (3.7%)  <NA>     <NA>     <NA>  
      15 Investigations                                                      1 (3.7%)  1 (3.7%)  <NA>      1 (3.7%) <NA>     <NA>  
      16 Musculoskeletal and connective tissue disorders                     1 (3.7%)  1 (3.7%)  <NA>      <NA>     <NA>     <NA>  
      17 Psychiatric disorders                                               1 (3.7%)  1 (3.7%)  1 (3.7%)  <NA>     <NA>     <NA>  
      18 Surgical and medical procedures                                     1 (3.7%)  1 (3.7%)  <NA>      <NA>     <NA>     <NA>  
      19 Vascular disorders                                                  <NA>      1 (3.7%)  2 (7.4%)  <NA>     <NA>     <NA>  
      20 Endocrine disorders                                                 <NA>      3 (11.1%) <NA>      1 (3.7%) <NA>     <NA>  
      21 Immune system disorders                                             1 (3.7%)  <NA>      1 (3.7%)  1 (3.7%) <NA>     <NA>  
      22 Renal and urinary disorders                                         <NA>      1 (3.7%)  1 (3.7%)  1 (3.7%) <NA>     <NA>  
      23 Metabolism and nutrition disorders                                  <NA>      1 (3.7%)  <NA>      <NA>     <NA>     <NA>  
      24 No Declared AE                                                      <NA>      <NA>      <NA>      <NA>     <NA>     <NA>  
         ctl_Tot   trt_G1   trt_G2   trt_G3   trt_G4   trt_G5   trt_NA  trt_Tot  
         <glue>    <glue>   <glue>   <glue>   <glue>   <glue>   <glue>  <glue>   
       1 3 (11.1%) 3 (13%)  1 (4.3%) 1 (4.3%) <NA>     1 (4.3%) <NA>    6 (26.1%)
       2 3 (11.1%) 2 (8.7%) <NA>     2 (8.7%) <NA>     1 (4.3%) <NA>    5 (21.7%)
       3 5 (18.5%) <NA>     <NA>     3 (13%)  <NA>     <NA>     <NA>    3 (13%)  
       4 5 (18.5%) 1 (4.3%) 1 (4.3%) <NA>     <NA>     <NA>     <NA>    2 (8.7%) 
       5 3 (11.1%) 2 (8.7%) 1 (4.3%) 1 (4.3%) <NA>     <NA>     <NA>    4 (17.4%)
       6 5 (18.5%) <NA>     <NA>     1 (4.3%) <NA>     1 (4.3%) <NA>    2 (8.7%) 
       7 2 (7.4%)  <NA>     2 (8.7%) 2 (8.7%) 1 (4.3%) <NA>     <NA>    5 (21.7%)
       8 1 (3.7%)  1 (4.3%) 1 (4.3%) 1 (4.3%) 2 (8.7%) <NA>     <NA>    5 (21.7%)
       9 6 (22.2%) <NA>     <NA>     <NA>     <NA>     <NA>     <NA>    <NA>     
      10 4 (14.8%) <NA>     <NA>     2 (8.7%) <NA>     <NA>     <NA>    2 (8.7%) 
      11 3 (11.1%) 1 (4.3%) <NA>     <NA>     1 (4.3%) <NA>     <NA>    2 (8.7%) 
      12 4 (14.8%) <NA>     1 (4.3%) <NA>     <NA>     <NA>     <NA>    1 (4.3%) 
      13 4 (14.8%) <NA>     1 (4.3%) <NA>     <NA>     <NA>     <NA>    1 (4.3%) 
      14 4 (14.8%) <NA>     1 (4.3%) <NA>     <NA>     <NA>     <NA>    1 (4.3%) 
      15 3 (11.1%) 1 (4.3%) 1 (4.3%) <NA>     <NA>     <NA>     <NA>    2 (8.7%) 
      16 2 (7.4%)  2 (8.7%) 1 (4.3%) <NA>     <NA>     <NA>     <NA>    3 (13%)  
      17 3 (11.1%) 1 (4.3%) <NA>     1 (4.3%) <NA>     <NA>     <NA>    2 (8.7%) 
      18 2 (7.4%)  2 (8.7%) <NA>     1 (4.3%) <NA>     <NA>     <NA>    3 (13%)  
      19 3 (11.1%) <NA>     1 (4.3%) <NA>     <NA>     1 (4.3%) <NA>    2 (8.7%) 
      20 4 (14.8%) <NA>     <NA>     <NA>     <NA>     <NA>     <NA>    <NA>     
      21 3 (11.1%) <NA>     <NA>     <NA>     <NA>     1 (4.3%) <NA>    1 (4.3%) 
      22 3 (11.1%) <NA>     <NA>     <NA>     <NA>     <NA>     <NA>    <NA>     
      23 1 (3.7%)  <NA>     <NA>     <NA>     <NA>     <NA>     <NA>    <NA>     
      24 <NA>      <NA>     <NA>     <NA>     <NA>     <NA>     3 (13%) 3 (13%)  
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", showNA = FALSE, total = FALSE)
    Output
      # A tibble: 24 x 11
         soc                                                                 ctl_G1  ctl_G2  ctl_G3  ctl_G4 ctl_G5 trt_G1  trt_G2
         <fct>                                                               <glue>  <glue>  <glue>  <glue> <glue> <glue>  <glue>
       1 Injury, poisoning and procedural complications                      1 (4%)  <NA>    1 (4%)  1 (4%) <NA>   3 (13%) 1 (4%)
       2 Neoplasms benign, malignant and unspecified (incl cysts and polyps) 2 (7%)  1 (4%)  <NA>    <NA>   <NA>   2 (9%)  <NA>  
       3 Nervous system disorders                                            1 (4%)  1 (4%)  3 (11%) <NA>   <NA>   <NA>    <NA>  
       4 Eye disorders                                                       2 (7%)  <NA>    2 (7%)  1 (4%) <NA>   1 (4%)  1 (4%)
       5 Hepatobiliary disorders                                             <NA>    2 (7%)  <NA>    1 (4%) <NA>   2 (9%)  1 (4%)
       6 Infections and infestations                                         2 (7%)  2 (7%)  1 (4%)  <NA>   <NA>   <NA>    <NA>  
       7 Skin and subcutaneous tissue disorders                              <NA>    <NA>    1 (4%)  1 (4%) <NA>   <NA>    2 (9%)
       8 Ear and labyrinth disorders                                         1 (4%)  <NA>    <NA>    <NA>   <NA>   1 (4%)  1 (4%)
       9 Reproductive system and breast disorders                            2 (7%)  4 (15%) <NA>    <NA>   <NA>   <NA>    <NA>  
      10 Respiratory, thoracic and mediastinal disorders                     2 (7%)  <NA>    1 (4%)  1 (4%) <NA>   <NA>    <NA>  
      11 Blood and lymphatic system disorders                                2 (7%)  1 (4%)  <NA>    <NA>   <NA>   1 (4%)  <NA>  
      12 Cardiac disorders                                                   1 (4%)  1 (4%)  1 (4%)  1 (4%) <NA>   <NA>    1 (4%)
      13 Gastrointestinal disorders                                          <NA>    2 (7%)  1 (4%)  <NA>   1 (4%) <NA>    1 (4%)
      14 General disorders and administration site conditions                3 (11%) <NA>    1 (4%)  <NA>   <NA>   <NA>    1 (4%)
      15 Investigations                                                      1 (4%)  1 (4%)  <NA>    1 (4%) <NA>   1 (4%)  1 (4%)
      16 Musculoskeletal and connective tissue disorders                     1 (4%)  1 (4%)  <NA>    <NA>   <NA>   2 (9%)  1 (4%)
      17 Psychiatric disorders                                               1 (4%)  1 (4%)  1 (4%)  <NA>   <NA>   1 (4%)  <NA>  
      18 Surgical and medical procedures                                     1 (4%)  1 (4%)  <NA>    <NA>   <NA>   2 (9%)  <NA>  
      19 Vascular disorders                                                  <NA>    1 (4%)  2 (7%)  <NA>   <NA>   <NA>    1 (4%)
      20 Endocrine disorders                                                 <NA>    3 (11%) <NA>    1 (4%) <NA>   <NA>    <NA>  
      21 Immune system disorders                                             1 (4%)  <NA>    1 (4%)  1 (4%) <NA>   <NA>    <NA>  
      22 Renal and urinary disorders                                         <NA>    1 (4%)  1 (4%)  1 (4%) <NA>   <NA>    <NA>  
      23 Metabolism and nutrition disorders                                  <NA>    1 (4%)  <NA>    <NA>   <NA>   <NA>    <NA>  
      24 No Declared AE                                                      <NA>    <NA>    <NA>    <NA>   <NA>   <NA>    <NA>  
         trt_G3  trt_G4 trt_G5
         <glue>  <glue> <glue>
       1 1 (4%)  <NA>   1 (4%)
       2 2 (9%)  <NA>   1 (4%)
       3 3 (13%) <NA>   <NA>  
       4 <NA>    <NA>   <NA>  
       5 1 (4%)  <NA>   <NA>  
       6 1 (4%)  <NA>   1 (4%)
       7 2 (9%)  1 (4%) <NA>  
       8 1 (4%)  2 (9%) <NA>  
       9 <NA>    <NA>   <NA>  
      10 2 (9%)  <NA>   <NA>  
      11 <NA>    1 (4%) <NA>  
      12 <NA>    <NA>   <NA>  
      13 <NA>    <NA>   <NA>  
      14 <NA>    <NA>   <NA>  
      15 <NA>    <NA>   <NA>  
      16 <NA>    <NA>   <NA>  
      17 1 (4%)  <NA>   <NA>  
      18 1 (4%)  <NA>   <NA>  
      19 <NA>    <NA>   1 (4%)
      20 <NA>    <NA>   <NA>  
      21 <NA>    <NA>   1 (4%)
      22 <NA>    <NA>   <NA>  
      23 <NA>    <NA>   <NA>  
      24 <NA>    <NA>   <NA>  
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", variant = "sup")
    Condition
      Warning:
      Total has been set to `FALSE` as totals are not very interpretable when `variant` is "sup" or "eq". Set `total=TRUE` explicitly to silence this warning.
    Output
      # A tibble: 24 x 13
         soc                                                                 ctl_G1  ctl_G2  ctl_G3  ctl_G4 ctl_G5 ctl_NA trt_G1 
         <fct>                                                               <glue>  <glue>  <glue>  <glue> <glue> <glue> <glue> 
       1 Injury, poisoning and procedural complications                      3 (11%) 2 (7%)  2 (7%)  1 (4%) <NA>   <NA>   6 (26%)
       2 Nervous system disorders                                            5 (19%) 4 (15%) 3 (11%) <NA>   <NA>   <NA>   3 (13%)
       3 Skin and subcutaneous tissue disorders                              2 (7%)  2 (7%)  2 (7%)  1 (4%) <NA>   <NA>   5 (22%)
       4 Infections and infestations                                         5 (19%) 3 (11%) 1 (4%)  <NA>   <NA>   <NA>   2 (9%) 
       5 Neoplasms benign, malignant and unspecified (incl cysts and polyps) 3 (11%) 1 (4%)  <NA>    <NA>   <NA>   <NA>   5 (22%)
       6 Ear and labyrinth disorders                                         1 (4%)  <NA>    <NA>    <NA>   <NA>   <NA>   5 (22%)
       7 Eye disorders                                                       5 (19%) 3 (11%) 3 (11%) 1 (4%) <NA>   <NA>   2 (9%) 
       8 Hepatobiliary disorders                                             3 (11%) 3 (11%) 1 (4%)  1 (4%) <NA>   <NA>   4 (17%)
       9 Respiratory, thoracic and mediastinal disorders                     4 (15%) 2 (7%)  2 (7%)  1 (4%) <NA>   <NA>   2 (9%) 
      10 Vascular disorders                                                  3 (11%) 3 (11%) 2 (7%)  <NA>   <NA>   <NA>   2 (9%) 
      11 Gastrointestinal disorders                                          4 (15%) 4 (15%) 2 (7%)  1 (4%) 1 (4%) <NA>   1 (4%) 
      12 Immune system disorders                                             3 (11%) 2 (7%)  2 (7%)  1 (4%) <NA>   <NA>   1 (4%) 
      13 Cardiac disorders                                                   4 (15%) 3 (11%) 2 (7%)  1 (4%) <NA>   <NA>   1 (4%) 
      14 Endocrine disorders                                                 4 (15%) 4 (15%) 1 (4%)  1 (4%) <NA>   <NA>   <NA>   
      15 Investigations                                                      3 (11%) 2 (7%)  1 (4%)  1 (4%) <NA>   <NA>   2 (9%) 
      16 Psychiatric disorders                                               3 (11%) 2 (7%)  1 (4%)  <NA>   <NA>   <NA>   2 (9%) 
      17 Reproductive system and breast disorders                            6 (22%) 4 (15%) <NA>    <NA>   <NA>   <NA>   <NA>   
      18 Blood and lymphatic system disorders                                3 (11%) 1 (4%)  <NA>    <NA>   <NA>   <NA>   2 (9%) 
      19 Renal and urinary disorders                                         3 (11%) 3 (11%) 2 (7%)  1 (4%) <NA>   <NA>   <NA>   
      20 General disorders and administration site conditions                4 (15%) 1 (4%)  1 (4%)  <NA>   <NA>   <NA>   1 (4%) 
      21 Surgical and medical procedures                                     2 (7%)  1 (4%)  <NA>    <NA>   <NA>   <NA>   3 (13%)
      22 Musculoskeletal and connective tissue disorders                     2 (7%)  1 (4%)  <NA>    <NA>   <NA>   <NA>   3 (13%)
      23 Metabolism and nutrition disorders                                  1 (4%)  1 (4%)  <NA>    <NA>   <NA>   <NA>   <NA>   
      24 No Declared AE                                                      <NA>    <NA>    <NA>    <NA>   <NA>   <NA>   <NA>   
         trt_G2  trt_G3  trt_G4 trt_G5 trt_NA
         <glue>  <glue>  <glue> <glue> <glue>
       1 3 (13%) 2 (9%)  1 (4%) 1 (4%) <NA>  
       2 3 (13%) 3 (13%) <NA>   <NA>   <NA>  
       3 5 (22%) 3 (13%) 1 (4%) <NA>   <NA>  
       4 2 (9%)  2 (9%)  1 (4%) 1 (4%) <NA>  
       5 3 (13%) 3 (13%) 1 (4%) 1 (4%) <NA>  
       6 4 (17%) 3 (13%) 2 (9%) <NA>   <NA>  
       7 1 (4%)  <NA>    <NA>   <NA>   <NA>  
       8 2 (9%)  1 (4%)  <NA>   <NA>   <NA>  
       9 2 (9%)  2 (9%)  <NA>   <NA>   <NA>  
      10 2 (9%)  1 (4%)  1 (4%) 1 (4%) <NA>  
      11 1 (4%)  <NA>    <NA>   <NA>   <NA>  
      12 1 (4%)  1 (4%)  1 (4%) 1 (4%) <NA>  
      13 1 (4%)  <NA>    <NA>   <NA>   <NA>  
      14 <NA>    <NA>    <NA>   <NA>   <NA>  
      15 1 (4%)  <NA>    <NA>   <NA>   <NA>  
      16 1 (4%)  1 (4%)  <NA>   <NA>   <NA>  
      17 <NA>    <NA>    <NA>   <NA>   <NA>  
      18 1 (4%)  1 (4%)  1 (4%) <NA>   <NA>  
      19 <NA>    <NA>    <NA>   <NA>   <NA>  
      20 1 (4%)  <NA>    <NA>   <NA>   <NA>  
      21 1 (4%)  1 (4%)  <NA>   <NA>   <NA>  
      22 1 (4%)  <NA>    <NA>   <NA>   <NA>  
      23 <NA>    <NA>    <NA>   <NA>   <NA>  
      24 <NA>    <NA>    <NA>   <NA>   <NA>  
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", variant = "eq")
    Condition
      Warning:
      Total has been set to `FALSE` as totals are not very interpretable when `variant` is "sup" or "eq". Set `total=TRUE` explicitly to silence this warning.
    Output
      # A tibble: 24 x 13
         soc                                                                 ctl_G1  ctl_G2  ctl_G3  ctl_G4 ctl_G5 ctl_NA trt_G1 
         <fct>                                                               <glue>  <glue>  <glue>  <glue> <glue> <glue> <glue> 
       1 Injury, poisoning and procedural complications                      1 (4%)  1 (4%)  1 (4%)  1 (4%) <NA>   <NA>   3 (13%)
       2 Neoplasms benign, malignant and unspecified (incl cysts and polyps) 2 (7%)  1 (4%)  <NA>    <NA>   <NA>   <NA>   3 (13%)
       3 Eye disorders                                                       2 (7%)  1 (4%)  2 (7%)  1 (4%) <NA>   <NA>   1 (4%) 
       4 Hepatobiliary disorders                                             <NA>    2 (7%)  <NA>    1 (4%) <NA>   <NA>   3 (13%)
       5 Nervous system disorders                                            1 (4%)  1 (4%)  3 (11%) <NA>   <NA>   <NA>   <NA>   
       6 Skin and subcutaneous tissue disorders                              <NA>    <NA>    2 (7%)  1 (4%) <NA>   <NA>   <NA>   
       7 Infections and infestations                                         2 (7%)  2 (7%)  1 (4%)  <NA>   <NA>   <NA>   <NA>   
       8 Ear and labyrinth disorders                                         1 (4%)  <NA>    <NA>    <NA>   <NA>   <NA>   1 (4%) 
       9 Gastrointestinal disorders                                          1 (4%)  2 (7%)  1 (4%)  <NA>   1 (4%) <NA>   <NA>   
      10 Reproductive system and breast disorders                            2 (7%)  4 (15%) <NA>    <NA>   <NA>   <NA>   <NA>   
      11 Respiratory, thoracic and mediastinal disorders                     2 (7%)  <NA>    1 (4%)  1 (4%) <NA>   <NA>   <NA>   
      12 Blood and lymphatic system disorders                                2 (7%)  1 (4%)  <NA>    <NA>   <NA>   <NA>   1 (4%) 
      13 Cardiac disorders                                                   1 (4%)  1 (4%)  1 (4%)  1 (4%) <NA>   <NA>   <NA>   
      14 General disorders and administration site conditions                3 (11%) <NA>    1 (4%)  <NA>   <NA>   <NA>   <NA>   
      15 Investigations                                                      1 (4%)  1 (4%)  <NA>    1 (4%) <NA>   <NA>   1 (4%) 
      16 Musculoskeletal and connective tissue disorders                     1 (4%)  1 (4%)  <NA>    <NA>   <NA>   <NA>   2 (9%) 
      17 Psychiatric disorders                                               1 (4%)  1 (4%)  1 (4%)  <NA>   <NA>   <NA>   1 (4%) 
      18 Surgical and medical procedures                                     1 (4%)  1 (4%)  <NA>    <NA>   <NA>   <NA>   2 (9%) 
      19 Vascular disorders                                                  <NA>    1 (4%)  2 (7%)  <NA>   <NA>   <NA>   <NA>   
      20 Endocrine disorders                                                 <NA>    3 (11%) <NA>    1 (4%) <NA>   <NA>   <NA>   
      21 Immune system disorders                                             1 (4%)  <NA>    1 (4%)  1 (4%) <NA>   <NA>   <NA>   
      22 Renal and urinary disorders                                         <NA>    1 (4%)  1 (4%)  1 (4%) <NA>   <NA>   <NA>   
      23 Metabolism and nutrition disorders                                  <NA>    1 (4%)  <NA>    <NA>   <NA>   <NA>   <NA>   
      24 No Declared AE                                                      <NA>    <NA>    <NA>    <NA>   <NA>   <NA>   <NA>   
         trt_G2 trt_G3  trt_G4 trt_G5 trt_NA
         <glue> <glue>  <glue> <glue> <glue>
       1 1 (4%) 1 (4%)  <NA>   1 (4%) <NA>  
       2 <NA>   2 (9%)  <NA>   1 (4%) <NA>  
       3 1 (4%) <NA>    <NA>   <NA>   <NA>  
       4 1 (4%) 1 (4%)  <NA>   <NA>   <NA>  
       5 <NA>   3 (13%) <NA>   <NA>   <NA>  
       6 2 (9%) 2 (9%)  1 (4%) <NA>   <NA>  
       7 <NA>   1 (4%)  <NA>   1 (4%) <NA>  
       8 1 (4%) 1 (4%)  2 (9%) <NA>   <NA>  
       9 1 (4%) <NA>    <NA>   <NA>   <NA>  
      10 <NA>   <NA>    <NA>   <NA>   <NA>  
      11 <NA>   2 (9%)  <NA>   <NA>   <NA>  
      12 <NA>   <NA>    1 (4%) <NA>   <NA>  
      13 1 (4%) <NA>    <NA>   <NA>   <NA>  
      14 1 (4%) <NA>    <NA>   <NA>   <NA>  
      15 1 (4%) <NA>    <NA>   <NA>   <NA>  
      16 1 (4%) <NA>    <NA>   <NA>   <NA>  
      17 <NA>   1 (4%)  <NA>   <NA>   <NA>  
      18 <NA>   1 (4%)  <NA>   <NA>   <NA>  
      19 1 (4%) <NA>    <NA>   1 (4%) <NA>  
      20 <NA>   <NA>    <NA>   <NA>   <NA>  
      21 <NA>   <NA>    <NA>   1 (4%) <NA>  
      22 <NA>   <NA>    <NA>   <NA>   <NA>  
      23 <NA>   <NA>    <NA>   <NA>   <NA>  
      24 <NA>   <NA>    <NA>   <NA>   <NA>  

