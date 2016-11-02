#Dates are represented by the Date class
#Times are represented by the POSIXct and POSIXlt classes
#Dates are stored as number of days since 1970-01-01
#Times are stored as number of seconds since 1970-01-01

x <- as.Date("1970-01-01")
x
## [1] "1970-01-01"
unclass(x)
## [1] 0
unclass(as.Date("1970-01-02"))
## [1] 1


x <- Sys.time()
x
## [1] "2016-06-07 00:59:45 IST"
p <- as.POSIXlt(x)
names(unclass(p))
# [1] "sec"    "min"    "hour"   "mday"   "mon"    "year"   "wday"   "yday"   "isdst" 
# [10] "zone"   "gmtoff"
p$sec
# [1] 45.30898
unclass(x)
# [1] 1465241385


datestring <- c("January 10, 2016 10:40", "February 5, 2016 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
#[1] "2016-01-10 10:40:00 IST" "2016-02-05 09:10:00 IST"


x <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
y <- as.Date("2012-01-01")
y-x
#Error in y - x : non-numeric argument to binary operator
#In addition: Warning message:
#  Incompatible methods ("-.Date", "-.POSIXt") for "-" 
y <- as.POSIXlt(y)
y-x
# Time difference of 356.747 days


# it keeps track of time zones, leap years, etc
x <- as.POSIXct("2016-01-05 01:00:00")
y <- as.POSIXct("2016-01-05 01:00:00", tz = "GMT")
y-x
#Time difference of 5.5 hours