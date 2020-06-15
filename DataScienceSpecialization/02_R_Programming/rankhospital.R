
# Ranking hospitals by outcome in a state

rankhospital <- function(state, outcome, num = "best") {
    
    ## Read outcome data
    data <- read.csv(choose.files(), colClasses = "character")
    
    ## Check that state, outcome, and num are valid
    if(!state %in% unique(data[, "State"])) {
        stop('invalid state')
    }
    if(!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop('invalid outcome')
    }
    if((!num %in% c("best", "worst")) & !is.numeric(num)) {
        stop('invalid num')
    }
    
    ## Create a subset for convenience
    if(outcome == "heart attack") {
        subdata <- data[, c(2, 7, 11)]
    } else if(outcome == "heart failure") {
        subdata <- data[, c(2, 7, 17)]
    } else {
        subdata <- data[, c(2, 7, 23)]
    }
    subdata <- subdata[subdata[, 2] == state, ]
    subdata[, 3] <- as.numeric(subdata[, 3])
    subdata <- subdata[complete.cases(subdata), ]
    
    ## Reorder the outcome
    subdata <- subdata[order(subdata[, 3], subdata[, 1], decreasing=FALSE), ]
    
    ## Return hospital name in that state with the given rank 30-day death rate
    if(num == "best") {
        subdata[1, 1]
    } else if(num == "worst") {
        subdata[nrow(subdata), 1]
    } else if(num > nrow(subdata)) {
        NA
    } else {
        subdata[num, 1]
    }
}