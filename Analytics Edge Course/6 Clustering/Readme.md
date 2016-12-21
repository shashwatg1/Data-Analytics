# Recommendation Systems

In a **recommendation system**, we have to make predictions to people about things based on what they feel about other things: <br>

Generally Data is of two forms, 1. The set of data with eath data's own characteristics and 2. What all the people feel about each data, irrespective of the data's characteristics <br>

We may know what people individually feel about some fruits irrespective of the properties of those fruits, at the same time we could know the properties of the fruits. So we could use both of these individual information while clustering<br>

-> If we do predictions of things which other people liked and also had similar response to the things this person rated, then the method is called **Collaborative Filtering**. We dont care about the information of each item.<br>

-> If we do predictions based on the properties of things which this person liked, then the method is called **Content Filtering**<br>

###Collaborative Filtering
* can suggest complex items without caring about the nature of the item
* requires lots of data about the user
* there should be lots of items and heavy computing power

###Content Filtering
* requires little data
* but limited scope. less insightful

Often, a hybrid is used for good recommendation systems. Clustering is often used in recommendation systems aswell

# Clustering

A form of unsupervised learning with the goal of segmenting the data into groups, not prediction. Predictions can be made later based on the clusters. We can make prediciton models for each cluster aswell. <br>

Two common methods as **Hierarchical** and **K-Means** <br>

Clustering methods are based on the distnce between the data points. Similar points are expected to be closer and are made into a cluster. We use Euclidean distance from the centroid of the clusters in this application. <br>

Another important thing is to normalize the data based on their scales to improve performance. Subtract from mean and divide by standard deviation<br>

###Hierarchical Clustering

We start with 'n' number of points and 'n' clusters for each point. Closest two clusters are combined into one cluster in each step. Euclidean centroid distance is used in our case. This process goes on and we are finally left with all points in 1 cluster only.<br>

A dendrogram can be used for seeing each step and bifurcation. The height represents the distance between the clusters. We can chose a horizontal line of separation based on how many clusters we need and the horizontal line must be at a position with significant height as a threshold to prevent error. Wherever we chose to make the horizontal line, the number of vertical lines crossing will be the number of clusters we will get.<br>

After making the clusters we must check if they are meaningful and if we need more or if we can reduce the clusters.<br>

This method cannot be applied to cases with high number of data points as calculating the pairwise distances takes too much memory<br>

###K-Means Clustering

* Specify the number of clusters 'k'
* Randomly assign a each data point to a cluster
* Compute cluster centrois
* Re-assign each point to the closest cluster centroid
* Recompute cluster centroids and keep repeating till required

Often random assignment initially can be a little risky and hence some prior knowledge of the data might help in the initial assignment. The value of k must also be tried and tested.

This method can be applied to cases with large number of data points unlike hierarchical clustering<br>

Essentially k-means clustering is same as the hierarchical clustering but here the number of clusters is fixed unlike hierarchical where we can select from the dendograms. <br>