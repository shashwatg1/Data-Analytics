#Textual Formats
dput()
dump()
#dumping and dputing are useful because the resulting textual format is editable and in case of curruption it is recoverable
#it is not very space efficient though
#it contains metadata by sacrificing readability. But makes work easier for the user and the computer while processing

y <- data.frame(a=1,b="a")
#y
#  a b
#1 1 a

dput(y)
#structure(list(a = 1, b = structure(1L, .Label = "a", class = "factor")), .Names = c("a", "b"), row.names = c(NA, -1L), class = "data.frame")
#it has constructed some code that is node very readable but has a lot of metadata

dput(y, file="y.R")
#we put the data in a file y.R

new.y <- dget("y.R")
#dget gets the R code from the file and puts it into the R object
#the object has been reconstructed as can be seen below
#dput writes R code which can then be used to reconstruct an R object
new.y
#  a b
#1 1 a


#dget can be used on a single R object
#dump can be used on multiple R objects
x <- "hi"
y <- data.frame(a=1, b= "a")
#creates x and y

dump(c("x","y"), file="data.R")
#dumps them in this file

rm(x,y)
#removes them
#now if we print x or y then we get an error

source("data.R")
#sourcing the file brings back x and y into the workspace
#now then can be used and printed etc