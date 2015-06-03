# Here we determine operting system to use correct upload method
Windows <- FALSE
if(Sys.info()["sysname"]=="Windows") Windows <- TRUE


#Here we check is data file already uploaded
file.in.a.hole <- F
if("household_power_consumption.txt" %in% dir()) file.in.a.hole <- T


# Here we download data file, read it 

if (!file.in.a.hole) {
url.data.file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp.zip.file.name <- "temp.zip"
data.file<-"household_power_consumption.txt"
if(Windows) download.file(url.data.file, temp.zip.file.name) else
    download.file(url.data.file, temp.zip.file.name, method="curl")
unzip(temp.zip.file.name)
file.remove(temp.zip.file.name)
}


# Here we check if the package "sqldf" exists and if it does not we upload it.
# Then we attach it.

if(!("sqldf" %in% installed.packages())) install.packages("sqldf")
library(sqldf)


# Here we read data from the dates 2007-02-01 and 2007-02-02 using sqldf package.

data.set <- read.csv.sql(data.file, sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header = TRUE, sep = ";")

# And finally we build the plot. No size adjustment needed since 480x480 is default value for png().

attach(data.set)
png(filename="plot1.png")
hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()