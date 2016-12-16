# Read Data
gerber = read.csv("gerber.csv")
mean(gerber$voting)
tapply(gerber$voting, gerber$civicduty, mean)
tapply(gerber$voting, gerber$hawthorne, mean)
tapply(gerber$voting, gerber$self, mean)
tapply(gerber$voting, gerber$neighbors, mean)

LogModel = glm(voting ~ civicduty + hawthorne + self + neighbors, data=gerber, family="binomial")
summary(LogModel)
predictLog = predict(LogModel, type="response")
table(gerber$voting, predictLog > 0.3)
table(gerber$voting, predictLog > 0.5)

library(ROCR)
ROCRpred = prediction(predictLog, gerber$voting)
as.numeric(performance(ROCRpred, "auc")@y.values)

library(rpart)
library(rpart.plot)
CARTmodel = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber)
prp(CARTmodel)

CARTmodel2 = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber, cp=0.0)
prp(CARTmodel2)

CARTmodel3 = rpart(voting ~ civicduty + hawthorne + self + neighbors + sex, data=gerber, cp=0.0)
prp(CARTmodel3)

CARTcontrol = rpart(voting ~ control, data=gerber, cp=0.0)
CARTsex = rpart(voting ~ control + sex, data=gerber, cp=0.0)
prp(CARTcontrol, digits=6)
prp(CARTsex, digits=6)

LogModel2 = glm(voting ~ sex + control, data=gerber, family="binomial")
summary(LogModel2)

Possibilities = data.frame(sex=c(0,0,1,1),control=c(0,1,0,1))
predict(LogModel2, newdata=Possibilities, type="response")

LogModel3 = glm(voting ~ sex + control + sex:control, data=gerber, family="binomial")
summary(LogModel3)

predict(LogModel3, newdata=Possibilities, type="response")
