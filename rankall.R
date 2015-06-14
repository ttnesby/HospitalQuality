rankall <- function(outcome, num = "best") {
     
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
     
     ## Prepare a function for ranking per state, data will be data.frame
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
     
     ## Split the data set for each state and apply rankingstate function
     result <- lapply(split(data, data$state), rankstate, num)
     
     ## Convert the result from list to data.frame
     resultdf <- data.frame(Reduce(rbind, result))
     
     ## Sort result data according to state
     resultdf <- resultdf[order(resultdf$state), ]
}
