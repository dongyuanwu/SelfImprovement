
# read data
dataset <- read.table("household_power_consumption.txt", header=TRUE, 
                      sep=";", na.strings="?")

# only use data from the dates 2007-02-01 and 2007-02-02
dataset <- dataset[dataset$Date %in% c("1/2/2007", "2/2/2007"), ]

# convert date and time classes
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")
dataset$datetime <- strptime(paste(dataset$Date, dataset$Time), 
                             format="%Y-%m-%d %H:%M:%S")

# create a png file
png(filename="plot1.png", width=480, height=480, units="px")

# draw a plot
hist(dataset$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

# close the png file
dev.off()
