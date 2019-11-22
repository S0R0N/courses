library(UsingR)
data("father.son")
x <- father.son$sheight
n <- length(x)
b <- 10000 # bootstrap resamples
resamples <- matrix(sample(x,n*8, replace = TRUE),b,n)
medians <- apply(resamples, 1, median)
sd(medians)
quantile(medians, c(0.025,0.975))

g = ggplot(data.frame(medians = medians), aes(x= medians))
g = g+geom_histogram(color = "black", fill = "lightblue", binwidth = 0.05 )


g
library(bootstrap)
bootstrap(x,nboot = 10000, median)
bcanon(x,nboot = 10000, median, alpha = c(.025, .975))
