# Gaussian Elimination.
# The general technique is to pick one regressor and to replace all other variables by the residuals of their regressions against that one
# The mean of a variable is the coefficient of its regression against the constant, 1
# When the technique says to regress to one predictor, it means to one,i.e., resting the 1 of the identity. 

# Example of multi var calculation in R
fit <- lm(Volume ~ Girth + Height + Constant - 1, trees)

trees2 <- eliminate("Girth", trees)

# THe code for the example of how to reduce a multivariable linear regression to a n-x dimensions. 
# Regress the given variable on the given predictor,
# suppressing the intercept, and return the residual.
regressOneOnOne <- function(predictor, other, dataframe){
  # Point A. Create a formula such as Girth ~ Height -1
  formula <- paste0(other, " ~ ", predictor, " - 1")
  # Use the formula in a regression and return the residual.
  resid(lm(formula, dataframe))
}

# Eliminate the specified predictor from the dataframe by
# regressing all other variables on that predictor
# and returning a data frame containing the residuals
# of those regressions.
eliminate <- function(predictor, dataframe){
  # Find the names of all columns except the predictor.
  others <- setdiff(names(dataframe), predictor)
  # Calculate the residuals of each when regressed against the given predictor
  temp <- sapply(others, function(other)regressOneOnOne(predictor, other, dataframe))
  # sapply returns a matrix of residuals; convert to a data frame and return.
  as.data.frame(temp)
}

##----------------------------------------------------------------------------------
##                Swis data, examples of multivariable regression.
##----------------------------------------------------------------------------------
# the dot means agaist all vars in the dataframe
all <- lm(Fertility ~ ., swiss)
# The addition or removal of indepdent variables affects the magnitude and sign of other variables coeficients

