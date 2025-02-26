# function that compares the summurised tables in R versus those in SAS
# output: if difference, dataframe with each row details of difference
# if no difference, dataframe displaying table R and table SAS side by side.
# author: Nusaibah

compare_soc <- function(tabR,tabSAS){
  # ae_table_soc() affiche toutes les colonnes grade 1à 5 NA et total(option) (pour chaque bras si le bras est indiqué)
  # supprimée les colonnes et lignes vides pour optimiser l'algorithme
  tabR = tabR[,!apply(is.na(tabR), 2, all)]
  tabR = tabR[!apply(is.na(tabR%>%select(-soc)), 1, all),]
  if ("term_"%in% c(colnames(tabR),colnames(tabSAS))){
    tabR = tabR %>% arrange(soc,term_)
  }else{
    tabR = tabR %>% arrange(soc)
  }

  tab=list()
  if (nrow(tabR)!=nrow(tabSAS)){#warning("Different number of SOC")

    socdiff=table(tabR$soc) %>%
      as.data.frame() %>%
      full_join(table(tabSAS$soc) %>%
                  as.data.frame(),
                by="Var1",suffix = c(".r",".sas")) %>%
      filter(Freq.r !=Freq.sas | (is.na(Freq.r) |is.na(Freq.sas)))

    if (nrow(tabR)<nrow(tabSAS)){

      tab$level=c(tab$level,"Mineur")
      tab$soc=c(tab$soc,paste(socdiff%>%filter(Freq.r<Freq.sas| is.na(Freq.r))%>%select(Var1)%>%pull,collapse = " & "))
      tab$table=c(tab$table,"R")
      if(any(grepl("level",colnames(tabR)))){
        tab$arm=c(tab$arm,NA)}
      if ("term_"%in% c(colnames(tabR),colnames(tabSAS))){
        tab$term_=c(tab$term_,paste(tabSAS[which(!(tabSAS$term_%in% tabR$term_)),"term_"]%>%pull,collapse = " & "))
        tab$main=c(tab$main,"Missing PT item")
      }else{

        tab$main=c(tab$main,"Missing SOC item")
      }
      tab$valueR=c(tab$valueR,NA)
      tab$valueSAS=c(tab$valueSAS,"Filled")

    }else if (nrow(tabR)>nrow(tabSAS)){


      tab$level=c(tab$level,"Mineur")
      tab$soc=c(tab$soc,paste(socdiff%>%filter(Freq.r>Freq.sas | is.na(Freq.sas))%>%select(Var1)%>%pull,collapse = " & "))
      tab$table=c(tab$table,"SAS")
      tab$grade=c(tab$grade,NA)
      if(any(grepl("bras",colnames(tabR)))){
        tab$arm=c(tab$arm,NA)}
      if ("term_"%in% c(colnames(tabR),colnames(tabSAS))){
        tab$term_=c(tab$term_,paste(tabR[which(!(tabR$term_%in% tabSAS$term_)),"term_"]%>%pull,collapse = " & "))
        tab$main=c(tab$main,"Missing PT item")
      }else{

        tab$main=c(tab$main,"Missing SOC item")
      }
      tab$valueR=c(tab$valueR,"Filled")
      tab$valueSAS=c(tab$valueSAS,NA)
    }
  }

  if (ncol(tabR)!=ncol(tabSAS)){#warning("Different number of column (arm or grade)")
    if (ncol(tabR)<ncol(tabSAS)){

      tab$level=c(tab$level,"Mineur")
      tab$grade=c(tab$grade,paste(colnames(tabSAS)[-(which(colnames(tabSAS) %in% colnames(tabR)))],collapse=" & "))
      tab$table=c(tab$table,"R")
      tab$soc=c(tab$soc,NA)
      if ("term_"%in% c(colnames(tabR),colnames(tabSAS))){ tab$term_=c(tab$term_,NA)}
      tab$main=c(tab$main,"Missing grade")
      tab$valueR=c(tab$valueR,NA)
      tab$valueSAS=c(tab$valueSAS,"Filled")
      if(any(grepl("bras",colnames(tabR)))){
        tab$arm=c(tab$arm,paste(unique(str_extract(colnames(tabSAS)[which(!(colnames(tabSAS)%in% colnames(tabR)))],"bras[:alnum:]+")),collapse = " & "))
      }
    }else if (ncol(tabR)>ncol(tabSAS)){

      tab$level=c(tab$level,"Mineur")
      tab$soc=c(tab$soc,NA)
      if ("term_"%in% c(colnames(tabR),colnames(tabSAS))){  tab$term_=c(tab$term_,NA)}
      tab$grade=c(tab$grade,paste(colnames(tabR)[-(which(colnames(tabR) %in% colnames(tabSAS)))],collapse = " & "))
      if(any(grepl("bras",colnames(tabR)))){
        tab$arm=c(tab$arm,paste(unique(str_extract(colnames(tabR)[which(!(colnames(tabR)%in% colnames(tabSAS)))],"bras[:alnum:]+")),collapse = " & "))
      }
      tab$table=c(tab$table,"SAS")
      tab$main=c(tab$main,"Missing grade")
      tab$valueR=c(tab$valueR,"Filled")
      tab$valueSAS=c(tab$valueSAS,NA)

    }
  }
  if (all(dim(tabR)==dim(tabSAS)) | "all_patients_NA" %in% colnames(tabR) ){# warning("Check: same dimension of tables or same grade")

    if ("term_"%in% c(colnames(tabR),colnames(tabSAS))){
      dfsas=tabSAS%>%
        pivot_longer(-c("soc","term_"),names_to = "grade",values_to = "count")%>%
        mutate(table="SAS")


      df=tabR%>%arrange(soc,term_)%>%
        pivot_longer(-c("soc","term_"),names_to = "grade",values_to = "count")%>%
        mutate(table="R")%>%
        full_join(dfsas,
                  by=c("soc","term_","grade"),
                  suffix = c(".r",".sas"))


      if (any(grepl("bras",df$grade))){

        df=df%>%separate(col="grade",into=c("arm","grade"),sep="__")}

      indice= df%>%filter(count.r!=count.sas | is.na(count.r)!=is.na(count.sas))


    }else{
      # df=tabR%>%arrange(soc)%>%full_join(tabSAS,by="soc",suffix = c(".r",".sas"))


      df=tabR%>%arrange(soc)%>%
        pivot_longer(-c("soc"),names_to = "grade",values_to = "count")%>%
        mutate(table="R")%>%
        full_join(tabSAS%>%
                    pivot_longer(-c("soc"),names_to = "grade",values_to = "count")%>%
                    mutate(table="SAS"),
                  by=c("soc","grade"),
                  suffix = c(".r",".sas"))
      if (any(grepl("bras",df$grade))){ df=df%>%mutate("arm"=str_extract(grade,"bras[:alnum:]+"))}
      indice=df[which(df$count.r!=df$count.sas | (is.na(df$count.r) & !is.na(df$count.sas)) |
                        (!is.na(df$count.r) & is.na(df$count.sas))
                      ,arr.ind = T),]
    }
    if (nrow(indice)!=0){
      # print(indice)
      # warning(paste0("Comparison result: Warning! Different outputs.",
      #                nrow(indice)," mismatching between the two tables. Above, the indices."))

      tab =rbind(as.data.frame(tab),indice%>%
                   mutate(level="MAJEUR",
                          table="Both",
                          main="Different value")%>%
                   dplyr::rename(valueR="count.r",
                                 valueSAS="count.sas")%>%
                   select(-c("table.r","table.sas")))


      tab=as.data.frame(tab)%>%
        distinct(level,grade,table,main,soc,.keep_all = TRUE)%>%
        flextable()%>%
        bold(part="header") %>%
        align(part="body", align="right",i=~str_detect(valueR,pattern="[:digit:]"),j="valueR")%>%
        align(part="body", align="right",i=~str_detect(valueSAS,pattern="[:digit:]"),j="valueSAS")%>%
        autofit() %>%
        bg(i=~level=="MAJEUR",bg="#f06d4d")

    }else{
      # warning("Comparison result: same outputs")
      # tab=cbind(data.frame("R table"=""),tabR,data.frame("SAS table"=""),tabSAS)

      if ("term_" %in% colnames(tabR)){ jointure=c("soc","term_")
      colsize=c(1,1,ncol(tabR)-2,ncol(tabSAS)-2)}else{jointure="soc"
      colsize=c(1,ncol(tabR)-1,ncol(tabSAS)-1) }
      tab = tabR%>%
        full_join(tabSAS,
                  by=jointure,
                  suffix = c("_r","_sas"))%>%
        flextable()%>%
        add_footer_lines( "Comparison result: same outputs", top=TRUE) %>%
        autofit() %>%
        add_header_row( values = c(jointure,"R table", "SAS table"), colwidths = colsize) %>%
        align(part="header", align="center",i=1)%>%
        bold(part="header") %>%
        # bold(i=~N1_r!=N1_sas,j=c(2,4))%>%
        vline(j=ncol(tabR), part = "body") %>%

        set_header_labels(values= c(colnames(tabR),colnames(tabSAS)[-c(1:length(jointure))])) %>%
        merge_at(i=c(1,2),j=1,  part = "header")%>%
        align(part="body", align="left",j=1)

      if ("term_" %in% colnames(tabR)){  tab = tab %>%  merge_at(i=c(1,2), j=2,  part = "header")%>%  align(part="body", align="left",j=2)}
    }
  }else{
    tab=as.data.frame(tab)%>%
      distinct(level,grade,table,main,soc,.keep_all = TRUE)%>%
      flextable()%>%
      bold(part="header") %>%
      align(part="body", align="right",i=~str_detect(valueR,pattern="[:digit:]"),j="valueR")%>%
      align(part="body", align="right",i=~str_detect(valueSAS,pattern="[:digit:]"),j="valueSAS")%>%
      autofit() %>%
      bg(i=~level=="MAJEUR",bg="#f06d4d")

  }
  return(tab)


}
