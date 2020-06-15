complete <- function(directory, id = 1:332) {
    setwd(directory)
    nobs <- NULL
    for(i in id) {
        i_char <- as.character(i)
        if(nchar(i_char) != 3) {
            zero <- paste(rep("0", times=3-nchar(i_char)), collapse="")
            i_char <- paste(zero, i_char, sep = "")
        }
        input <- read.csv(paste(i_char, ".csv", sep=""))
        nobs <- c(nobs, sum(complete.cases(input)))
    }
    data.frame(id = id, nobs = nobs)
}