# Read data
wiki = read.csv("wiki.csv", stringsAsFactors = FALSE)
str(wiki)
wiki$Vandal = as.factor(wiki$Vandal)
str(wiki)
table(wiki$Vandal)

library(tm)

# Create corpus
corpusAdded = Corpus(VectorSource(wiki$Added))

# Pre-process data
corpusAdded = tm_map(corpusAdded, removeWords, stopwords("english"))
corpusAdded = tm_map(corpusAdded, stemDocument)
dtmAdded = DocumentTermMatrix(corpusAdded)
sparseAdded = removeSparseTerms(dtmAdded, .997)
# sparseAdded
wordsAdded = as.data.frame(as.matrix(sparseAdded))
colnames(wordsAdded) = paste("A", colnames(wordsAdded))


# Repeat for WordsRemoved
corpusRemoved = Corpus(VectorSource(wiki$Removed))
corpusRemoved = tm_map(corpusRemoved, removeWords, stopwords("english"))
corpusRemoved = tm_map(corpusRemoved, stemDocument)
dtmRemoved = DocumentTermMatrix(corpusRemoved)
sparseRemoved = removeSparseTerms(dtmRemoved, .997)
wordsRemoved = as.data.frame(as.matrix(sparseRemoved))
colnames(wordsRemoved) = paste("R", colnames(wordsRemoved))
ncol(wordsRemoved)

wikiWords = cbind(wordsAdded, wordsRemoved) 
wikiWords$Vandal = wiki$Vandal
library(caTools)
set.seed(123)
spl = sample.split(wikiWords$Vandal, SplitRatio = 0.7)
wikiTrain = subset(wikiWords, spl==TRUE)
wikiTest = subset(wikiWords, spl==FALSE)
table(wikiTest$Vandal)

library(rpart)
library(rpart.plot)
wikiCART = rpart(Vandal~., data=wikiTrain, method="class")
prp(wikiCART)
testPredictCART = predict(wikiCART, newdata=wikiTest, type="class")
table(wikiTest$Vandal, testPredictCART)

# To improve, we think of adding the term http to search. This is because the presence of web links is often related to vandalism
wikiWords2 = wikiWords # making a copy
wikiWords2$HTTP = ifelse(grepl("http",wiki$Added,fixed=TRUE), 1, 0)
table(wikiWords2$HTTP)

wikiTrain2 = subset(wikiWords2, spl==TRUE)
wikiTest2 = subset(wikiWords2, spl==FALSE)

wikiCART2 = rpart(Vandal~., data=wikiTrain2, method="class")
prp(wikiCART2)
testPredictCART2 = predict(wikiCART2, newdata=wikiTest2, type="class")
table(wikiTest2$Vandal, testPredictCART2)

# Now looking at the number of words added and removed
wikiWords2$NumWordsAdded = rowSums(as.matrix(dtmAdded))
wikiWords2$NumWordsRemoved = rowSums(as.matrix(dtmRemoved))
mean(wikiWords2$NumWordsAdded)

wikiTrain3 = subset(wikiWords2, spl==TRUE)
wikiTest3 = subset(wikiWords2, spl==FALSE)
wikiCART3 = rpart(Vandal ~ ., data=wikiTrain3, method="class")
testPredictCART3 = predict(wikiCART3, newdata=wikiTest3, type="class")
table(wikiTest3$Vandal, testPredictCART3)

# Now we want to use the metadata
wikiWords3 = wikiWords2
wikiWords3$Minor = wiki$Minor
wikiWords3$Loggedin = wiki$Loggedin

wikiTrain4 = subset(wikiWords3, spl==TRUE)
wikiTest4 = subset(wikiWords3, spl==FALSE)
wikiCART4 = rpart(Vandal ~ ., data=wikiTrain4, method="class")
predictTestCART4 = predict(wikiCART4, newdata=wikiTest4, type="class")
table(wikiTest4$Vandal, predictTestCART4)
prp(wikiCART4)
