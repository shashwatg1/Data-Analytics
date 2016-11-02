#apply : evaluate a function over the margins of an array

#we pass an array, an integer vector(margin) and a function to 'apply'

x <- matrix(rnorm(200),20,10)

apply(x,2,mean)
#[1] -0.04159846 -0.05620044  0.03682282 -0.13260544 -0.08032171  0.04657775
#[7] -0.17818124 -0.24170362 -0.06512908  0.15934690

apply(x,1,sum)
#[1] -2.4704570  0.4933024  2.1611733 -1.7441682  3.1250849 -4.6424256  3.7909205
#[8] -5.7656328 -2.6625246  0.3569783  0.8334005 -5.7614565 -3.4801515 -2.3076941
#[15]  2.1885330  2.2014548  4.8217322 -0.6938398 -2.3703711  0.8662909

#rowSums is an optimized function same as apply(x,1,sum)
#similarly we have rowMeans colSums and colMeans

a <- array(rnorm(2*2*10),c(2,2,10))
apply(a,c(1,2),mean)
#[,1]        [,2]
#[1,]  0.2455613 0.530495423
#[2,] -0.3596144 0.007905242
rowMeans(a,dims=2)
#[,1]        [,2]
#[1,]  0.2455613 0.530495423
#[2,] -0.3596144 0.007905242