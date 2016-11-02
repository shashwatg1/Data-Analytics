#R uses Lexical Scoping to deal with free variables.
f <- function (x,y) {
	x + y + z
}
#in this function, we observe that z is free variable, thus lexical scoping is applied.
# the values of free variables is serched in the environment in which the function is defined
# first the function environment is checked followed by the parent environment and so on. if the top-level environment is also unable to help then we follow the scoping list till we hit the empty environment after which an error occurs

make.power <- function(n) {
	pow <- function(x) {
		x^n
	}
	pow
}

cube <- make.power(3)
square <- make.power(2)

cube(3) #prints 27	
square(3) #prints 9

ls(environment(square)) #ls prints environment
# [1] "n", "pow"
get("n",environment(square))
# [1] 2


# Solve for f(3)
y <- 10
f <- function(x) {
	y <- 2
	y^2 + g(x)
}
g <- function(x) {
	x*y
}
# lexical scoping says y=10 in g, dynamic scoping says y=2 in g. R goes with Lexical scoping
