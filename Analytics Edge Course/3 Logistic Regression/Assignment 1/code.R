#Reading Data and Analysing
songdata = read.csv('songs.csv')
str(songdata)
table(songdata$year)
table(songdata$artistname == 'Michael Jackson')
mj = subset(songdata, artistname=='Michael Jackson')
mj[c('songtitle', 'Top10')]
table(songdata$timesignature)
songdata$songtitle[which.max(songdata$tempo)]

SongsTrain = subset(songdata, year<=2009)
SongsTest = subset(songdata, year>2009)

#we dont care about the following variables for now:
nonvars = c("year", "songtitle", "artistname", "songID", "artistID")

SongsTrain = SongsTrain[ , !(names(SongsTrain) %in% nonvars) ]
SongsTest = SongsTest[ , !(names(SongsTest) %in% nonvars) ]

#Model 1
model1 = glm(Top10 ~ ., data=SongsTrain, family=binomial)
summary(model1)

cor(SongsTrain$loudness, SongsTrain$energy)

#Model 2
model2 = glm(Top10 ~ . - loudness, data=SongsTrain, family=binomial)
summary(model2)

#Model 3
model3 = glm(Top10 ~ . - energy, data=SongsTrain, family=binomial)
summary(model3)

#Predictions
predictTest = predict(model3, type="response", newdata=SongsTest)
table(SongsTest$Top10, predictTest > 0.45)
#Accuracy = 0.8793566

#Baseline Model Analysis, Predict all not Top10
table(SongsTest$Top10)
#Accuracy = 0.8418231

#Our model is slightly better but quite conservative