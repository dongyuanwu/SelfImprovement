
# Ranking hospitals by outcome in a state

rankall <- function(outcome, num = "best") {
    
    ## Read outcome data
    data <- read.csv(choose.files(), colClasses = "character")
    
    ## Check that outcome and num are valid
    if(!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
        stop('invalid outcome')
    }
    if((!num %in% c("best", "worst")) & !is.numeric(num)) {
        stop('invalid num')
    }
    
    ## Create a subset for convenience
    if(outcome == "heart attack") {
        subdata <- data[, c(2, 7, 11)]
    }else if(outcome == "heart failure") {
        subdata <- data[, c(2, 7, 17)]
    }else {
        subdata <- data[, c(2, 7, 23)]
    }
    subdata[, 3] <- as.numeric(subdata[, 3])
    subdata <- subdata[complete.cases(subdata), ]
    subdata <- subdata[order(subdata[ ,2]), ]
    colnames(subdata) <- c("hospital", "state", "rate")
    
    ## For each state, find the hospital of the given rank
    uniq_state <- unique(subdata[, 2])
    rankset <- NULL
    
    if(num == "best") {
        for(i in 1:length(uniq_state)) {
            stateset <- subdata[subdata[, 2] == uniq_state[i], ]
            rankset <- rbind(rankset, stateset[order(stateset[, 3], stateset[, 1]), ])
        }
        output <- rankset[!duplicated(rankset[, 2]), c("hospital", "state")]
    }else if(num == "worst") {
        for(i in 1:length(uniq_state)) {
            stateset <- subdata[subdata[, 2] == uniq_state[i], ]
            rankset <- rbind(rankset, stateset[order(stateset[, 3], stateset[, 1],
                                                     decreasing=TRUE), ])
        }
        output <- rankset[!duplicated(rankset[, 2]), c("hospital", "state")]
    }else {
        n_hos <- rep(0, length(uniq_state))
        output <- data.frame(hospital=NULL, state=NULL)
        for(i in 1:length(uniq_state)) {
            stateset <- subdata[subdata[, 2] == uniq_state[i], ]
            rankset <- rbind(rankset, stateset[order(stateset[, 3], stateset[, 1]), ])
            n_hos[i] <- nrow(stateset)
        }
        flag <- num > n_hos
        for(i in 1:length(flag)){
            if(flag[i]) {
                output <- rbind(output, data.frame(hospital=NA, state=uniq_state[i]))
            }else {
                stateset <- rankset[rankset[, 2] == uniq_state[i], c("hospital", "state")]
                output <- rbind(output, stateset[num, ])
            }
        }
    }
    
    ## Return a data frame with the hospital names and the (abbreviated) state name
    output
}