
## Question 1

### Download the csv file
setwd("D:\\Courses\\Coursera\\Data_Science_JHU\\DataScienceSpecialization\\03_Getting_and_Cleaning_Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "survey.csv")

### Load the csv file
survey <- read.csv("survey.csv")

### How many properties are worth $1,000,000 or more?
sum(survey$VAL == 24, na.rm = TRUE)


## Question 3

### Download the csv file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "gas.xlsx", mode='wb')

### Load the csv file
library(xlsx)
dat <- read.xlsx("gas.xlsx", sheetIndex = 1, colIndex = 7:15, rowIndex = 18:23)

### What is the value of:
sum(dat$Zip*dat$Ext,na.rm=T)


## Question 4

### Read the file into R
library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)

### How many restaurants have zipcode 21231?
sum(xpathSApply(rootNode, "//zipcode", xmlValue) == 21231)


## Question 5

### Read the file into R
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "communities.csv")

### Load the csv file
library(data.table)
DT <- fread("communities.csv")

### Which will deliver the fastest user time?
### The right answer may be something according to the data.table function,
### but actually there are four methods have 0 user time on my computer lol.
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(mean(DT[DT$SEX==1,]$pwgtp15)+mean(DT[DT$SEX==2,]$pwgtp15))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(rowMeans(DT)[DT$SEX==1]+rowMeans(DT)[DT$SEX==2])
