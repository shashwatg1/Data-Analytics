x <- matrix(1:6, 2, 3)
x

#     [,1] [,2] [,3]
#[1,]    1    3    5
#[2,]    2    4    6

 x[1, 2]
#[1] 3
 x[2, 1]
#[1] 2
 
 x[1, ]
#[1] 1 3 5
 x[, 2]
#[1] 3 4


# By default, when returning a single element, it is converted into a vector
# If we want a matrix of 1X1, we must set drop = flase
 x[1,2,drop=FALSE]
#     [,1]
#[1,]    3

# Same applies for a column
 
 x[1, ]
#[1] 1 3 5

 x[1, , drop =FALSE]
#     [,1] [,2] [,3]
#[1,]    1    3    5



# Partial matching of names is allowed with [[ and $

 x <- list(aardwark = 1:5)
 # we dont want to type entire aardwark everytime
 x$a
#[1] 1 2 3 4 5
 x[["a"]]
#NULL
# it fails because it expects an exact match, we can set exact to false to disable this feature and get partial matching
 x[["a", exact = FALSE]]
#[1] 1 2 3 4 5


# Removing missing values

 x <- c(1,2,NA,4,NA,5)
 x
#[1]  1  2 NA  4 NA  5
 bad <- is.na(x)
 bad
#[1] FALSE FALSE  TRUE FALSE  TRUE FALSE
 x[!bad]
#[1] 1 2 4 5

 x<-c(1,2,NA,4,NA,5)
 y<-c("a","b",NA,"d",NA,"f")
 good<-complete.cases(x,y)
 good
#[1]  TRUE  TRUE FALSE  TRUE FALSE  TRUE
 x[good]
#[1] 1 2 4 5
 y[good]
#[1] "a" "b" "d" "f"
 
 x<-c(1,2,NA,4,NA,5)
 y<-c("a","b",NA,"d","g",NA)
 good<-complete.cases(x,y)
 good
#[1]  TRUE  TRUE FALSE  TRUE FALSE FALSE
 x[good]
#[1] 1 2 4
 y[good]
#[1] "a" "b" "d"
