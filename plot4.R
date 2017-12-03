power_data_file <- "D:/Projects/R/Coursera - Exploratory Data Analysis/Exploratory Data Analysis Week 1 Project/data/household_power_consumption.txt"

power_data <- read.csv(power_data_file, sep=";", stringsAsFactors = FALSE)

power_data$Datetime <- strptime(paste(power_data$Date, power_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

power_data$Date <- strptime(power_data$Date, "%d/%m/%Y")
power_data$Time <- strptime(power_data$Time, "%H:%M:%S")
power_data$Global_active_power <- as.numeric(power_data$Global_active_power)
power_data$Global_reactive_power <- as.numeric(power_data$Global_reactive_power)
power_data$Voltage <- as.numeric(power_data$Voltage)
power_data$Sub_metering_1 <- as.numeric(power_data$Sub_metering_1)
power_data$Sub_metering_2 <- as.numeric(power_data$Sub_metering_2)
power_data$Sub_metering_3 <- as.numeric(power_data$Sub_metering_3)

from_date <- strftime("2007-02-01", "%Y-%m-%d")
to_date <- strftime("2007-02-02", "%Y-%m-%d")

date_select <- power_data$Date >= from_date & power_data$Date <= to_date & !is.na(power_data$Sub_metering_1) & !is.na(power_data$Sub_metering_2) & !is.na(power_data$Sub_metering_3)

power_data_sub <- power_data[date_select, ]

par(mfrow=c(2, 2), bg = "white")

plot(power_data_sub$Datetime, power_data_sub$Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(power_data_sub$Datetime, power_data_sub$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(power_data_sub$Datetime, power_data_sub$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(power_data_sub$Datetime, power_data_sub$Sub_metering_2, col="red")
lines(power_data_sub$Datetime, power_data_sub$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=2.5, lty=1, bty="n", cex=0.8)

plot(power_data_sub$Datetime, power_data_sub$Global_reactive_power, type="l", xlab="datetime", ylab="Global_relative_power")

dev.copy(png, "plot4.png")
dev.off()