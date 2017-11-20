url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

library(dplyr)
library(readr)


household_power_consumption <- read_delim("D:/Users/s36733/Downloads/household_power_consumption.txt",
                                          ";", 
                                          escape_double = FALSE, 
                                          trim_ws = TRUE)

household_power_consumption$Date <- as.Date.character(household_power_consumption$Date, "%d/%m/%Y")


dat <- household_power_consumption %>%
  filter(between(.$Date, as.Date.character("2007-02-01"), as.Date.character("2007-02-02")))



dat$DateTime <- paste(dat$Date, dat$Time)
dat$DateTime <- strptime(dat$DateTime, format = "%Y-%m-%d %H:%M:%S")

# Plot 2
ylabel1 <- 'Global Active Power'
png('plot4.png', width = 480, height = 480)
par(mfrow = c(2,2))
plot(dat$DateTime, dat$Global_active_power, type = 'l', ylab = ylabel1, xlab = "")
plot(dat$DateTime, dat$Voltage, type = 'l', xlab = "datetime", ylab = "Voltage")
plot(dat$DateTime, dat$Sub_metering_1, type = 'l', ylab = ylabel, xlab = "")
lines(dat$DateTime, dat$Sub_metering_2, col = 'red')
lines(dat$DateTime, dat$Sub_metering_3, col = "blue")
legend("topright", col = c('black', 'red', 'blue'), legend = paste0('Sub_metering_',1:3), lty = 1, bty = 'n')
plot(dat$DateTime, dat$Global_reactive_power, type= 'l', xlab = "datetime", ylab = 'Global_reactive_power')
dev.off()
