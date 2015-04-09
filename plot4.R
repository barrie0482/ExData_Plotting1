setwd("C:/Users/baz/Copy/Data Analysis/4. Exploratory Data Analysis/src/Course Project 1/ExData_Plotting1")
# Load required libraries
library(dplyr)
library(lubridate)
# Download data file into a temp file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
# Extract and load the data file into memory
data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";",
                   colClasses=c("character","character", "numeric", "numeric", "numeric", 
                                "numeric", "numeric", "numeric", "numeric"),
                   na.strings = c("","?"))
# Delete the temp file
unlink(temp)
# Save the original data structure. Use a copy
mydata <- data
# Change the date into POSIXct
mydata$Date <- dmy(mydata$Date)
# Subset the data based on date range
mydata <- filter(mydata, Date>="2007-02-01", Date<"2007-02-03")
# Combine Date and Time into new column "timestamp"
mydata <- within(mydata, { timestamp=format(as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S") })
# Change timestamp column into POSIXct
mydata$timestamp <- dmy_hms(mydata$timestamp)
# Open a png device and save plot to file
png(filename = 'plot4.png', width=480, height=480, res=72)
# Create a 2 x 2 layout to display the plots
par(mfcol=c(2,2))
# Plot 1
# Create the plot
plot(mydata$timestamp, mydata$Global_active_power, type="l",axes = FALSE, xlab = "", ylab = "")
# Create x axis (bottom) tick points and and tick point labels
axis(1,at=c(1170288000,1170374400,1170460800), labels=c("Thu","Fri","Sat"))
# Create y axis (left) tick points and tick point labels
axis(2)
# Create y axis label
title(ylab = "Global Active Power",cex.lab=1)
# Draw a box around the plot
box()
# Plot 2
# Create the plot and the first data series
plot(mydata$timestamp, mydata$Sub_metering_1, type="l",axes = FALSE, xlab = "", ylab = "")
# Create the second data series
lines(mydata$timestamp, mydata$Sub_metering_2, type="l", xlab = "", ylab = "",col = "red")
# Create the second data series
lines(mydata$timestamp, mydata$Sub_metering_3, type="l", xlab = "", ylab = "", col = "blue")
# Create x axis (bottom) tick points and and tick point labels
axis(1,at=c(1170288000,1170374400,1170460800), labels=c("Thu","Fri","Sat"))
# Create y axis (left) tick points and tick point labels
axis(2)
# Create y axis label
title(ylab = "Energy sub metering",cex.lab=1)
# Create the legend in the top right of the plot
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty = 1, col = c("black","red","blue"), bty = "n")
# Draw a box around the plot
box()
# Plot 3 
# Create the plot
plot(mydata$timestamp, mydata$Voltage, type="l",axes = FALSE, xlab = "", ylab = "")
# Create x axis (bottom) tick points and and tick point labels
axis(1,at=c(1170288000,1170374400,1170460800), labels=c("Thu","Fri","Sat"))
# Create y axis (left) tick points and tick point labels
axis(2)
title(xlab = "datetime", ylab = "Voltage",cex.lab=1)
box()
# Plot 4 
# Create the plot
plot(mydata$timestamp, mydata$Global_reactive_power, type="l",axes = FALSE, xlab = "", ylab = "")
# Create x axis (bottom) tick points and and tick point labels
axis(1,at=c(1170288000,1170374400,1170460800), labels=c("Thu","Fri","Sat"))
# Create y axis (left) tick points and tick point labels
axis(2)
# Create y axis label
title(xlab = "datetime", ylab = "Global_reactive_power",cex.lab=1)
# Draw a box around the plot
box()
# Close the png device
dev.off()
# Clean up Global Environment
rm(list=ls())
