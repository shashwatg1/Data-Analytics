# Our goal will be to predict whether or not the stock return in December will be positive, using the stock returns for the first 11 months of the year.
stocks = read.csv('StocksCluster.csv')
str(stocks)
mean(stocks$PositiveDec)
cor(stocks)
summary(stocks)

# splitting the data
library(caTools)
set.seed(144)
spl = sample.split(stocks$PositiveDec, SplitRatio = 0.7)
stocksTrain = subset(stocks, spl == TRUE)
stocksTest = subset(stocks, spl == FALSE)

# logistic regression and accuracy on training set and testing set
StocksModel = glm(PositiveDec ~ ., data=stocksTrain, family=binomial)
PredictTrain = predict(StocksModel, type="response")
table(stocksTrain$PositiveDec, PredictTrain > 0.5) # 0.571
PredictTest = predict(StocksModel, type="response", newdata = stocksTest)
table(stocksTest$PositiveDec, PredictTest > 0.5) # 0.567

# baseling model
table(stocksTrain$PositiveDec) # always predict 1
table(stocksTest$PositiveDec) # 0.546

# Using clustering now and removing the dependent variable PositiveDec
limitedTrain = stocksTrain
limitedTrain$PositiveDec = NULL
limitedTest = stocksTest
limitedTest$PositiveDec = NULL

# normalizing
library(caret)
preproc = preProcess(limitedTrain)
normTrain = predict(preproc, limitedTrain)
normTest = predict(preproc, limitedTest)
summary(normTrain)
summary(normTest)

# K-means
set.seed(144)
km = kmeans(normTrain, centers = 3)
table(km$cluster)

library(flexclust)
km.kcca = as.kcca(km, normTrain)
clusterTrain = predict(km.kcca)
clusterTest = predict(km.kcca, newdata=normTest)
table(clusterTest)

# separating the data frames
stocksTrain1 = subset(stocksTrain, clusterTrain == 1)
stocksTrain2 = subset(stocksTrain, clusterTrain == 2)
stocksTrain3 = subset(stocksTrain, clusterTrain == 3)
stocksTest1 = subset(stocksTest, clusterTest == 1)
stocksTest2 = subset(stocksTest, clusterTest == 2)
stocksTest3 = subset(stocksTest, clusterTest == 3)

mean(stocksTrain1$PositiveDec)
mean(stocksTrain2$PositiveDec)
mean(stocksTrain3$PositiveDec)

# applying logistic regression on each cluster independently
StocksModel1 = glm(PositiveDec ~ ., data=stocksTrain1, family=binomial)
StocksModel2 = glm(PositiveDec ~ ., data=stocksTrain2, family=binomial)
StocksModel3 = glm(PositiveDec ~ ., data=stocksTrain3, family=binomial)
summary(StocksModel1)
summary(StocksModel2)
summary(StocksModel3)
# make predictions
PredictTest1 = predict(StocksModel1, newdata = stocksTest1, type="response")
PredictTest2 = predict(StocksModel2, newdata = stocksTest2, type="response")
PredictTest3 = predict(StocksModel3, newdata = stocksTest3, type="response")
table(stocksTest1$PositiveDec, PredictTest1 > 0.5) # 0.619
table(stocksTest2$PositiveDec, PredictTest2 > 0.5) # 0.55
table(stocksTest3$PositiveDec, PredictTest3 > 0.5) # 0.645

# combining all predictions and actual outcomes and getting combined accuracy of "cluster-then-predict"
AllPredictions = c(PredictTest1, PredictTest2, PredictTest3)
AllOutcomes = c(stocksTest1$PositiveDec, stocksTest2$PositiveDec, stocksTest3$PositiveDec)
table(AllOutcomes, AllPredictions > 0.5) # 0.578
