library(caTools)
library(ROCR)
library(rpart)
library(rpart.plot)
library(randomForest)
library(caret)

# Read Data
statedata = read.csv("statedataSimple.csv")
str(statedata)

# Linear Regression
lrmodel = lm(Life.Exp ~ ., data = statedata)
summary(lrmodel)
sum((lrmodel$residuals)^2) # SSE

lrmodel2 = lm(Life.Exp ~ Population + Murder + Frost + HS.Grad, data = statedata)
summary(lrmodel2)
sum((lrmodel2$residuals)^2) # SSE

# CART Model
cartmodel = rpart(Life.Exp ~ ., data = statedata)
prp(cartmodel)
pred = predict(cartmodel)
sum((pred-statedata$Life.Exp)^2)

cartmodel2 = rpart(Life.Exp ~ ., data = statedata, minbucket =5)
prp(cartmodel2)
pred2 = predict(cartmodel2)
sum((pred2-statedata$Life.Exp)^2)

cartmodel3 = rpart(Life.Exp ~ Area, data = statedata, minbucket =1)
prp(cartmodel3)
pred3 = predict(cartmodel3)
sum((pred3-statedata$Life.Exp)^2)

# Cross Validation
set.seed(111)
fitControl = trainControl( method = "cv", number = 10 )
cartGrid = expand.grid( .cp = seq(0.01,0.5,0.01)) 
train( Life.Exp ~ . , data = statedata, method = "rpart", trControl = fitControl, tuneGrid = cartGrid ) # cp = 0.11
model = rpart(Life.Exp~., data=statedata, cp=0.11)
prp(model)
pred = predict(model)
sum((pred-statedata$Life.Exp)^2)


set.seed(111)
train( Life.Exp ~ Area, data = statedata, method = "rpart", trControl = fitControl, tuneGrid = cartGrid ) # cp = 0.06
model2 = rpart(Life.Exp~Area, data=statedata, cp=0.06)
prp(model2)
pred = predict(model2)
sum((pred-statedata$Life.Exp)^2)
