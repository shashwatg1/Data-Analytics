# Flower is a simple sample example. We are actually interested in the MRI images helathy and tumor.
# The gray-scale image information is provided in the csv files
# The images are represented as a matrix of the pixel intensity values between 0 and 1. 8 bit hence 256 levels between 0 to 1.
# To apply cluster to these images, we can cluster pixels according to their intensity values
# To do this we can convert the matrix to a long vector and then assign each pixel value to a cluster.

## for hierarchical clustering, we need to find distances (pairwise) between the vector elements

flower = read.csv("flower.csv", header=FALSE)
str(flower)

# Remember that R treats Rows as Observations and Columsn as variables

# Change the data type to matrix
flowerMatrix = as.matrix(flower)
str(flowerMatrix) # Thus 50 X 50 pixel image

# Turn matrix into a vector
flowerVector = as.vector(flowerMatrix)
str(flowerVector) # 2500 values as expected

# We converted to matrix and then to vector, if we turn to vector directly then the following happens
flowerVector2 = as.vector(flower)
str(flowerVector2) # Same as the data frame itself, hence we cant do directly

# Compute distances
distance = dist(flowerVector, method = "euclidean")

# Hierarchical clustering
clusterIntensity = hclust(distance, method="ward.D") # ward basically minimises the variance and the distance among clusters

# Plot the dendrogram
plot(clusterIntensity)

# Select 3 clusters 
# Visualise the cut
rect.hclust(clusterIntensity, k = 3, border = "red")

# Making the cut
flowerClusters = cutree(clusterIntensity, k = 3)
flowerClusters # a vector of 2500 variables stating the cluster of each pixel value

# Find mean intensity values
tapply(flowerVector, flowerClusters, mean)
# So it looks like the 1st cluster has very low intensity value pixels (black) and 3rd cluster has high intensity value pixels (white)

# Plot the image and the clusters
# convert the vector to a matrix
dim(flowerClusters) = c(50,50)
# To output the image based on the input matrix. Each colour will correspond to a particular cluster
image(flowerClusters, axes = FALSE)

# Original image
image(flowerMatrix,axes=FALSE,col=grey(seq(0,1,length=256)))

# So we have done a great job using the hierarchical clustering method

# In this flower example, we understood the clustering algorithm's potential, however in this case the image was very low resolution

# Now lets work on teh high resolution MRI images of the brain

healthy = read.csv("healthy.csv", header=FALSE)
healthyMatrix = as.matrix(healthy) # considerably larger in resolution
str(healthyMatrix)

# Plot image
image(healthyMatrix,axes=FALSE,col=grey(seq(0,1,length=256)))

# Hierarchial clustering
healthyVector = as.vector(healthyMatrix)
# distance = dist(healthyVector, method = "euclidean")
# We have an error - why?
str(healthyVector) # Because there are 365636 elements which is too much and R runs out of memory

# Thus in such cases we cannot apply Hierarchical clustering and must go to K-means clustering

# K-means clustering Algo
# Specify number of clusters (based on some information known from before)
k = 5

# Run k-means
set.seed(1)
KMC = kmeans(healthyVector, centers = k, iter.max = 1000) # iter.max is the total iterations. it is fast.
str(KMC)
# Cluster vector gives information about the cluster of each data point in the input vector

# Extract clusters of each data point (pixel intensity)
healthyClusters = KMC$cluster

# Centers contains the mean intensity value of each cluster (no need for tapply, lapply, etc)
KMC$centers

# Plot the image with the clusters
dim(healthyClusters) = c(nrow(healthyMatrix), ncol(healthyMatrix))
image(healthyClusters, axes = FALSE, col=rainbow(k))
# Thus we have done a good job again in segmenting


# Detecting tumors
# Apply to a test image
tumor = read.csv("tumor.csv", header=FALSE)
tumorMatrix = as.matrix(tumor)
tumorVector = as.vector(tumorMatrix)

# Apply clusters from before to new image, using the flexclust package
# install.packages("flexclust")
library(flexclust)
# This contaings kcca package which stands for k centroids cluster analysis
# Basically we need to convert the informationg from clustering algo to an object of class kcca

KMC.kcca = as.kcca(KMC, healthyVector)
tumorClusters = predict(KMC.kcca, newdata = tumorVector)

# Visualize the clusters
dim(tumorClusters) = c(nrow(tumorMatrix), ncol(tumorMatrix))
image(tumorClusters, axes = FALSE, col=rainbow(k))

# Thus we are able to notice a circular tumor in this new image
