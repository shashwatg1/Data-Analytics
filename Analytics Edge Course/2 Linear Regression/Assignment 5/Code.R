# Read Data
Elantra = read.csv('elantra.csv')

# Create Training set and Testing Set
ElantraTrain = subset(Elantra, Year<=2012)
str(ElantraTrain)
ElantraTest = subset(Elantra, Year>2012)
str(ElantraTest)


# Make a model
model1 = lm(ElantraSales ~ Unemployment + CPI_all + CPI_energy + Queries, data = ElantraTrain)
summary(model1)
# All the variables seem to be redundant 

#Including the effect of season, adding month
model2 = lm(ElantraSales ~ Month + Unemployment + CPI_all + CPI_energy + Queries, data = ElantraTrain)
summary(model2)
#The problem is that month is not stored as a factor with levels, it is numeric in nature

ElantraTrain$MonthFactor = as.factor(ElantraTrain$Month)
ElantraTest$MonthFactor = as.factor(ElantraTest$Month)
model3 = lm(ElantraSales ~ Unemployment + Queries + CPI_energy + CPI_all + MonthFactor, data=ElantraTrain)
summary(model3)
# The model is significantly better but we have multicollinearity

cor(ElantraTrain[c("Unemployment","Month","Queries","CPI_energy","CPI_all")])

model4 = lm(ElantraSales ~ Unemployment + CPI_energy + CPI_all + MonthFactor, data=ElantraTrain)
summary(model4)


# Predicting
prediction = predict(model4, newdata = ElantraTest)
SSE = sum((prediction - ElantraTest$ElantraSales)^2)
SST = sum((mean(ElantraTrain$ElantraSales) - ElantraTest$ElantraSales)^2)
R2 = 1 - (SSE/SST)
R2