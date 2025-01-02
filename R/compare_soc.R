# function that compares the summurised tables in R versus those in SAS
# output: if difference, dataframe with each row details of difference
# if no difference, dataframe displaying table R and table SAS side by side.
# author: Nusaibah

compare_soc <- function(tabR,tabSAS){
  #####################  a reporter dans les exemples.
  colnames(tabR)=gsub("all_patients_G","grade",colnames(tabR))  # quand il n'y a pas de PT term
  tabSAS= tabSAS %>%
    fill(soc,.direction="down")

  tabR = tabR[,!apply(is.na(tabR), 2, all)]
  tabR = tabR[!apply(is.na(tabR%>%select(-soc)), 1, all),]


  if (any(grepl("level",colnames(tabR))) | any(grepl("bras",colnames(tabSAS)))){
    lev=tabR %>% colnames()%>%str_extract(".*__") %>% str_remove_all("level_|__") %>% unique %>% discard(is.na)

    bras=  unique(gsub("bras|_","",str_extract(colnames(tabSAS),".*_"))%>%discard(is.na))
    corresp = data.frame("levels"=lev,
                         "levelsSAS"=bras[bras!="term"]

    )
    brasBis=data.frame("SAS"=colnames(tabSAS)[grepl("bras",colnames(tabSAS))])%>%
      mutate(chiffre=gsub("bras|_","",str_extract(SAS,".*_")))%>%
      left_join(corresp,by=c("chiffre"="levelsSAS"))%>%
      mutate(R=paste0("level_",levels,"__",gsub("grade","G",str_extract(SAS,"grade[:digit:]"))))

    colnames(tabSAS)[grepl("bras",colnames(tabSAS))] =brasBis[,"R"]
  }

  #######################################
  tab=list()
  if (nrow(tabR)!=nrow(tabSAS)){#warning("Different number of SOC")
    if (nrow(tabR)<nrow(tabSAS)){

      tab$level=c(tab$level,"Mineur")
      tab$soc=c(tab$soc,tabSAS[which(!(tabSAS$soc%in% tabR$soc)),"soc"]%>%pull)
      tab$table=c(tab$table,"R")
      if(any(grepl("level",colnames(tabR)))){
        tab$arm=c(tab$arm,NA)}
      if ("term_"%in% c(colnames(tabR),colnames(tabSAS))){
        tab$term_=c(tab$term_,tabSAS[which(!(tabSAS$term_%in% tabR$term_)),"term_"]%>%pull)
        tab$main=c(tab$main,"Missing PT item")
      }else{

        tab$main=c(tab$main,"Missing SOC item")
      }
    }else if (nrow(tabR)>nrow(tabSAS)){
      tab$level=c(tab$level,"Mineur")
      tab$soc=c(tab$soc,tabR[which(!(tabR$soc%in% tabSAS$soc)),"soc"]%>%pull)
      tab$table=c(tab$table,"SAS")
      tab$grade=c(tab$grade,NA)
      if(any(grepl("level",colnames(tabR)))){
        tab$arm=c(tab$arm,NA)}
      if ("term_"%in% c(colnames(tabR),colnames(tabSAS))){
        tab$term_=c(tab$term_,tabR[which(!(tabR$term_%in% tabSAS$term_)),"term_"]%>%pull)
        tab$main=c(tab$main,"Missing PT item")
      }else{

        tab$main=c(tab$main,"Missing SOC item")
      }
      tab$valueR=c(tab$valueR,NA)
      tab$valueSAS=c(tab$valueSAS,NA)
    }
  }

  if (ncol(tabR)!=ncol(tabSAS)){#warning("Different number of column (arm or grade)")
    if (ncol(tabR)<ncol(tabSAS)){

      tab$level=c(tab$level,"Mineur")
      tab$grade=c(tab$grade,colnames(tabSAS)[-(which(colnames(tabSAS) %in% colnames(tabR)))])
      tab$table=c(tab$table,"R")
      tab$soc=c(tab$soc,NA)
      tab$term_=c(tab$term_,NA)
      tab$main=c(tab$main,"Missing grade")
      tab$valueR=c(tab$valueR,NA)
      tab$valueSAS=c(tab$valueSAS,"Filled")
      if(any(grepl("level",colnames(tabR)))){
        tab$arm=c(tab$arm,paste(unique(str_extract(colnames(tabSAS)[which(!(colnames(tabSAS)%in% colnames(tabR)))],"level_[:alnum:]+__")),collapse = " & "))
      }
    }else if (ncol(tabR)>ncol(tabSAS)){

      tab$level=c(tab$level,"Mineur")
      tab$soc=c(tab$soc,NA)
      tab$term_=c(tab$term_,NA)
      tab$grade=c(tab$grade,paste(colnames(tabR)[-(which(colnames(tabR) %in% colnames(tabSAS)))],collapse = " & "))
      if(any(grepl("level",colnames(tabR)))){
        tab$arm=c(tab$arm,paste(unique(str_extract(colnames(tabR)[which(!(colnames(tabR)%in% colnames(tabSAS)))],"level_[:alnum:]+__")),collapse = " & "))}
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


      if (any(grepl("level",df$grade))){

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
      if (any(grepl("level",df$grade))){ df=df%>%mutate("arm"=str_extract(grade,"level_[:alnum:]+__"))}
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


      tab=as.data.frame(tab)%>%distinct(level,grade,table,main,soc,.keep_all = TRUE)
    }else{  #   warning("Comparison result: same outputs")
      tab=cbind(data.frame("R table"=""),tabR,data.frame("SAS table"=""),tabSAS)
    }
  }
  return(as.data.frame(tab))


}
