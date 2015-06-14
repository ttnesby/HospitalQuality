## Set relevant working dir
setwd("~/Documents/GitHub/Coursera/RProgramming/HospitalQuality")

## Load best.R to test
source(paste(getwd(), "best.R", sep = "/"))

## Test cases
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")

## Clean up
rm(best)
