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

## Open a PNG device, create the histogram and close the device
png(file='plot1.png')
hist(data$Global_active_power, xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power', col = 'red')
dev.off()