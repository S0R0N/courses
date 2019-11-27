## 
# first this course is just an intro the following to this one is the machine learning by standford in coursera by andrew NG
# Now
# prediction process
# PROBABILITY/SAMPLING first step and important one
## example of google flu, the model was good, but over time the data changed , the keywords and how they were used changed and that reflected on the model performance negatively.

# QUESTION - >INPUT DATA -> FEATURES -> ALGORITHM -> PARAMETERS - > EVALUATION
# Input datA: get the best that you have
# Features: from that data you get measured characteristics or use computationali process to build features that might be useful 
# Algorithm: use 
# PARAMETERS: estimate the parameters 
# EVALUATION: use those parameters to apply them to a new dataset. 

# TRADEOFF and COMPONENTS OF A ML algorithm

# QUESTION: the most important and it has to be concrete and filial to the data. i.e., something we can really answer with the available data. 

# DATA:
# - the more similar is the in to the predicted out the better the algorithm will work.
# - there is a discussion about getting lots of data. However, the relevant data is the best

# FEATURES: Compressing the data
# - Compress the data
# - Contain relevant info while compressing the data
# - MISTAKES: trying to automate feature selection, no paying attention to the data quirks , throwing away information unnecessarily
# ALGORITHM: the execution part
# - it is not that important compared to linear regressions or basic predictor algorithms. 
# - COMPONENTS: Interpretable, SImple, Accurate, FAST, Scalable(easy to apply to a large dataset - paralelizable or fast). 

# PREDICTION: is about tradeoffs
# - Interpretability vs accuracy
# - Speed Vs accuracy
# - Simplicity vs accuracy
# - Scalability vs accuracy

# IN SAMPLE AND OUT OF SAMPLE ERROR
# IN SAMPLE error: the error rate you get when you predict on the same data you used to train your model - resubstitution error ()
# OUT of SAMPLE ERROR: the error you get on a new dataset - generalization error 
#  - WE CARE ABOUT the out of sample error!!!!!
#  - sometimes you can gie a little bit of accuracy in the data you have to improve the out of sample
#  - In a data set we have some random variation. If we fit exactly to that random variation we might be adding that error to our model and incurrying in overfitting
#  - In any dataset there is signal and noise, we want to predict signal 

## PREDICTION STUDY DESIGN
# How to minimize the in sample and out of sample errors
# - Define your error rate
# - Split the data: 
# - - Trainning, 
# - - Testing 
# - - Validation
# - Pick features on the trainning set
# - - Crossvalidation??? - use the data set to pick the features that are more important for your model
# - On the trainning set pick prediction function (the algorithm - and parameters)
# - - Crossvalidation???
# - If no validation 
# - Apply 1X to trainning set - apply the best model one time to the test set - the one time restriction is because if you do it many times you are not using it as a evaluation but trainning. 
# - If validation 
# - - apply to test set and refine 
# - - Apply 1X to validation

# - DATA SPLITTING:
# - ALWAYS randome sample your tests
# - If your predictions evolove with time, split train and test sets into time chunks (backtesting)
# - All subsets should reflect as much diversity as possible (randomization)
# - large data sample size
# - - 60% trainning
# - - 20% Test
# - - 20% validation
# - Medium data sample size
# - - 60% trainning
# - - 40% testing
# - Small sample size
# - - Do cross validation 
# - - Report caveat of small sample size
# - SET BENCHMARKS: like control sets, when all the data points are cero or all are wrong
# - LARGE SAMPLE SIZE (trainning datasets): e.g., for binary classification there is a 50% chance of getting it right without doing anthing

#  TYPE OF ERRORS and EVALUATION
#  SENSITIVITY AND SPECIFICITY (BINARY PREDICTIoNS)
# - - TRUE positive:  correctlly accepted   (TP)
# - - False positive: incorreglty accepted  (FP)
# - - TRUE negative:  correctly rejected    (TN)
# - - FALSE negative: incorrectly rejected  (FN)
# - - SENSITIVITY:              Pr(postiive test | disease)   - True positives - TP/(TP+FN) - positivos entre todos los positivos
# - - SPECIFICITY:              Pr(negative test| no disease) - True negative  - TN/(FP+TN) - negativos entre todos los negativos
# - - Positive predicted value: Pr(disease| positive test)    -                - TP/(TP+FP) - de los positivos cuantos realmente positivos
# - - NEgative predicted value: Pr(no disease | negative test)-                - TN/(FN+TN) - de los negativos cuanto realmente negativos
# - - ACCURACY                : Pr(correct outcome)           - Added true positives and true negative - (TP+TN)/(TP+FP+TN+FN)

# NOTE ON POPULATION AND EVALUATION
# you need to know your population, sometimes you are predicting rare events. These by default will have small percentages. 

# MEAN SQUARED ERROR (Continous prediction) - EVALUATION
# - Mean squared error or root: continuous data , sensisitve to outliers (mean of the distance)
# - Median absolute deviation: cointinous data, often more robust.       (median of the distance) median of the absolute of the difference betwen predicted and real
# - sensitivity (recall): if you want few missed positives
# - secificity: if you want few negatives called positives
# - Accuracy  : weights false and positive equaly.
# - Concordance: kappa??? multiclass cases??? 


# ROC, Reciver Operating Curves - receiver operating charactersitics curves - EVALUATION
## USED to measure the quality or the goodness of a prediction algorithm

## PLOT of the probabilities of Pr(FP) - (1-specificity) vs TP 
## In the case of predicting binary data you you know that is either one or the other
## however, normally you would predict quantiative data such as the probability of being alive
## to dive this continous data into alive or not, you have to define a cut-off or threshold. 
## this CUT-OFF gives you different results for your model

## DRAWING THE ROC CURVE - EVALUATION
## THE ROC curve gets these cut-offs and tells you the performance of the model according to them
## - Obtanied by giving different cut-off values and obtaining TP and FP for them.
## - Cut-off is like the threshold that says is it x= 1 and x =0 
## - The higher the area under the curve of a ROC the better the algorithm
## - AUC: Area under the curve:
## - - AUC = 0.5 is random guessing
## - - AUC = 1 is perfect classifier
## - - AUC > 0.8 is considered good


## CROSS VALIDATION - EVALUATION
## THEORY
## - using the trainning set many times for test and trainning and averaging the errors (like boosting)
##  - CTL, the average of a sample will tend to the average of the population
## USED FOR
## - picking variables to include in the model
## - picking type of prediction function to use (algorithm) you test many algorithms many times
## - picking the parameters of the prediction function
## - comparing different predictors
## HOW TO
## - random subsampling of the trainning set and defining many trainning and tests sets, using them and averaging.
## - K-fold: defined sized subsets of trainning and test data. like 20% chunks of trainning and other of test and you move it like a window.
## - Leave one out: test with one sample and train with the rest and move it like a window
## WARNINGS:
## - for time series, you need to get chunks (time chunks to evaluate the effect over time)
## - for K-fold: the large the K the less bias, more varaiance
## - for K-fold: the samller the K, more bias, less variance
## - Random sampling must be done without replacement
## - Random sampling with replacemnt is bootstrap
## - - Boostrap: underestimates the error
## - - Can be corrected: but it is complicated
## - If you crossvalidate to pick up predictos, you must estimate errors on independent data
## - - the above means that after you did the crossvalidation you go and see the real errors on an indepdent set not the ones reported by the crossvalidated data

## DATA: 
## Understanidng your data set, might help you to integrate it or to assign weights to it
## if you want to predict something that happens to X, use data that is closely related to X 
## like money ball. using the players info + past players similiar to them to predict them. 
## like netflix. using movie ratings of users using info about previous ratings and data about that people
## the close is the data to the issue the better your predictions will be
## knowing how the data connects to your prediction is important