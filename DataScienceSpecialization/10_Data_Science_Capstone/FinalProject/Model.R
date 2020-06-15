
##################### Preparation #####################

library(stringi)
library(knitr)
library(tm)
#library(RWeka) # N-grams dosen't work
library(quanteda) # N-grams

# change system language
Sys.setlocale("LC_TIME", "English")

# read data
setwd("D:/Courses/Coursera/Data_Science_JHU/10_Data_Science_Capstone/FinalProject")

con <- file("en_US.news.txt", open="r")
news <- readLines(con, encoding="UTF-8")
close(con)

con <- file("en_US.blogs.txt", open="r")
blogs <- readLines(con, encoding="UTF-8")
close(con) 

con <- file("en_US.twitter.txt", open="r")
twitter <- readLines(con, encoding="UTF-8")
close(con)


##################### Functions #####################

str.sample <- function(string, proportion=0.005) {
    sample(string, length(string) * proportion)
}

str.token <- function(string, n) {
    token <- tokens(string, what="word", remove_numbers=TRUE, 
                    remove_punct=TRUE, remove_separators=TRUE, 
                    remove_symbols=TRUE)
    token <- tokens_ngrams(token, n)
    return(token)
}

str.freq <- function(token) {
    token.dfm <- dfm(token, tolower=TRUE, remove=stopwords("english"),
                     remove_punct=TRUE)
    freq <- topfeatures(token.dfm, 10000)
    freq <- freq[order(freq, decreasing = T)]
    data.frame("words"=names(freq), "freq"=freq)
}



##################### Ngrams #####################

blogs <- str.sample(blogs, 0.4)
news <- str.sample(news, 0.4)
twitter <- str.sample(twitter, 0.4)

string <- c(blogs, news, twitter)

## bigram
string.token <- str.token(string, 2)
bigram <- str.freq(string.token)
bigram.words <- strsplit(as.character(bigram$words),split="_")
bigram <- data.frame("freq"=bigram$freq, 
                     "first"=sapply(bigram.words, function(x) x[1]),
                     "second"=sapply(bigram.words, function(x) x[2]))
saveRDS(bigram, "bigram.rds")

## trigram
string.token <- str.token(string, 3)
trigram <- str.freq(string.token)
trigram.words <- strsplit(as.character(trigram$words),split="_")
trigram <- data.frame("freq"=trigram$freq, 
                     "first"=sapply(trigram.words, function(x) x[1]),
                     "second"=sapply(trigram.words, function(x) x[2]),
                     "third"=sapply(trigram.words, function(x) x[3]))
saveRDS(trigram, "trigram.rds")

## quadgram 
string.token <- str.token(string, 4)
quadgram <- str.freq(string.token)
quadgram.words <- strsplit(as.character(quadgram$words),split="_")
quadgram <- data.frame("freq"=quadgram$freq, 
                      "first"=sapply(quadgram.words, function(x) x[1]),
                      "second"=sapply(quadgram.words, function(x) x[2]),
                      "third"=sapply(quadgram.words, function(x) x[3]),
                      "fourth"=sapply(quadgram.words, function(x) x[4]))
saveRDS(quadgram, "quadgram.rds")

## fivegram 
string.token <- str.token(string, 5)
fivegram <- str.freq(string.token)
fivegram.words <- strsplit(as.character(fivegram$words),split="_")
fivegram <- data.frame("freq"=fivegram$freq, 
                       "first"=sapply(fivegram.words, function(x) x[1]),
                       "second"=sapply(fivegram.words, function(x) x[2]),
                       "third"=sapply(fivegram.words, function(x) x[3]),
                       "fourth"=sapply(fivegram.words, function(x) x[4]),
                       "fifth"=sapply(fivegram.words, function(x) x[5]))
saveRDS(fivegram, "fivegram.rds")
