#Basics of R

#setwd("location") sets working directory
#getwd() tells current working directory

#dir() shows all files in the directoy

x <- 1 #assigns 1 to x
class(x) #tells the class of x : Numeric, Integer, Logical, Character, Complex
print(x)

#a vector can store multiple values in a single variable but they all must belong to the same class.
x <- 1:10 #1 2 3 ... 10
x <- c(1,2) #x=1 2 c-concatenates
x <- vector("numeric", length =10) #creates a vector of numeric class and size 10. It will be initialisted as all 0s.
x <- c(1.2, "a") #this is not possible in a vector as only one class can exist. Thus the 1.2 will automaticaly become "1.2" and the vector will be of charater class. x = "1.2" "a" 
#The above was implicit coercion. We also have explicit coercion:
x <- 0:6 #x=0 1 ... 6
y=as.character(x) #y="0" "1"...."6" (converts number to character)

#a list can store multiple values in a single variable and they all can belong to different classes as well!
x <- list(1,"a",T)
# print(x) gives:
# [[1]]
# [1] 1
# [[2]]
# [1] "a"
# [[3]]
# [1] TRUE

#In vector, the element number has single bracket around them, in lists the element number has double bracket around it.

x <- 1:3
#[1] 1 2 3

x <- list((1:3),5,"a","b")
#[[1]]
#[1] 1 2 3
#
#[[2]]
#[1] 5
#
#[[3]]
#[1] "a"
#
#[[4]]
#[1] "b"
