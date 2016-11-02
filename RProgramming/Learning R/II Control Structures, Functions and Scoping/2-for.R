for (i in 1:10) {
	print(i)
}


a <- c("a","b","c","d")

# Different ways to print this array :

for (i in 1:4) {
	print (a[i])
}

for (i in 1:4) print (a[i])

for (i in seq_along) {
	print (a[i])
}

for (letter in a) {
	print (letter)
}

# Nested loop

x <- matrix (1:6 ,2 ,3)

for (i in seq_len(nrow(x))) {
	for (j in seq_len(ncol(x))) {
		print (x[i,j])
	}
}