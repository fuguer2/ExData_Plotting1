file = "household_power_consumption.txt"

# get the lines that contain the dates of interest
d=grep("^[12]/2/2007", readLines(file))

# speed hack to make this run faster during development since i know this is the right linenos
#d=66638:69517

# in this case i've already checked that max(d)-min(d)+1 = length(d) 
# so i know the data is all contiguous
skip = d[1] - 1
nrows = length(d)

# read the data from the 2 days in question Feb 1 & 2, 2007
df = read.csv(file, skip=skip, nrows=nrows, sep=";", na.strings="?", header=FALSE)
names(df) = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# format date and time
df$Date = as.Date(df$Date, "%d/%m/%Y")
df$DateTime <- strptime(paste(df$Date,df$Time, sep=" "),"%Y-%m-%d %H:%M:%S")

# Plot 1
png(file="plot1.png", width = 480, height = 480)
par(mfrow=c(1,1))
hist(df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
