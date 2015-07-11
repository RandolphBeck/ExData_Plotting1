## Read in the raw data file, which is assumed to be in the active working directory
## placing header in column names, using ; as the separator,
##   changing the "?" to NA, and setting as.is so Date and Time remain strings
dat<-read.table("household_power_consumption.txt",header=T,sep=";",na.strings="?",as.is=T)

## Convert the Date vector from string to Date class and store it in vector k
k<-as.Date(dat$Date,"%d/%m/%Y")

## Replace the Date column with the converted vector
dat$Date<-k

## Create a new data table with just Feb 1 and Feb 2, 2007 
d<-dat[c(which(k=="2007-02-01"),which(k=="2007-02-02")),]

## Clear out the temporary variables
remove(dat)
remove(k)

## Open a png device
png(file="Plot4.png")

## Set up a 2 x 2 array of graphs, filled rowwise
par(mfrow=c(2,2))

## Set up a date-time vector combining the Date and Time columns
datetime<-strptime(paste(d$Date,d$Time),format="%Y-%m-%d %H:%M:%S")

## Reduce the size of axis and label text to match the target examples
par(cex.axis=.75,cex.lab=.75)

## Plot Global active power use vs the date-time formed by combining the date and time fields
plot(datetime,d$Global_active_power,t="l",ylab="Global Active Power (kilowatts)",xlab="")

## Plot Voltage vs the date-time formed by combining the date and time fields
plot(datetime, d$Voltage,t="l",ylab="Voltage")

## Plot Sub-metering data use vs the date-time formed by combining the date and time fields
plot(datetime,d$Sub_metering_1,t="l",ylab="Energy sub metering",xlab="")
lines(datetime,d$Sub_metering_2,col="red")
lines(datetime,d$Sub_metering_3,col="blue")

##Add the appropriate legend
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.75,bty="n",lwd=1,col=c("black","red","blue"))

## Plot Global Reactive Power vs the date-time formed by combining the date and time fields
plot(datetime,d$Global_reactive_power,ylab="Global_reactive_power",t="l")

## Close the connection
dev.off()


