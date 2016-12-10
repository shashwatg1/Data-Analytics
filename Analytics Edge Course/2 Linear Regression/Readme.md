# Theory Needed:

### One variable Linear Regression

model : y = a0 + a1 * x + e<br>
a0, a1 are constants. x is the variable. e is the error from the true value.

Baseline model: y = C, where C is the average of the dependent variable (output)<br>
SSE: Sum of square errors<br>
SST: Total sum of squares, or the SSE for the baseline model<br>
RMSE: sqrt(SSE/N)<br>
R Square measure: Compares best model to baseline model. R^2 = 1 - (SSE/SST).<br>
R^2 = 1 means perfect model

### Multiple Linear Regression

Uses multiple variables to improve prediction. But dont use all variables as it would need more data and may cause overfitting despite high R^2 value

model: y = a0 + a1 * x1 + a2 * x2 +...+ an * xn + e<br>