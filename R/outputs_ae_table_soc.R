#fonction formatting R and SAS outputs from ae_table_soc to same table format
outputs_ae_table_soc <- function(R_output,
                                 SAS_output,
                                 SAS_soc,        #soc name in SAS output
                                 SAS_term = NULL #term name in SAS output
                                 ){

  SAS_output <- SAS_output %>%
    fill(any_of(SAS_soc), .direction = "down") %>%
    rename(soc = SAS_soc, term_ = SAS_term)

  return(list(R = R_output, SAS = SAS_output))

}
