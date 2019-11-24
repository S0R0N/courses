## Posssion for outbounded counts
## EXAMPLES
## COUNTS
## -  The number of calls to a call center
## -  The number of flu cases
## - Number of cars that cross a bridge
## RATES
## - Percent of children passing a test
## - Percent of hits to a web site from a country
## - number of intances a nuclear pum falied per time
## - incicdence rate number of newly developed casesper person time at risk

## POISSON LINEAR REGRESION MODEL
## E(NHSSi|JDi, B0, B1) = exp(B0+B1JDi)
## for the example of the web hits

## POISSON RATE LINER REGRESSION MODEL
## E(NHSSi|JDi, B0, B1)/NHi = exp(B0+B1JDi)
## log(E(NHSSi|JDi, B0, B1)) = log(NHi) + B0 + B1JDi

## BINOMIAL APROX
## - when the when the success prob is very small and the end is very large

## CONTIGENCY TABLE DATA
## like word co-occurrence

## MASS POISSON FUNCTION
## P(X = x) = (t*lambda)*exp(-t*lambda)/!x
# t total tiem
# Poisson tends to a normal when t*lamnda gets larger

# LINEAR VS POISSON REGRESSION
# linear we have the expected outcome given the predictors
# poisson we have the log of the expected outcome of the fiven predictors 
# poisson is like the expected value  = Exp(the linear regression model)
# THEREFORE, EXP(B1) is expected increment of my predicted variable when modifying the predictor by 1. 

## MODELING PROCESS
## first a normal linear model
## check the graph
## then a log linear model a transformation. 
### what is a log transformation do? 
#### the value exp(E(log(Y))): the population geometric mean
#### when you do this transformation, your coeficients are interpretable to the arimetic mean
#### for example exp(B0) is the estimated geometric mean of hits on day 0. 
###### To make B0 more interpretable is best to start the cero count in our cero day of the sampled data
#### exp(B1) is the estimated increase or decrease with respect of the geometric mean hits per day
#### you have to add a constat to elimnate ceros from your dataset when using log
## DO the possion model
## EVALUATE THE POISSON MODEL
## if the variance is increasing in time then use quasy possion model.
## Check the residuals and try quasy poisson models 
## Hover ever if it fails. You have to check other options. (???)

## CHANGE IN INTERPRETATION WHEN WORKING WITH RATES
## we are dividing the count by something. time, person at risk time. 
## example, web hits originating from simply statistics / total web hits
## Adding the division changes the model 
## The only change is to add to the B0 the log of the rate (e.g., total web hits, person at risk, total humans)
## the easiet way to add it to our model is by using the parameter offset = (rate+1)


### CHALLENGES
### CERO INFLATION: check the jeff leck pagackge pscl 

## CODE EXAMPLE 
load("data/gaData.rda")
gaData$julian <- julian(gaData$date)# julian data counts the days since january 1 1970. Why the transformation?
### to have date in a count format
head(gaData)
## THe model goes like this
# NHi =  B0 + B1XJDi +ei
# NH: number of hits per day
# JDi: day of the year (julian day)
# B0 = number of hits on julian day 0 (for this dataset)
# B1: increase in muber of hits per unit of day (time)
# ei: variation due to everthing we did not measure. 
## normal linear regression still not the poisson
plot(gaData$julian,gaData$visits,pch=19,col="darkgrey",xlab="Julian",ylab="Visits")
lm1 <- lm(gaData$visits ~ gaData$julian)
abline(lm1,col="red",lwd=3)

## TRANSFORMING THE linear REGRESSION WITH LOG
round(exp(coef(lm(I(log(gaData$visits + 1)) ~ gaData$julian))), 5)
## B1 1.00231 - > in exponential sclae this means that there is an increase of .2 hits per day.
log(round(exp(coef(lm(I(log(gaData$visits + 1)) ~ gaData$julian))), 5))[2]

## LINEAR VS POISSON REGRESSION
##
plot(gaData$julian,gaData$visits,pch=19,col="darkgrey",xlab="Julian",ylab="Visits")
glm1 <- glm(gaData$visits ~ gaData$julian,family="poisson")
abline(lm1,col="red",lwd=3); lines(gaData$julian,glm1$fitted,col="blue",lwd=3)

plot(glm1$fitted,glm1$residuals,pch=19,col="grey",ylab="Residuals",xlab="Fitted") # this graph shows that the possion model 
# has a problem in variance (the residuals). The problem is that the variance increases in lower vales of time. 
# it should look random. 

# getting the confidence interval for your poisson model 
library(sandwich)
confint.agnostic <- function (object, parm, level = 0.95, ...)
{
  cf <- coef(object); pnames <- names(cf)
  if (missing(parm))
    parm <- pnames
  else if (is.numeric(parm))
    parm <- pnames[parm]
  a <- (1 - level)/2; a <- c(a, 1 - a)
  pct <- stats:::format.perc(a, 3)
  fac <- qnorm(a)
  ci <- array(NA, dim = c(length(parm), 2L), dimnames = list(parm,
                                                             pct))
  ses <- sqrt(diag(sandwich::vcovHC(object)))[parm]
  ci[] <- cf[parm] + ses %o% fac
  ci
}

confint(glm1)
confint.agnostic(glm1) # developed by Jhon hopkins professors. It shows you the quasy approx to calculate the conf int
# these coefs are not exponentiated. If you exp values close to cero, they will probably just add 1. 


## EXAMPLE OF FITTING RATES
## NOTES: the parameter offset to add the rate
## NOTES: the parameter family: so it knows is a poisson
glm2 <- glm(gaData$simplystats ~ julian(gaData$date),offset=log(visits+1),
            family="poisson",data=gaData)
plot(julian(gaData$date),glm2$fitted,col="blue",pch=19,xlab="Date",ylab="Fitted Counts")
points(julian(gaData$date),glm1$fitted,col="red",pch=19)

## THE FITTED MODEL INCLUDING THE RATE
glm2 <- glm(gaData$simplystats ~ julian(gaData$date),offset=log(visits+1),
            family="poisson",data=gaData)
plot(julian(gaData$date),gaData$simplystats/(gaData$visits+1),col="grey",xlab="Date",
     ylab="Fitted Rates",pch=19)
lines(julian(gaData$date),glm2$fitted/(gaData$visits+1),col="blue",lwd=3)
