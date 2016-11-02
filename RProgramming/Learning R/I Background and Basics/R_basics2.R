y=Inf #Infinite. It can be used (1/0)
z=NaN #Undefined (not a number) (0/0)

#Missing Values
#NA or NaN
is.na() #used to test if the object is NA
is.nan() ##used to test if the object is NaN
#NA also has a class: integer NA, character NA, etc
#NaN value is NA but NA is not NaN

x <- c(1,2,NaN,NA,4)
is.na(x)
#[1] FALSE FALSE  TRUE  TRUE FALSE
is.nan(x)
#[1] FALSE FALSE  TRUE FALSE FALSE

#NaN is used for Undefined mathematical operations and NA is used for everything else