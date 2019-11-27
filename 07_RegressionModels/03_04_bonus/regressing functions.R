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

## FURIER BASIS
## Discrete fourier transform
## USED to identify the sines or cosine components of a sample


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

## EXAMPLE OF FOURIER BASIS
notes4 <- c(261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25)
t <- seq(0, 2, by = .001); n <- length(t)
c4 <- sin(2 * pi * notes4[1] * t); e4 <- sin(2 * pi * notes4[3] * t); 
g4 <- sin(2 * pi * notes4[5] * t)
chord <- c4 + e4 + g4 + rnorm(n, 0, 0.3)
x <- sapply(notes4, function(freq) sin(2 * pi * freq * t))
fit <- lm(chord ~ x - 1)

plot(c(0, 9), c(0, 1.5), xlab = "Note", ylab = "Coef^2", axes = FALSE, frame = TRUE, type = "n")
axis(2)
axis(1, at = 1 : 8, labels = c("c4", "d4", "e4", "f4", "g4", "a4", "b4", "c5"))
for (i in 1 : 8) abline(v = i, lwd = 3, col = grey(.8))
lines(c(0, 1 : 8, 9), c(0, coef(fit)^2, 0), type = "l", lwd = 3, col = "red")

a <- fft(chord); plot(Re(a)^2, type = "l")
