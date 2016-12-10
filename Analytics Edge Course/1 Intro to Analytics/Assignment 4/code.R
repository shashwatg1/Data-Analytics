## 1st Part

poll = read.csv("AnonymityPoll.csv")
summary(poll)
table(poll$Smartphone)
table(poll$Region == "Midwest", poll$State)
SouthInterviewees = subset(poll, Region=="South")
table(SouthInterviewees$State) 


## 2nd Part

table(poll$Internet.Use, poll$Smartphone)
limited = subset(poll, Internet.Use == 1 | Smartphone == 1)


## 3rd Part

summary(limited)
table(limited$Info.On.Internet)
table(limited$Worry.About.Info)


## 4th Part

hist(limited$Age)
max(table(limited$Age, limited$Info.On.Internet)) 
jitter(c(1, 2, 3))
plot(jitter(limited$Age), jitter(limited$Info.On.Internet))
tapply(limited$Info.On.Internet, limited$Smartphone, mean)
