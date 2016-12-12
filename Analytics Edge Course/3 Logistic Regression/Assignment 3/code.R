#Reading Data and Analysing
dataset = read.csv('parole.csv')
str(dataset)
table(dataset$violator)

#Converting State and crime to factor as it is not understood correctly by R in the present form
dataset$state = as.factor(dataset$state)
dataset$crime = as.factor(dataset$crime)
str(dataset)

#Splitting
set.seed(144)
library(caTools)
split = sample.split(dataset$violator, SplitRatio = 0.7)
train = subset(dataset, split == TRUE)
test = subset(dataset, split == FALSE)


#Model 1
model1 = glm(violator ~ ., data=train, family=binomial)
summary(model1)


#Predictions
predictTest = predict(model1, type="response", newdata=test)
max(predictTest)

table(test$violator, predictTest > 0.5)
#Accuracy = 0.8861386

#Baseline Model Analysis, Predict all not Top10
table(test$violator)
#Accuracy = 0.8861386

library(ROCR)
ROCRpred = prediction(predictTest, test$violator)
as.numeric(performance(ROCRpred, "auc")@y.values)
