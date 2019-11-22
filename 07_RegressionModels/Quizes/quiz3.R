data("mtcars")
# cilinders as a factor and wt as cofounder. predicted is mpg. 
# give the adjusted estimate for the expected change in mpg comparing cilinders 8(reference) to 4
# combination of factor and regression. 
head(mtcars)
cyl.relevel <- relevel(as.factor(mtcars$cyl), "8")
fit <- lm(mpg ~wt + cyl.relevel, mtcars)
summary(fit)
# -6xxx
# compare the same effcect of 8 on 4 but including and not including wt
ft.nowt <- lm(mpg ~ cyl.relevel, mtcars)
summary(fit)$coef
summary(ft.nowt)$coef
# holding weigth constant , cyl have less impact

# compare the fit with the model of the interaction of the wt and cyl.
fit1.Q3 <- lm(mpg ~ as.factor(cyl) + wt, mtcars)
fit2.Q3 <- lm(mpg ~ as.factor(cyl) + wt + as.factor(cyl)*wt, mtcars)
#lets do the nested model thingy.
anova(fit1.Q3, fit2.Q3)
# so according to anova thingy it is necessary, but which hipo test are we running???!!
# trying the p-value is small lesss than .05 . thus is surely true that there is an interaction term in the true model
# BAD!!!!
summary(ft.interaction)
# pregunta 3
# the p value is small so we fail to reject null. therefore, it must be necessary. 
# BADD!!!
# lrtest()
# THE THING was with the anova test. but the p value is greater than .05 so we reject and there is no relationship


#pregunta 4
fit.Q4<- lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
# the estimated change in mpg per half ton, for a specified number of cilynders 
# BAD!!
# must be the estimated change in mpg per half ton
# BAD!!!
# that leaves only the half ton change against the averages, why?!
# xpected change in MPG per one ton increase in weight"
# because the wt is given in lbs not kilos and tons is 1000kilos... soo, OMFG!
 
# pregunta 5
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
fit.Q5 <- lm(y~x)
plot(fit.Q5)
hatvalues(fit.Q5)
# .994

# pregunta 6
# the biggest hat value was point 5
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
fit.Q6 <- lm(y~x)
hatvalues(fit.Q6)
dfbetas(fit.Q6)
#round(dfbetas(fit.Q6)[5, 2], 3)
# 134
# pregunta 7 
# it can change isngs...