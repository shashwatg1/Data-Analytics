# Read Data
dataset = read.csv("census.csv")
library(caTools)
set.seed(2000)
spl = sample.split(dataset$over50k, SplitRatio = 0.6)
train = subset(dataset, spl == TRUE)
test = subset(dataset, spl == FALSE)

# Logistic Reg model
lgmodel = glm(over50k ~ ., data = train, family = "binomial")
summary(lgmodel)

predictions = predict(lgmodel, newdata = test, type = "response")
table(test$over50k,predictions >= 0.5) # Accuracy = 0.855

#Baseline Model
table(train$over50k) # predict all <= 50k
table(test$over50k) # accuracy = 0.759

library(ROCR)
ROCRpred = prediction(predictions,test$over50k)
as.numeric(performance(ROCRpred, "auc")@y.values) #AUC value
ROCRperf = performance(ROCRpred, "tpr", "fpr")
plot(ROCRperf)

#CART Model
library(rpart)
library(rpart.plot)
trmodel = rpart(over50k ~ ., data = train, method = "class")
prp(trmodel)
predictions = predict(trmodel, newdata = test)
table(test$over50k,predictions[,2]>=0.5) # accuracy = .847

ROCRpred = prediction(predictions[,2],test$over50k)
as.numeric(performance(ROCRpred, "auc")@y.values) #AUC value
ROCRperf = performance(ROCRpred, "tpr", "fpr")
plot(ROCRperf)

# RF Model
library(randomForest)
# Down sampling the training dataset
set.seed(1)
trainSmall = train[sample(nrow(train), 2000), ]
set.seed(1)
rfmodel = randomForest(over50k ~., data = trainSmall)
predictions = predict(rfmodel, newdata = test)
table(test$over50k, predictions) # accuracy = 0.8351184

# This code produces a chart that for each variable measures the number of times that variable was selected for splitting
vu = varUsed(rfmodel, count=TRUE)
vusorted = sort(vu, decreasing = FALSE, index.return = TRUE)
dotchart(vusorted$x, names(rfmodel$forest$xlevels[vusorted$ix]))

varImpPlot(rfmodel)
# A different metric we can look at is related to "impurity", which measures how homogenous each bucket or leaf of the tree is.
# In each tree in the forest, whenever we select a variable and perform a split, the impurity is decreased.
# Therefore, one way to measure the importance of a variable is to average the reduction in impurity, taken over all the times
# that variable is selected for splitting in all of the trees in the forest. This plot shows exactly that only.

# Cross Validation to selct CP
library(caret)
set.seed(2)
fitControl = trainControl( method = "cv", number = 10 )
cartGrid = expand.grid( .cp = seq(0.002,0.1,0.002)) 
train( over50k ~ . , data = train, method = "rpart", trControl = fitControl, tuneGrid = cartGrid ) # cp = 0.002

model = rpart(over50k~., data=train, method="class", cp=0.002)
prp(model)
predictions = predict(model, newdata = test)
table(test$over50k,predictions[,2]>=0.5) # accuracy = .86
