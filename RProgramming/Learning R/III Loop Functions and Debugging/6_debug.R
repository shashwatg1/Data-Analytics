mean(s)
#Error in mean(s) : object 's' not found
traceback()
#1: mean(s)
#on calling traceback it shows the problem

lm(m-n)
#Error in stats::model.frame(formula = m - n, drop.unused.levels = TRUE) : 
#  object 'm' not found
traceback()
#4: stats::model.frame(formula = m - n, drop.unused.levels = TRUE)
#3: eval(expr, envir, enclos)
#2: eval(mf, parent.frame())
#1: lm(m - n)

#there are several othe tools which help debugging