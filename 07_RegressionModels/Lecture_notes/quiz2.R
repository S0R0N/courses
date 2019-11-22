x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)# predictor
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)  # outcome
data <- data.frame(x = x, y= y)
summary(lm(y~x,data))

data(mtcars)
mpg <- mtcars$mpg
wt  <- mtcars$wt
fit <- lm( mpg ~ wt ,mtcars)
summary(fit)
#  inference from the linear model 
mean(wt)# 3.21

# makes more sense to claculate the interval for each betas and then apply the model 
# Y = B0 +x*B1
sumCoef <- summary(fit)$coefficients
# X is mean(mtcars$wt)

newx = data.frame(wt = mean(wt))
data.frame(predict(fit, newdata= newx,interval = ("confidence")))

#
?mtcars
# [, 1]	mpg	Miles/(US) gallon
# [, 6]	wt	Weight (1000 lbs)
# so for an increase of 1000lbs the mpg reduces B1 - 5.31

nd <- vector("numeric", 32)
nd[] <- 3
##

newx = data.frame(wt = 3)
data.frame(predict(fit, newdata= newx,interval = ("confidence")))

data.frame(predict(fit, newdata= newx,interval = ("prediction")))
## Scaling to short-ton, multiplying Beta1 per 2. 
# Interval for B1 scaled
fit$coefficients[2]*2

(sumCoef[2,1] + c(-1, 1) * qt(.975, df = fit$df) * sumCoef[2, 2])*2

# Comparing the sum of the squared errors of a model with just the intercept and othre with the slope and intercept
fit$coefficients
fit1 <- lm(mpg ~ wt, data = mtcars)#numerador
fit2 <- lm(mpg ~ 1, data = mtcars) #denominador

m1.y <- predict(fit1) #numerador
m2.y <- predict(fit2) #denominador

#m2.y <- fit$coefficients[1] + wt*fit$coefficients[2]
#predict(fit)

ssx <- sum((x - mean(x))^2) 
ss.m1 <- sum((mpg - m1.y)^2)#numerador
ss.m2 <- sum((mpg - m2.y)^2)#denominador 

ss.m1/ss.m2
# PRUEBA BETA1 +C
