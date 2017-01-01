# Course project 1

# Clear environment, set working directory, load packages needed
rm(list = ls())
setwd("~/R/Coursera/Exploring Data")
library(lubridate)

# Load data
unzip("exdata_data_household_power_consumption.zip", "household_power_consumption.txt")

ElectricPowerConsumption <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,na.strings=c("?","NA"),
                                       colClasses = c("character", "character", rep("numeric",7)))
ElectricPowerConsumption$Date <- as.Date(ElectricPowerConsumption$Date, format = "%d/%m/%Y")

# Filter rows with data between 01/02/2007 and 02/02/2007
DateFrom <- dmy("01/02/2007")
DateTill <- dmy("02/02/2007")
EPCused <- subset(ElectricPowerConsumption, Date >= DateFrom & Date <= DateTill)
EPCused$timestamp <- ymd_hms(paste(EPCused$Date, EPCused$Time))
head(EPCused)

# Reclass the time variable in the dataset
EPCused$Time <- strptime(EPCused$Time, format = "%H:%M:%S")


# Make plot 2
plot(EPCused$timestamp, EPCused$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(EPCused$timestamp, EPCused$Global_active_power)
dev.copy(png, file = "plot2.png")
dev.off()