
# Finding the best hospital in a state

best <- function(state, outcome) {
    
    ## Read outcome data
    data <- read.csv(choose.files(), colClasses = "character")
    
    ## Check that state and outcome are valid
    if(!state %in% unique(data[, "State"])) {
        stop('invalid state')
    }
    if(!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop('invalid outcome')
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
    
    ## Return hospital name in that state with lowest 30-day death rate
    subdata[1, 1]
}