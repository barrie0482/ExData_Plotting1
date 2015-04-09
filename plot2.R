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
png(filename = 'plot2.png', width=480, height=480, res=72)
# Create the plot
plot(mydata$timestamp, mydata$Global_active_power, type="l",axes = FALSE, xlab = "", ylab = "")
# Create x axis (bottom) tick points and and tick point labels
axis(1,at=c(1170288000,1170374400,1170460800), labels=c("Thu","Fri","Sat"))
# Create y axis (left) tick points and tick point labels
axis(2)
# Create y axis label
title(ylab = "Global Active Power (kilowatts)",cex.lab=0.8)
# Draw a box around the plot
box()
# Close the png device
dev.off()
# Clean up Global Environment
rm(list=ls())
