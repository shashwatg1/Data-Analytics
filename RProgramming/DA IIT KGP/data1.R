x = 1+2
y = log(2)

data1 = c(3,6,9,12,78)
data1Text = c('Mon', 'Tue', "WED")

data1Text = c(data1Text, "Thur")

data2 = scan()

data2Text = scan(what = 'character')

#getwd()
setwd('/home/shashwat/Data Analytics/RProgramming/DA IIT KGP')
#dir()
tcdata = read.csv('stateData.csv', header = T, sep = ',')
extractData = tcdata$X


x = c(1,2,3,4,56) #vector

y <- matrix(1:20, nrow = 4, ncol = 5) #matrix

A = matrix(c(1,2,3,4),ncol=2) 
B = matrix(2:7,nrow=2) 
C = matrix(5:2,ncol=2)

mm = A%*%C     # matrix multiplication 
em = A*C       # entrywise multiplication 
tA = t(A)      # Transpose 


# List
# Unlike a vector or a matrix a list can hold different kinds of objects.
# One entry in a list may be a number, while the next is a matrix, while a third is a character string
x = list(name="Arun Patel", nationality="Indian", height=5.5, grades=c(95,45,80))
# names(x)
# x$name


# Data frames
# A data frame is more general than a matrix, in that different columns can have different modes (numeric, character, factor, etc.)
d <- c(1,2,3,4) 
e <- c("red", "white", "red", NA) 
f <- c(TRUE,TRUE,TRUE,FALSE) 
myframe <- data.frame(d,e,f)
names(myframe) <- c("ID","Color","Passed") 

gender <- c(rep("male",20), rep("female", 30))
gender <- factor(gender)
#summary(gender)
