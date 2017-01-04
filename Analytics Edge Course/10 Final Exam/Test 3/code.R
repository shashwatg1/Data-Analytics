energy = read.csv('energy.csv')
str(energy)
energy$STATE[which.max(energy$GenTotalRenewable)]
energy$YEAR[which.max(energy$GenTotalRenewable)]

energy$presidential.results = as.factor(energy$presidential.results)
tapply(energy$AllSourcesCO2, energy$presidential.results, mean, na.rm = TRUE)
tapply(energy$AllSourcesNOx, energy$presidential.results, mean, na.rm = TRUE)

cor(energy$AllSourcesCO2, energy$EsalesIndustrial, use = "complete")
cor(energy$AllSourcesSO2, energy$EsalesIndustrial, use = "complete")
cor(energy$AllSourcesNOx, energy$EsalesResidential, use = "complete")
cor(energy$AllSourcesCO2, energy$EsalesCommercial, use = "complete")

boxplot(energy$EPriceTotal)

set.seed(144)
spl = sample(1:nrow(energy), size = 0.7*nrow(energy))
train = energy[spl,]
test = energy[-spl,]

mod = glm(GenSolarBinary~GenHydro + GenSolar + CumlFinancial + CumlRegulatory + Total.salary + Import, data = train, family = "binomial")
summary(mod)

predictTest = predict(mod, type="response", newdata = test)
table(test$GenSolarBinary, predictTest > 0.5)

predictTest = predict(mod, type="response", newdata = subset(test, test$presidential.results==0))
table(subset(test, test$presidential.results==0)$GenSolarBinary, predictTest > 0.5)

predictTest = predict(mod, type="response", newdata = subset(test, test$presidential.results==1))
table(subset(test, test$presidential.results==1)$GenSolarBinary, predictTest > 0.5)

library(caret)
train.limited = as.data.frame(cbind(train$Total.salary, train$presidential.results, train$CumlRegulatory, train$CumlFinancial, train$Import))
preproc = preProcess(train.limited)
train.norm = predict(preproc, train.limited)
str(train.limited)

test.limited = as.data.frame(cbind(test$Total.salary, test$presidential.results, test$CumlRegulatory, test$CumlFinancial, test$Import))
preproc = preProcess(test.limited)
test.norm = predict(preproc, test.limited)
str(test.limited)

set.seed(144)
km = kmeans(train.norm, centers = 2, iter.max = 1000)
library(flexclust)
km.kcca = as.kcca(km, train.norm)
cluster.train = predict(km.kcca)
train1 = subset(train, cluster.train==1)
train2 = subset(train, cluster.train==2)
summary(train1)
summary(train2)
