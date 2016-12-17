# Read data
trials = read.csv("clinical_trial.csv", stringsAsFactors = FALSE)
str(trials)
summary(trials)
max(nchar(trials$abstract))
sum(nchar(trials$abstract)==0)
which.min(nchar(trials$title))
trials$title[1258]

library(tm)

# Create corpus
corpusTitle = Corpus(VectorSource(trials$title))
corpusAbstract = Corpus(VectorSource(trials$abstract))

# Pre-process data
corpusTitle = tm_map(corpusTitle, tolower)
corpusAbstract = tm_map(corpusAbstract, tolower)
corpusTitle = tm_map(corpusTitle, PlainTextDocument)
corpusAbstract = tm_map(corpusAbstract, PlainTextDocument)
corpusTitle = tm_map(corpusTitle, removePunctuation)
corpusAbstract = tm_map(corpusAbstract, removePunctuation)
corpusTitle = tm_map(corpusTitle, removeWords, stopwords("english"))
corpusAbstract = tm_map(corpusAbstract, removeWords, stopwords("english"))
corpusTitle = tm_map(corpusTitle, stemDocument)
corpusAbstract = tm_map(corpusAbstract, stemDocument)

dtmTitle = DocumentTermMatrix(corpusTitle)
dtmAbstract = DocumentTermMatrix(corpusAbstract)
dtmTitle = removeSparseTerms(dtmTitle, .95)
dtmAbstract = removeSparseTerms(dtmAbstract, .95)
dtmTitle = as.data.frame(as.matrix(dtmTitle))
dtmAbstract = as.data.frame(as.matrix(dtmAbstract))
str(dtmTitle)
str(dtmAbstract)

which.max(colSums(dtmAbstract))

# building the model
# We want to merge the frames together but since many entries have the same name, we append T and A to them resp.
colnames(dtmTitle) = paste0("T", colnames(dtmTitle))
colnames(dtmAbstract) = paste0("A", colnames(dtmAbstract))
dtm = cbind(dtmTitle, dtmAbstract)
dtm$trial = trials$trial

library(caTools)
set.seed(144)
spl = sample.split(dtm$trial, SplitRatio = 0.7)
train = subset(dtm, spl==TRUE)
test = subset(dtm, spl==FALSE)

#Baseline Model
table(train$trial) #  0.56

# CART model
library(rpart)
library(rpart.plot)
trialCART = rpart(trial~., data=train, method="class")
prp(trialCART)
predTrain = predict(trialCART)
predTrain = predTrain[,2]
summary(predTrain)
table(train$trial, predTrain>=0.5) # 0.823

predTest = predict(trialCART, newdata = test)[,2]
table(test$trial, predTest>=0.5) # 0.758

library(ROCR)
predROCR = prediction(predTest, test$trial)
perfROCR = performance(predROCR, "tpr", "fpr")
plot(perfROCR, colorize=TRUE)
# Compute AUC
performance(predROCR, "auc")@y.values # 0.794
