# repeat it is an infinite loop terminated by calling break only

repeat {
	# to do's
	break
}


# next is the equivalent of continue

for (i in 1:100) {
	if(i <= 20) {
		# skip first 20
		next
	}
}

# return is used to stop a loop and return a value