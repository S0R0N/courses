# Q1
library(MASS)
data(shuttle)
?shuttle
d <- shuttle
#d[,"use"] <- as.character(d[,"use"])
#d[d[,"use"] == "auto","use"] <- 1
#d[d[,"use"] == "noauto","use"] <- 0
d$use  <-  relevel(d$use,"auto")
d$wind <-  relevel(d$wind,"head")

mdl.Q1 <- glm(use ~ wind,family="binomial", data = d)
summary(mdl.Q1)
exp(mdl.Q1$coefficients)

#Q2
mdl.Q2 <- glm(use ~ wind+ magn,family="binomial", data = d)
summary(mdl.Q2)
exp(mdl.Q2$coefficients)
##
#q3 not using the autolander
d.inv <- shuttle
d.inv$use  <-  relevel(d.inv$use,"noauto")
mdl.Q3 <- glm(use ~ wind,family="binomial", data = d.inv)
exp(mdl.Q3$coefficients[2])
mdl.Q3$coefficients[2]
mdl.Q1$coefficients[2]
exp(mdl.Q1$coefficients[2])
# Q4 
# load InsectSpray
data("InsectSprays")
d.Q4 <- InsectSprays
d.Q4$spray
d.Q4$spray 
spray.develed <-relevel(d.Q4$spray,"B")

mdl.Q4 <- glm(count ~ spray, data = d.Q4, family = "poisson")
mdl.Q4 <- glm(count ~ spray.develed, data = d.Q4, family = "poisson")

exp(mdl.Q4$coefficients[2])# B/A
## .9457

glm(gaData$simplystats ~ julian(gaData$date),offset=log(visits+1),
    family="poisson",data=gaData)
# Q5 what happens if I add log 10 as an offset to a variable. 
# the coeficient should not hcange, caouse it is a constant added to an uncorrelated variable time
# it is possion, so the rates depend on time. so if you agument the scale of time, you decrese the rates
# like from secs to hours to days. the rates will become smaller 

# Q6
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
plot(x,y)

z <- (x > 0) * x
fit <- lm(y ~ x + z)
sum(coef(fit)[2:3])
# 1.013
