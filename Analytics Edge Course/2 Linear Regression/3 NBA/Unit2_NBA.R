# Read in the data
NBA = read.csv("NBA_train.csv")
str(NBA)
# SeasonEnd = which season, Playoff = 1 means went to Playoff, W = wins, PTS = points,
# oppPts = opponent points, FG = no. of field goals (1,2 and 3), X2P = 2 pointers
# X3P = 3 pointers, FT = free throws. The A with these 4 are attempted. Non-A is successful
# ORB,DRB is off. and def. rebounds, followed by assist, steals, blocks and turnovers


# How many wins to make the playoffs?
table(NBA$W, NBA$Playoffs)
#Thus winning about 41-42 games lets you qualify for the playoffs

# Compute Points Difference
NBA$PTSdiff = NBA$PTS - NBA$oppPTS

# Check for linear relationship
plot(NBA$PTSdiff, NBA$W)
# Thus there is definitely a strong linear relationship

# W will be dependent and PTSdiff will be the independent variable

# Linear regression model for wins
WinsReg = lm(W ~ PTSdiff, data=NBA)
summary(WinsReg)

# W = 41 + 0.0326*PTSdiff
# Thus for W = 42, PTSdiff must be atleast 31


# Linear regression model for points scored
PointsReg = lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + DRB + TOV + STL + BLK, data=NBA)
summary(PointsReg)

# Sum of Squared Errors
PointsReg$residuals
SSE = sum(PointsReg$residuals^2)
SSE

# Root mean squared error
RMSE = sqrt(SSE/nrow(NBA))
RMSE
# So we have a 184 points error

# Average number of points in a season
mean(NBA$PTS)
# 8370 points, so 184 points error isnt much but we can improve

# Remove insignifcant variables
# We remove based on stars, Pr, coeff value
summary(PointsReg)

PointsReg2 = lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + DRB + STL + BLK, data=NBA)
summary(PointsReg2)

PointsReg3 = lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + STL + BLK, data=NBA)
summary(PointsReg3)

PointsReg4 = lm(PTS ~ X2PA + X3PA + FTA + AST + ORB + STL, data=NBA)
summary(PointsReg4)

# Compute SSE and RMSE for new model
SSE_4 = sum(PointsReg4$residuals^2)
RMSE_4 = sqrt(SSE_4/nrow(NBA))
SSE_4
RMSE_4
# Thus the model is simplified with no change in RMSE


# Predictions
# Read in test set
NBA_test = read.csv("NBA_test.csv")

# Make predictions on test set
PointsPredictions = predict(PointsReg4, newdata=NBA_test)

# Compute out-of-sample R^2
SSE = sum((PointsPredictions - NBA_test$PTS)^2)
SST = sum((mean(NBA$PTS) - NBA_test$PTS)^2)
R2 = 1 - SSE/SST
R2

# Compute the RMSE
RMSE = sqrt(SSE/nrow(NBA_test))
RMSE
