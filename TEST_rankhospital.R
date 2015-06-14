## Set relevant working dir
setwd("~/Documents/GitHub/Coursera/RProgramming/HospitalQuality")

## Load best.R to test
source(paste(getwd(), "rankhospital.R", sep = "/"))

## Test cases
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)

rankhospital("MD", "heart attack", "test")
rankhospital("MN", "heart attack", 0)

## Clean up
rm(rankhospital)
