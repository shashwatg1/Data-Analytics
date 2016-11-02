#"summary" function which gives compact structure of any R object

str(str)
#str(function (object, ...)  

str(lm)
#function (formula, data, subset, weights, na.action, method = "qr", model = TRUE, 
#          x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, contrasts = NULL, offset, 
#          ...) 

x <- rnorm(100,2,4)
summary(x)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#-9.7250 -0.1894  1.9050  1.9810  4.3090 11.7200 
str(x)
#num [1:100] 1.01 3.5 3.23 4.16 2.17 ...


m <- matrix(rnorm(100),10,10)
str(m)
#num [1:10, 1:10] 0.877 -1.43 -0.462 0.393 0.66 ...
