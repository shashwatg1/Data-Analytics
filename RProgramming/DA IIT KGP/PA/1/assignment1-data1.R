csvdata = read.csv("Data1.csv")

print.descriptive.stat <- function(arr) {
  print(paste("Mean:", mean(arr, na.rm=T)))
  print(paste("Variance:", var(arr, na.rm=T)))
  print(paste("Standard Deviation:", sd(arr, na.rm=T)))
  cat("\n")
}

print("Subject-wise")
for(i in names(csvdata)[-1]) {  # -1 means all except 1
  print(paste("For", i))
  subject = csvdata[[i]]  # convert column to row
  print.descriptive.stat(subject)
}

print("Student-wise")
for(i in 1:nrow(csvdata)) {
  print(paste("For student:", i))
  student = as.numeric(csvdata[i,])
  print.descriptive.stat(student)
}

print(paste("Median of mean values subject-wise:", median(colMeans(csvdata[-1]), na.rm=T)))
