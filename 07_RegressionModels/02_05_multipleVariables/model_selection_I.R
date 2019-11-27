# MODEL SELECTION
## regession is about simple interpretable models
## prediction is about complex interaction, automated search algorithms and prediction. 
## Known known     : the ones we know and put into the model
## known unknown   : the ones we know and igrnore or do not have data to include into the model
#@ Unknown unknowns: what we are missing. 

## KNOWN KNOWNS:
## -forgetting important variables has consequences. It can be softened by using randomization 
## -adding not neccesarly variables adds error. (Variance inflation)

# VARIANCE INFLATION FACTORS
## - I should avoid variables that are highly correlated with Y that are not necessary. 
## - obvious like sinonims or anotnyms to the predicted variable. hot and cold. tall and short. 
## - Variance Inflation Factor (VIF) to get a proxy of variance inflation
## - VIF: shows you the relation between what you have Vs the ideal case. for real variance
## - For each regression coefficient, the variance inflation due to including all the others.
## - For instance, the variance in the estimated coefficient of Education is 2.774943 times what it might have
## - been if Education were not correlated with the other regressors

# VARIANCE INFLATION in the ESTIMATED VARIANCE
# so if you overfit or correctly model you get little variance. 
# However, the variance of the estimated variance will be inflated. 

# ANOVA - nested models for model evaluation
# uses an F statistic to evaluate the null hipothesis on the new predictors added to a model
# F statistic is a ratio of two sums of squares divided by their respective degrees of freedom
# F statistic is equal to deviance(fit3)/43 || deviance(fit1)-deviance(fit3)/(number of additional predictors in fit 3)
# 43 us the degrees of freedom of fit 3 meaning the number of data vs the regressors 3 plus the intercept
# HOWEVER, Analysis of variance is sensitive to its assumption that model residuals are approximately normal
# SOLUTION: The Shapiro-Wilk test - shapiro.test(fit3$residuals)
# SHAPIRO-WILK: has as null hipo normality therefore, failing to reject it is cool!

# AUTOMATED MODEL SELECTION
# is in machine learning now. 
#  - DIMENSION REDUCTION: if you have to much predictors, then you can use dimension reduction, like clustering or PCA. But. 
#     the down side of dimension reduction is that they might be less interpretable than the single varble.
#  - GOOD EXPERIMENTAL DESIGN: can help to avoid nausanses of intervariablitity of observations or bias. 
#  - NESTED MODELS: adding explanatory variables and comparing them. They have to be nested, i.e., the same just including more variables with update

### CODE EXAMPLES
# VARIANCE INFLATION - when you inlcude unnecessary variables
# trick is it influence the actual variance , not the predicted variace. 
n <- 100; nosim <- 1000
x1 <- rnorm(n); x2 <- rnorm(n); x3 <- rnorm(n); 
betas <- sapply(1 : nosim, function(i){
  y <- x1 + rnorm(n, sd = .3)
  c(coef(lm(y ~ x1))[2], 
    coef(lm(y ~ x1 + x2))[2], 
    coef(lm(y ~ x1 + x2 + x3))[2])
})
round(apply(betas, 1, sd), 5)
#3 in this example we see that because the variables are not related they do not affect much in the mode. 

## VARIANCE INFLATION II - when the variables depend on each other
n <- 100; nosim <- 1000
x1 <- rnorm(n); x2 <- x1/sqrt(2) + rnorm(n) /sqrt(2)
x3 <- x1 * 0.95 + rnorm(n) * sqrt(1 - 0.95^2); 
betas <- sapply(1 : nosim, function(i){
  y <- x1 + rnorm(n, sd = .3)
  c(coef(lm(y ~ x1))[2], 
    coef(lm(y ~ x1 + x2))[2], 
    coef(lm(y ~ x1 + x2 + x3))[2])
})
round(apply(betas, 1, sd), 5)
# they do affect the model


#EXAMPLE OF VARIANCE INFLATION FACTOR
data(swiss); 
fit1 <- lm(Fertility ~ Agriculture, data = swiss)
a <- summary(fit1)$cov.unscaled[2,2]
fit2 <- update(fit1, Fertility ~ Agriculture + Examination)
fit3 <- update(fit1, Fertility ~ Agriculture + Examination + Education)
c(summary(fit2)$cov.unscaled[2,2],
  summary(fit3)$cov.unscaled[2,2]) / a 

library(car)
fit <- lm(Fertility ~ . , data = swiss)
vif(fit)
sqrt(vif(fit)) #I prefer sd 

# EXMAPLE OF NESTED MODELS
fit1 <- lm(Fertility ~ Agriculture, data = swiss)
fit3 <- update(fit1, Fertility ~ Agriculture + Examination + Education)
fit5 <- update(fit3, Fertility ~ Agriculture + Examination + Education + Catholic + Infant.Mortality)
anova(fit1, fit3, fit5)
# the interpretation of the Anova tests
# first it tells you the models and their varibles
# Res.Df: the degrees of freedom of the model (number of data points - number of parameters to fit)
# RSS   : the residual sums of squares 
# Df    : excess degrees of freedom betweem compared models. 
# S/F   : statistic?? 
# p-values : 
