# function that compares the summrised tables in R versus those in SAS
# output: if difference, dataframe with each row details of difference
# if no difference, dataframe displaying table R and table SAS side by side.
# author: Nusaibah


compare_grade <- function(tabR,tabSAS){

  tab=list()  # list containing all difference between the 2 tables
  tabRraw=tabR
  tabSASraw=tabSAS

  #warning("Different number of grade levels")------------
  if (nrow(tabR)!=nrow(tabSAS)){

    if (nrow(tabR)<nrow(tabSAS)){
      tab$grade=c(tab$grade,tabSAS[which(!(tabSAS$grade%in% tabR$grade)),"grade"]%>%pull)
      tab$level=c(tab$level,rep("Mineur",length(tabSAS[which(!(tabSAS$grade%in% tabR$grade)),"grade"]%>%pull)))
      tab$table=c(tab$table,rep("R",length(tabSAS[which(!(tabSAS$grade%in% tabR$grade)),"grade"]%>%pull)))
      tab$main=c(tab$main,rep("Missing grade level",length(tabSAS[which(!(tabSAS$grade%in% tabR$grade)),"grade"]%>%pull)))
      tab$valueR=c(tab$valueR,rep(NA,length(tabSAS[which(!(tabSAS$grade%in% tabR$grade)),"grade"]%>%pull)))
      tab$valueSAS=c(tab$valueSAS,rep("Filled",length(tabSAS[which(!(tabSAS$grade%in% tabR$grade)),"grade"]%>%pull)))
      tab$arm=c(tab$arm,rep("All",length(tabSAS[which(!(tabSAS$grade%in% tabR$grade)),"grade"]%>%pull)))

    }else if (nrow(tabR)>nrow(tabSAS)){
      tab$grade=c(tab$grade,tabR[which(!(tabR$grade%in% tabSAS$grade)),"grade"]%>%pull)
      tab$level=c(tab$level,rep("Mineur",length(tabR[which(!(tabR$grade%in% tabSAS$grade)),"grade"]%>%pull)))
      tab$table=c(tab$table,rep("SAS",length(tabR[which(!(tabR$grade%in% tabSAS$grade)),"grade"]%>%pull)))
      tab$main=c(tab$main,rep("Missing grade level",length(tabR[which(!(tabR$grade%in% tabSAS$grade)),"grade"]%>%pull)))
      tab$valueR=c(tab$valueR,rep("Filled",length(tabR[which(!(tabR$grade%in% tabSAS$grade)),"grade"]%>%pull)))
      tab$valueSAS=c(tab$valueSAS,rep(NA,length(tabR[which(!(tabR$grade%in% tabSAS$grade)),"grade"]%>%pull)))
      tab$arm=c(tab$arm,rep("All",length(tabR[which(!(tabR$grade%in% tabSAS$grade)),"grade"]%>%pull)))



    }
  }
  #  warning("Different number of arm")----------
  if (ncol(tabR)!=ncol(tabSAS)){

    if (ncol(tabR)<ncol(tabSAS)){
      tab$level=c(tab$level,"Mineur")
      tab$arm=c(tab$arm,paste(unique(str_extract(colnames(tabSAS)[which(!(colnames(tabSAS)%in% colnames(tabR)))],"[:digit:]")),collapse = " & "))
      tab$table=c(tab$table,"R")
      tab$main=c(tab$main,"Missing arm")
      tab$valueR=c(tab$valueR,NA)
      tab$valueSAS=c(tab$valueSAS,"Filled")
      tab$grade=c(tab$grade,"All")


    }else if (ncol(tabR)>ncol(tabSAS)){
      tab$level=c(tab$level,"Mineur")
      tab$arm=c(tab$arm,paste(unique(str_extract(colnames(tabR)[which(!(colnames(tabR)%in% colnames(tabSAS)))],"[:digit:]")),collapse = " & "))
      tab$table=c(tab$table,"SAS")
      tab$main=c(tab$main,"Missing arm")
      tab$valueR=c(tab$valueR,"Filled")
      tab$valueSAS=c(tab$valueSAS,NA)
      tab$grade=c(tab$grade,"All")

    }}

  #compare the commun elements---------------
  tabR=tabR[,colnames(tabR) %in% colnames(tabSAS)]
  tabSAS=tabSAS[,colnames(tabSAS) %in% colnames(tabR)]

  df=tabR%>%arrange(grade)%>%full_join(tabSAS,by="grade",suffix = c(".r",".sas"))


  indice=which(df[,paste0(tabR%>%select(-grade)%>%colnames(),paste=".r")]!=df[,paste0(tabSAS%>%select(-grade)%>%colnames(),paste=".sas")],
               arr.ind=TRUE)  # difference numérique number or percentage
  indice[,"col"]=indice[,"col"]+1 # parce qu'on avait retiré le grade

  indice=rbind2(indice,
                which(is.na(df),arr.ind = T)%>%as.data.frame())
  # difference NA quand 2 grades ne se correspondent pas dans les 2 tables. je garde NA

  if (nrow(indice)!=0){
    for (i in 1: nrow(indice)){

      if (is.na(df[indice[i,"row"],indice[i,"col"]]) & grepl(".r",colnames(df)[indice[i,"col"]])){

        tab$level=c(tab$level,"Mineur")
        tab$grade=c(tab$grade,df[indice[i,"row"],"grade"]%>%pull)
        tab$table=c(tab$table,"R")
        tab$main=c(tab$main,"Missing grade level")
        tab$valueR=c(tab$valueR,NA)
        if (indice[i,"col"]%%2==0){
          tab$valueSAS=c(tab$valueSAS,
                         df[indice[i,"row"],indice[i,"col"]+2] %>%pull )
        }else{
          tab$valueSAS=c(tab$valueSAS,
                         paste0(df[indice[i,"row"],indice[i,"col"]+2] %>%pull ,"%"))
        }
        tab$arm = c(tab$arm,str_extract(string=colnames(df)[indice[i,"col"]],pattern = "[:digit:]"))


      }else if (is.na(df[indice[i,"row"],indice[i,"col"]]) & grepl(".sas",colnames(df)[indice[i,"col"]])){

        tab$level=c(tab$level,"Mineur")
        tab$grade=c(tab$grade,df[indice[i,"row"],"grade"]%>%pull)
        tab$table=c(tab$table,"SAS")
        tab$main=c(tab$main,"Missing grade level")
        if (indice[i,"col"]%%2==0){ #means number
          tab$valueR=c(tab$valueR, df[indice[i,"row"],indice[i,"col"]-2] %>% pull)
        }else{   #mean percentage
          tab$valueR=c(tab$valueR, paste0(df[indice[i,"row"],indice[i,"col"]-2] %>% pull,"%"))
        }
        tab$valueSAS=c(tab$valueSAS,NA)
        tab$arm = c(tab$arm,str_extract(string=colnames(df)[indice[i,"col"]],pattern = "[:digit:]"))

      }#else

        if(indice[i,"col"]%%2==0){

        tab$level=c(tab$level,"MAJEUR")
        tab$grade=c(tab$grade,df[indice[i,"row"],"grade"]%>%pull)
        tab$table=c(tab$table,"Both")
        tab$main=c(tab$main,"Different number")
        tab$arm = c(tab$arm,str_extract(string=colnames(df)[indice[i,"col"]],pattern = "[:digit:]"))
        if (grepl(".sas",colnames(df)[indice[i,"col"]])){
          tab$valueR=c(tab$valueR,df[indice[i,"row"],indice[i,"col"]-2]%>%pull)
          tab$valueSAS=c(tab$valueSAS,df[indice[i,"row"],indice[i,"col"]]%>%pull)
        }else{
          tab$valueR=c(tab$valueR,df[indice[i,"row"],indice[i,"col"]]%>%pull)
          tab$valueSAS=c(tab$valueSAS,df[indice[i,"row"],indice[i,"col"]+2]%>%pull)
        }
      }else if (indice[i,"col"]%%2==1){

        tab$level=c(tab$level,"MAJEUR")
        tab$grade=c(tab$grade,df[indice[i,"row"],"grade"]%>%pull)
        tab$table=c(tab$table,"Both")
        tab$main=c(tab$main,"Different percentage")
        tab$arm = c(tab$arm,str_extract(string=colnames(df)[indice[i,"col"]],pattern = "[:digit:]"))
        if (grepl(".sas",colnames(df)[indice[i,"col"]])){
          tab$valueR=c(tab$valueR,df[indice[i,"row"],indice[i,"col"]-2]%>%pull)
          tab$valueSAS=c(tab$valueSAS,df[indice[i,"row"],indice[i,"col"]]%>%pull)
        }else{
          tab$valueR=c(tab$valueR,df[indice[i,"row"],indice[i,"col"]]%>%pull)
          tab$valueSAS=c(tab$valueSAS,df[indice[i,"row"],indice[i,"col"]+2]%>%pull)
        }

      }


    }}



  if (nrow(tabRraw)==nrow(tabSASraw) & ncol(tabRraw)==ncol(tabSASraw) & nrow(indice)==0 ){
    # warning("Comparison result: same outputs")

    tablo = tabRraw%>%
      full_join(tabSASraw,
                by="grade",
                suffix = c("_r","_sas"))%>%
      flextable()%>%
      add_footer_lines( "Comparison result: same outputs", top=TRUE) %>%
      autofit() %>%
      add_header_row( values = c("grade","R table", "SAS table"), colwidths = c(1,ncol(tabRraw)-1, ncol(tabSASraw)-1)) %>%
      align(part="header", align="center",i=1)%>%
      bold(part="header") %>%
      # bold(i=~N1_r!=N1_sas,j=c(2,4))%>%
      vline(j=ncol(tabRraw), part = "body") %>%

      set_header_labels(values= c(colnames(tabRraw),colnames(tabSASraw)[-1])) %>%
      merge_at(i=c(1,2),j=1,  part = "header")%>%
      align(part="body", align="center",j=1)
  }else{
    tablo=as.data.frame(tab)%>%
      #distinct(level,grade,table,main,.keep_all = TRUE) %>%
      flextable()%>%
      bold(part="header") %>%
      align(part="body", align="right",i=~str_detect(valueR,pattern="[:digit:]"),j="valueR")%>%
      align(part="body", align="right",i=~str_detect(valueSAS,pattern="[:digit:]"),j="valueSAS")%>%
      autofit() %>%
      bg(i=~level=="MAJEUR",bg="#f06d4d")
  }


  return(tablo)
}


