library(data.table)
suppressWarnings(consumption <- fread("household_power_consumption.txt",
                                      na.strings = c("?", "NA")))
consumption <- consumption[consumption$Date %in% c("1/2/2007", "2/2/2007"), ]
consumption <- as.data.frame(consumption)
consumption[, 3:9] <- as.numeric(unlist(consumption[, 3:9]))
names(consumption) <- c("date", "time", "activepower", "reactivepower",
                        "voltage", "intensity", "kitchenmeter", "laundrymeter", "utilmeter")
consumption <- transform(consumption, datetime = strptime(paste(date, time), 
                                                          "%d/%m/%Y %H:%M:%S"))

png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))
attach(consumption)

plot(datetime, activepower, col = "black", main = "", xlab = "",
                       type = "l", ylab = "Global Active Power")
plot(datetime, voltage, col = "black", main = "",  xlab = "datetime",
     type = "l", ylab = "Voltage")

plot(datetime, kitchenmeter, col = "black", main = "", 
     type = "l", ylab = "Energy sub metering", xlab = "")
lines(datetime, laundrymeter, col = "red")
lines(datetime, utilmeter, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
    "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

plot(datetime, reactivepower, col = "black", main = "",  xlab = "datetime",
     type = "l", ylab = "Global_reactive_power")

detach(consumption)
dev.off()