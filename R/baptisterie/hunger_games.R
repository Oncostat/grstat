library(magrittr)
library(purrr)
library(tibble)
library(ggplot2)

#---- Functions ----

#Rules for one tournament
tournoi <- function(forces){
  estocades <- forces %>%
    map(~{rnorm(1, .x, 10)})
  winner <- names(which.max(estocades))
  return(winner)
}

#Simulation of N tournaments
tournois <- function(n_tournois, participants){
  victoires_participants <- as.list(setNames(rep(0, length(participants)), participants))
  force_participants <- as.list(setNames(nchar(participants), participants))
  for(i in 1:n_tournois){
    winner <- tournoi(force_participants)
    victoires_participants[[winner]] <- 1 + victoires_participants[[winner]]
  }
  return(victoires_participants)
}

#Displaying of results
histogramme_victoires <- function(tournois){
  data <- tibble(participants = names(tournois), nb_victoires = unlist(tournois))
  ggplot(data, aes(x = participants, y = nb_victoires, fill = participants)) +
    geom_col() +
    labs(x = "Participants", y = "Nombre de victoires") +
    ylim(c(0, 1000)) +
    theme(legend.position = "none")
}

#---- Fight ! ----

participants <- c("dan", "nus", "livia", "alde", "cha", "baptiste archambaud", "dat")
histogramme_victoires(tournois(1000, participants))


