# ae_table_grade() works

    Code
      tm = grstat_example()
      attach(tm)
      ae_table_grade(ae, df_enrol = enrolres)
    Output
      # A tibble: 18 x 4
         .id           label                                   variable `All patients`
         <fct>         <fct>                                   <fct>    <chr>         
       1 max_grade     "Patient maximum AE grade"              No decl~ 3 (6%)        
       2 max_grade     "Patient maximum AE grade"              Grade 1  4 (8%)        
       3 max_grade     "Patient maximum AE grade"              Grade 2  10 (20%)      
       4 max_grade     "Patient maximum AE grade"              Grade 3  18 (36%)      
       5 max_grade     "Patient maximum AE grade"              Grade 4  9 (18%)       
       6 max_grade     "Patient maximum AE grade"              Grade 5  6 (12%)       
       7 any_grade_sup "Patient had at least one AE of grade"  No decl~ 3 (6%)        
       8 any_grade_sup "Patient had at least one AE of grade"  Grade =~ 6 (12%)       
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥~ 47 (94%)      
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥~ 43 (86%)      
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥~ 33 (66%)      
      12 any_grade_sup "Patient had at least one AE of grade"  Grade ≥~ 15 (30%)      
      13 any_grade_eq  "Patient had at least one AE of grade " No decl~ 3 (6%)        
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1  28 (56%)      
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2  25 (50%)      
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3  27 (54%)      
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4  11 (22%)      
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5  6 (12%)       
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM")
    Output
      # A tibble: 18 x 6
         .id           label                                variable Ctl   Trt   Total
         <fct>         <fct>                                <fct>    <chr> <chr> <chr>
       1 max_grade     "Patient maximum AE grade"           No decl~ 0 (0~ 3 (1~ 3 (6~
       2 max_grade     "Patient maximum AE grade"           Grade 1  3 (1~ 1 (4~ 4 (8~
       3 max_grade     "Patient maximum AE grade"           Grade 2  5 (1~ 5 (2~ 10 (~
       4 max_grade     "Patient maximum AE grade"           Grade 3  10 (~ 8 (3~ 18 (~
       5 max_grade     "Patient maximum AE grade"           Grade 4  8 (3~ 1 (4~ 9 (1~
       6 max_grade     "Patient maximum AE grade"           Grade 5  1 (4~ 5 (2~ 6 (1~
       7 any_grade_sup "Patient had at least one AE of gra~ No decl~ 0 (0~ 3 (1~ 3 (6~
       8 any_grade_sup "Patient had at least one AE of gra~ Grade =~ 1 (4~ 5 (2~ 6 (1~
       9 any_grade_sup "Patient had at least one AE of gra~ Grade ≥~ 27 (~ 20 (~ 47 (~
      10 any_grade_sup "Patient had at least one AE of gra~ Grade ≥~ 24 (~ 19 (~ 43 (~
      11 any_grade_sup "Patient had at least one AE of gra~ Grade ≥~ 19 (~ 14 (~ 33 (~
      12 any_grade_sup "Patient had at least one AE of gra~ Grade ≥~ 9 (3~ 6 (2~ 15 (~
      13 any_grade_eq  "Patient had at least one AE of gra~ No decl~ 0 (0~ 3 (1~ 3 (6~
      14 any_grade_eq  "Patient had at least one AE of gra~ Grade 1  15 (~ 13 (~ 28 (~
      15 any_grade_eq  "Patient had at least one AE of gra~ Grade 2  17 (~ 8 (3~ 25 (~
      16 any_grade_eq  "Patient had at least one AE of gra~ Grade 3  14 (~ 13 (~ 27 (~
      17 any_grade_eq  "Patient had at least one AE of gra~ Grade 4  8 (3~ 3 (1~ 11 (~
      18 any_grade_eq  "Patient had at least one AE of gra~ Grade 5  1 (4~ 5 (2~ 6 (1~
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM", variant = c("eq", "max"))
    Output
      # A tibble: 12 x 6
         .id          label                                 variable Ctl   Trt   Total
         <fct>        <fct>                                 <fct>    <chr> <chr> <chr>
       1 any_grade_eq "Patient had at least one AE of grad~ No decl~ 0 (0~ 3 (1~ 3 (6~
       2 any_grade_eq "Patient had at least one AE of grad~ Grade 1  15 (~ 13 (~ 28 (~
       3 any_grade_eq "Patient had at least one AE of grad~ Grade 2  17 (~ 8 (3~ 25 (~
       4 any_grade_eq "Patient had at least one AE of grad~ Grade 3  14 (~ 13 (~ 27 (~
       5 any_grade_eq "Patient had at least one AE of grad~ Grade 4  8 (3~ 3 (1~ 11 (~
       6 any_grade_eq "Patient had at least one AE of grad~ Grade 5  1 (4~ 5 (2~ 6 (1~
       7 max_grade    "Patient maximum AE grade"            No decl~ 0 (0~ 3 (1~ 3 (6~
       8 max_grade    "Patient maximum AE grade"            Grade 1  3 (1~ 1 (4~ 4 (8~
       9 max_grade    "Patient maximum AE grade"            Grade 2  5 (1~ 5 (2~ 10 (~
      10 max_grade    "Patient maximum AE grade"            Grade 3  10 (~ 8 (3~ 18 (~
      11 max_grade    "Patient maximum AE grade"            Grade 4  8 (3~ 1 (4~ 9 (1~
      12 max_grade    "Patient maximum AE grade"            Grade 5  1 (4~ 5 (2~ 6 (1~
    Code
      ae_table_grade(ae, df_enrol = enrolres, arm = "ARM", percent = FALSE, total = FALSE)
    Output
      # A tibble: 18 x 5
         .id           label                                   variable    Ctl   Trt  
         <fct>         <fct>                                   <fct>       <chr> <chr>
       1 max_grade     "Patient maximum AE grade"              No declare~ 0     3    
       2 max_grade     "Patient maximum AE grade"              Grade 1     3     1    
       3 max_grade     "Patient maximum AE grade"              Grade 2     5     5    
       4 max_grade     "Patient maximum AE grade"              Grade 3     10    8    
       5 max_grade     "Patient maximum AE grade"              Grade 4     8     1    
       6 max_grade     "Patient maximum AE grade"              Grade 5     1     5    
       7 any_grade_sup "Patient had at least one AE of grade"  No declare~ 0     3    
       8 any_grade_sup "Patient had at least one AE of grade"  Grade = 5   1     5    
       9 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 1   27    20   
      10 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 2   24    19   
      11 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 3   19    14   
      12 any_grade_sup "Patient had at least one AE of grade"  Grade ≥ 4   9     6    
      13 any_grade_eq  "Patient had at least one AE of grade " No declare~ 0     3    
      14 any_grade_eq  "Patient had at least one AE of grade " Grade 1     15    13   
      15 any_grade_eq  "Patient had at least one AE of grade " Grade 2     17    8    
      16 any_grade_eq  "Patient had at least one AE of grade " Grade 3     14    13   
      17 any_grade_eq  "Patient had at least one AE of grade " Grade 4     8     3    
      18 any_grade_eq  "Patient had at least one AE of grade " Grade 5     1     5    

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
         soc           all_patients_G1 all_patients_G2 all_patients_G3 all_patients_G4
         <fct>         <glue>          <glue>          <glue>          <glue>         
       1 Injury, pois~ 4 (8%)          1 (2%)          2 (4%)          1 (2%)         
       2 Neoplasms be~ 4 (8%)          1 (2%)          2 (4%)          <NA>           
       3 Nervous syst~ 1 (2%)          1 (2%)          6 (12%)         <NA>           
       4 Eye disorders 3 (6%)          1 (2%)          2 (4%)          1 (2%)         
       5 Hepatobiliar~ 2 (4%)          3 (6%)          1 (2%)          1 (2%)         
       6 Infections a~ 2 (4%)          2 (4%)          2 (4%)          <NA>           
       7 Skin and sub~ <NA>            2 (4%)          3 (6%)          2 (4%)         
       8 Ear and laby~ 2 (4%)          1 (2%)          1 (2%)          2 (4%)         
       9 Reproductive~ 2 (4%)          4 (8%)          <NA>            <NA>           
      10 Respiratory,~ 2 (4%)          <NA>            3 (6%)          1 (2%)         
      11 Blood and ly~ 3 (6%)          1 (2%)          <NA>            1 (2%)         
      12 Cardiac diso~ 1 (2%)          2 (4%)          1 (2%)          1 (2%)         
      13 Gastrointest~ <NA>            3 (6%)          1 (2%)          <NA>           
      14 General diso~ 3 (6%)          1 (2%)          1 (2%)          <NA>           
      15 Investigatio~ 2 (4%)          2 (4%)          <NA>            1 (2%)         
      16 Musculoskele~ 3 (6%)          2 (4%)          <NA>            <NA>           
      17 Psychiatric ~ 2 (4%)          1 (2%)          2 (4%)          <NA>           
      18 Surgical and~ 3 (6%)          1 (2%)          1 (2%)          <NA>           
      19 Vascular dis~ <NA>            2 (4%)          2 (4%)          <NA>           
      20 Endocrine di~ <NA>            3 (6%)          <NA>            1 (2%)         
      21 Immune syste~ 1 (2%)          <NA>            1 (2%)          1 (2%)         
      22 Renal and ur~ <NA>            1 (2%)          1 (2%)          1 (2%)         
      23 Metabolism a~ <NA>            1 (2%)          <NA>            <NA>           
      24 No Declared ~ <NA>            <NA>            <NA>            <NA>           
    Code
      ae_table_soc(ae, df_enrol = enrolres, sort_by_count = FALSE)
    Output
      # A tibble: 24 x 8
         soc           all_patients_G1 all_patients_G2 all_patients_G3 all_patients_G4
         <chr>         <glue>          <glue>          <glue>          <glue>         
       1 Blood and ly~ 3 (6%)          1 (2%)          <NA>            1 (2%)         
       2 Cardiac diso~ 1 (2%)          2 (4%)          1 (2%)          1 (2%)         
       3 Ear and laby~ 2 (4%)          1 (2%)          1 (2%)          2 (4%)         
       4 Endocrine di~ <NA>            3 (6%)          <NA>            1 (2%)         
       5 Eye disorders 3 (6%)          1 (2%)          2 (4%)          1 (2%)         
       6 Gastrointest~ <NA>            3 (6%)          1 (2%)          <NA>           
       7 General diso~ 3 (6%)          1 (2%)          1 (2%)          <NA>           
       8 Hepatobiliar~ 2 (4%)          3 (6%)          1 (2%)          1 (2%)         
       9 Immune syste~ 1 (2%)          <NA>            1 (2%)          1 (2%)         
      10 Infections a~ 2 (4%)          2 (4%)          2 (4%)          <NA>           
      11 Injury, pois~ 4 (8%)          1 (2%)          2 (4%)          1 (2%)         
      12 Investigatio~ 2 (4%)          2 (4%)          <NA>            1 (2%)         
      13 Metabolism a~ <NA>            1 (2%)          <NA>            <NA>           
      14 Musculoskele~ 3 (6%)          2 (4%)          <NA>            <NA>           
      15 Neoplasms be~ 4 (8%)          1 (2%)          2 (4%)          <NA>           
      16 Nervous syst~ 1 (2%)          1 (2%)          6 (12%)         <NA>           
      17 No Declared ~ <NA>            <NA>            <NA>            <NA>           
      18 Psychiatric ~ 2 (4%)          1 (2%)          2 (4%)          <NA>           
      19 Renal and ur~ <NA>            1 (2%)          1 (2%)          1 (2%)         
      20 Reproductive~ 2 (4%)          4 (8%)          <NA>            <NA>           
      21 Respiratory,~ 2 (4%)          <NA>            3 (6%)          1 (2%)         
      22 Skin and sub~ <NA>            2 (4%)          3 (6%)          2 (4%)         
      23 Surgical and~ 3 (6%)          1 (2%)          1 (2%)          <NA>           
      24 Vascular dis~ <NA>            2 (4%)          2 (4%)          <NA>           
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", digits = 1)
    Output
      # A tibble: 24 x 15
         soc    ctl_G1 ctl_G2 ctl_G3 ctl_G4 ctl_G5 ctl_NA ctl_Tot trt_G1 trt_G2 trt_G3
         <fct>  <glue> <glue> <glue> <glue> <glue> <glue> <glue>  <glue> <glue> <glue>
       1 Injur~ 1 (3.~ <NA>   1 (3.~ 1 (3.~ <NA>   <NA>   3 (11.~ 3 (13~ 1 (4.~ 1 (4.~
       2 Neopl~ 2 (7.~ 1 (3.~ <NA>   <NA>   <NA>   <NA>   3 (11.~ 2 (8.~ <NA>   2 (8.~
       3 Nervo~ 1 (3.~ 1 (3.~ 3 (11~ <NA>   <NA>   <NA>   5 (18.~ <NA>   <NA>   3 (13~
       4 Eye d~ 2 (7.~ <NA>   2 (7.~ 1 (3.~ <NA>   <NA>   5 (18.~ 1 (4.~ 1 (4.~ <NA>  
       5 Hepat~ <NA>   2 (7.~ <NA>   1 (3.~ <NA>   <NA>   3 (11.~ 2 (8.~ 1 (4.~ 1 (4.~
       6 Infec~ 2 (7.~ 2 (7.~ 1 (3.~ <NA>   <NA>   <NA>   5 (18.~ <NA>   <NA>   1 (4.~
       7 Skin ~ <NA>   <NA>   1 (3.~ 1 (3.~ <NA>   <NA>   2 (7.4~ <NA>   2 (8.~ 2 (8.~
       8 Ear a~ 1 (3.~ <NA>   <NA>   <NA>   <NA>   <NA>   1 (3.7~ 1 (4.~ 1 (4.~ 1 (4.~
       9 Repro~ 2 (7.~ 4 (14~ <NA>   <NA>   <NA>   <NA>   6 (22.~ <NA>   <NA>   <NA>  
      10 Respi~ 2 (7.~ <NA>   1 (3.~ 1 (3.~ <NA>   <NA>   4 (14.~ <NA>   <NA>   2 (8.~
      11 Blood~ 2 (7.~ 1 (3.~ <NA>   <NA>   <NA>   <NA>   3 (11.~ 1 (4.~ <NA>   <NA>  
      12 Cardi~ 1 (3.~ 1 (3.~ 1 (3.~ 1 (3.~ <NA>   <NA>   4 (14.~ <NA>   1 (4.~ <NA>  
      13 Gastr~ <NA>   2 (7.~ 1 (3.~ <NA>   1 (3.~ <NA>   4 (14.~ <NA>   1 (4.~ <NA>  
      14 Gener~ 3 (11~ <NA>   1 (3.~ <NA>   <NA>   <NA>   4 (14.~ <NA>   1 (4.~ <NA>  
      15 Inves~ 1 (3.~ 1 (3.~ <NA>   1 (3.~ <NA>   <NA>   3 (11.~ 1 (4.~ 1 (4.~ <NA>  
      16 Muscu~ 1 (3.~ 1 (3.~ <NA>   <NA>   <NA>   <NA>   2 (7.4~ 2 (8.~ 1 (4.~ <NA>  
      17 Psych~ 1 (3.~ 1 (3.~ 1 (3.~ <NA>   <NA>   <NA>   3 (11.~ 1 (4.~ <NA>   1 (4.~
      18 Surgi~ 1 (3.~ 1 (3.~ <NA>   <NA>   <NA>   <NA>   2 (7.4~ 2 (8.~ <NA>   1 (4.~
      19 Vascu~ <NA>   1 (3.~ 2 (7.~ <NA>   <NA>   <NA>   3 (11.~ <NA>   1 (4.~ <NA>  
      20 Endoc~ <NA>   3 (11~ <NA>   1 (3.~ <NA>   <NA>   4 (14.~ <NA>   <NA>   <NA>  
      21 Immun~ 1 (3.~ <NA>   1 (3.~ 1 (3.~ <NA>   <NA>   3 (11.~ <NA>   <NA>   <NA>  
      22 Renal~ <NA>   1 (3.~ 1 (3.~ 1 (3.~ <NA>   <NA>   3 (11.~ <NA>   <NA>   <NA>  
      23 Metab~ <NA>   1 (3.~ <NA>   <NA>   <NA>   <NA>   1 (3.7~ <NA>   <NA>   <NA>  
      24 No De~ <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>    <NA>   <NA>   <NA>  
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", showNA = FALSE, total = FALSE)
    Output
      # A tibble: 24 x 11
         soc     ctl_G1 ctl_G2 ctl_G3 ctl_G4 ctl_G5 trt_G1 trt_G2 trt_G3 trt_G4 trt_G5
         <fct>   <glue> <glue> <glue> <glue> <glue> <glue> <glue> <glue> <glue> <glue>
       1 Injury~ 1 (4%) <NA>   1 (4%) 1 (4%) <NA>   3 (13~ 1 (4%) 1 (4%) <NA>   1 (4%)
       2 Neopla~ 2 (7%) 1 (4%) <NA>   <NA>   <NA>   2 (9%) <NA>   2 (9%) <NA>   1 (4%)
       3 Nervou~ 1 (4%) 1 (4%) 3 (11~ <NA>   <NA>   <NA>   <NA>   3 (13~ <NA>   <NA>  
       4 Eye di~ 2 (7%) <NA>   2 (7%) 1 (4%) <NA>   1 (4%) 1 (4%) <NA>   <NA>   <NA>  
       5 Hepato~ <NA>   2 (7%) <NA>   1 (4%) <NA>   2 (9%) 1 (4%) 1 (4%) <NA>   <NA>  
       6 Infect~ 2 (7%) 2 (7%) 1 (4%) <NA>   <NA>   <NA>   <NA>   1 (4%) <NA>   1 (4%)
       7 Skin a~ <NA>   <NA>   1 (4%) 1 (4%) <NA>   <NA>   2 (9%) 2 (9%) 1 (4%) <NA>  
       8 Ear an~ 1 (4%) <NA>   <NA>   <NA>   <NA>   1 (4%) 1 (4%) 1 (4%) 2 (9%) <NA>  
       9 Reprod~ 2 (7%) 4 (15~ <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      10 Respir~ 2 (7%) <NA>   1 (4%) 1 (4%) <NA>   <NA>   <NA>   2 (9%) <NA>   <NA>  
      11 Blood ~ 2 (7%) 1 (4%) <NA>   <NA>   <NA>   1 (4%) <NA>   <NA>   1 (4%) <NA>  
      12 Cardia~ 1 (4%) 1 (4%) 1 (4%) 1 (4%) <NA>   <NA>   1 (4%) <NA>   <NA>   <NA>  
      13 Gastro~ <NA>   2 (7%) 1 (4%) <NA>   1 (4%) <NA>   1 (4%) <NA>   <NA>   <NA>  
      14 Genera~ 3 (11~ <NA>   1 (4%) <NA>   <NA>   <NA>   1 (4%) <NA>   <NA>   <NA>  
      15 Invest~ 1 (4%) 1 (4%) <NA>   1 (4%) <NA>   1 (4%) 1 (4%) <NA>   <NA>   <NA>  
      16 Muscul~ 1 (4%) 1 (4%) <NA>   <NA>   <NA>   2 (9%) 1 (4%) <NA>   <NA>   <NA>  
      17 Psychi~ 1 (4%) 1 (4%) 1 (4%) <NA>   <NA>   1 (4%) <NA>   1 (4%) <NA>   <NA>  
      18 Surgic~ 1 (4%) 1 (4%) <NA>   <NA>   <NA>   2 (9%) <NA>   1 (4%) <NA>   <NA>  
      19 Vascul~ <NA>   1 (4%) 2 (7%) <NA>   <NA>   <NA>   1 (4%) <NA>   <NA>   1 (4%)
      20 Endocr~ <NA>   3 (11~ <NA>   1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      21 Immune~ 1 (4%) <NA>   1 (4%) 1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   1 (4%)
      22 Renal ~ <NA>   1 (4%) 1 (4%) 1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      23 Metabo~ <NA>   1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      24 No Dec~ <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", variant = "sup")
    Condition
      Warning:
      Total has been set to `FALSE` as totals are not very interpretable when `variant` is "sup" or "eq". Set `total=TRUE` explicitly to silence this warning.
    Output
      # A tibble: 24 x 13
         soc     ctl_G1 ctl_G2 ctl_G3 ctl_G4 ctl_G5 ctl_NA trt_G1 trt_G2 trt_G3 trt_G4
         <fct>   <glue> <glue> <glue> <glue> <glue> <glue> <glue> <glue> <glue> <glue>
       1 Injury~ 3 (11~ 2 (7%) 2 (7%) 1 (4%) <NA>   <NA>   6 (26~ 3 (13~ 2 (9%) 1 (4%)
       2 Nervou~ 5 (19~ 4 (15~ 3 (11~ <NA>   <NA>   <NA>   3 (13~ 3 (13~ 3 (13~ <NA>  
       3 Skin a~ 2 (7%) 2 (7%) 2 (7%) 1 (4%) <NA>   <NA>   5 (22~ 5 (22~ 3 (13~ 1 (4%)
       4 Infect~ 5 (19~ 3 (11~ 1 (4%) <NA>   <NA>   <NA>   2 (9%) 2 (9%) 2 (9%) 1 (4%)
       5 Neopla~ 3 (11~ 1 (4%) <NA>   <NA>   <NA>   <NA>   5 (22~ 3 (13~ 3 (13~ 1 (4%)
       6 Ear an~ 1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   5 (22~ 4 (17~ 3 (13~ 2 (9%)
       7 Eye di~ 5 (19~ 3 (11~ 3 (11~ 1 (4%) <NA>   <NA>   2 (9%) 1 (4%) <NA>   <NA>  
       8 Hepato~ 3 (11~ 3 (11~ 1 (4%) 1 (4%) <NA>   <NA>   4 (17~ 2 (9%) 1 (4%) <NA>  
       9 Respir~ 4 (15~ 2 (7%) 2 (7%) 1 (4%) <NA>   <NA>   2 (9%) 2 (9%) 2 (9%) <NA>  
      10 Vascul~ 3 (11~ 3 (11~ 2 (7%) <NA>   <NA>   <NA>   2 (9%) 2 (9%) 1 (4%) 1 (4%)
      11 Gastro~ 4 (15~ 4 (15~ 2 (7%) 1 (4%) 1 (4%) <NA>   1 (4%) 1 (4%) <NA>   <NA>  
      12 Immune~ 3 (11~ 2 (7%) 2 (7%) 1 (4%) <NA>   <NA>   1 (4%) 1 (4%) 1 (4%) 1 (4%)
      13 Cardia~ 4 (15~ 3 (11~ 2 (7%) 1 (4%) <NA>   <NA>   1 (4%) 1 (4%) <NA>   <NA>  
      14 Endocr~ 4 (15~ 4 (15~ 1 (4%) 1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      15 Invest~ 3 (11~ 2 (7%) 1 (4%) 1 (4%) <NA>   <NA>   2 (9%) 1 (4%) <NA>   <NA>  
      16 Psychi~ 3 (11~ 2 (7%) 1 (4%) <NA>   <NA>   <NA>   2 (9%) 1 (4%) 1 (4%) <NA>  
      17 Reprod~ 6 (22~ 4 (15~ <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      18 Blood ~ 3 (11~ 1 (4%) <NA>   <NA>   <NA>   <NA>   2 (9%) 1 (4%) 1 (4%) 1 (4%)
      19 Renal ~ 3 (11~ 3 (11~ 2 (7%) 1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      20 Genera~ 4 (15~ 1 (4%) 1 (4%) <NA>   <NA>   <NA>   1 (4%) 1 (4%) <NA>   <NA>  
      21 Surgic~ 2 (7%) 1 (4%) <NA>   <NA>   <NA>   <NA>   3 (13~ 1 (4%) 1 (4%) <NA>  
      22 Muscul~ 2 (7%) 1 (4%) <NA>   <NA>   <NA>   <NA>   3 (13~ 1 (4%) <NA>   <NA>  
      23 Metabo~ 1 (4%) 1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      24 No Dec~ <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
    Code
      ae_table_soc(ae, df_enrol = enrolres, arm = "ARM", variant = "eq")
    Condition
      Warning:
      Total has been set to `FALSE` as totals are not very interpretable when `variant` is "sup" or "eq". Set `total=TRUE` explicitly to silence this warning.
    Output
      # A tibble: 24 x 13
         soc     ctl_G1 ctl_G2 ctl_G3 ctl_G4 ctl_G5 ctl_NA trt_G1 trt_G2 trt_G3 trt_G4
         <fct>   <glue> <glue> <glue> <glue> <glue> <glue> <glue> <glue> <glue> <glue>
       1 Injury~ 1 (4%) 1 (4%) 1 (4%) 1 (4%) <NA>   <NA>   3 (13~ 1 (4%) 1 (4%) <NA>  
       2 Neopla~ 2 (7%) 1 (4%) <NA>   <NA>   <NA>   <NA>   3 (13~ <NA>   2 (9%) <NA>  
       3 Eye di~ 2 (7%) 1 (4%) 2 (7%) 1 (4%) <NA>   <NA>   1 (4%) 1 (4%) <NA>   <NA>  
       4 Hepato~ <NA>   2 (7%) <NA>   1 (4%) <NA>   <NA>   3 (13~ 1 (4%) 1 (4%) <NA>  
       5 Nervou~ 1 (4%) 1 (4%) 3 (11~ <NA>   <NA>   <NA>   <NA>   <NA>   3 (13~ <NA>  
       6 Skin a~ <NA>   <NA>   2 (7%) 1 (4%) <NA>   <NA>   <NA>   2 (9%) 2 (9%) 1 (4%)
       7 Infect~ 2 (7%) 2 (7%) 1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   1 (4%) <NA>  
       8 Ear an~ 1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   1 (4%) 1 (4%) 1 (4%) 2 (9%)
       9 Gastro~ 1 (4%) 2 (7%) 1 (4%) <NA>   1 (4%) <NA>   <NA>   1 (4%) <NA>   <NA>  
      10 Reprod~ 2 (7%) 4 (15~ <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      11 Respir~ 2 (7%) <NA>   1 (4%) 1 (4%) <NA>   <NA>   <NA>   <NA>   2 (9%) <NA>  
      12 Blood ~ 2 (7%) 1 (4%) <NA>   <NA>   <NA>   <NA>   1 (4%) <NA>   <NA>   1 (4%)
      13 Cardia~ 1 (4%) 1 (4%) 1 (4%) 1 (4%) <NA>   <NA>   <NA>   1 (4%) <NA>   <NA>  
      14 Genera~ 3 (11~ <NA>   1 (4%) <NA>   <NA>   <NA>   <NA>   1 (4%) <NA>   <NA>  
      15 Invest~ 1 (4%) 1 (4%) <NA>   1 (4%) <NA>   <NA>   1 (4%) 1 (4%) <NA>   <NA>  
      16 Muscul~ 1 (4%) 1 (4%) <NA>   <NA>   <NA>   <NA>   2 (9%) 1 (4%) <NA>   <NA>  
      17 Psychi~ 1 (4%) 1 (4%) 1 (4%) <NA>   <NA>   <NA>   1 (4%) <NA>   1 (4%) <NA>  
      18 Surgic~ 1 (4%) 1 (4%) <NA>   <NA>   <NA>   <NA>   2 (9%) <NA>   1 (4%) <NA>  
      19 Vascul~ <NA>   1 (4%) 2 (7%) <NA>   <NA>   <NA>   <NA>   1 (4%) <NA>   <NA>  
      20 Endocr~ <NA>   3 (11~ <NA>   1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      21 Immune~ 1 (4%) <NA>   1 (4%) 1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      22 Renal ~ <NA>   1 (4%) 1 (4%) 1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      23 Metabo~ <NA>   1 (4%) <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  
      24 No Dec~ <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>   <NA>  

