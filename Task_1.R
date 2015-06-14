# Set relevant working dir
setwd("~/Documents/GitHub/Coursera/RProgramming/HospitalQuality")

# Read the outcome CSV file
outcome <- read.csv("./data/outcome-of-care-measures.csv", colClasses = "character")

# See a few rows
head(outcome)

# Convert col "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" to numeric
outcome[, 11] <- as.numeric(outcome[, 11]) # Warning for Not Available to NA

# Plot histogram of col 11
hist(outcome[, 11])
