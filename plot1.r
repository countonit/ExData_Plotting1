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
png(file="plot1.png", width = 480, height = 480)

#Create the Plot
twodays$Global_active_power=as.numeric(as.character(twodays$Global_active_power))
hist(twodays$Global_active_power, ylab="Frequency", xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power", ylim=c(0,1200), xlim=c(0,6))

#Close Graphics Device
dev.off()