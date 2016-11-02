#Reading Data
read.table() #read a table and generate a data frame
read.csv() #read a table and generate a data frame
source() # source any .R file code (opposite of dump)
readLines() #reading lines of a txt file
dget() # reading r code files for r objects which have been de parsed (opposite of dput)
load() # reading in workspaces
unserialize() #loading binary objects into R

#writing Data
analogous functions
write.table()
writeLines()
dump()
dput()
save()
serialize()


#read.table() function arguments:

#file() name of file
#header() logical indicating if the first line is a header line with all the header names and is not data
#sep() string indicating how the columns are separated eg. , or ; or tab etc. default is space
#colClasses() character vector with length equal to number of columns telling what class each column is
#nrows() number of rows in dataset
#comment.char() tells which is the comment symbol : # or $ etc. the lines to the left of that symbol are skipped. defualt is #
#skip() number of lines to skip from beginning
#stringsAsFactors() logical: should character variables be coded as factors?

#generally for small datasets we  read.table directly without specifying any arguments and it understands
data <- read.table("a.txt")
# '#'lines are skipped
# nrows, colClasses is figured out automatically but it is twice as slow
#read.csv is identical to read.table except that the default separator is a comma.


#Reading Large Datasets using read.table

#read the help page for read.table()

#if dataset is larger than the RAM on computer then stop right there as all the data is stored onto the RAM
#set comment.char = "" if there are no commented lines in your file
#specify colClasses for more speed IMPORTANT!!
#set nrows for better memory usage IMPORTANT!!

#Calculating MemoryRequirements:

# 1,500,000 rows and 120 columns, all numeric.
# 1,500,000 * 120 * 8 bytes/numeric
# 1440000000 bytes / 2^20 ....this gives MB
# 1373 MB
# 1.34 GB
# space a little more than 1.34 GB at least is required. having twice is recommended.
