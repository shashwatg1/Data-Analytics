# Read in dataset
quality = read.csv("quality.csv")

# Look at structure
str(quality)

# Table outcome
table(quality$PoorCare)

# Baseline accuracy -> predict all good care
98/131 # about 75%

# Install and load caTools package
# install.packages("caTools")
library(caTools)

# Randomly split data into training and testing set
set.seed(88)
split = sample.split(quality$PoorCare, SplitRatio = 0.75)
# makes a 3/4 split into Train and Test sets. It maintains the ratio of 1 and 0 in poorcare in each of the sets aswell
split

# Create training and testing sets
qualityTrain = subset(quality, split == TRUE)
qualityTest = subset(quality, split == FALSE)

# Logistic Regression Model
QualityLog = glm(PoorCare ~ OfficeVisits + Narcotics, data=qualityTrain, family=binomial)
#glm -> generalised linear model, family = binomial makes it logistic regression
summary(QualityLog)
# AIC is the measure of the model

# Make predictions on training set
predictTrain = predict(QualityLog, type="response")
# type = response tells the predict function to return probabilities

# Analyze predictions
summary(predictTrain)
tapply(predictTrain, qualityTrain$PoorCare, mean)

# So the output is a probability but we want a prediction. Thus we threshold and predict from the prob. value
# Confusion matrix or Classification matrix, for threshold of 0.5
table(qualityTrain$PoorCare, predictTrain > 0.5)
# predicted :  0   1 
# Actual = 0  TN  FP
# Actual = 1  FN  TP

# Sensitivity or true positive rate, the recall, or probability of detection = TP/(TP+FN)
# Specificity or true negative rate = TN/(TN+FP)

10/25 # Sensitivity
70/74 # Specificity

# Confusion matrix for threshold of 0.7
table(qualityTrain$PoorCare, predictTrain > 0.7)

# Sensitivity and specificity
8/25
73/74

# Confusion matrix for threshold of 0.2
table(qualityTrain$PoorCare, predictTrain > 0.2)

# Sensitivity and specificity
16/25
54/74

# Incresing threshold, decreases sensitivity and increases specificity
# How to decide the correct threshold? ROC helps with that


# ROC -> Receiver Operator Characteristic
# ROC Curve is Sensitivity Vs (1-Specificity) for all threshold values from 0 to 1

# Install and load ROCR package
# install.packages("ROCR")
library(ROCR)

# Prediction function
ROCRpred = prediction(predictTrain, qualityTrain$PoorCare) # predicted and true values are passed

# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")

# Plot ROC curve
plot(ROCRperf)

# Add colors
plot(ROCRperf, colorize=TRUE)

# Add threshold labels 
plot(ROCRperf, colorize=TRUE, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))
