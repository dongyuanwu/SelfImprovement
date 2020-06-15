
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
png(filename="plot4.png", width=480, height=480, units="px")

# configure multiplot
par(mfrow=c(2, 2))

# draw 1st plot
with(dataset, plot(x=datetime, y=Global_active_power, type="l", xlab="",
     ylab="Global Active Power"))

# draw 2nd plot
with(dataset, plot(x=datetime, y=Voltage, type="l", ylab="Voltage"))

# draw 3rd plot
with(dataset, {
    plot(x=datetime, y=Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(x=datetime, y=Sub_metering_2, type="l", col="red")
    lines(x=datetime, y=Sub_metering_3, type="l", col="blue")
})
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1, 1, 1),
       col = c("black", "red", 'blue'),
       bty = "n")

# draw 4th plot
with(dataset, plot(x=datetime, y=Global_reactive_power, type="l", 
                   ylab="Global_reactive_power"))

# close the png file
dev.off()
