# This time the data is in a txt file
movies = read.table("movieLens.txt", header=FALSE, sep="|",quote="\"")
str(movies)
# because of the lack of headers, R assigns default names V1, V2, etc

# Add column names
colnames(movies) = c("ID", "Title", "ReleaseDate", "VideoReleaseDate", "IMDB", "Unknown", "Action", "Adventure", "Animation", "Childrens", "Comedy", "Crime", "Documentary", "Drama", "Fantasy", "FilmNoir", "Horror", "Musical", "Mystery", "Romance", "SciFi", "Thriller", "War", "Western")
str(movies)

# Remove unnecessary variables
movies$ID = NULL
movies$ReleaseDate = NULL
movies$VideoReleaseDate = NULL
movies$IMDB = NULL
str(movies)

# Remove duplicates
movies = unique(movies)
str(movies)

# For hierarchical clustering we first need the distances and then we need to form the clusters

# Compute distances
distances = dist(movies[2:20], method = "euclidean")

# Hierarchical clustering
clusterMovies = hclust(distances, method = "ward.D") 

# Plot the dendrogram
plot(clusterMovies)
# The black part is basically lots and lots of data variables very close to each other. Difficult to cluster at that level

# Assign points to clusters
clusterGroups = cutree(clusterMovies, k = 10) # Choosing 10 clusters

# Now let's figure out what the clusters are like.
# Let's use the tapply function to compute the percentage of movies in each genre and cluster

tapply(movies$Action, clusterGroups, mean)
tapply(movies$Romance, clusterGroups, mean)
# We can repeat this for each genre. If you do, you get the results in ClusterMeans.ods

# Find which cluster Men in Black is in.
subset(movies, Title=="Men in Black (1997)")
clusterGroups[257]

# Create a new data set with just the movies from cluster 2
cluster2 = subset(movies, clusterGroups==2)

# Look at the first 10 titles in this cluster:
cluster2$Title[1:10] # Content filtering would recommend these movies to a person who liked Men in Black


# To obtain all the tapply commands for the different genre's, we could do the following:
spl = split(movies[2:20], clusterGroups)
lapply(spl, colMeans) # gives values for each cluster


# Suppose we made only 2 clusters
clusterGroups2 = cutree(clusterMovies, k = 2)
spl2 = split(movies[2:20], clusterGroups2)
lapply(spl2, colMeans) # gives values for each cluster
