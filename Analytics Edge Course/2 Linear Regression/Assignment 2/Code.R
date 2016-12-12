# Read Data
pisaTrain = read.csv('pisa2009train.csv')
pisaTest = read.csv('pisa2009test.csv')

tapply(pisaTrain$readingScore, pisaTrain$male, mean)
summary(pisaTrain)
str(pisaTrain)

# Eliminating missing data observations
pisaTrain = na.omit(pisaTrain)
pisaTest = na.omit(pisaTest)

# changing the refernce level in the raceeth factor
pisaTrain$raceeth = relevel(pisaTrain$raceeth, "White") 
pisaTest$raceeth = relevel(pisaTest$raceeth, "White")

# Make a model
lmScore = lm(readingScore ~ ., data = pisaTrain) # This is to predict readingScore using all the other variables in the data frame
summary(lmScore)

SSE = sum((lmScore$residuals)^2)
RMSE = sqrt(SSE/nrow(pisaTrain))
RMSE


# Predicting
predTest = predict(lmScore, newdata = pisaTest)
summary(predTest)

SSE = sum((predTest - pisaTest$readingScore)^2)
RMSE = sqrt(SSE/nrow(pisaTest))
SST = sum((mean(pisaTrain$readingScore) - pisaTest$readingScore)^2)
R2 = 1 - (SSE/SST)
R2
