
## Question 1

## The American Community Survey distributes downloadable data about
## United States communities. Download the 2006 microdata survey about
## housing for the state of Idaho using download.file() from here:

## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

## and load the data into R. The code book, describing the variable names is here:

## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

## Create a logical vector that identifies the households on greater than
## 10 acres who sold more than $10,000 worth of agriculture products.
## Assign that logical vector to the variable agricultureLogical. 
## Apply the which() function like this to identify the rows of the data frame 
## where the logical vector is TRUE: which(agricultureLogical)

## What are the first 3 values that result?


### Download the csv file
setwd("D:\\Courses\\Coursera\\Data_Science_JHU\\DataScienceSpecialization\\03_Getting_and_Cleaning_Data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "survey.csv")

### Load the csv file
survey <- read.csv("survey.csv")

### Create a logical vector
agricultureLogical <- survey$ACR == 3 & survey$AGS == 6

which(agricultureLogical)[1:3]



## Question 2

## Using the jpeg package read in the following picture of your instructor into R

## https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

## Use the parameter native=TRUE.
## What are the 30th and 80th quantiles of the resulting data?
## (some Linux systems may produce an answer 638 different for the 30th quantile)

library(jpeg)

### Download the jpg file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile = "pic.jpg", mode = "wb")

### Load the jpg file
pic <- readJPEG("pic.jpg", native = TRUE)

quantile(pic, probs = c(0.3, 0.8))



## Question 3

## Load the Gross Domestic Product data for the 190 ranked countries in this data set:

## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

## Load the educational data from this data set:

## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

## Match the data based on the country shortcode. How many of the IDs match? 
## Sort the data frame in descending order by GDP rank (so United States is last). 
## What is the 13th country in the resulting data frame?

## Original data sources:

## http://data.worldbank.org/data-catalog/GDP-ranking-table
## http://data.worldbank.org/data-catalog/ed-stats

### Download the csv file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "product.csv")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile = "educ.csv")

### Load the csv file
product <- read.csv("product.csv", skip = 4, nrows = 215) # according to original data sourses
product <- product[product$X != "" & !is.na(product$X), ]
educ <- read.csv("educ.csv")

### Rename product
product <- rename(product, CountryCode = X, Ranking = X.1, Long.Name = X.3, gdp = X.4)

### merge
newdata <- merge(product, educ, all = TRUE, by = "CountryCode")

sum(!is.na(unique(newdata$Ranking)))
arrange(newdata, desc(Ranking))[13, "Long.Name.x"]



## Question 4

## What is the average GDP ranking for the "High income: OECD" 
## and "High income: nonOECD" group?

library(plyr)
ddply(newdata, .(Income.Group), summarize, mean(Ranking, na.rm = TRUE))



## Question 5

## Cut the GDP ranking into 5 separate quantile groups. 
## Make a table versus Income.Group. How many countries are 
## Lower middle income but among the 38 nations with highest GDP?

library(Hmisc)
xtabs( ~ cut2(Ranking, g = 5) + Income.Group, data = newdata)
