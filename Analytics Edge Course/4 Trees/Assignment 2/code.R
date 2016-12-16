# Read Data
letters = read.csv('letters_ABPR.csv')
str(letters)
letters$isB = as.factor(letters$letter == "B")

library(caTools)
set.seed(1000)
spl = sample.split(letters$isB, SplitRatio = 0.5)
train = subset(letters, spl == TRUE)
test = subset(letters, spl == FALSE)
table(test$isB) # Baseline model accuracy = 0.754


# CART
CARTb = rpart(isB ~ . - letter, data=train, method="class")
predictions = predict(CARTb, newdata=test, type="class")
table(test$isB, predictions)

# Random Forrest
library(randomForest)
set.seed(1000)
RFb = randomForest(isB ~ . - letter, data=train) 
predictions = predict(RFb, newdata=test)
table(test$isB, predictions)

# Convert to factor
letters$letter = as.factor( letters$letter ) 

set.seed(2000)
spl = sample.split(letters$letter, SplitRatio = 0.5)
train = subset(letters, spl == TRUE)
test = subset(letters, spl == FALSE)

# Baseline Model
table(train$letter) # P is most frequent
table(test$letter) # accuracy is about 0.25

# CART Model
CARTletter = rpart(letter ~ . - isB, data=train, method="class")
predictLetter = predict(CARTletter, newdata=test, type="class")
table(test$letter, predictLetter)

# RF Model
set.seed(1000)
RFl = randomForest(letter ~ . - isB, data=train) 
predictions = predict(RFl, newdata=test)
table(test$letter, predictions)
