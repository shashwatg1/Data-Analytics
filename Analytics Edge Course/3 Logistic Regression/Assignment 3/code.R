#Reading Data and Analysing
dataset = read.csv('loans.csv')
str(dataset)
table(dataset$not.fully.paid)
summary(dataset)

missing = subset(dataset, is.na(log.annual.inc) | is.na(days.with.cr.line) | is.na(revol.util) | is.na(inq.last.6mths) | is.na(delinq.2yrs) | is.na(pub.rec))

#Filling missing values using mice
library(mice)
set.seed(144)
vars.for.imputation = setdiff(names(dataset), "not.fully.paid")
imputed = complete(mice(dataset[vars.for.imputation]))
dataset[vars.for.imputation] = imputed
summary(dataset)

#This data for some reason is not the same as the data in the Video Series. Thus we use the imputed_datafile provided for the remaining half
dataset = read.csv('loans_imputed.csv')
summary(dataset)


#Splitting
set.seed(144)
library(caTools)
split = sample.split(dataset$not.fully.paid, SplitRatio = 0.7)
train = subset(dataset, split == TRUE)
test = subset(dataset, split == FALSE)

#Model 1
model1 = glm(not.fully.paid ~ ., data=train, family=binomial)
summary(model1)

#Predictions
test$predicted.risk = predict(model1, newdata=test, type="response")
table(test$not.fully.paid, test$predicted.risk > 0.5)
#Accuracy = 0.8364079

#Baseline Model Analysis, Predict all not Top10
table(test$not.fully.paid)
#Accuracy = 0.8398886

library(ROCR)
ROCRpred = prediction(test$predicted.risk, test$not.fully.paid)
as.numeric(performance(ROCRpred, "auc")@y.values)

#Model 2
model2 = glm(not.fully.paid ~ int.rate, data=train, family=binomial)
summary(model2)

predictTest = predict(model2, type="response", newdata=test)
table(test$not.fully.paid, predictTest > 0.5)
max(predictTest)

ROCRpred = prediction(predictTest, test$not.fully.paid)
as.numeric(performance(ROCRpred, "auc")@y.values)

#Calculating Profits
test$profit = exp(test$int.rate*3) - 1
test$profit[test$not.fully.paid == 1] = -1

max(test$profit)

highInterest = subset(test, int.rate>=.15)
mean(highInterest$profit)
mean(highInterest$not.fully.paid)

cutoff = sort(highInterest$predicted.risk, decreasing=FALSE)[100]

selectedLoans = subset(highInterest, predicted.risk<=cutoff)
sum(selectedLoans$profit)
sum(selectedLoans$not.fully.paid)
