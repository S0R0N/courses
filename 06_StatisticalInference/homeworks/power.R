mu0 <- 30  #null hopohtesis
mua <- 32 # how powerful it is in respect to 32
sigma <- 4 # estimated variance of the pop
n <- 16    # expected number of samples 
alpha <- 0.05
z = qnorm(1-alpha) # hipo test
# how to calculate the power. 
pnorm(mu0+z*sigma/sqrt(n),mean = mu0,sd = sigma/sqrt(n),lower.tail = FALSE)

library(ggplot2)
library(manipulate)
myplot <- function(sigma, mua, n, alpha){
  g <- ggplot(data.frame(mu = c(27,36)),aes(x=mu))
  g = g+stat_function(fun=dnorm, geom = "line",
                      args=list(mean = mu0,sd=sigma/sqrt(n)),
                      size = 2,col = "red"
                      )
  g = g+stat_function(fun = dnorm, geom = "line",
                      args=list(mean = mua,sd=sigma/sqrt(n)),
                      size = 2,col = "blue"
                      )
  xitc = mu0+qnorm(1-alpha)*sigma/sqrt(n)
  g = g+geom_vline(xintercept = xitc, size = 3)
  g
}
manipulate(
  myplot(sigma, mua, n, alpha),
  sigma = slider(1,10, step = 1, initial = 4),
  mua = slider(30,35,step = 1, initial = 32),
  n = slider(1,50,step = 1, initial = 16),
  alpha = slider(0.01,0.1,step = 0.01, initial = 0.05) 
)
# alt to specify one sided or two sided tests. i.e., u > u0 or u< u0 if you specify that the difference in the means is negative
# delta is the difference between the means
# type a one sample t test
# I can calculate power or...
power.t.test(n = 16,delta = 2/4,sd = 1,type = "one.sample",alt = "one.sided")$power
power.t.test(n = 16,delta = 2,sd = 4,type = "one.sample",alt = "one.sided")$power
power.t.test(n = 16,delta = 100,sd = 200, type = "one.sample",alt = "one.sided")$power
# I can calculate n
power.t.test(power = 0.8,delta = 100,sd = 200, type = "one.sample",alt = "one.sided")$n
power.t.test(power = 0.8,delta = 2/4,sd = 1,type = "one.sample",alt = "one.sided")$n
power.t.test(power = 0.8,delta = 2,sd = 4,type = "one.sample",alt = "one.sided")$n
# I can calculate delta
power.t.test(power = 0.8,n = 16,sd = 200, type = "one.sample",alt = "one.sided")$delta
power.t.test(power = 0.8,n = 2,sd = 1,type = "one.sample",alt = "one.sided")$delta
power.t.test(power = 0.8,n = 4,sd = 4,type = "one.sample",alt = "one.sided")$delta





