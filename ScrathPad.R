# Task 2 best.R

outcome <- "heart attack"
num <- 20

# Set relevant working dir
setwd("~/Documents/GitHub/Coursera/RProgramming/HospitalQuality")

## Relevant outcomes and corresponding columns
outcome_and_column <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)

## Check that outcome is valid
if (!is.element(outcome, names(outcome_and_column))) stop("invalid outcome")

ranking_char <- c("best", "worst")

## Check that num is valid, either as ranking_char or > 0
if (is.character(num) & !is.element(num, ranking_char)) stop("invalid num")

if (is.numeric(num) & num <= 0) stop("invalid num")

## Read outcome data
data <- read.csv("./data/outcome-of-care-measures.csv", colClasses = "character")

col <- outcome_and_column[outcome]

## Convert current outcome vector to numeric - suppressing warning
data[, col] <- suppressWarnings(as.numeric(data[, col]))

## Keep only data for hospital name, state and outcome - disregard NA's
data <- data[!is.na(data[, col]), c(2, 7, col)]
names(data) <- c("hospital", "state","outcome")

test <- split(data, data$state)

class(test[[1]])

test$AK

data.frame(hospital = c(NA), state = "TX")

lapply(split(data, data$state), function(data, ...){num}, num)

rankstate <- function(data, num){

     ## Sort the data by outcome hospital 
     data <- data[order(data$outcome, data$hospital), ]
     
     current_state <- data[[1, 2]]
     no_hospital <- data.frame(hospital = c(NA), state = current_state)
     
     if (is.character(num) & num == "best")  return(data[1, c("hospital","state")])
     if (is.character(num) & num == "worst") return(data[nrow(data), c("hospital","state")])
     if (is.numeric(num) & num > nrow(data)) return(no_hospital)
     
     data[num, c("hospital", "state")]
}

mylist <- lapply(split(data, data$state), rankstate, num)

names(mylist)

t1 <- do.call(rbind, lapply(mylist, data.frame, stringsAsFactors=FALSE))

t2 <- data.frame(Reduce(rbind, mylist))

sapply(mylist, function(data) data[1])

head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)
