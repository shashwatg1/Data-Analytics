# Read data
emails = read.csv("emails.csv", stringsAsFactors = FALSE)
str(emails)
summary(emails)
table(emails$spam)
emails$text[1]

max(nchar(emails$text))
which.min(nchar(emails$text))

library(tm)

# Create corpus
corpus = Corpus(VectorSource(emails$text))
corpus = tm_map(corpus, tolower)
corpus = tm_map(corpus, PlainTextDocument)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords("english"))
corpus = tm_map(corpus, stemDocument)
dtm = DocumentTermMatrix(corpus)
dtm
spdtm = removeSparseTerms(dtm, 0.95)
spdtm

# Data Frame
emailsSparse = as.data.frame(as.matrix(spdtm))
colnames(emailsSparse) = make.names(colnames(emailsSparse))
which.max(colSums(emailsSparse)) 
emailsSparse$spam = emails$spam 
sort(colSums(subset(emailsSparse, spam == 0)))
sort(colSums(subset(emailsSparse, spam == 1)))

emailsSparse$spam = as.factor(emailsSparse$spam)
set.seed(123)
library(caTools)
spl = sample.split(emailsSparse$spam, 0.7)
train = subset(emailsSparse, spl == TRUE)
test = subset(emailsSparse, spl == FALSE) 

# Logistic Reg
spamLog = glm(spam~., data=train, family="binomial")

# CART
library(rpart)
library(rpart.plot)
spamCART = rpart(spam~., data=train, method="class")

# RF
library(randomForest)
set.seed(123)
spamRF = randomForest(spam~., data=train)

# Probabilities
predTrainLog = predict(spamLog, type="response")
predTrainCART = predict(spamCART)[,2]
predTrainRF = predict(spamRF, type="prob")[,2] 

table(predTrainLog < 0.00001)
table(predTrainLog > 0.99999)
table(predTrainLog >= 0.00001 & predTrainLog <= 0.99999)
summary(spamLog)

prp(spamCART)

# Accuracies on Training Set
table(train$spam, predTrainLog > 0.5)

library(ROCR)
predictionTrainLog = prediction(predTrainLog, train$spam)
as.numeric(performance(predictionTrainLog, "auc")@y.values) 

table(train$spam, predTrainCART > 0.5)

predictionTrainCART = prediction(predTrainCART, train$spam)
as.numeric(performance(predictionTrainCART, "auc")@y.values) 

table(train$spam, predTrainRF > 0.5)

predictionTrainRF = prediction(predTrainRF, train$spam)
as.numeric(performance(predictionTrainRF, "auc")@y.values) 

# Logistic regression seems to be doing the best so far but it might be over fitted aswell

# Check on Test set
predTestLog = predict(spamLog, newdata=test, type="response")
predTestCART = predict(spamCART, newdata=test)[,2]
predTestRF = predict(spamRF, newdata=test, type="prob")[,2] 

table(test$spam, predTestLog > 0.5)
predictionTestLog = prediction(predTestLog, test$spam)
as.numeric(performance(predictionTestLog, "auc")@y.values) 

table(test$spam, predTestCART > 0.5)
predictionTestCART = prediction(predTestCART, test$spam)
as.numeric(performance(predictionTestCART, "auc")@y.values) 

table(test$spam, predTestRF > 0.5)
predictionTestRF = prediction(predTestRF, test$spam)
as.numeric(performance(predictionTestRF, "auc")@y.values) 

# Thus Log reg was indeed overfitted and RF does the best
