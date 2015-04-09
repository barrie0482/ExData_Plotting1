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
# Open a png device and save plot to file
png(filename = 'plot1.png', width=480, height=480, res=72)
# Create a histogram
with(mydata, hist(Global_active_power, main = "Global Active Power", 
                  col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency"))
# Close the png device
dev.off()
# Clean up Global Environment
rm(list=ls())
