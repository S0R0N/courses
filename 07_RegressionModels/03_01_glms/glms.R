## GML
## Generalized linear models (GLMs)
## limitations of linear models 
## - Additive response models don’t make much sense if the response is discrete
## - or strictly positive
## you could do transformatios , but some of them hurt interpretability. (natural log is the best)

#A GLM involves three components
# - An exponential family model for the response: (RANDOM COMPONENT - DISTRIBUTION)
# - A systematic component via a linear predictor. (SYSTEMATIC COMPONENT - SET OF COEFICIENTS)
# - A link function that connects the means of the response to the linear predictor. (CONNECTING COMPONENT - LINK FUNCTION)

#The three most famous cases of GLMs are:
# - linear models
# - binomial and binary regression
# - Poisson regression

## EXAMPLE - normal
## You have to describe the distribution of your Y ~N(u,sigma^2) (EXPONENTIAL COMPONENT)
## DEFINE THE LINEAR PREDICTORS: n= SUM(Xik*Bik) - multi linear regression (SYSTEMATIC COMPONENT)
## DEfine the linking function: g(u) = n. connect the mean of the normal distribution (exp) to the predictor (siste)

## EXAMPLE - logistic regression - bernoully- cero or one - binary
## Y~ Bernoully(u), E(Y)= u where 0<=u<=1
## linear predictor  = n = SUM(Xik*Bik)
## link function g(u) = n = log(u/1-u), g is the natural log odds, refered to as the logit. 
## the link function transform from the prob of a head (success) to the dimensios of the coeficients

## EXAMPLE - POISSON REGRESSION - POISSON DISTIBUTION - COUNTS/RATES
## Y ~ Poisson(u) so that E(Y) =  u where u>=0
## Linear predictor = n = SUM(xik*Bik)
## link function g(u) = n = log(u). We are not logging the data, just the mean of the distribution
## we can get the u by going backwards the link function

## Modeling assumptions put a restriction between the mean and the variance. 
## sometimes in the real data this restriction does not comply. therefore, the models can not be applied

## GENERAL ISSUES
## Interpretation: is the same as before but in the scale of the distribution we are working with
## INFERECE: The inference test provided by these models require lots of samples. so you better work!

