#NOTATIONS

# Ordinary least squares (OLS) are the thing for linear regressions
# important concepts
## normalization which is centering by the mean (substracting the mean) and dividing by the standard error.
## covaraince is the multiplicacion of the variances of two datasets. n number of elements. 
## correlation is the covarainace standardized to null dimensions (i.e., divided by the Standard deviations)
## correlation has to be between -1 and 1
## correlation measures the strenghts of the linear relationship between the X and Y data, with stronger relationships to the extremes
## correlation  = 0 implies no linear relationship

# Least squares estimation of regression
# the linear regresion is about getting the parameters that form the best line to relate two datasets. 
# so to calculate it we need to find the best parameters, the intercept and the slope of the line that connects the two datasets 
# To calculate the parameters, we need a criteria, one is the least square. 
# B1 slope is the correlation multiplied by the ratio of the standard deviations
# B0 the intercept is Ybar - B1*Xbar. 
# if you change the order of fitting, i.e., X to Y and Y to X the results will be different
# the slope will be the same if you center the data first.
# if you normalize the data, the slope B1 will be equal to the correlation
# Regressions are a part of linear models.

# B1 or the slope says the relation between the vars.
# Residuals: are the differences between the value in the line and the real values. 
## Residuals have mean cero
## Residuals must be uncorrelated with our predictors
## The varaiance of residuals and estimates is equal to the varaince of the data. 
### i.e., var(data)=var(estimate)+var(residuals) 
### Therefore, the varaince of the estimate is always less than the varaince of the data
### varaiances are always positive, cause they are squared. 

library(UsingR)
data(galton)
library(dplyr); library(ggplot2)
freqData <- as.data.frame(table(galton$child, galton$parent))
names(freqData) <- c("child", "parent", "freq")
freqData$child <- as.numeric(as.character(freqData$child))
freqData$parent <- as.numeric(as.character(freqData$parent))
g <- ggplot(filter(freqData, freq > 0), aes(x = parent, y = child))
g <- g  + scale_size(range = c(2, 20), guide = "none" )
g <- g + geom_point(colour="grey50", aes(size = freq+20, show_guide = FALSE))
g <- g + geom_point(aes(colour=freq, size = freq))
g <- g + scale_colour_gradient(low = "lightblue", high="white")  
g


## running the model to explain childs heights in terms of father heights
## manual calculation
y <- galton$child
x <- galton$parent
beta1 <- cor(y, x) *  sd(y) / sd(x) # slope manual calculation
beta0 <- mean(y) - beta1 * mean(x)  # intercept manual calculation 
rbind(c(beta0, beta1), coef(lm(y ~ x))) # comparison of the manual calculation and the lm command
# lm by default includes the intercept
# coef extracts only the coeficient from the linear regression

## now what happens if we reverse the roles
beta1 <- cor(y, x) *  sd(x) / sd(y)
beta0 <- mean(x) - beta1 * mean(y)
rbind(c(beta0, beta1), coef(lm(x ~ y)))

# now what happens if we center the data? the slope should be the same
yc <- y - mean(y)
xc <- x - mean(x)
beta1 <- sum(yc * xc) / sum(xc ^ 2)
c(beta1, coef(lm(y ~ x))[2])# perfect it holds.

# using directly lm is done using the centered datasets and substracting 1
lm(yc ~ xc - 1)

# now testing that if we normalize the datasets their slope will be their correlation
yn <- (y - mean(y))/sd(y)
xn <- (x - mean(x))/sd(x)
c(cor(y, x), cor(yn, xn), coef(lm(yn ~ xn))[2])3 #nice it holds

#How to add a regression line to a scatter plot
g <- ggplot(filter(freqData, freq > 0), aes(x = parent, y = child))
g <- g  + scale_size(range = c(2, 20), guide = "none" )
g <- g + geom_point(colour="grey50", aes(size = freq+20, show_guide = FALSE))
g <- g + geom_point(aes(colour=freq, size = freq))
g <- g + scale_colour_gradient(low = "lightblue", high="white")  
g <- g + geom_smooth(method="lm", formula=y~x)# nice way to plot the regression line. The gray line is the confidence interval
g

# adding a regresion line to a simple plot
plot(jitter(child,4) ~ parent,galton)
regrline <- lm(child ~ parent, galton)
abline(regrline, lwd=3, col='red')

# code for multiple variable regression
efit <- lm(accel ~ mag+dist, attenu)# check the plus between the dependent variables
