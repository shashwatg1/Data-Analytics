#Say we have a model of our own
# y = 0.5 + 2a + b
# a = N(0,1)
# b = N(0,4)

set.seed(20)
a <- rnorm(100)
b <- rnorm(100,0,2)
y <- 0.5 + 2*a + b
summary(y)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#-6.4080 -1.5400  0.6789  0.6893  2.9300  6.5050
plot(a,y)


#y=poisson(u)
#log u = 0.5 + 0.3x
set.seed(1)
x <- rnorm(100)
log.u <- 0.5 + 0.3*x
y <- rpois(100,exp(log.u))
summary(y)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#0.00    1.00    1.00    1.55    2.00    6.00
