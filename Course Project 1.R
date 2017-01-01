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

# Make plot 1
hist(EPCused$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()

# Make plot 2
plot(EPCused$timestamp, EPCused$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(EPCused$timestamp, EPCused$Global_active_power)
dev.copy(png, file = "plot2.png")
dev.off()

# Make plot 3
plot(EPCused$timestamp, EPCused$Global_active_power, type = "n", xlab = "", ylab = "Energy sub metering", ylim = c(0,30))
lines(EPCused$timestamp, EPCused$Sub_metering_1)
lines(EPCused$timestamp, EPCused$Sub_metering_2, col = "red")
lines(EPCused$timestamp, EPCused$Sub_metering_3, col = "blue")
legend(x = "topright", legend = (c("sub-metering_1", "sub-metering_2", "sub_metering_3")), lty = 1, col = c("black", "red", "blue"))
dev.copy(png, file = "plot3.png")
dev.off()

# Make plot 4
par(mfrow = c(2,2), mar = c(5,4,4,2))
# part 1
plot(EPCused$timestamp, EPCused$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(EPCused$timestamp, EPCused$Global_active_power)
# part 2
plot(EPCused$timestamp, EPCused$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(EPCused$timestamp, EPCused$Voltage)

# part 3
plot(EPCused$timestamp, EPCused$Global_active_power, type = "n", xlab = "", ylab = "Energy sub metering", ylim = c(0,30))
lines(EPCused$timestamp, EPCused$Sub_metering_1)
lines(EPCused$timestamp, EPCused$Sub_metering_2, col = "red")
lines(EPCused$timestamp, EPCused$Sub_metering_3, col = "blue")
legend(x = "topright", legend = (c("sub-metering_1", "sub-metering_2", "sub_metering_3")), lty = 1, col = c("black", "red", "blue"), cex = 0.4, bty = "n")

# part 4
plot(EPCused$timestamp, EPCused$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(EPCused$timestamp, EPCused$Global_reactive_power)

# copy to png
dev.copy(png, file = "plot4.png")
dev.off()
