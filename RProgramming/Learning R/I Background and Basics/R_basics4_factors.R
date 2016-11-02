#Factors
#Used to represent categorical data. Ordered/Unordered.
#it is like an integer vector where each integer has a label.
#usng factors with labels is recommended as it is self-describing.
x <- factor(c("yes","yes","no","yes","no"))
#[1] yes yes no  yes no 
#Levels: no yes
table(x)
#no yes 
#2   3 
unclass(x)
#[1] 2 2 1 2 1
#attr(,"levels")
#[1] "no"  "yes"
#Here no is coded as 1 and yes is coded as 2. No is the baseline level as it comes before alphabetically.

x <- factor(c("yes","yes","no","yes","no"), levels = c("yes","no"))
#[1] yes yes no  yes no 
#Levels: yes no
table(x)
#yes no 
#3   2 
unclass(x)
#[1] 1 1 2 1 2
#attr(,"levels")
#[1] "yes"  "no"
#Here yes is the baseline level as we defined it first