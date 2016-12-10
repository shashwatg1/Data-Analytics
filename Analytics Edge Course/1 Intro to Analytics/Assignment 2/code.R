IBM = read.csv("IBMStock.csv")
GE = read.csv("GEStock.csv")
ProcterGamble = read.csv("ProcterGambleStock.csv")
CocaCola = read.csv("CocaColaStock.csv")
Boeing = read.csv("BoeingStock.csv")

## 1st Part

IBM$Date = as.Date(IBM$Date, "%m/%d/%y")
GE$Date = as.Date(GE$Date, "%m/%d/%y")
CocaCola$Date = as.Date(CocaCola$Date, "%m/%d/%y")
ProcterGamble$Date = as.Date(ProcterGamble$Date, "%m/%d/%y")
Boeing$Date = as.Date(Boeing$Date, "%m/%d/%y")

summary(IBM)
sd(ProcterGamble$StockPrice)


## 2nd Part

plot(CocaCola$Date, CocaCola$StockPrice, 'l', col = 'red')
lines(ProcterGamble$Date, ProcterGamble$StockPrice, col = 'blue') # adds this new line plot on top of the existing plot
abline(v=as.Date(c("2000-03-01")), lwd=2) # adds a verticle line at a point of interest


## 3rd Part

plot(CocaCola$Date[301:432], CocaCola$StockPrice[301:432], type="l", col="red", ylim=c(0,210))
  #prices from 1995 through 2005, ylim sets range of y axis
lines(ProcterGamble$Date[301:432], ProcterGamble$StockPrice[301:432], col = 'blue')
lines(Boeing$Date[301:432], Boeing$StockPrice[301:432], col = 'green')
lines(GE$Date[301:432], GE$StockPrice[301:432], col = 'yellow')
lines(IBM$Date[301:432], IBM$StockPrice[301:432], col = 'orange')
abline(v=as.Date(c("2000-03-01"))) # adds a verticle line at a point of interest

abline(v=as.Date(c("1997-09-01")))
abline(v=as.Date(c("1997-11-01")))

abline(v=as.Date(c("2004-01-01")))
abline(v=as.Date(c("2005-01-01")))


## 4th Part

mean(IBM$StockPrice) # -> 144.375
tapply(IBM$StockPrice, months(IBM$Date), mean)

tapply(GE$StockPrice, months(GE$Date), mean)
tapply(CocaCola$StockPrice, months(CocaCola$Date), mean)
