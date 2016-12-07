## 1st Part

mvt = read.csv("mvtWeek1.csv")
str(mvt) #191641 rows of data in 11 columns

which.max(mvt$ID) # which index is max for ID -> 18134
mvt$ID[18134] # max value of ID -> 9181151
  #alternate:
  max(mvt$ID) -> 9181151

#To get number of TRUE's in Arrest variable (2 methods):
summary(mvt)
table(mvt$Arrest)


## 2nd Part

mvt$Date[1]
#This tells time is in the format Month/Day/Year Hour:Minute

DateConvert = as.Date(strptime(mvt$Date, "%m/%d/%y %H:%M"))
summary(DateConvert)

mvt$Month = months(DateConvert)
mvt$Weekday = weekdays(DateConvert)
mvt$Date = DateConvert

table(mvt$Month) # shows Feb had least number of observations hence least number of thefts

table(mvt$Month, mvt$Arrest) # shows Jan had maximum arrests


## 3rd Part
hist(mvt$Date, breaks=100)

boxplot(mvt$Date ~ mvt$Arrest)

table(mvt$Year, mvt$Arrest)


## 4th Part

sort(table(mvt$LocationDescription)) # We obseve top 5 except Other

Top5 = subset(mvt, LocationDescription=="STREET" | LocationDescription=="PARKING LOT/GARAGE(NON.RESID.)" | LocationDescription=="ALLEY" | LocationDescription=="GAS STATION" | LocationDescription=="DRIVEWAY - RESIDENTIAL")

  #Alternate:
  TopLocations = c("STREET", "PARKING LOT/GARAGE(NON.RESID.)", "ALLEY", "GAS STATION", "DRIVEWAY - RESIDENTIAL")
  Top5 = subset(mvt, LocationDescription %in% TopLocations)
  
Top5$LocationDescription = factor(Top5$LocationDescription) # To remove the other categories

table(Top5$Arrest, Top5$LocationDescription)


