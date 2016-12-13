#Reading Data and Analysing
baseball = read.csv('baseball.csv')
str(baseball)
length(table(baseball$Year))

baseball=subset(baseball,Playoffs == 1)
table(table(baseball$Year))

PlayoffTable = table(baseball$Year)
names(PlayoffTable)

baseball$NumCompetitors = PlayoffTable[as.character(baseball$Year)]
summary(baseball)
table(baseball$NumCompetitors)

baseball$WorldSeries = as.numeric(baseball$RankPlayoffs == 1)
table(baseball$WorldSeries)


#Model Checking
summary(glm(WorldSeries~Year, data=baseball, family="binomial"))
summary(glm(WorldSeries~RA, data=baseball, family="binomial"))
summary(glm(WorldSeries~RS, data=baseball, family="binomial"))

#Model 1
model1 = glm(WorldSeries~Year+RA+RankSeason+NumCompetitors, data=baseball, family="binomial")
summary(model1)

cor(baseball[c('Year', 'RA', 'RankSeason', 'NumCompetitors')])

#Model with lowest AIC is
model2 = glm(WorldSeries~NumCompetitors, data=baseball, family="binomial")
summary(model2)
