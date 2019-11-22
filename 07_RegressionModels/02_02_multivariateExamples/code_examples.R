## CODE Examples for multivarible
### Example of a graph to show the cprelations of all the variables between themselves. 
require(datasets); data(swiss); require(GGally); require(ggplot2)
library(GGally)
library(ggplot2)    
data(swiss)

# Function to return points and geom_smooth
# allow for the method to be changed
# a fix
my_fn <- function(data, mapping, method="loess", ...){
  p <- ggplot(data = data, mapping = mapping) + 
    geom_point() + 
    geom_smooth(method=method, ...)
  p
}

# Default loess curve    
#g = GGally::ggpairs(swiss, lower = list(continuous = "smooth"),params = c(method = "loess"))
#g
g = ggpairs(swiss, lower = list(continuous = my_fn))
####
#Calcualting a linear model from all the variables in a dataset. using the . command in lm
summary(lm(Fertility ~ . , data = swiss))$coefficients
# standard error of a coeficient speaks of its precision or varaibility.

## The addition or removal of variables into the model have consequences in the coeficients. 
## However, adding not informative variables to the model is bad
z <- swiss$Agriculture + swiss$Education
lm(Fertility ~ . + z, data = swiss)
# the coeficint assigned to it is NA. This mean that the variable you added was a linear combination of the other variables already assigned to the model


## DUMMY VARIABLES ARE SMART - HOWEVER they have ISSUES!!! see bellow
## Factor variables, 0 or 1
## The of the facto variable will indicate the increase or decrease in the mean comparing those in the group to those not
## these test is similar to the T-test of two groups assuming common variance
## when comparing three factors for example republicans, independent and democrats. 
## the betas become the comparision factors. i.e., X1 is republicans, X2 is democrats and indepdents is excluded.
## then B1 would be the comparision of republicans vs independents
## B2 would be comparison of democrats vs independents 
## B2-B1 would be comparision of democrats vs republicans. 
## if you omit any of the other factors from the set then the reference changes. 
## the omited factor is the reference.
## The intercept is the mean of the reference predictor

# EXAMPLE OF FACTOR VARIABLES
require(datasets);data(InsectSprays); require(stats); require(ggplot2)
g = ggplot(data = InsectSprays, aes(y = count, x = spray, fill  = spray)) # fill parameter tells what variable will fill the objects I will create later in the ggplot
g = g + geom_violin(colour = "black", size = 2) # violin - gives max Vs min of different factors showing ranges
g = g + xlab("Type of spray") + ylab("Insect count")
g
## Running the linear model of the factors it automatically recongnized the different values of the factor spray
summary(lm(count ~ spray, data = InsectSprays))$coef
## the process in which R selects the reference factor is by selecting the lower alphanumeric factor
## i.e., if the factor values are numbers then gets the lowest if they are letters it gets "lowest"
## The I function????
summary(lm(count ~ 
             I(1 * (spray == 'B')) + I(1 * (spray == 'C')) + 
             I(1 * (spray == 'D')) + I(1 * (spray == 'E')) +
             I(1 * (spray == 'F'))
           , data = InsectSprays))$coef

# If I plug in the reference variable to the model, then R will NA it. 

# if I want to compare my factors against the default and not a reference factor then what?
summary(lm(count ~ spray - 1, data = InsectSprays))$coef
library(dplyr)
summarise(group_by(InsectSprays, spray), mn = mean(count))
# it shows a factor for each mean of the sprays, like comparing them to cero not a control factor

# REoRDERING LEVELS to SET A REFERENCE
spray2 <- relevel(InsectSprays$spray, "C") # relevel command defines the reference
summary(lm(count ~ spray2, data = InsectSprays))$coef
#
## ISSUES
## Not all data is normal: The data are counts, they are likely to be poisson not normal distributed. 
## The variance of the compared datasets might be different, not constant (as assumed by the linear approach)
## Heteroscedasticity other advaced topics of statistical inference


## ENCOVA - Fitting multiple lines with different intercepts and slopes
## is to include analysis to combine factor and continous variables
## also to model the factor and continous varibles and their interaction
## meaning thar varying models you can analyze different behaviours in the data. 

library(datasets); data(swiss)
head(swiss)
library(dplyr); 
swiss = mutate(swiss, CatholicBin = 1 * (Catholic > 50))# adds a variable chatholicbin to the data frame by applying the indicated operation over the variable catholic

g = ggplot(swiss, aes(x = Agriculture, y = Fertility, colour = factor(CatholicBin)))
g = g + geom_point(size = 6, colour = "black") + geom_point(size = 4)
g = g + xlab("% in Agriculture") + ylab("Fertility")
g
#####
# examples of the ANCOVA models
summary(lm(Fertility ~ Agriculture + factor(CatholicBin), data = swiss))$coef
# This one comes from the model without interaction, only a normal line. 
# Y  = B0 + B1*X1(continuos) + B2*X2(bonomial)
# it gives you the two lines for Y affected by agriculture with or the effect of catholisim
# drawing two paralel lines showing the fit lines for taking into acount the binary relationship
# one line for catholisim 1 and other for 0
fit = lm(Fertility ~ Agriculture + factor(CatholicBin), data = swiss)
g1 = g
g1 = g1 + geom_abline(intercept = coef(fit)[1], slope = coef(fit)[2], size = 2) # only agriculture is for those with catholic = 0
g1 = g1 + geom_abline(intercept = coef(fit)[1] + coef(fit)[3], slope = coef(fit)[2], size = 2)# agriculture plus catholic- 1
g1

summary(lm(Fertility ~ Agriculture * factor(CatholicBin), data = swiss))$coef
##
## THIS ONE is showing the interaction between the variables
## to do that include the * to fit the interaction
fit = lm(Fertility ~ Agriculture * factor(CatholicBin), data = swiss) # note the asteric in agriculture
g1 = g
g1 = g1 + geom_abline(intercept = coef(fit)[1], slope = coef(fit)[2], size = 2)
g1 = g1 + geom_abline(intercept = coef(fit)[1] + coef(fit)[3], 
                      slope = coef(fit)[2] + coef(fit)[4], size = 2)
g1

## THis one gives you directly the line without the relationship and with the relationship
summary(lm(Fertility ~ Agriculture + Agriculture : factor(CatholicBin), data = swiss))$coef

# The intercept for mostly protestant (the variable 0)
# Slope agriculture is the slope for mostly protestant
# The third factor + protestant intercept is going to be the intercept for mostly catholic
# and the slope A and B are the slopes for the mostly catholic


## ADJUSTMENT
## Adjustment, is the idea of putting regressors into a linear model to investigate the role of a third variable on the relationship between another two
## The coefficient of interest is interpreted as the effect of the predictor on the response, holding the adjustment variable constant.
## like control variables as company size and like that
## A treatment versus a control or something you might see in an AB test when we're adjusting for a continuous variable.

## In the paralel lines model the B1 represent the change in the intercept of the groups
## B2 is the common slope that exists between the grups



