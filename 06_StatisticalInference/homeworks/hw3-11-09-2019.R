install.packages("swirl")
library(swirl)

install_from_swirl("Statistical Inference")
swirl()
mn +c(-1,1)*qt(.975,9)*(s/sqrt(10))
t.test(difference)
rbind(
  mn + c(-1, 1) * qt(.975, n-1) * s / sqrt(n),
  as.vector(t.test(difference)$conf.int),
  as.vector(t.test(g2, g1, paired = TRUE)$conf.int),
  as.vector(t.test(extra ~ I(relevel(group, 2)), paired = TRUE, data = sleep)$conf.int)
)
132.86-127.44 + c(-1,1)*qt(.975,ns)*sp*sqrt(1/8+1/21)
sp <- sqrt((9*var(g1)+9*var(g2))/18)

md + c(-1,1)*qt(.975,18)*sp*sqrt(1/5)

num <- (15.34^2/8 + 18.23^2/21)^2 

#santi
132.86-127.44 + c(-1,1)*qt(.975,mdf)*sqrt(15.34^2/8+18.23^2/21)

#P values
swirl()
# testing the probability tha q value being 2.5 
pt(q = 2.5,df = 15,lower.tail = FALSE)


#X +- pt()*sd/sqrt(n) Calculating simple T interval at 95%
sd <- 30
m  <- 1100
n  <- 9
m + c(-1,1)*qt(.975,8)*sd/sqrt(n) # okay, el error era la funcion de t que estaba usando. 

# X +- pt()*sd/sqrt(n)  Calcualting the sd of a t interval for it to be 0 on a 95% - Si funcionaba, el problema era la funcion de t 
# que estaba usando. no pt si no qt. 
n  <- 9
mn <- -2
mn+pt(.975,8)*sd/sqrt(n) = 0
mn+pt(.975,8, lower.tail = FALSE)*sd/sqrt(n) = 0
sd = 2*3/qt(.975,8,lower.tail = TRUE)# did not work!
#
#caclulating the T interval for two sets of independent experiments with constant variation. 
#do not have the data set only the differences. 
# have to do it manually. 
# mn -+ qt(difference of degrees of freedom)*sd(pooled sd) - no dio?????? porque????
mx  <- 3
sdx <- sqrt(0.60)
my  <- 5
sdy <- sqrt(.68)
nx  <- 10
ny  <- 10
mn  <- mx-my
df  <- nx+ny-2
sd  <- sqrt(((nx-1)*sdx^2+(ny-1)*sdy^2)/df)
sd  <- sqrt((9*.6+9*.68)/18)

mn + c(-1,1)*qt(.975,18)*sd*(1/10 +1/10)^.5

# Tesing hipothesis given two independent sets with different variances and enough data to approximate to normal 
# Y-X+-Z(Sx^2/nx + sy^2/ny)^.5
# new experiment Y, old X
# the sd is the weighted average 
my  <- 4
sdy <- .5
mx  <- 6
sdx <- 2
sed <- ((sdx^2/100) +(sdy^2/100))^.5

mx-my + c(-1,1)*qnorm(p = .975,mean = mx-my,sd = sed)*sed

# calculate T test of differences of two sets of normal distributed experiments with common variance. 
# tratamiento Y, placebo X
my  <- -3
sdy <- 1.5
mx  <- 1
sdx <- 1.8
nx <- 9
ny <- 9
df <- ny+nx-2
sp  <- sqrt(((nx-1)*sdx^2+(ny-1)*sdy^2)/(nx+ny-2))
sp  <- sqrt((8*1.8^2+8*1.5^2)/16)

my-mx + c(-1,1)*qnorm(.95,mean = my-mx, sd = sp)*sp*(1/9 +1/9)^.5
my-mx + c(-1,1)*qt(.95,df = df)*sp*(1/9 +1/9)^.5
