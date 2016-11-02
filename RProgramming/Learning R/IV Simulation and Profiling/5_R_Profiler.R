#Premature optimization is the key to evil
#We are often concerned with the speed of our program and we want to optimize it. But this should be done only after design is complete.

# User time : time taken by CPUs
# Elapsed time : time experienced by User

# usually they are close. User > elapsed for multi-core processors, etc and User < elapsed for large waiting time cases

system.time(readLines("http://www.jhsph.edu"))
#user  system elapsed 
#0.83    0.49    4.27

h <- function(n) {
  i <- 1:n
  1/outer(i-1,i,"+")
}
x<- h(1000)
system.time(svd(x))
#user  system elapsed 
#7.47    0.02    7.64 


Rprof() # profiler for R
summaryRprof() # summarises output of Rprof
