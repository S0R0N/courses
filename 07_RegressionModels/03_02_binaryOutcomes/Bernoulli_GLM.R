## THEY CAN BE USED FOR 
## in biostatistics we're all for doing things like survival analysis where people are either alive or dead at the end of the study
## for example, a cancer study. We can look at wins versus losses, like we're going to do today, or success or failures of any kind.
## The success probability is constant and they're independent, then the total number of successes or failures is a so-called binomial random variable.

## WE HAVE BINARY AND BINOMIAL DATA
## BINARY: coin flip
## BINOMIAL: The success probability is constant and they're independent, the total number of successes or failures

## MODEL THE ODDS into a linear model
## what are the ODDS that the reven win given different score values
## ODDS: how much are you willing to pay for a p probability of winning a dollar
## ODDS: of 1 is no change
## ODDS: <5 or > 2 is a moderated effect (inbalance to one ot the other side)
## IF P>0.5 you have to pay more if you lose than you get if you win
## IF p<0.5 you have to pay less if you win if you lose than you get if you win
## Y oods, X score 
## I can go from the ODDS to the probability and from the probability to the OODS
## P * O/1+O
## O = P/1-P
## logit = is the log of the odds

## the MODEL IS log(Pr(RW|RSi,B0,B1)/1-Pr(RW|RSi,bo,b1)) = B0 +B1Rsi 
## the model is Pr(RW|RSi,B0,B1)/1-Pr(RW|RSi,bo,b1) = exp(B0+B1Rsi)/1+exp(B0+B1*Rsi)
## Rw: event of win or lose
## Rs: Result score
## Pr probability
##
# INTERPRETATION
## MODEL OF ONE BINARY VS CONTINOUS
## - B0 = probability of win With RS =0 (the intercept) i.e., the log odds of a raven wins if they score cero points
## - B1 = The the log odds ratio of win probability for each increment in score (compared ot zero points)
## - exp(B1) = Odds ratio of win probability for each point scored (compared to zero points)
## MODEL OF ONE BINARY VS BINARY
## - Only intercept then it becomes the log odds of the poblation(Y) being Y= success
## - One binary predictor: 
## - - B0 becomes the log odds of Y= success given the predictor(X1) = 0
## - - B1 becomes the ratio of log odds of X1 = success (1) / X1 = Fail (0) -> given Y = success 
## - - so you could get the log odd of predictor (X1) =1 by B0*B1
 

## EVALUATION
## ANOVA, it gives the resid. dev between the models and a deviance value. 
## to know if that deviance value is significant you have to qchisq(0.95, df) 
## DF is the difference between the predictors used in the models
download.file("https://dl.dropboxusercontent.com/u/7710864/data/ravensData.rda"
              , destfile="./data/ravensData.rda",method="curl")
load("./data/ravensData.rda")
head(ravensData)

## CODE EXAMPLE 
library(manipulate)
x <- seq(-10, 10, length = 1000)
manipulate(
  plot(x, exp(beta0 + beta1 * x) / (1 + exp(beta0 + beta1 * x)), 
       type = "l", lwd = 3, frame = FALSE),
  beta1 = slider(-2, 2, step = .1, initial = 2),
  beta0 = slider(-2, 2, step = .1, initial = 0)
)
# it shows that what a linear regression of log odds is doing is getting a curve that 
# minimize the errors to the values of 0 and 1. 

# EXAMPLE OF CALCULATION
# the parameter binomial is for 0 and 1 data, if we are using count data then we should have to provide its sample size
logRegRavens <- glm(ravensData$ravenWinNum ~ ravensData$ravenScore,family="binomial")
summary(logRegRavens)
# the resulting coeficient we want it close to cero (log scale). in the prob scale close to 1

exp(logRegRavens$coeff)
exp(confint(logRegRavens))# getting the confidence interval for the coeficients

## anova test works just the same 


