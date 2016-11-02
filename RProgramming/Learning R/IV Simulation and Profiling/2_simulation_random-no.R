#rnorm: generate random normal variates given mean and sd
#dnorm: evauate normal prob. density given mean and sd at a point or vector of points
#pnorm: evaluate cdf for a normal dist.
#rpois: generate random poisson variates with a given rate

#d: density
#r: random no. generate
#p: cumulative dist
#q: quantile function

#for norm, default mean is 0 and sd is 1

x <- rnorm(10)
x
#[1]  0.07081951 -1.51924129  1.11774298  1.01408136 -0.10532624 -1.35292841
#[7] -2.06315187  0.42490045 -0.76285962  0.54374631
x <- rnorm(10,2,4)
x
#[1]  5.0462172  4.4983837 -0.3237913  1.7968001 -6.0714264  3.1011467  3.0583345
#[8]  3.4618310  2.4956713  9.0653288


# we can seed aswell to reproduce random no's
set.seed(1)
rnorm(5)
#[1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078
rnorm(5)
#[1] -0.8204684  0.4874291  0.7383247  0.5757814 -0.3053884
set.seed(1)
rnorm(5)
#[1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078


rpois(10,1)
#[1] 0 0 1 1 2 1 1 4 1 2
rpois(10,2)
#[1] 4 1 2 0 1 1 0 1 4 1


ppois(2,2)
#[1] 0.6766764
ppois(4,2)
#[1] 0.947347