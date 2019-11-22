#Residuals represent variation left unexplained by our model
#The errors unobservable true errors from the known coefficients
#The residuals are the observable errors from the estimated coefficients.
#The residuals are estimates of the errors.

# The residuals are useful to evaluate your models
# are the distance between the real data and the line
# REsiduals have the same dimension as the Ys

# FITTED values are Y hat
# the expected value of the population of residuals is cero
# their sum if you include the intercept is cero as so its mean
# the sum of the residuals times the regression variable has to be cero
# residual regression: variation after removing the predictor
# sistematic regression: variation explained by the regresion model

# The sum of the squared residuals, times over n is an estimate of sigma squared. 
# normally n-2 is used i.e., sigma squared  =  the sum of the squered residuals / n-2

#THE TOTAL VARIATION  = REGRESSION VAR + RESIDUAL VAR 
## the variation across the average
#REGRESSION VARIABILITY
## the variability explaind by the regressor variable
#RESIDUAL VARIABILITY
## The variation not explained by the regression
# sRes <- deviance(fit) gives me directly the sum of squares of the residuals yreal - ypredicted

# R2 an index of how much of the total variation is explained by the model
## R2 equals to regression variability / total variability
## has to be between 0 and 1
## R2 has to be re-checked. We can delete data or unexplained variability 

# now we will check the variation of dimond prices using their mass
library(UsingR)
data(diamond)
library(ggplot2)
g = ggplot(diamond, aes(x = carat, y = price))
g = g + xlab("Mass (carats)")
g = g + ylab("Price (SIN $)")
g = g + geom_smooth(method = "lm", colour = "black")
g = g + geom_point(size = 7, colour = "black", alpha=0.5)
g = g + geom_point(size = 5, colour = "blue", alpha=0.2)
g

### Calculating the residuals example
data(diamond)
y <- diamond$price; x <- diamond$carat; n <- length(y)
fit <- lm(y ~ x)
e <- resid(fit)          # with this line you can get the residuals
yhat <- predict(fit)     # Calcula los datos predichos con respecto al X.
max(abs(e -(y - yhat)))  # La diferencia entre los residuales teoricos y los de R
max(abs(e - (y - coef(fit)[1] - coef(fit)[2] * x)))

###Plotting the data and setting a line to visualize the residuals
plot(diamond$carat, diamond$price,  
     xlab = "Mass (carats)", 
     ylab = "Price (SIN $)", 
     bg = "lightblue", 
     col = "black", cex = 2, pch = 21,frame = FALSE)
abline(fit, lwd = 2)
for (i in 1 : n) # here you go through all the points and set the line with respect to the regression line
  lines(c(x[i], x[i]), c(y[i], yhat[i]), col = "red" , lwd = 2)
### Plotting the residuals as an scatter plot
plot(x, e,  
     xlab = "Mass (carats)", 
     ylab = "Residuals (SIN $)", 
     bg = "lightblue", 
     col = "black", cex = 2, pch = 21,frame = FALSE)
abline(h = 0, lwd = 2)
for (i in 1 : n) 
  lines(c(x[i], x[i]), c(e[i], 0), col = "red" , lwd = 2)

#USING RESIDUALS EXAMPLES - In here the X is not entirely explained by the sin variation component
x = runif(100, -3, 3); y = x + sin(x) + rnorm(100, sd = .2); 
library(ggplot2)
g = ggplot(data.frame(x = x, y = y), aes(x = x, y = y))
g = g + geom_smooth(method = "lm", colour = "black")
g = g + geom_point(size = 7, colour = "black", alpha = 0.4)
g = g + geom_point(size = 5, colour = "red", alpha = 0.4)
g

## Plotting the residuals as an scatter plot 

g = ggplot(data.frame(x = x, y = resid(lm(y ~ x))), # y as the residuals gives me the scatter plot
           aes(x = x, y = y))
g = g + geom_hline(yintercept = 0, size = 2); 
g = g + geom_point(size = 7, colour = "black", alpha = 0.4)
g = g + geom_point(size = 5, colour = "red", alpha = 0.4)
g = g + xlab("X") + ylab("Residual")
g

## VIsual advantage of pltting residuals.
## THE scale of the graph can cheat - Heteroskedasticity

x <- runif(100, 0, 6); y <- x + rnorm(100,  mean = 0, sd = .001 * x); # the standard deviation related to the X applies the heteroskedasticity
g = ggplot(data.frame(x = x, y = y), aes(x = x, y = y))
g = g + geom_smooth(method = "lm", colour = "black")
g = g + geom_point(size = 7, colour = "black", alpha = 0.4)
g = g + geom_point(size = 5, colour = "red", alpha = 0.4)
g

g = ggplot(data.frame(x = x, y = resid(lm(y ~ x))), 
           aes(x = x, y = y))
g = g + geom_hline(yintercept = 0, size = 2); 
g = g + geom_point(size = 7, colour = "black", alpha = 0.4)
g = g + geom_point(size = 5, colour = "red", alpha = 0.4)
g = g + xlab("X") + ylab("Residual")
g


### Example with the diamond data
diamond$e <- resid(lm(price ~ carat, data = diamond))
g = ggplot(diamond, aes(x = carat, y = e))
g = g + xlab("Mass (carats)")
g = g + ylab("Residual price (SIN $)")
g = g + geom_hline(yintercept = 0, size = 2)
g = g + geom_point(size = 7, colour = "black", alpha=0.5)
g = g + geom_point(size = 5, colour = "blue", alpha=0.2)
g


### REsiduals of the diamond dataset
e = c(resid(lm(price ~ 1, data = diamond)),    # residuals are the deviation around the average price
      resid(lm(price ~ carat, data = diamond)))# residuasl around the carat variable
fit = factor(c(rep("Itc", nrow(diamond)),      # factor element, with the labels of the elements. 
               rep("Itc, slope", nrow(diamond))))
g = ggplot(data.frame(e = e, fit = fit), aes(y = e, x = fit, fill = fit))# monodimensional graph, showing the values of the residuals according to the types of fits, ITC and slope ITC
g = g + geom_dotplot(binaxis = "y", size = 2, stackdir = "center", binwidth = 20) # dot plot????
g = g + xlab("Fitting approach")
g = g + ylab("Residual price")
g
#### EXample of calculating the residual variation out of lm
y <- diamond$price; x <- diamond$carat; n <- length(y)
fit <- lm(y ~ x)
summary(fit)$sigma                   # the code to get it
sqrt(sum(resid(fit)^2) / (n - 2))    # the manual calculation of the standard deviation sigma
sqrt(sum(fit$residuals^2) / (n - 2)) # alternative manual calculation of the standard deviation sigma
sqrt(deviance(fit)/(n-2))            # another alternative

## Getting Rsqured directly
summary(fit)$r.squared
cor(galton$child, galton$parent)^2
