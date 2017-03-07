library(data.table)

## Setting up the colomn names and classes for faster date loading
mynames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
             "Voltage","Global_intensity", "Sub_metering_1", "Sub_metering_2", 
             "Sub_metering_3")
myclass <-  c("character", "character", "numeric", "numeric", "numeric", 
              "numeric", "numeric", "numeric", "numeric")

## Loading data, reading only the rows we need 
dat <- fread("household_power_consumption.txt",sep = ';', header = FALSE, 
              na.strings = '?', colClasses = myclass, col.names = mynames,
              skip = 66637, nrows = 2880)

## Setting up the canvas
png("plot1.png",width=480,height=480,units="px")

hist(dat$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

## Closing the device
dev.off()
