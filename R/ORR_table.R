#' @importFrom dplyr select
#' @importFrom GenBinomApps clopper.pearson.ci
#' @importFrom flextable as_flextable surround delete_rows footnote as_paragraph
#' @importFrom officer fp_border
#' @importFrom cli cli_abort

ORR_table = function(id = recist$SUBJID, global_response = recist$RCRESP, date = recist$RCDT, confirmed = FALSE, show_CBR = FALSE){
  `%notin%` <- Negate(`%in%`)
  if(is.na(id)){
    cli_abort("id must be defined")
  }
  if(is.na(date)){
    cli_abort("date must be defined")
  }
  if(is.na(global_response)){
    cli_abort("global_response must be defined")
  }
  if(length(id) != length(global_response) | length(id) != length(date) | length(date) != length(global_response)){
    cli_abort("id, global_reponse and date should have the same length")
  }
  if(length(confirmed) > 1){
    cli_abort("confirmed shoulb be TRUE or FALSE (default = FALSE)")
  }
  if(length(show_CBR) > 1){
    cli_abort("show_CBR shoulb be TRUE or FALSE (default = FALSE)")
  }
  if(confirmed %notin% c(TRUE,FALSE,NA)){
    cli_abort("confirmed shoulb be TRUE or FALSE (default = FALSE)")
  }
  if(show_CBR %notin% c(TRUE,FALSE,NA)){
    cli_abort("show_CBR shoulb be TRUE or FALSE (default = FALSE)")
  }
  if(is.Date(date)!= TRUE){
    cli_abort("date shoul be in as.Date format")
  }

  data = data.frame(subjid = id, rcresp = global_response, rcdt = date)

  #Si un patient a une seule visite recist (la premiere) puis aucune autre, on le modifie en NA
  data = data %>%
    mutate(n = n(), .by = subjid) %>%
    mutate(rcresp = ifelse(n==1, "Not evaluable",as.character(rcresp)))


  recist_2 = data %>%
    distinct(subjid,rcresp,rcdt) %>%
    arrange(as.numeric(subjid), rcdt) %>%
    mutate(rcresp_num=as.numeric(as.factor(rcresp))) %>%
    filter(!is.na(rcresp_num) & !is.na(rcdt) & !is.na(subjid)) %>%
    mutate(previous_rcresp_num=lag(rcresp_num),
           previous_date=lag(rcdt),
           delta_date=as.numeric(rcdt - previous_date),
           delta_date= ifelse(is.na(delta_date),0,delta_date),
           delta_date_before_PD_or_end = cumsum(delta_date),
           delta_date_before_PD_or_end = ifelse(rcresp=="Progressive disease" ,0,delta_date_before_PD_or_end),
           delta_date_before_PD_or_end= replace_na(delta_date_before_PD_or_end,0),
           duree_suivi_max = max(delta_date_before_PD_or_end),
           bestresponse_withinprotocole=ifelse(previous_rcresp_num==rcresp_num, 1, 0 ),
           .by = subjid)

  if (is.na(confirmed) | confirmed == FALSE){
    final_best_response=recist_2 %>%
      mutate(bestresponse=min(rcresp_num),
             .by = subjid) %>%
      filter(bestresponse==rcresp_num) %>%
      slice_head(by=subjid) %>%
      mutate(Overall_ORR= ifelse(rcresp=="Complete response" | rcresp=="Partial response",1,0),
             CBR = ifelse(duree_suivi_max >= 152 | rcresp=="Complete response" | rcresp=="Partial response",1,0))
  }
  else if(confirmed == TRUE){
    recist_2 <- recist_2 %>%
      mutate(
        meilleur_reponse = case_when(
          rcresp_num == 1 & previous_rcresp_num == 1 & delta_date >= 28 ~ 1,
          rcresp_num == 1 & previous_rcresp_num == 1 & delta_date < 28  ~ 3,
          rcresp_num == 1 & previous_rcresp_num == 2 & delta_date >= 28 ~ 2,
          rcresp_num == 1 & previous_rcresp_num == 2 & delta_date < 28  ~ 3,
          rcresp_num == 1 & previous_rcresp_num == 3                    ~ 3,
          rcresp_num == 1 & previous_rcresp_num == 4                    ~ 4,
          rcresp_num == 1 & previous_rcresp_num == 5                    ~ 5,

          rcresp_num == 2 & previous_rcresp_num <= 2 & delta_date >= 28 ~ 2,
          rcresp_num == 2 & previous_rcresp_num <= 2 & delta_date < 28  ~ 3,
          rcresp_num == 2 & previous_rcresp_num == 3                    ~ 3,
          rcresp_num == 2 & previous_rcresp_num == 4                    ~ 4,
          rcresp_num == 2 & previous_rcresp_num == 5                    ~ 5,

          is.na(previous_rcresp_num) & rcresp_num == 4                  ~ 4,

          TRUE ~ rcresp_num
        )
      )

    final_best_response=recist_2 %>%
      mutate(bestresponse=min(meilleur_reponse),
             .by=subjid
      ) %>%
      filter(bestresponse==meilleur_reponse) %>%
      slice_head(by=subjid) %>%
      mutate(Overall_ORR= ifelse(rcresp=="Complete response" | rcresp=="Partial response",1,0),
             CBR = ifelse(duree_suivi_max >= 152 | rcresp=="Complete response" | rcresp=="Partial response",1,0))
  }

    total <- length(unique(final_best_response$subjid))
    CR <- length(final_best_response$rcresp[final_best_response$rcresp == "Complete response"])
    PR <- length(final_best_response$rcresp[final_best_response$rcresp == "Partial response"])
    SD <- length(final_best_response$rcresp[final_best_response$rcresp == "Stable disease"])
    PD <- length(final_best_response$rcresp[final_best_response$rcresp == "Progressive disease"])
    NE <- length(final_best_response$rcresp[final_best_response$rcresp == "Not evaluable"])
    Overall_ORR <- CR + PR
    CBR <- length(final_best_response$CBR[final_best_response$CBR==1])

    CR_CP <- clopper.pearson.ci(CR,total,CI="two.sided", alpha = 0.05)
    PR_CP <- clopper.pearson.ci(PR,total,CI="two.sided", alpha = 0.05)
    SD_CP <- clopper.pearson.ci(SD,total,CI="two.sided", alpha = 0.05)
    PD_CP <- clopper.pearson.ci(PD,total,CI="two.sided", alpha = 0.05)
    NE_CP <- clopper.pearson.ci(NE,total,CI="two.sided", alpha = 0.05)
    Overall_ORR_CP <- clopper.pearson.ci(Overall_ORR,total,CI="two.sided", alpha = 0.05)
    CBR_CP <- clopper.pearson.ci(CBR,total,CI="two.sided", alpha = 0.05)

    CR_CP_IC <- paste0("[",round(CR_CP$Lower.limit*100,1),";",round(CR_CP$Upper.limit*100,1),"]")
    PR_CP_IC <- paste0("[",round(PR_CP$Lower.limit*100,1),";",round(PR_CP$Upper.limit*100,1),"]")
    SD_CP_IC <- paste0("[",round(SD_CP$Lower.limit*100,1),";",round(SD_CP$Upper.limit*100,1),"]")
    PD_CP_IC <- paste0("[",round(PD_CP$Lower.limit*100,1),";",round(PD_CP$Upper.limit*100,1),"]")
    NE_CP_IC <- paste0("[",round(NE_CP$Lower.limit*100,1),";",round(NE_CP$Upper.limit*100,1),"]")
    Overall_ORR_CP_IC <- paste0("[",round(Overall_ORR_CP$Lower.limit*100,1),";",round(Overall_ORR_CP$Upper.limit*100,1),"]")
    CBR_CP_IC <- paste0("[",round(CBR_CP$Lower.limit*100,1),";",round(CBR_CP$Upper.limit*100,1),"]")

    if (is.na(show_CBR) | show_CBR == FALSE){
      IC_95 <- c(Overall_ORR_CP_IC,
                 CR_CP_IC,
                 PR_CP_IC,
                 SD_CP_IC,
                 PD_CP_IC,
                 NE_CP_IC)

      Name <- c("Overall ORR",
                "Complete response (CR)",
                "Partial response (PR)",
                "Stable disease (SD)",
                "Progressive disease (PD)",
                "Not evaluable (NE)")

      N <- c(Overall_ORR,
             CR,
             PR,
             SD,
             PD,
             NE)

      Percentage <- c(round(Overall_ORR/total*100,1),
                      round(CR/total*100,1),
                      round(PR/total*100,1),
                      round(SD/total*100,1),
                      round(PD/total*100,1),
                      round(NE/total*100,1))
    }
    else if(show_CBR == TRUE){IC_95 <- c(Overall_ORR_CP_IC,
                                    CR_CP_IC,
                                    PR_CP_IC,
                                    SD_CP_IC,
                                    PD_CP_IC,
                                    NE_CP_IC,
                                    CBR_CP_IC)

    Name <- c("Overall ORR",
              "Complete response (CR)",
              "Partial response (PR)",
              "Stable disease (SD)",
              "Progressive disease (PD)",
              "Not evaluable (NE)",
              "Clinical Benefit Rate (CBR)")

    N <- c(Overall_ORR,
           CR,
           PR,
           SD,
           PD,
           NE,
           CBR)

    Percentage <- c(round(Overall_ORR/total*100,1),
                    round(CR/total*100,1),
                    round(PR/total*100,1),
                    round(SD/total*100,1),
                    round(PD/total*100,1),
                    round(NE/total*100,1),
                    round(CBR/total*100,1))
    }

    Best_Response_during_treatment <- as.data.frame(cbind(Name,N,Percentage,IC_95))
    if (is.na(confirmed) | confirmed == FALSE){
      nom_col = c("Unconfirmed Best Response during treatment",paste0("N=",total),"%","IC 95%")
    }
    else if(confirmed == TRUE){
      nom_col = c("Confirmed Best Response during treatment",paste0("N=",total),"%","IC 95%")
    }

    colnames(Best_Response_during_treatment) <- nom_col
    Best_Response_during_treatment =  Best_Response_during_treatment %>%
      as_flextable(show_coltype = F, include.row_percent = FALSE, include.column_percent = FALSE, include.table_percent = FALSE) %>%
      delete_rows(i=1, part = "footer") %>%
      bold(bold = TRUE, part = "header") %>%
      surround(i = c(1,6), j = 1:4, border.bottom = fp_border(color = "black", style = "solid", width = 1), part = "body")

      if (is.na(confirmed) | confirmed == FALSE){
      Best_Response_during_treatment =  Best_Response_during_treatment %>%
        footnote( i = 1, j = c(4),
                  value = as_paragraph(
                    c("Clopper-Pearson (Exact) method was used for confidence interval")),
                  ref_symbols =c("*"), part = "header") %>%
        valign(valign = "bottom", part = "header")
      }
      else if(confirmed == TRUE){
        Best_Response_during_treatment =  Best_Response_during_treatment %>%
        footnote( i = 1, j = c(4,1),
                  value = as_paragraph(
                    c("Clopper-Pearson (Exact) method was used for confidence interval",
                      "For CR & PR confirmation of response had to be be demonstrated with an assessment 4 weeks or later from the initial response for response. *As stated in the protocol: «For equivocal findings of progression (e.g., very small and uncertain new lesions; cystic changes or necrosis in existing lesions), treatment may continue until the next scheduled assessment». Therefore, some patients had a response after a progressive disease response, in that case best response was examine before and after PD. Scans conducted after initiating new anti-cancer therapy were not included in the ORR analyses")),
                  ref_symbols =c("*","1"), part = "header") %>%
        valign(valign = "bottom", part = "header")
        }

    if (is.na(show_CBR) | show_CBR == FALSE){
      Best_Response_during_treatment =  Best_Response_during_treatment %>%
        bold(i = c(1), j = 1, bold = TRUE, part = "body")
      }
    else if(show_CBR == TRUE & confirmed == TRUE){
      Best_Response_during_treatment =  Best_Response_during_treatment %>%
        footnote( i = c(7), j = 1,
                  value = as_paragraph(
                    c("CBR was defined as the presence of at least a partial response (PR), complete response (CR), or stable disease (SD) lasting at least six months (using a window of +/-1 month for the RECIST date).")),
                  ref_symbols = c("2"), part = "body") %>%
        valign(valign = "bottom", part = "header") %>%
        bold(i = c(1,7), j = 1, bold = TRUE, part = "body")
    }
    else if(show_CBR == TRUE & (is.na(confirmed) | confirmed == FALSE)){
      Best_Response_during_treatment =  Best_Response_during_treatment %>%
        footnote( i = c(7), j = 1,
                  value = as_paragraph(
                    c("CBR was defined as the presence of at least a partial response (PR), complete response (CR), or stable disease (SD) lasting at least six months (using a window of +/-1 month for the RECIST date).")),
                  ref_symbols = c("1"), part = "body") %>%
        valign(valign = "bottom", part = "header") %>%
        bold(i = c(1,7), j = 1, bold = TRUE, part = "body")
    }
Best_Response_during_treatment
}
