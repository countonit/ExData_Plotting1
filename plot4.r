#Setup the file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";", na.strings="?")
unlink(temp)

#subset for just the two days
twodays=subset(data, Date=="1/2/2007"|Date=="2/2/2007")

#create date time fields
x <- paste(twodays$Date, twodays$Time)
twodays$datetime=strptime(x, "%d/%m/%Y %H:%M:%S")
twodays$datetime2=as.POSIXct(twodays$datetime)

#Open Graphics Device
png(file="plot4.png", width = 480, height = 480)

#Plot 4
par(mfrow = c(2,2))
#par(mar = c(2,2,1,1))
plot(twodays$Global_active_power~twodays$datetime2, type="l", ylab="Global Active Power (kilowatts)", xlab="")
plot(twodays$Voltage~twodays$datetime2, type="l", ylab="Voltage", xlab="datetime")

plot(twodays$Sub_metering_1~twodays$datetime2, type="l", ylab="Energy sub metering", xlab="")
lines(twodays$Sub_metering_3~twodays$datetime2, col="blue")
lines(twodays$Sub_metering_2~twodays$datetime2, col="red")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), pch="___", col=c("black", "blue", "red"), bty="n")

plot(twodays$Global_reactive_power~twodays$datetime2, type="l", ylab="Global_reactive_power", xlab="datetime")

#Close Graphics Device
dev.off()