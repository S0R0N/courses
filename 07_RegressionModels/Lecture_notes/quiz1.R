library(swirl)
install_from_swirl("Regression Models")
swirl()
#1
x <- c(0.18, -1.54, 0.42, 0.95)# data
w <- c(2, 1, 3, 1)             # weights
sum(x*w)/sum(w)

sum(w)

z <- mean(x)/mean(w)
sum(w*x)


#2
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
x.c <- x/sd(x)
y.c <- y/sd(y)

beta1 <- cor(y.c, x.c) *  sd(y) / sd(x)
lm(y ~ x - 1)

#
data(mtcars)
# mpg  outcome
# weight as the predictor
# slope coeficient
y <- mtcars$mpg
x <- mtcars$wt
beta1 <- cor(y, x) *  sd(y) / sd(x)  # intercept manual calculation 
rbind(beta1, coef(lm(y ~ x))) # comparison of the manual calculation and the lm command
#
1
#
1.5*.4
#normalizing datasets
x <- c(8.58, 10.46, 9.01, 9.64, 8.86)
m <- mean(x)
sdx <- sd(x)
x.norm <- (x-m)/sdx

#
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
beta1 <- cor(y, x) *  sd(y) / sd(x) # slope manual calculation
beta0 <- mean(y) - beta1 * mean(x)  # intercept manual calculation 
rbind(c(beta0, beta1), coef(lm(y ~ x))) # comparison of the manual calculation and the lm command

# sqaured errors 
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
mean(x)

