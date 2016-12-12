# Read Data
data = read.csv('climate_change.csv')
str(data)

# Create Training set and Testing Set
train_data = subset(data, Year<=2006)
str(train_data)
test_data = subset(data, Year>2006)
str(test_data)

# Make a model
model1 = lm(Temp ~ MEI + CO2 + CH4 + N2O + CFC.11 + CFC.12 + TSI + Aerosols, data = train_data)
summary(model1)

# Remove redundant variables (N20 and CH4)
model2 = lm(Temp ~ MEI + CO2 + CFC.11 + CFC.12 + TSI + Aerosols, data = train_data)
summary(model2)

# The data suffers from multicollinearity as coeff of greenhouse gases cant be negative
cor(train_data)

model3 = lm(Temp ~ MEI + N2O + TSI + Aerosols, data = train_data)
summary(model3)
# Despite removing so many variables in model3 there is little change due to the high correlation


# Automatically Building the Model

# step function can be used to automatically find a simplified model
modelx = step(model1)
summary(modelx)

# The step function does not address the collinearity of the variables, except that adding highly correlated variables will not 
# improve the R2 significantly. The consequence of this is that the step function will not necessarily produce a very interpretable model
# just a model that has balanced quality and simplicity for a particular weighting of quality and simplicity (AIC).


# Predicting
prediction = predict(modelx, newdata = test_data)
SSE = sum((prediction - test_data$Temp)^2)
SST = sum((mean(train_data$Temp) - test_data$Temp)^2)
R2 = 1 - (SSE/SST)
R2
