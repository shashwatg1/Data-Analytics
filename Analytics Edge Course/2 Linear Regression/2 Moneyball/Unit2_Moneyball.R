# Read in data
baseball = read.csv("baseball.csv")
str(baseball)

# Subset to only include moneyball years (before 2002)
moneyball = subset(baseball, Year < 2002)
str(moneyball)

# Compute Run Difference
# RA -> runs allowed, RS -> Runs Scored, RD -> new variable Run Difference which is RS - RA
moneyball$RD = moneyball$RS - moneyball$RA
str(moneyball)

# Scatterplot to check for linear relationship between RD and Wins(W)
plot(moneyball$RD, moneyball$W) # shows a strong linear relation

# Regression model to predict wins
WinsReg = lm(W ~ RD, data=moneyball)
summary(WinsReg)
#this gives a strong model with the variable RD to predict Win
#Our equation is W = 80.881375 + 0.105766 * RD
#For W >= 95, RD = 133.4 (Similar to moneyball's claim)

str(moneyball)

# Regression model to predict runs scored
RunsReg = lm(RS ~ OBP + SLG + BA, data=moneyball)
summary(RunsReg)
#Coeff of BA is negative which doesnt make sense. This is because of multi collinearity and the three varaibles are highly correlated.

# Testing with 2 out of the 3
RunsReg = lm(RS ~ BA + SLG, data=moneyball)
summary(RunsReg)

RunsReg = lm(RS ~ OBP + BA, data=moneyball)
summary(RunsReg)

RunsReg = lm(RS ~ OBP + SLG, data=moneyball)
summary(RunsReg)
#The best model is obtained using OBP and SLG. Also OBP coefficient is greater. Thus OBP is most important followed by SLG. This is in sync with moneyball's claims


#Similarly OOBP and OSLG can be used to predict runs allowed
RunsAReg = lm(RA ~ OOBP + OSLG, data=moneyball)
summary(RunsAReg)
#Model to predict runs allowed

#Both models have high R-Square of more than 0.9