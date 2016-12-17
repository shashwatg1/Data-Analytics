# Load the dataset
emails = read.csv("energy_bids.csv", stringsAsFactors=FALSE)
str(emails)

# Look at emails
emails$email[1] # not related to enron energy
emails$responsive[1]
emails$email[2] # related to enron energy
emails$responsive[2]

# Responsive emails
table(emails$responsive)

# Load tm package
library(tm)

# Create corpus
corpus = Corpus(VectorSource(emails$email))
corpus[[1]]
strwrap(corpus[[1]])

# Pre-process data
corpus = tm_map(corpus, tolower)
corpus = tm_map(corpus, PlainTextDocument)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords("english"))
corpus = tm_map(corpus, stemDocument)

# Look at first email
corpus[[1]]
strwrap(corpus[[1]])

# Create matrix
dtm = DocumentTermMatrix(corpus) # look at the terms. 20k that is too much
dtm

# Remove sparse terms
dtm = removeSparseTerms(dtm, 0.97) # remove words not in atleast 3 percent of the documents
dtm

# Now we have processed the data. We can make the data frame and apply ML algorithms
# Create data frame
labeledTerms = as.data.frame(as.matrix(dtm))

# Add in the outcome variable
labeledTerms$responsive = emails$responsive
str(labeledTerms)


# Split the data
library(caTools)
set.seed(144)
spl = sample.split(labeledTerms$responsive, 0.7)
train = subset(labeledTerms, spl == TRUE)
test = subset(labeledTerms, spl == FALSE)

# Build a CART model
library(rpart)
library(rpart.plot)

emailCART = rpart(responsive~., data=train, method="class")
prp(emailCART)


# Make predictions on the test set
pred = predict(emailCART, newdata=test)
pred[1:10,] # looking at the first few observations of pred
pred.prob = pred[,2] # we are interested in the right part only (responsive = 1)

# Compute accuracy
table(test$responsive, pred.prob >= 0.5)
(195+25)/(195+25+17+20) # 0.856

# Baseline model accuracy
table(test$responsive)
215/(215+42) # 0.836

# ROC curve
library(ROCR)
predROCR = prediction(pred.prob, test$responsive)
perfROCR = performance(predROCR, "tpr", "fpr")
plot(perfROCR, colorize=TRUE)

# Compute AUC
performance(predROCR, "auc")@y.values # 0.794
