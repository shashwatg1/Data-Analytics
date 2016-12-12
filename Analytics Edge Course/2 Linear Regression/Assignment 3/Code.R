# Read Data
FluTrain = read.csv('FluTrain.csv')
FluTest = read.csv('FluTest.csv')
summary(FluTrain)
str(FluTrain)

FluTrain$Week[which.max(FluTrain$ILI)]
FluTrain$Week[which.max(FluTrain$Queries)]

hist(FluTrain$ILI)
plot(FluTrain$Queries, log(FluTrain$ILI))
# Log of ILI is linear to the Queries


# Make a model
FluTrend1 = lm(log(ILI)~Queries, data=FluTrain)
summary(FluTrend1)


# Predicting
PredTest1 = exp(predict(FluTrend1, newdata=FluTest)) #exp to go from log ILI to ILI
summary(PredTest1)

PredTest1[which(FluTest$Week == "2012-03-11 - 2012-03-17")]

plot(FluTrain$Queries, log(FluTrain$ILI))

(FluTest$ILI[11]-PredTest1[11])/FluTest$ILI[11]

SSE = sum((PredTest1 - FluTest$ILI)^2)
RMSE = sqrt(SSE/nrow(FluTest))
SST = sum((mean(FluTrain$ILI) - FluTest$ILI)^2)
R2 = 1 - (SSE/SST)
R2


# Training a Time Series Model
library(zoo)
ILILag2 = lag(zoo(FluTrain$ILI), -2, na.pad=TRUE) 
# -2 means return 2 observations before the current one, na.pad=TRUE means to add missing values

FluTrain$ILILag2 = coredata(ILILag2)
summary(FluTrain$ILILag2)

plot(log(FluTrain$ILILag2), log(FluTrain$ILI))

FluTrend2 = lm(log(ILI)~Queries+log(ILILag2), data=FluTrain)
summary(FluTrend2)


# Test Data
ILILag2 = lag(zoo(FluTest$ILI), -2, na.pad=TRUE) 
FluTest$ILILag2 = coredata(ILILag2)
summary(FluTest$ILILag2)

FluTest$ILILag2[1] = FluTrain$ILI[416]
FluTest$ILILag2[2] = FluTrain$ILI[417]

FluTest$ILILag2
FluTest$ILI

PredTest2 = exp(predict(FluTrend2, newdata=FluTest))
SSE = sum((PredTest2-FluTest$ILI)^2)
RMSE = sqrt(SSE / nrow(FluTest))