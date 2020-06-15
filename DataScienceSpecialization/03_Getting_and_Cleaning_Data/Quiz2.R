
## Question 1

## Access the API to get information on your instructors repositories.
## Use this data to find the time that the datasharing repo was created.
## (hint: this is the url you want "https://api.github.com/users/jtleek/repos").
## What time was it created?

## This tutorial may be useful 
## (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r).

library(httr)

# 1. Find OAuth settings for github: http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("Quiz2",
                   key = "77ffa3ca63a7ac107057",
                   secret = "294727209c5dd20083e146d5dbd91b6d14e1701a"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
data <- content(req)
search <- sapply(data, function(x) sum(grep("datasharing", x))) # searching for datasharing
data[[which(search != 0)]]$created_at



## Question 2

## The sqldf package allows for execution of SQL commands on R data frames. 
## We will use the sqldf package to practice the queries we might send with 
## the dbSendQuery command in RMySQL.

## Download the American Community Survey data and load it into an R object
## called "acs" https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

## Which of the following commands will select only the data for the probability 
## weights pwgtp1 with ages less than 50?

library(sqldf)

### Download the csv file
setwd("D:\\Courses\\Coursera\\Data_Science_JHU\\DataScienceSpecialization\\03_Getting_and_Cleaning_Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "survey.csv")

### Load the csv file
acs <- read.csv("survey.csv")

### Try every command
sq1 <- sqldf("select pwgtp1 from acs where AGEP < 50")
sq2 <- sqldf("select pwgtp1 from acs")
sq3 <- sqldf("select * from acs where AGEP < 50")
sq4 <- sqldf("select * from acs")



## Question 3

## Using the same data frame you created in the previous problem, 
## what is the equivalent function to unique(acs$AGEP)

sq1 <- sqldf("select unique * from acs")
sq2 <- sqldf("select distinct AGEP from acs")
sq3 <- sqldf("select distinct pwgtp1 from acs")
sq4 <- sqldf("select AGEP where unique from acs")



## Question 4

## How many characters are in the 10th, 20th,
## 30th and 100th lines of HTML from this page:
## http://biostat.jhsph.edu/~jleek/contact.html

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
data <- readLines(con)
close(con)
c(nchar(data[10]), nchar(data[20]), nchar(data[30]), nchar(data[100]))



## Question 5

## Read this data set into R and report the sum of the numbers
## in the fourth of the nine columns.
## https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
## (Hint this is a fixed width file format)

library(foreign)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile = "ffile.for")

### This kind of file is weird. You need to set the width when loading.
### But if I have not loaded the data, how can I know its width??
### Finally I just refered len's tips and course notes to finish this question.
### https://github.com/lgreski/datasciencectacontent/blob/master/markdown/cleaningData-week2Q5.md

wid <- c(-1, 9, -5, 4, 4, -5, 4, 4, -5, 4, 4, -5, 4, 4)
data <- read.fwf(file = "ffile.for", skip = 4, widths = wid)
sum(data[, 4])
