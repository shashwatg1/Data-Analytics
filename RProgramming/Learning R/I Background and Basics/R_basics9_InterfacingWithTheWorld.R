#Interfaces to the Outside World
#there are several functions which are used to make connections

#file : opens a connection to a file
#gzfile : opens a connection to a file compressed with gzip
#bzfile : opens a connection to a file compressed with bzip2
#url : opens a connection to a webpage

#these connections are generally made internally and not always externally

str(file)
#function (description = "", open = "", blocking = TRUE, encoding = getOption("encoding"), raw = FALSE)

#description is the name
#open is the code indicating:
#   "r" read only
#   "w" writing and initializing a new fil
#   "a" appending
#   "rb" "wb" "ab" reading writing or appending in binary mode



#generally the connection interface is taken care directly

con <- file("a.txt", "r")
data <- read.csv(con)
close(con)

#this is the same as:

data <- read.csv("a.txt")



#connection can be useful to read parts of a file

con <- gzfile("a.gz")
x <- readLines(con, 10)
print(x)
#the first 10 lines are read
#writeLines() can also be used to write lines into the file



#Reading from a webpage

#this might take time
con <- url("http://www.blah.com", "r")
x <- readLines(con)

