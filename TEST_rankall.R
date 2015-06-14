## Set relevant working dir
setwd("~/Documents/GitHub/Coursera/RProgramming/HospitalQuality")

## Load best.R to test
source(paste(getwd(), "rankall.R", sep = "/"))

## Test cases
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

## Clean up
rm(rankall, rankstate)
