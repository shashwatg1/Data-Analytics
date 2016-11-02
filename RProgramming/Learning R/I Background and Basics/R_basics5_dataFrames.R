#Data Frames
#used to store tabular data
#it is a special type of list where every element of the list has the same length.
#all elements can be thought of as a column and the length of each element is the number of rows
#thus each element must be of the same length but may have a different class
#each element is a column. Its length makes up that column and hence its equal to the number of rows
#thus the elements are being stored horizontally and then each element is opened vertically
row.names() #each row has a name
read.table() #or read.csv()
#data frames are created by calling this
data.matrix() #convert to a matrix however coercion will take place as all have to be of same class in matrix

x= data.frame(foo=10:13, bar=c(T,T,F,F))
#   foo   bar
#1   10  TRUE
#2   11  TRUE
#3   12 FALSE
#4   13 FALSE

#default row names are 1,2,3,4,...

nrow(x) #[1] 4
ncol(x) #[1] 2