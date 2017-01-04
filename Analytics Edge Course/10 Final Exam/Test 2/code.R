dataset = read.csv('Households.csv')
str(dataset)
summary(dataset)
table(dataset$MorningPct>=100)
table(dataset$AfternoonPct>=100)
subset(dataset, dataset$AvgSalesValue>=150)$AvgDiscount
subset(dataset, dataset$AvgDiscount>=25)$AvgSalesValue
d = subset(dataset, dataset$NumVisits>=300)

library(caret)
preproc = preProcess(dataset)
HouseholdsNorm = predict(preproc, dataset)
max(HouseholdsNorm$NumVisits)
min(HouseholdsNorm$AfternoonPct)

set.seed(200)
distances <- dist(HouseholdsNorm, method = "euclidean")
ClusterShoppers <- hclust(distances, method = "ward.D")
plot(ClusterShoppers, labels = FALSE)

k = 10
hMatrix = as.matrix(HouseholdsNorm)
hVector = as.vector(hMatrix)
set.seed(200)
KMC = kmeans(hVector, centers = k, iter.max = 1000)
str(KMC)
table(KMC$cluster)

set.seed(5000)
KMC = kmeans(hVector, centers = 5, iter.max = 1000)
str(KMC)
table(KMC$cluster)
