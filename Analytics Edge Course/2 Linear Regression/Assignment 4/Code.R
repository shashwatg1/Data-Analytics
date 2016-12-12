# Read Data
statedata = read.csv('statedata.csv')
str(statedata)

tapply(statedata$HS.Grad, statedata$state.region, mean)

boxplot(statedata$Murder ~ statedata$state.region)

NortheastData = subset(statedata, state.region == "Northeast")
NortheastData$state.abb[which.max(NortheastData$Murder)]


# Make a model
model = lm(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost + Area, data = statedata)
summary(model)

plot(statedata$Income, statedata$Life.Exp)

# We are again facing Multicollinearity
# Remove the one with the largest "p-value" first, or "t value" closest to zero

model2 = lm(Life.Exp ~ Population + Murder + HS.Grad + Frost, data = statedata)
summary(model2)

# Min and max life expectancy predicted and actual
sort(predict(model2))
statedata$state.abb[1] # Min = 1
statedata$state.abb[47] # Max = 47

which.min(statedata$Life.Exp) # Actual min = 40
statedata$state.abb[40]

which.max(statedata$Life.Exp) # Actual max = 11
statedata$state.abb[11]

# Looking at Residuals
sort(abs(model$residuals)) # 14 is min adn 11 is max
statedata$state.abb[14]
statedata$state.abb[11]