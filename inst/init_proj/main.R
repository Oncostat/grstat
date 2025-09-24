

#Initialisation
source("R/init.R")
source("R/read.R")
source("R/populations.R")

#Data-management
# source("R/dm_treatments.R")
# source("R/dm_events.R")

#Description
source("R/09_inclusion.R")          #Section 09: Inclusion - populations, accrual, flowchart
source("R/10_baseline.R")           #Section 10: Description of the population at inclusion
source("R/11_treatments.R")         #Section 11: Treatment - adherence, doses...
source("R/12_tolerance.R")          #Section 12: Tolerance

#Analyses
source("R/13_efficacy.R")           #Section 13: Efficacy
source("R/14_other_analyses.R")     #Section 14: Other
source("R/15_ancillary_analyses.R") #Section 15: Ancillary

#Checking and reporting
source("R/check.R")
source("R/report.R")

beepr::beep()
stop("Analysis has been performed successfully")

