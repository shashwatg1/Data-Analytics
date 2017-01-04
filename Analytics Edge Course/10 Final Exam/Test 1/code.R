# load dataset
fedFunds = read.csv('federalFundsRate.csv', stringsAsFactors = FALSE)
str(fedFunds)
mean(fedFunds$RaisedFedFunds)
table(fedFunds$Chairman, fedFunds$RaisedFedFunds)

# Make factors
fedFunds$Chairman = as.factor(fedFunds$Chairman)
fedFunds$DemocraticPres = as.factor(fedFunds$DemocraticPres)
fedFunds$RaisedFedFunds = as.factor(fedFunds$RaisedFedFunds)
str(fedFunds)

# Train and test datasets
set.seed(201)
library(caTools)
spl = sample.split(fedFunds$RaisedFedFunds, 0.7)
training = subset(fedFunds, spl == TRUE)
testing = subset(fedFunds, spl == FALSE)

# Logistic regression model
model = glm(RaisedFedFunds ~ PreviousRate + Streak + Unemployment + HomeownershipRate + DemocraticPres + MonthsUntilElection, data = training, family = "binomial")
summary(model)

# Make predictions on training set
predictTest = predict(model, type="response", newdata = testing)
# Confusion matrix or Classification matrix, for threshold of 0.5
table(testing$RaisedFedFunds, predictTest > 0.5)

# AUC
library(ROCR)
ROCRpred = prediction(predictTest, testing$RaisedFedFunds)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")
# Plot ROC curve
plot(ROCRperf)
# Add colors
plot(ROCRperf, colorize=TRUE)
# Add threshold labels 
plot(ROCRperf, colorize=TRUE, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))

library(rpart)
library(rpart.plot)
library(caret)
library(e1071)
numFolds = trainControl( method = "cv", number = 10 ) # cv = cross validation. 10 folds.
cpGrid = expand.grid( .cp = seq(0.001,0.05,0.001))  # seq -> sequence 
# Perform the cross validation
train(RaisedFedFunds ~ PreviousRate + Streak + Unemployment + HomeownershipRate + DemocraticPres + MonthsUntilElection, data = training, method = "rpart", trControl = numFolds, tuneGrid = cpGrid)

# Create a new CART model
treeCV = rpart(RaisedFedFunds ~ PreviousRate + Streak + Unemployment + HomeownershipRate + DemocraticPres + MonthsUntilElection, data = training, method="class", cp = 0.016)
prp(treeCV)

# Make predictions
PredictCV = predict(treeCV, newdata = testing, type = "class")
table(testing$RaisedFedFunds, PredictCV)
