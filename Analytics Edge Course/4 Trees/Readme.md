# Basic Theroy of Trees

Used when it is difficult to have a lenier model fit the dataset<br>

CART stands for Classification and Regression Trees<br>

It makes use of splits and predicts the outcome following the splits. It is not linear and is very interpretable.<br>

Say a dataset is non-linearly spread on a 2D plane. We split the plane into zones which will classify to a particular output. Thus we have split the dataset into zones. Now we can easily make a decision tree for the different zones. <br>

Conventionally, "Yes" is on the left and "No" is on the right side. <br>

How to know the number of split?<br>
One way is to set a lower bound for the number of points in each subset. The parameter to do this in R is called minbucket. The smaller it is the more the number of splits. But too small will lead to overfitting and too much will lead to bias.