## CARET PACKAGE the ML framework in R

## CODE EXAMPLE
library(caret); library(kernlab);install.packages('e1071', dependencies=TRUE)
data(spam)
inTrain <- createDataPartition(y=spam$type,
                               p=0.75, list=FALSE) # creates a partitiion with the set p and the factor spam type as predicted V
training <- spam[inTrain,]    #partition gives the indexes so you get the data related to those indexes
testing <- spam[-inTrain,]    # you get the other data that was not selected by partition
dim(training)

### FIT a MODEL
set.seed(32343)
modelFit <- train(type ~.,data=training, method="glm")
modelFit
warnings()
modelFit$finalModel

# PREDICTING
predictions <- predict(modelFit,newdata=testing)
predictions

# EVALUATING
confusionMatrix(predictions,testing$type)
# Accuracy. 95% CI is the 95% interval for accuracy
