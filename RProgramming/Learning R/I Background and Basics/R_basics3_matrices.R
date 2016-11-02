#Matrices
#Special type of vectors which have a dimension attribute
m <- matrix(nrow = 2, ncol = 3)
#     [,1] [,2] [,3]
#[1,]   NA   NA   NA
#[2,]   NA   NA   NA
dim(m) #[1] 2 3
attributes(m)
#$dim
#[1] 2 3

m <- matrix(1:6, nrow = 2, ncol = 3)
#filled column wise
#      [,1] [,2] [,3]
#[1,]    1    3    5
#[2,]    2    4    6

#another was of defining a matrix:
m <- 1:6  #[1] 1 2 3 4 5 6
dim(m) <- c(2,3)
print(m)
#      [,1] [,2] [,3]
#[1,]    1    3    5
#[2,]    2    4    6

#Binding rows and columns
x <- 1:3
y <- 10:12
cbind(x,y)
#     x  y
#[1,] 1 10
#[2,] 2 11
#[3,] 3 12
rbind(x,y)
#  [,1] [,2] [,3]
#x    1    2    3
#y   10   11   12