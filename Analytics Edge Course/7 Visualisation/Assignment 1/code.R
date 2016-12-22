# Election predictions visualised

library(ggplot2)
library(ggmap)
library(maps)
statesMap = map_data("state")
table(statesMap$group)
ggplot(statesMap, aes(x = long, y = lat, group = group)) + geom_polygon(fill = "white", color = "black") 

polling = read.csv('PollingImputed.csv')
str(polling)
Train = subset(polling, Year<=2008)
str(Train)
# missing observations for Alaska, Delaware, Alabama, Wyoming, and Vermont, so these states will not appear colored in our map. 
Test = subset(polling, Year==2012)

# Log reg
mod2 = glm(Republican~SurveyUSA+DiffCount, data=Train, family="binomial")
TestPrediction = predict(mod2, newdata=Test, type="response")
TestPredictionBinary = as.numeric(TestPrediction > 0.5)
predictionDataFrame = data.frame(TestPrediction, TestPredictionBinary, Test$State) # put all three in a data frame to pass to ggplot
str(predictionDataFrame)

# merge predictionDataframe with mapdata
predictionDataFrame$region = tolower(predictionDataFrame$Test.State)
predictionMap = merge(statesMap, predictionDataFrame, by = "region")
predictionMap = predictionMap[order(predictionMap$order),]
str(predictionMap)

ggplot(predictionMap, aes(x = long, y = lat, group = group, fill = TestPredictionBinary)) + geom_polygon(color = "black")
# Light blue is republican and dark blue is democratic

# another way
ggplot(predictionMap, aes(x = long, y = lat, group = group, fill = TestPredictionBinary))+ geom_polygon(color = "black") + scale_fill_gradient(low = "blue", high = "red", guide = "legend", breaks= c(0,1), labels = c("Democrat", "Republican"), name = "Prediction 2012")
