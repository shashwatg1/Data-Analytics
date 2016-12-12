# Read in data
wine = read.csv("wine.csv")
str(wine)
summary(wine)

# Linear Regression (one variable) lm -> lenier model
model1 = lm(Price ~ AGST, data=wine) # price is dependent. AGST is independent. wine is the dataset
summary(model1)
# estimate gives the coefficients of each term for the model y = a0 + a1x1 ...
# Std. error tells how much the coefficient is likely to vary from the estimate value (always positive)
# t value = estimate / std. error. High absolute value of t value is desired
# Pr is the measure of how plausible it is for the estimate to be zero (high is t value is low) Small value is desired here
# stars at the end denote how significant that variable is for the prediction

# Sum of Squared Errors
model1$residuals
SSE = sum(model1$residuals^2)
SSE

# Linear Regression (two variables)
model2 = lm(Price ~ AGST + HarvestRain, data=wine)
summary(model2)

# Sum of Squared Errors
SSE = sum(model2$residuals^2)
SSE

# Linear Regression (all variables)
model3 = lm(Price ~ AGST + HarvestRain + WinterRain + Age + FrancePop, data=wine)
summary(model3)

# Sum of Squared Errors
SSE = sum(model3$residuals^2)
SSE


# Remove FrancePop
model4 = lm(Price ~ AGST + HarvestRain + WinterRain + Age, data=wine)
summary(model4)
SSE = sum(model4$residuals^2)
SSE
# this improves the model and also makes age important suddenly. this was because age and francepop were correlated.


# Correlations, measure of linear relation between variables
# +1 is perfect positive, -1 is perfect negative, 0 is uncorrelated
cor(wine$WinterRain, wine$Price)
cor(wine$Age, wine$FrancePop)
cor(wine) # shows all the possible correlations

# Remove Age and FrancePop
model5 = lm(Price ~ AGST + HarvestRain + WinterRain, data=wine)
summary(model5)
#degrades the model

#Correlations more than 0.7 or less than -0.7 are cause for concerns
#If variables have correlation to the phenomenan multicollinearity and must be fixed.
#in 5 since we removed both age and francepop it caused problems. we need age only.


#Making Predictions:
#Training Data is the data used to build the model
#Test Data is the new data which we predict and is used to see how good the model is.

# Read in test set
wineTest = read.csv("wine_test.csv") # 2 new observations
str(wineTest)

# Make test set predictions
predictTest = predict(model4, newdata=wineTest) # function to make predictions with given model and test dataset
predictTest # predictions for the 2 data points each. This is close to the actual values checked in the str(wineTest)

# Compute R-squared For the Test set. This is different from the model R Square
SSE = sum((wineTest$Price - predictTest)^2)
SSE # This is SSE for the Test set, different from SSE of the model on training set
SST = sum((wineTest$Price - mean(wine$Price))^2)
SST
1 - SSE/SST

#Test set R-Square can also be negative unlike model R-square as the model can do worse than the baseline model for the new test data
