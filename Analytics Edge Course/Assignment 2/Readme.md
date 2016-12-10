#Theory Needed:

###One variable Linear Regression

model : y = a_0 + a_1*x + e
a0, a1 are constants. x is the variable. e is the error from the true value.

Baseline model: y = C, where C is the average of the dependent variable (output)
SSE: Sum of square errors
SST: Total sum of squares, or the SSE for the baseline model
RMSE: sqrt(SSE/N)
R Square measure: Compares best model to baseline model. R^2 = 1 - (SSE/SST). R^2 = 1 means perfect model

###Multiple Linear Regression

Uses multiple variables to improve prediction. But dont use all variables as it would need more data and may cause overfitting despite high R^2 value

model: y = a_0 + a_1*x_1 + a_2*x_2 +...+ a_n*x_n + e


#Four part Assignment