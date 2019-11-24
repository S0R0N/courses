## regressing models of the type 
## REGRESSION SPLINES
## Y = F(Xi)+ e # not linear relationships??????
## is like a trick 

# SPLINES: points that define a complex regression line
# BASIS: COLLECTION OF REGRESSORS (SPLINE TERMS). i.e., collection of building block for a function
# Each BASIS has strenghs and weaknesses. so there are basis sets??
# TYPE OF BASIS
# - WAVELET BASIS
# - THE FOURIER BASIS
# - SPLINE BASIS (lots of types of spline basis)

#ISSUES:
# We do not know where the knots points are. 
# Putting in too few or too many

# SOLUTION
# putting a regulation term

# REGULIZATION TERM
# penalizes the coeficients from the nought(spline) terms with larger coeficients

## you can use REGRESSION  SPLINES TO MODEL LINEAR ONES
## specify the regression splines in the predictor

## it becomes something like this

## DISCRETE MODEL
## Yi = B0 + B1Xi + SUM((xi - epsilonk))_+*gama + ei
## (a)_+ returns a if a is positive or cero otherwise
## k are nouthg points. i.e., like breaking points of lines that model the data. 
## like little fixs or discretization of the line to fit the data points.
## it gives you a discrete line like the one shown running the code bellow. 
n <- 500; x <- seq(0, 4 * pi, length = n); y <- sin(x) + rnorm(n, sd = .3)
knots <- seq(0, 8 * pi, length = 20); 
splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot))
xMat <- cbind(1, x, splineTerms)
yhat <- predict(lm(y ~ xMat - 1))
plot(x, y, frame = FALSE, pch = 21, bg = "lightblue", cex = 2)
lines(x, yhat, col = "red", lwd = 2)
## how to make it look smoother??
## Addign squared terms. 

## SQUARED MODEL
# Yi = B0 + B1Xi + B2Xi^2+ SUM((xi - epsilonk))^2_+*gama + ei
splineTerms <- sapply(knots, function(knot) (x > knot) * (x - knot)^2)# Added the squared term 
xMat <- cbind(1, x, x^2, splineTerms)
yhat <- predict(lm(y ~ xMat - 1))
plot(x, y, frame = FALSE, pch = 21, bg = "lightblue", cex = 2)
lines(x, yhat, col = "red", lwd = 2)
