#tapply : evaluate a function over subsets of a vector

x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3,10)
f
#[1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3
#Levels: 1 2 3

tapply(x,f,mean)
#         1          2          3 
#-0.1256812  0.5983218  1.0011637 

tapply(x,f,mean,simplify=FALSE)
#$`1`
#[1] -0.1256812
#$`2`
#[1] 0.5983218
#$`3`
#[1] 1.001164