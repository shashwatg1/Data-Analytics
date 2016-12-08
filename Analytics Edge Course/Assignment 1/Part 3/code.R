## 1st Part

CPS = read.csv("CPSData.csv")
str(CPS)
summary(CPS)
sort(table(CPS$State))
table(CPS$Citizenship)
(table(CPS$Citizenship)[1] + table(CPS$Citizenship)[2])/sum(table(CPS$Citizenship)) #percentage american citizens
table(CPS$Race, CPS$Hispanic)


## 2nd Part

summary(CPS)
table(CPS$Region, is.na(CPS$Married))
table(CPS$Sex, is.na(CPS$Married))
table(CPS$Age, is.na(CPS$Married))

table(CPS$State, is.na(CPS$MetroAreaCode))
table(CPS$Region, is.na(CPS$MetroAreaCode))

sort(tapply(is.na(CPS$MetroAreaCode), CPS$State, mean))


## 3rd Part

MetroAreaMap = read.csv("MetroAreaCodes.csv")
CPS = merge(CPS, MetroAreaMap, by.x="MetroAreaCode", by.y="Code", all.x=TRUE)
summary(CPS)

sort(tapply(CPS$Hispanic, CPS$MetroArea, mean))
sort(tapply(CPS$Race == "Asian", CPS$MetroArea, mean))
sort(tapply(CPS$Education == "No high school diploma", CPS$MetroArea, mean, na.rm=TRUE))


## 4th Part

CountryMap = read.csv("CountryCodes.csv")
CPS = merge(CPS, CountryMap, by.x="CountryOfBirthCode", by.y="Code", all.x=TRUE)
summary(CPS)

table(CPS$MetroArea ==  "New York-Northern New Jersey-Long Island, NY-NJ-PA", CPS$Country != "United States")
sort(tapply(CPS$Country ==  "India", CPS$MetroArea, sum, na.rm=TRUE))
sort(tapply(CPS$Country ==  "Brazil", CPS$MetroArea, sum, na.rm=TRUE))
sort(tapply(CPS$Country ==  "Somalia", CPS$MetroArea, sum, na.rm=TRUE))
