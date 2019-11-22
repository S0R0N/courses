## introduction to multivarible regression
# Problem of multicplicity: sometimes after searching thtrouh varibles we find random relationship
# objective of multivariable regression
## It's trying to look at the relationship of a predictor and a response, while having, at some level, accounted for other variables.

## components 
## MODEL SEARCH: how do we pick which predictors to include in a model
## AVOID OVERFITTING: 


# basic equations
# the model is like the ones in one variable but with the other included
# Y = B0 +B1X1 + B2X2 + ... + BnXn
# sum of squared error is 
# Sum(Yresponse - Sum(XkiBj)^2)
# the linearity means linearity in the regressors, i.e., if I square all of them they are linear between themselves or if I log them then they are still linear between themselves. 

### HOW TO GET THE ESTIMATES
# So to get the estimates is like sacrificing variables and getting the variation of them into the others. 
# so you can do this for all the variables in the model. 
# like contracting their variation into the other variables. 
# the regresions against constants is the Yi-Yexpected

# WHAT THE ESTIMATES MEANS
# So the interpretation of a multi-variable regression coefficient is
# it is the expected change in the response for a unit change in a regressor but
# holding all the other ones constant.

# Properties of the model
# variance estimate: simga^2 = 1//(n-p) * Sum(e^2) where P is the number of regressors
# the coeficients have standard errors. 

## POSIBLE APPLICATIONS
# Decompose signals to its armonics. 
# Felxibly fit complicated functions  (curves)
# Fit factor variables as predictors
# Build accurate predion models

## GETTING THEM ON R
n = 100; x = rnorm(n); x2 = rnorm(n); x3 = rnorm(n) # simulated predictors
y = 1 + x + x2 + x3 + rnorm(n, sd = .1) # simualted real values
ey = resid(lm(y ~ x2 + x3))             # getting the residuals of Y fitted to X2 and X3
ex = resid(lm(x ~ x2 + x3))             # getting the residuals of X fitted to X2 and X3
sum(ey * ex) / sum(ex ^ 2)              # regression to the origin estimate i.e., lm(ey ~ ex - 1)
coef(lm(ey ~ ex - 1))                   # sames as above
coef(lm(y ~ x + x2 + x3))               # this code shows that the regression of all Y into x2 and x3 and x on x2 and x3 and the regression of these residuals to each other are the same value of the X coeficient in the real model


## code examples

