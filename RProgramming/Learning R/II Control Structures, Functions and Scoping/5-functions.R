# function to add two values

add2 <- function(x,y) {
	x+y
}
# automatically returns the last expression
# just call add2(1,2) and 3 is printed


# function to return elements of a vector greator than some 'n'

aboven <- function(x, n = 10) {  # n = 10 says that 10 is a default value if user doesnt enter any 2nd parameter
  use <- x > n
  x[use]
}

# function to calculate mean of each column

colmean <- function(x) {
	nc = ncol(x)
	means = numeric(nc)
	for (i in 1:nc) {
		means[i] <- mean(x[,i])
	}
	means
}

# there may be NA's present and we can ignore them

colmean <- function(x, remNA = TRUE) {
	nc = ncol(x)
	means = numeric(nc)
	for (i in 1:nc) {
		means[i] <- mean(x[,i], na.rm = remNA)
	}
	means
}



# Argument matching is done is R
# func(y-x, mydata, 1:100, FALSE)
# can also be called as below
# func(data = mydata, y-x, model=FALSE, 1:100)
# if argument is named, they are matched, and then the unnamed ones are placed sequentially
# this is useful when calling a function with many arguments



# Function evaluation is LAZY, i.e evaluation is done only when needed

f <- function(a,b) {
	print(a)
	print(b)
}

# say someone types f(10). What is the output?
# [1] 45
# Error: argument 'b' is missing, with no default
# thus 'a' is printed with no problem and the function notices that b is absent only when evaluating b



# ... argument
myplot <- function (x,y,type = "l", ...) {
	plot(x,y,type=type, ...)
}
# ... indicates that a variable number of arguments that are usually passed to other functions. It can be used to extend other functions.