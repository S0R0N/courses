# Estimation is useful, but we also need to know how to extend our estimates to a population
# Probabilistic model for linear regression
# the line model, but with some gassian error, that is the varaibility of the variables you did not include
# Expected vvalue of Y predicted is the regressed line.
# The variance of the response is sigma squared

# B0 THE INTERCEPT
# B0 is the expected value of Y given that the X is 0
# you can shift the values of B0 by a constant a, 
# often a is set to X mean. So it is interpreted as the expected response at the average X value.

# B1 THE SLOPE
# is the expected change in response for a 1 unit change in the predictor
# the multiplicacion of by a factor a resulsts in dividing the coefficient by a factor of a. (si escalas los datos , divides el slope)


##
library(UsingR)
data(diamond)
library(ggplot2)
g = ggplot(diamond, aes(x = carat, y = price))
g = g + xlab("Mass (carats)")
g = g + ylab("Price (SIN $)")
g = g + geom_point(size = 7, colour = "black", alpha=0.5)# types of points
g = g + geom_point(size = 5, colour = "blue", alpha=0.2)# types of points
g = g + geom_smooth(method = "lm", colour = "black") # adding the regression line to the data
g

fit <- lm(price ~ carat, data = diamond)
coef(fit)
summary(fit)
# the coef tells us that for 1 carat, the price increases 3721
# the intercept means that for 0 carats the price is -259

#NOW mean centering the diamond model. 
fit2 <- lm(price ~ I(carat - mean(carat)), data = diamond)
coef(fit2)

# CHANGIN ghte scale of the data
fit3 <- lm(price ~ I(carat * 10), data = diamond)
coef(fit3)

# Simulating the estimation of the price of a new diamond not in the set
# if you want to predict new values use the predict command with the fit and then the parameter new data
newx <- c(0.16, 0.27, 0.34)              # new diamonds
coef(fit)[1] + coef(fit)[2] * newx     
predict(fit, newdata = data.frame(carat = newx))# using the command predict and giving it the fit and the data
