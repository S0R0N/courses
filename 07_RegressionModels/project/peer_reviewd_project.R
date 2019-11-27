
# Did the student interpret the coefficients correctly?
# Did the student do some exploratory data analyses?
# Did the student fit multiple models and detail their strategy for model selection?
# Did the student answer the questions of interest or detail why the question(s) is (are) not answerable?
# Did the student do a residual plot and some diagnostics?
# Did the student quantify the uncertainty in their conclusions and/or perform an inference correctly?
# Was the report brief (about 2 pages long) for the main body of the report and no longer than 5 with supporting appendix of figures?
# Did the report include an executive summary?
# Was the report done in Rmd (knitr)?

# (MPG) (outcome)
# “Is an automatic or manual transmission better for MPG”
# "Quantify the MPG difference between automatic and manual transmissions"
if (!require("devtools")) install.packages("devtools")
devtools::install_github("trestletech/shinyAce")
devtools::install_github("swarm-lab/editR")

library(editR)


data("mtcars")
?mtcars
# Exploratory analises
head(mtcars)
summary(mtcars)# am has to be converted into factor

qqnorm(mtcars$mpg)# our output variable follows a normal distribution
p <- ggplot(mtcars, aes(x=as.factor(mtcars$am), y=mtcars$mpg)) + 
  geom_boxplot()+ labs(title="Plot of mpg per automatic or manual transmision", x="AM (A = 1, M = 0)", y = "MPG")
p
#boxplot(mtcars$mpg ~ mtcars$am) # there is a visible difference in mpgs when using automatic vs manual

# 
#mtcars$am  1 = manual, 0 automatic
mtcars$am <- as.factor(mtcars$am)
mdl.project <- lm(mpg ~ am, mtcars)

# Evaluting the model
summary(mdl.project)
# the coeficient seem correctand the difference significative with manual mpg goes up
anova(mdl.project)# okay
# checking for the normality of the coeficients
shapiro.test(mdl.project$residuals)
# can not deny the null hipothesis then the residuals are normal! win

# Interpretation of coeficients 
# The B0 is the mean mpgs when automatic, around 17 mpgs increment
# the B1 is the increment difference between the automatic and the manual. 
# B1 would increment manual-auto = 7.245. Therefore, the average increment in mpgs when using manual is 17.145 + 7.245

# Evalauting inference intervals
p1 = data.frame(predict(mdl.project, interval = ("confidence")))

coef.statistics <- summary(mdl.project)$coef

B0.interval <- coef.statistics[1,1] +c(-1,1)*qt(.975, df = mdl.project$df)*coef.statistics[1,2]
B1.interval <- coef.statistics[2,1] +c(-1,1)*qt(.975, df = mdl.project$df)*coef.statistics[2,2]# B1 is above cero is still signficative

# so in conclusion
# - Automatic transmition is slighty better than manual transmission 
# - When using automatic transmission there is a reduction of an average of 7.245 mpgs
# - The 95% t-test showed B1 that the lower end of B1 was 3.631. Therefore, a positive difference hold

# MULTIPLE MODEL APPROACH
# CHECKING CO-RELATIONS
## The model selection strategy is based on correlations between am and the other predictors and anova and saphiro test
## First, I calculate the correlations of Am and the other variables in the dataset and create models according to these correlations
## The nested models are created in the order of the magnitude of AM and the other predictors. The justification for this policy is that, the more correlation another predictor has with AM the more impact it will have on its regressed coeficient
## The models will be evaluated by looking at the p vales of their anova and saphiro test. Anova to evaluate the model and saphiro to account for the normality of the residuals. 

# Matrix of correlations to check possible interefects between the variables
data("mtcars")# original is all numeric as cor needs it
mtcars.cor <- cor(mtcars)
# getting only the corelation of am
am.cor <- sort(abs(mtcars.cor[,"am"]), decreasing = T)
# according to this the lowest corelations are with carb and Vs lets test it

# TESTING NESTED MODELS following the corelation info
?mtcars
# check the impact of converting some variables to factors. 

mdl.project  <- lm(mpg ~ am, mtcars)
mdl.project1 <- lm(mpg ~ am+gear, mtcars)# gear
mdl.project2 <- lm(mpg ~ am+gear+drat, mtcars)# drat
mdl.project3 <- lm(mpg ~ am+gear+drat+wt, mtcars) #wt
mdl.project4 <- lm(mpg ~ am+gear+drat+wt+disp, mtcars) #disp
mdl.project5 <- lm(mpg ~ am+gear+drat+wt+disp+cyl, mtcars) #cyl
mdl.project6 <- lm(mpg ~ am+gear+drat+wt+disp+cyl+hp, mtcars) #hp
mdl.project7 <- lm(mpg ~ am+gear+drat+wt+disp+cyl+hp+qsec, mtcars) #qsec
mdl.project8 <- lm(mpg ~ am+gear+drat+wt+disp+cyl+hp+qsec+carb, mtcars) #carb
mdl.project9 <- lm(mpg ~ am+gear+drat+wt+disp+cyl+hp+qsec+carb+vs, mtcars) #vs

s <- c(shapiro.test(mdl.project$residuals)$p.value,
  shapiro.test(mdl.project1$residuals)$p.value,
  shapiro.test(mdl.project2$residuals)$p.value,
  shapiro.test(mdl.project3$residuals)$p.value,
  shapiro.test(mdl.project4$residuals)$p.value,
  shapiro.test(mdl.project5$residuals)$p.value,
  shapiro.test(mdl.project6$residuals)$p.value,
  shapiro.test(mdl.project7$residuals)$p.value,
  shapiro.test(mdl.project8$residuals)$p.value,
  shapiro.test(mdl.project9$residuals)$p.value
  )
names(s) <- c("m","m1","m2","m3","m4","m5","m6","m7","m8","m9")
s # m4 is bad
a <- anova(mdl.project, mdl.project1,
           mdl.project2,
           mdl.project3,#ok
           mdl.project4,# horrible
           mdl.project5,#ok
           mdl.project6,
           mdl.project7,
           mdl.project8,
           mdl.project9)
a# m4 is bad
# decided to remove disp

# Second iteration of nested models removing disp 
mdl.project   <- lm(mpg ~ am, mtcars)
mdl.project1  <- lm(mpg ~ am+gear, mtcars)# gear
mdl.project2  <- lm(mpg ~ am+gear+drat, mtcars)# drat
mdl.project3  <- lm(mpg ~ am+gear+drat+wt, mtcars) #wt
mdl.project10 <- lm(mpg ~ am+gear+drat+wt+cyl, mtcars) #cyl
mdl.project11 <- lm(mpg ~ am+gear+drat+wt+cyl+hp, mtcars) #hp
mdl.project12 <- lm(mpg ~ am+gear+drat+wt+cyl+hp+qsec, mtcars) #qsec
mdl.project13 <- lm(mpg ~ am+gear+drat+wt+cyl+hp+qsec+carb, mtcars) #carb
mdl.project14 <- lm(mpg ~ am+gear+drat+wt+cyl+hp+qsec+vs, mtcars) #vs

mdl.project$coefficients
mdl.project1$coefficients
mdl.project2$coefficients
mdl.project3$coefficients# 
mdl.project10$coefficients
mdl.project11$coefficients
mdl.project12$coefficients
mdl.project13$coefficients
mdl.project14$coefficients

s <- c(shapiro.test(mdl.project$residuals)$p.value,
       shapiro.test(mdl.project1$residuals)$p.value,  shapiro.test(mdl.project2$residuals)$p.value,
       shapiro.test(mdl.project3$residuals)$p.value,  shapiro.test(mdl.project10$residuals)$p.value,
       shapiro.test(mdl.project11$residuals)$p.value,  shapiro.test(mdl.project12$residuals)$p.value,
       shapiro.test(mdl.project13$residuals)$p.value,  shapiro.test(mdl.project14$residuals)$p.value)
names(s) <- c("m","m1","m2","m3","m10","m11","m12","m13","m14")
s # m12 is bad
a <- anova(mdl.project, mdl.project1,
           mdl.project2,
           mdl.project3,
           mdl.project10,
           mdl.project11,# do not pass the anova hp
           mdl.project12,
           mdl.project13,
           mdl.project14
           )
a$`Pr(>F)`[6]# hp does not pass the anova test, it is rejected
# Another iteration removing disp and hp
mdl.project   <- lm(mpg ~ am, mtcars)
mdl.project1  <- lm(mpg ~ am+gear, mtcars)# gear
mdl.project2  <- lm(mpg ~ am+gear+drat, mtcars)# drat
mdl.project3  <- lm(mpg ~ am+gear+drat+wt, mtcars) #wt
mdl.project10 <- lm(mpg ~ am+gear+drat+wt+cyl, mtcars) #cyl
mdl.project15 <- lm(mpg ~ am+gear+drat+wt+cyl+qsec, mtcars) #qsec
mdl.project16 <- lm(mpg ~ am+gear+drat+wt+cyl+qsec+carb, mtcars) #carb
mdl.project17 <- lm(mpg ~ am+gear+drat+wt+cyl+qsec+vs, mtcars) #vs

mdl.project$coefficients
mdl.project1$coefficients
mdl.project2$coefficients
mdl.project3$coefficients# 
mdl.project10$coefficients
mdl.project15$coefficients
mdl.project16$coefficients
mdl.project17$coefficients


shapiro.test(mdl.project$residuals)# am
shapiro.test(mdl.project1$residuals)# gear
shapiro.test(mdl.project2$residuals)# drat
shapiro.test(mdl.project3$residuals)# wt
shapiro.test(mdl.project10$residuals)# cyl
shapiro.test(mdl.project15$residuals)# qsec # weak
shapiro.test(mdl.project16$residuals)# carb # weak
shapiro.test(mdl.project17$residuals)# vs # dies!


a <- anova(mdl.project,
           mdl.project1,
           mdl.project2,
           mdl.project3,
           mdl.project10,
           mdl.project15,# do not pass the anova hp
           mdl.project16,
           mdl.project17
)
# I did three iterations and selected the model mpg = 
# - In the first iteration all variables were nested, after the evalaution the varible disp was removed. 
# - In the second iteration hp was removed.
# - in the third iteration qsec was removed. 
# - In this iteration the best model mpg ~ am + gear + drat + wt + cyl was selected wit anova p-value of xxx and saphiro p-value of xx

# Calcualting the inference interval for the B1
mdl.project10.coef.statistics <- summary(mdl.project10)$coef
mdl.project10.coef.statistics.B1.int <- mdl.project10.coef.statistics[2,1] +c(-1,1)*qt(.975, df = mdl.project10$df)*mdl.project10.coef.statistics[2,2]

# CONCLUSION AFTER NESTED MODEL ANALYSIS
# The interval of the B1 for the selected model was tested at a 95% t-test and it contained cero. Therefore, taking into account other variables in the dataset, AM does not have a significant effect on mpg
# The quantity could be
# model 10: 1.301 with interval of -2.46 and 5.06
# Limitations: In this approach only three iterations of one set of possible combinations of the variables was done, in a future study all the other possible combinations of the variables can be explored to find the best possbile model and with re-evaluate the answer to these question.
# Assumptions: for linear model regression to compare binary values the assumptions are that the samples were iid and that their variances was equal


## CRAZY MODEL
# so design a function to do the nested model evaluation 
# we can do it by generatig a matrix of measures we are interested in
# therefore, it would be something like this

# Generate the different combinations of models 
## A matrix where AN is a constant predictor
## Size i = other predictors by j = other predictors
## Do not calculate or remember the i = j
## Calculate the rest accumulating predictors
## Calculate matrices of the values of interest

## Report the model coeficient of interest B1
## Report P value of Shapiro test for all model's residuals
## Report P value of anova test for all models a$`Pr(>F)`

# CRAZY TEST
mtcars
# Number of variables to test total dataset minus the predicted (MPG) and the reference (AM)
n <- length(colnames(mtcars))-2
i <- n
j <- n
vars <- c("cyl","disp","hp","drat","wt","qsec","vs","gear","carb")
d.sub <- mtcars[,vars]
x     <- mtcars$am  # Reference predictor
y     <- mtcars$mpg # Predicted
B1.matrix        <- matrix("numeric", nrow = i,ncol = j, dimnames = list(vars,vars))
shapiro_p.matrix <- matrix("numeric", nrow = i,ncol = j, dimnames = list(vars,vars))
anova_p.matrix   <- matrix("numeric", nrow = i,ncol = j, dimnames = list(vars,vars))


for(i in 1:n){
  for(j in 1:n){
    if(i==j){
      value <- 0
    }else{
      # create model 
      ## the model have memory so.. 
      ### there are conditions to the calculation of the models
      # get the coef
      # get the anova p value 
      # get the shapiro p value
    }
  }
}
