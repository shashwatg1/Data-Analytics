# Basic Theroy of Logistic Regression

We deal with classification problems which may be Univariate or multivariate<br>
Say Class Yes is denoted by y=1, Class No is denoted by y=0<br>

P(y=1) = 1 - P(y=0)<br>

P(y=1) = 1/[1 + exp(-1 * (a0 + a1 * x1 + a2 * x2 +...+ an * xn))]<br>
Thus, P(y=1) may be between 0 to 1<br>

Odds = P(y=1) / P(y=0)<br>
Thus, Odds = exp(a0 + a1 * x1 + a2 * x2 +...+ an * xn)<br>
Log(Odds) = a0 + a1 * x1 + a2 * x2 +...+ an * xn<br>
Log(Odds) is also called Logit and looks like the lenier regression. Bigger logit, bigger P(y=1)<br>

Based of P(y=1) and P(y=0) we make predictions for the dataset