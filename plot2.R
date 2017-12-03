power_data_file <- "D:/Projects/R/Coursera - Exploratory Data Analysis/Exploratory Data Analysis Week 1 Project/data/household_power_consumption.txt"

power_data <- read.csv(power_data_file, sep=";", stringsAsFactors = FALSE)

power_data$Datetime <- strptime(paste(power_data$Date, power_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

power_data$Date <- strptime(power_data$Date, "%d/%m/%Y")
power_data$Time <- strptime(power_data$Time, "%H:%M:%S")
power_data$Global_active_power <- as.numeric(power_data$Global_active_power)

from_date <- strftime("2007-02-01", "%Y-%m-%d")
to_date <- strftime("2007-02-02", "%Y-%m-%d")

date_select <- power_data$Date >= from_date & power_data$Date <= to_date & !is.na(power_data$Global_active_power)

power_data_sub <- power_data[date_select, ]

par(bg = "white")

plot(power_data_sub$Datetime, power_data_sub$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.copy(png, "plot2.png")
dev.off()