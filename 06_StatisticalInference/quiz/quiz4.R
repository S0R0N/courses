# computer calculation
# hipothesis testing using t-interval for paired dataset at the by default 95% two sided
# base hipothesis a mean reduction in blood pressure
# meaning that the difference between the base line and the threatment is negative. 
# give the p-value for the associated test

b      <- c(140, 138,150,148,135)
t      <- c(132,135,151,146,130)
b.sd   <- sd(b)
b.mean <- mean(b)

t.test(b,t,paired = T)
#
# T student, small sample, manual calculation
n <- 9
m <- 1100
sd <- 30

m +c(-1,1)*qt(.975,n-1)*(sd/sqrt(n))
#

# blind test, constant variance. not paired
# binomial
# pbinom 
# the prob of 0.5 is used asumming there is prefference between the two
pbinom(3,size = 4, prob = .5, lower.tail = F)# lets see why?
pbinom(2,size = 4, prob = .5, lower.tail = F)# lets see why?

# poissson p value
# the one sided p-value is the hospital bellow the standard. 
benchmark <- 1/100# theoretical 
exp <- 10/1787
#benchamrk ratio multiplied by the sampled time of the real ratio. what is the probability that it gives me the number of infections that the data is saying 
#In other words, just change the ratio for the theoretical ratio and leave the time and occurences constant. 
#In that way you will check how the experimental data beheaves in terms of the theoretical benchmark

ppois(q = 10,benchmark*1787,lower.tail = T)

# common variance, independent datasets
# base line 
# 4 weeks after
# follow up  - base line  = -3
# normality
# find P value
placebo.m    <- 1
placebo.sd   <- 1.8
placebo.n    <- 9
treatment.m  <- -3
treatment.sd <- 1.5
treatment.n  <- 9
mn <- treatment.m -placebo.m
#T-P !=0

df  <- treatment.n+placebo.n-2
sp  <- sqrt(((treatment.n-1)*treatment.sd^2+(placebo.n-1)*placebo.sd^2)/df)

# otro tiro usando el T test sencillo 
# Teorico es el placebo
# practico es el tratamiento
#practico - teorico /(sp/sqrt(18))
pt(mn*sqrt(placebo.n +treatment.n)/sp,df = df)
#

#POWER calculation
#power.t.test(n = 16,delta = 100,sd = 200, type = "one.sample",alt = "one.sided")$power
n <- 100
ma <- 0.01
m0 <- 0
sd <- .04
#POWER? 
# for  a 5% one sided test  - that means prob of .95 and one sided  
#versus the null hipothesis of no volume loss
power.t.test(n = n,delta = ma-m0,sd = sd, type = "one.sample",alt = "one.sided")$power

# n calculation
power.t.test( power = .9,delta = ma-m0,sd = sd, type = "one.sample",alt = "one.sided")$n





