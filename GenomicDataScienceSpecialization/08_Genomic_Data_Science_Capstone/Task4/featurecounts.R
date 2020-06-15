
dir <- list.files(getwd(), pattern=".tabular")
datlist <- vector(mode="list", length=length(dir))
sample <- c("R3452", "R3462", "R3485", "R2869", "R3098", "R3467")
for (i in 1:length(dir)) {
    datlist[[i]] <- read.table(dir[i], skip=1)
    colnames(datlist[[i]]) <- c("GENEID", sample[i])
}


library(plyr)
dat <- join_all(datlist, by="GENEID", type="full", match="all")

write.table(dat, "featurecounts.txt", quote=FALSE, sep="\t", row.names=FALSE)
