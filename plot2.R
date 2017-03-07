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


## Combining the date and time together and store in datetime
dat$datetime <- with(dat, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))


## Setting up the canvas
png("plot2.png",width=480,height=480,units="px")

with(dat, plot(datetime, Global_active_power, type = 'l', xlab="", ylab =  "Global Active Power (kilowatts)"))
## Closing the device
dev.off()