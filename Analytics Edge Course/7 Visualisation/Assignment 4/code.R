# Visualizing Attributes of Parole Violators
parole = read.csv('parole.csv')
str(parole)
parole$male = as.factor(parole$male)
parole$state = as.factor(parole$state)
parole$crime = as.factor(parole$crime)
str(parole)
table(parole$male, parole$violator)
table(parole$crime, parole$state)

# historgram for the parole count with age
library(ggplot2)
ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5, color="blue")

# take gender into account
# horizontal split
ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5, color="blue") + facet_grid(male ~ .)
# alternate, vertical split
ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5, color="blue") + facet_grid(.~male)

# another alternate, adding colour to the same histogram to show both on them. Here females are stacked on top of where the male column ends
ggplot(data = parole, aes(x = age, fill = male)) + geom_histogram(binwidth = 5)
# changing the colours
colorPalette = c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
ggplot(data = parole, aes(x = age, fill = male)) + geom_histogram(binwidth = 5) + scale_fill_manual(values=colorPalette)

# Best method : adding some transparency and showing each gender individually for better comparison
ggplot(parole, aes(x = age, fill = male)) + geom_histogram(binwidth = 5, position = "identity", alpha = 0.5) + scale_fill_manual(values=colorPalette)


# parole count with Time served
ggplot(data = parole, aes(x = time.served)) + geom_histogram(binwidth = 1)
ggplot(data = parole, aes(x = time.served)) + geom_histogram(binwidth = .1)
ggplot(data = parole, aes(x = time.served)) + geom_histogram(binwidth = 1) + facet_grid(crime ~ .)
ggplot(data=parole, aes(x=time.served, fill=crime)) + geom_histogram(binwidth=1, position="identity", alpha=0.5)
