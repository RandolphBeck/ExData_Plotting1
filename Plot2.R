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

## Reduce the axis labels to match the size of the example, approximately
par(cex.axis=.75,cex.lab=.75)

## Plot Global active power use vs the date-time formed by combining the date and time fields
plot(strptime(paste(d$Date,d$Time),format="%Y-%m-%d %H:%M:%S"),d$Global_active_power,t="l",ylab="Global Active Power (kilowatts)",xlab="")

## Output the plot to a png file & close the connection
dev.copy(png,file="plot2.png")
dev.off()
