best <- function(state, outcome) {
     
     ## Relevant outcomes and corresponding columns
     outcome_and_column <- c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
     
     ## Check that outcome is valid
     if (!is.element(outcome, names(outcome_and_column))) stop("invalid outcome")
     
     ## Read outcome data
     data <- read.csv("./data/outcome-of-care-measures.csv", colClasses = "character")
     
     ## Check that state is valid
     if (!is.element(state, unique(data$State))) stop("invalid state")
     
     col <- outcome_and_column[outcome]
     
     ## Convert current outcome vector to numeric - suppressing warning
     data[, col] <- suppressWarnings(as.numeric(data[, col]))
     
     ## Get the minimum value for the current state and outcome, disregard NA's
     min_val <- min(data[data$State == state, col], na.rm = TRUE)
     
     ## Do the row selection (not NA's, current state and min val) in terms of a vector of boolean
     row_selection <- (!is.na(data[, col]) & data$State == state & data[, col] == min_val)
     
     ## Get all hospital names for the selected rows
     candidates <- data[row_selection, "Hospital.Name"]
     
     ## Lazy tie handling - independent of no. of candidates - return 1st from alphabetical sort
     sort(candidates)[1]
}