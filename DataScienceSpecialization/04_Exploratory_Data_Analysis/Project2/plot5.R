##########################################################

# Question 5

# How have emissions from motor vehicle sources changed from 1999¨C2008 in Baltimore City?

##########################################################

# read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get the subset for motor vehicles sourses in the Baltimore City
NEI.sub <- subset(NEI, fips=="24510" & type=="ON-ROAD")

# create a png file
png(filename="plot5.png", width=480, height=480, units="px")

# draw a plot
library(ggplot2)
ggplot(NEI.sub, aes(x=year, y=Emissions)) +
    stat_summary(fun.y = sum, geom="line") + 
    geom_point(stat='summary', fun.y=sum) + 
    labs(x="Year", y=expression(Total~PM[2.5]~Emissions~(tons)),
         title=expression(Total~PM[2.5]~Emissions~from~Motor~Vehicles~Sources~`in`~the~Baltimore~City)) +
    scale_x_continuous(breaks=c(1999, 2002, 2005, 2008))


# close the png file
dev.off()


##########################################################

# Emissions from motor vehicle sources have decreased from 1999-2008 in Baltimore City.

##########################################################