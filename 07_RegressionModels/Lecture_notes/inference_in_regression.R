# implementing inference into the linear models
# hot to implement statistical hipothesis test abou the B1 and Bo parameters
## HERE WE speak about variance of our estimates. how the estimates vary

# Review of basic statistics
# Statistics of the form (teta-teta hat)/standard error teta have the following properties
## normally distributed and if we replace the variance (sigma) with the estimated variance (sigma/sqrt(n)) follow T-student
## Quantile 1-alpha/2 - > the trick that takes the interval up

# The variability of our estimates is 
# sigma squared is replaced by sd/sqrt(n)
# VAR (B1hat) = Simga^2/SUM(Xi - Xexpected)^2
# VAR (B0hat) = (1/n + Xexpected^2 / Sum(Xi-Xexpected))sigma^2
# Bhat is the estimate, and B is the real thing
# Bhat - B/Var(Bhat) follows a t distribution with n-2 degrees of freedom. T-statistic

# PREDICTION
# this is interpreted as the model with just the intercept
# fit2 <- lm(mpg ~ 1, data = mtcars)

# important in regression you can predict and put inference on top of your predictions
# The prediction error is  going to be lowest when when Xpredicted is equal to X bar. 
# the uncertaintly of the predicted line can be reduced with the n. However, the Y uncertaintly will remain given the existence of e or the errors
# it is a line after all. 

# This code shows where do R gets the values it shows using the lm command.  

library(UsingR); data(diamond)
y <- diamond$price; x <- diamond$carat; n <- length(y)
beta1 <- cor(y, x) * sd(y) / sd(x) # equation of the slope
beta0 <- mean(y) - beta1 * mean(x) # equation of the intercept
e <- y - beta0 - beta1 * x         # residual error
sigma <- sqrt(sum(e^2) / (n-2))    # variability of the errors, variability around the regression line. standard deviation
ssx <- sum((x - mean(x))^2)        # sums of squares of Xs 
seBeta0 <- (1 / n + mean(x) ^ 2 / ssx) ^ .5 * sigma  # standard error for Beta0
seBeta1 <- sigma / sqrt(ssx)                         # standard error for Beta1
tBeta0 <- beta0 / seBeta0; tBeta1 <- beta1 / seBeta1 # T-statisticos for the Beta0 and Beta1 - true value is assumed ot be 0 in this hipothesis
pBeta0 <- 2 * pt(abs(tBeta0), df = n - 2, lower.tail = FALSE) # doubling the probability of being that t-statistic
pBeta1 <- 2 * pt(abs(tBeta1), df = n - 2, lower.tail = FALSE) # doubling the probability of being that t-statistic
coefTable <- rbind(c(beta0, seBeta0, tBeta0, pBeta0), c(beta1, seBeta1, tBeta1, pBeta1)) #
colnames(coefTable) <- c("Estimate", "Std. Error", "t value", "P(>|t|)")
rownames(coefTable) <- c("(Intercept)", "x")

# short way
coefTable
fit <- lm(y ~ x); 
summary(fit)$coefficients

# how to get a confidence interval 
sumCoef <- summary(fit)$coefficients                            # get the information of the coeficients
sumCoef[1,1] + c(-1, 1) * qt(.975, df = fit$df) * sumCoef[1, 2] # calculating the confidence interval for B0hat
(sumCoef[2,1] + c(-1, 1) * qt(.975, df = fit$df) * sumCoef[2, 2]) / 10 # calculating the confidence interval for B1hat scaled to 10 or .1 karats
# the later says the interval of .1 karat increse how much it is in singapur dolars. 


## plotting prediction intervals
library(ggplot2)
newx = data.frame(x = seq(min(x), max(x), length = 100))
p1 = data.frame(predict(fit, newdata= newx,interval = ("confidence"))) # to get the interval around the estimated line of those particular values of X not for a potential value of Y but the line
p2 = data.frame(predict(fit, newdata = newx,interval = ("prediction")))
p1$interval = "confidence"
p2$interval = "prediction"
p1$x = newx$x
p2$x = newx$x
dat = rbind(p1, p2)
names(dat)[1] = "y"

g = ggplot(dat, aes(x = x, y = y))
g = g + geom_ribbon(aes(ymin = lwr, ymax = upr, fill = interval), alpha = 0.2) 
g = g + geom_line()
g = g + geom_point(data = data.frame(x = x, y=y), aes(x = x, y = y), size = 4)
g

#
library(swirl)
swirl()
