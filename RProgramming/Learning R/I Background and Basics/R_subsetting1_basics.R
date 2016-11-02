#Subsetting

#There are several operators that can be used to extract subsets of R objects

# [ (single square bracket)
# [[ (The double square bracket)
# $

# [ always returns an object of the same class as the original. So the subset a vector, you're going to get back a vector.
# Any time you used the single bracket operator to subset an object, you'll get the same, an object of the same class back. 
# furthermore the single bracket operator can be used to select more than one element of an object.

# [[ is used to extract elements of a list or a data frame. It can only be used to extract a single element and the class of the returned object will not necessarily be a list or a data frame.
# [[ to extract an element of a list, the object that comes back may not be a list, it may be an object of a totally different class. So that's what the double brack operator is useful for.

# $ is used to extract elements of a list, again of a list or data frame that have a name.
# one of the reasons you've used names in an object is so that you can reference elements of the object by the different names.
# the semantics of the dollar sign are similar to the double bracket in the sense that when you use the dollar sign to extract an element of an object it may or may not be of the same class as the original object.

x <- c("a", "b", "c", "d", "e")
x
#[1] "a" "b" "c" "d" "e"
x[1]
#[1] "a"
x[1:4]
#[1] "a" "b" "c" "d" 

x[x>"a"]
#[1] "b" "c" "d" "e"
 
u <- x>"b"
u
#[1] FALSE FALSE  TRUE  TRUE  TRUE
x[u]
#[1] "c" "d" "e"


x <- list(foo = 1:4, bar = 0.6)
x
#$foo
#[1] 1 2 3 4

#$bar
#[1] 0.6

x[1]
#$foo
#[1] 1 2 3 4

x[[1]]
#[1] 1 2 3 4
 
 x$bar
#[1] 0.6
 x[["bar"]]
#[1] 0.6
 x["bar"]
#$bar
#[1] 0.6


 x <- list(foo = 1:4, bar = 0.6, baz="hello")
 x[c(1,3)]
# $foo
# [1] 1 2 3 4

# $baz
# [1] "hello"


# [[ operator can be used with computed indices
 x <- list(foo = 1:4, bar = 0.6, baz="hello")
 name <- "foo"
 x[[name]] ## computed index for "foo"
# [1] 1 2 3 4
 x$name ## element "name" doesnt exist
# NULL
 x$foo
# [1] 1 2 3 4


 x <- list(a=list(10,12,14), b=c(3.14,2.81))
 x
#$a
#$a[[1]]
#[1] 10

#$a[[2]]
#[1] 12

#$a[[3]]
#[1] 14

#$b
#[1] 3.14 2.81

 x[[c(1,3)]]
#[1] 14
 x[[1]][[3]]
#[1] 14
 x[[c(2,1)]]
#[1] 3.14 
