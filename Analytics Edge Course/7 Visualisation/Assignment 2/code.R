#Market Segmentation for Airlines
airlines = read.csv('AirlinesCluster.csv')
summary(airlines)

#We need to normalise
library(caret)
preproc = preProcess(airlines) # preprocessing the data
airlinesNorm = predict(preproc, airlines) # makes mean = 0 and sd = 1
summary(airlinesNorm)


## Hierarchical clustering
distances = dist(airlinesNorm, method="euclidean")
hierClust = hclust(distances, method="ward.D")
plot(hierClust)
# choosing 5 clusters
rect.hclust(hierClust, k = 5, border = "red")
clusterGroups = cutree(hierClust, k = 5)
table(clusterGroups)

# To see the stats of each variable
lapply(split(airlines, clusterGroups), colMeans)


## K-means clustering
set.seed(88)
kmeansClust = kmeans(airlinesNorm, centers=5, iter.max=1000)
table(kmeansClust$cluster)
