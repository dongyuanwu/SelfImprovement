corr <- function(directory, threshold = 0) {
    setwd(directory)
    com_nobs <- which(complete(directory)$nobs > threshold)
    cr <- NULL
    if(length(com_nobs > 0)) {
        dat <- NULL
        for(i in com_nobs) {
            i_char <- as.character(i)
            if(nchar(i_char) != 3) {
                zero <- paste(rep("0", times=3-nchar(i_char)), collapse="")
                i_char <- paste(zero, i_char, sep = "")
            }
            input <- read.csv(paste(i_char, ".csv", sep=""))
            cr <- c(cr, cor(input$sulfate, input$nitrate, use="complete.obs"))
        }
    }
    cr
}