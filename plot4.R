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
png("plot4.png",width=480,height=480,units="px")
par(mfrow = c(2,2))

## First plot
with(dat, plot(datetime, Global_active_power, type = 'l', xlab = "", ylab =  "Global Active Power"))

## Second plot
with(dat, plot(datetime, Voltage, type = 'l'))

## Third plot
with(dat,plot(datetime, Sub_metering_1, type = 'l', xlab = "", 
              ylab = "Energy sub metering"))
with(dat,lines(datetime, Sub_metering_2, col = "red"))
with(dat,lines(datetime, Sub_metering_3, col = "blue"))

legend("topright", lty=c(1,1,1),col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty='n')

## Fourth plot
with(dat, plot(datetime, Global_reactive_power, type = 'l'))

## Closing the device
dev.off()