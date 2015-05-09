## Install necessary libraries
install.packages('sqldf')
library(sqldf)

## Load the data for the two days we are interested in 1/2/2007 and 2/2/2007
data <- read.csv.sql('household_power_consumption.txt', sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"', header = T, sep = ';')

## Create a DateTime vector that pastes Date and Time together and convert to Date/Time format
DateTime <- paste(data$Date, data$Time)
DateTime <- strptime(DateTime, format = '%d/%m/%Y %H:%M:%S')

## Bind the DateTime vector to the data frame
data <- cbind(DateTime, data)

## Open a PNG device, create the plot and close the device
png(file = 'plot4.png')

## Modify the parameters in order to have several plots in one device
par(mfrow = c(2,2))

## 1st plot
plot(data$DateTime, data$Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)')

## 2nd plot
plot(data$DateTime, data$Voltage, type = 'l', xlab = 'DateTime', ylab = 'Voltage')

## 3rd plot
plot(data$DateTime, data$Sub_metering_1, type = 'l', col = 'black', xlab = '', ylab = 'Energy sub metering')
lines(data$DateTime, data$Sub_metering_2, col = 'red')
lines(data$DateTime, data$Sub_metering_3, col = 'blue')
legend('topright', lty = 1, col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

## 4th plot
plot(data$DateTime, data$Global_reactive_power, type = 'l', ylab = 'Global Reactive Power', xlab = 'DateTime')

dev.off()
