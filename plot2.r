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
png(file="plot2.png", width = 480, height = 480)

#Plot 2
plot(twodays$Global_active_power~twodays$datetime2, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#Close Graphics Device
dev.off()