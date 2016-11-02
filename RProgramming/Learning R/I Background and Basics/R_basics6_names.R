#Names

#R Objects can have names

x <- 1:3
#x
#1 2 3
names(x)
#NULL
names(x) <- c("a","b","c") #giving names to each element of vector x
#x
#a b c
#1 2 3
names(x)
#[1] "a" "b" "c"

#in lists:
x <- list(a=1,b=2,c=3)
#$a
#[1] 1
#$b
#[1] 2
#$c
#[1] 3

#in matrices
x <- matrix(1:4, nrow = 2, ncol = 2)
#     [,1] [,2]
#[1,]    1    3
#[2,]    2    4
dimnames(x)
#NULL
dimnames(x) <- list(c("a","b"), c("c","d")) # row names and column names
#  c d
#a 1 3
#b 2 4