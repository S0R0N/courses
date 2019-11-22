# RESIDUALS and Diagnostic
# residuals are 
# Yi -Ypredicted = Yi - sum(XikBj)
# estimated variation of residuals= simga^2 = Sum(eik^2)/(n-p)

# Plotting the residuals helps to analize model fit or lack of model fit. 
data(swiss); par(mfrow = c(2, 2))
fit <- lm(Fertility ~ . , data = swiss);
plot(fit)
# these commmands gives you four plots showing indicators of your fits
# the par command was used to create a frid of 2X2 to fit all graphs in one page. 

## INFLUENTIAL PONTS AND OUTLIERS - DIAGNOSTIC OF POINTS
## two measures, influence or leverage

## LEVERAGE
## the point of the means is the center. then the more away from that point a point is then it has more torque or leverage

## INFLUENCE
## wether or not that point chooses to excert that leverage. 

## OUTLIER
## they can be random or not, but if they are real they are very important

## MEASURES to test outliers
## - rstudent
## - rstandard are variations to residuals. disadvantage or the residuals, is that they have units
## - HAT values:  measure of influence - finding data entry errors
## - dffit and dfbetas: get the point, get it out, refit and eval what you want to eval. 
## - - dffit check how much the predicted point in that point changes after removing the evaluated point
## - - dfbetas: check how much the beta changes after removing the point
## - - cook.distance: overall change in our coeficients, summarizes the dfbetas
## - - resid, returns the ordinary residuals ->
## - - Pressresiduals: resid(fit) / 1-(hatvalues(fit)) detecting outliers
## normaly you would plot your residuals against the predicted values and check if there are patterns in the residuals
## those patterns could be regresseded
## the residual QQ plot, tries to assertain normality
## the plot of leverage values... shows the leverage of the values
## Residuals Vs levarage, shows which point's residual has high leverage. 
## Scaled location: pltos the standarized residuals vs the fitted values. search for patterns. 

## CODIGN EXAMPLES
# DFBETAS
n <- 100; x <- c(10, rnorm(n)); y <- c(10, c(rnorm(n)))
plot(x, y, frame = FALSE, cex = 2, pch = 21, bg = "lightblue", col = "black")
abline(lm(y ~ x))            
## case of a point with high leverage and influence
fit <- lm(y ~ x)
round(dfbetas(fit)[1 : 10, 2], 3)# data point number 1 , was various scales bigger

round(hatvalues(fit)[1 : 10], 3)# data point 1 is also bigger... alarm!!! alarm!!!

##case of a point of high leverage and low influence
x <- rnorm(n); y <- x + rnorm(n, sd = .3)
x <- c(5, x); y <- c(5, y)
plot(x, y, frame = FALSE, cex = 2, pch = 21, bg = "lightblue", col = "black")
fit2 <- lm(y ~ x)
abline(fit2)    

round(dfbetas(fit2)[1 : 10, 2], 3) #dfbetas does not show much difference
round(hatvalues(fit2)[1 : 10], 3)  # but the hatvalues show a difference
