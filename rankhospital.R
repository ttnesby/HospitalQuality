rankhospital <- function(state, outcome, num = "best") {
     
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
     
     ## Check that state is valid
     if (!is.element(state, unique(data$State))) stop("invalid state")
     
     col <- outcome_and_column[outcome]
     
     ## Convert current outcome vector to numeric - suppressing warning
     data[, col] <- suppressWarnings(as.numeric(data[, col]))
     
     ## Keep only data for current state - outcome and hospital name - disregard NA's
     data <- data[!is.na(data[, col]) & data$State == state, c(col, 2)]
     
     ## Sort the data by outcome (new column 1) and hospital name (new column 2)
     data <- data[order(data[, 1], data[, 2]), ]
     
     if (is.character(num) & num == "best") return(data[1, 2])
     
     if (is.character(num) & num == "worst") return(data[nrow(data), 2])
     
     if (is.numeric(num) & num > nrow(data)) return(NA)
     
     data[num, 2]
}
