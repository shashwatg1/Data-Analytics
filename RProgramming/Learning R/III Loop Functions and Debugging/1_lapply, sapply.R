#lapply : loop over a list and evaluate a function on each element
#sapply : same as lapply but try to simplify the result


#1. lapply always returns a list irrespective of input class
x <- list(a = 1:5, b = rnorm(10))
x
#$a
#[1] 1 2 3 4 5
#$b
#[1]  1.1985344  0.5090294 -0.2086277  1.5272033 -0.1675176  0.5150004 -1.9034091
#[8] -0.2444238  1.4132932 -0.7756535

lapply(x,mean)
#$a
#[1] 3
#$b
#[1] 0.1863429

x <- 1:3
lapply(x,runif,min=0,max=10)
#[[1]]
#[1] 2.791962
#[[2]]
#[1] 7.139597 4.833702
#[[3]]
#[1] 0.728970 6.151311 8.405722


#2. Sapply tries to simplify the result of lapply
#it tries to return a vector, or matrix if possible, else a list

x <- list(a = 1:5, b = rnorm(10))
sapply(x,mean)
#       a          b 
#3.0000000 -0.6402939 