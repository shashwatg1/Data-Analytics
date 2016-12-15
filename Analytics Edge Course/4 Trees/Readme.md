# Basic Theroy of Trees

Used when it is difficult to have a lenier model fit the dataset<br>

###CART stands for Classification and Regression Trees<br>

It makes use of splits and predicts the outcome following the splits. It is not linear and is very interpretable.<br>

Say a dataset is non-linearly spread on a 2D plane. We split the plane into zones which will classify to a particular output. Thus we have split the dataset into zones. Now we can easily make a decision tree for the different zones. <br>

Conventionally, "Yes" is on the left and "No" is on the right side. <br>

How to know the number of split?<br>
One way is to set a lower bound for the number of points in each subset. The parameter to do this in R is called minbucket. The smaller it is the more the number of splits. But too small will lead to overfitting and too much will lead to bias.<br>

In each subset there are a bucket of different observations which may belong to different classes. Calculate propability of each class and classify the subset according to the threshold. ROC curve and AUC can be used to evaluate the model.

###Random Forest

They are designed to improve the performance of CART by building a large number of CART trees. Each tree then votes for the outcome and we pick the majority.<br>

Each tree is built from a "bagged" or "bootstrapped" sample of data<br>
Eg. The data "12345" could be used as 24521 and 53512 in two different trees and so on.<br>

nodesize is the parameter for the min. number of observations in a subset. Small nodesize leads to more trees and hence more time will be taken up. Each bag may miss some data points thus there should be resonable number of trees.

###Cross Validation

Done using methods like k-fold Cross validation to select a parameter called cp (Complexity Parameter). it would measure the tradeoff between model simplicity and accuracy. Smaller cp means bigger tree.