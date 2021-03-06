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


# Plot 1
xlabel <- 'Global Active Power (kilowatts)'
main_title <- "Global Active Power"
png('plot1.png', width = 480, height = 480)
hist(dat$Global_active_power, col = 'red', xlab = xlabel, main = main_title)
dev.off()
         