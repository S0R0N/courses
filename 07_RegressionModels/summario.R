# UTILIDAD
## Detectar los componentes de algo, senales, variabilidad, sabor, etc. 

# Obtener datos
# CALCULO
# Revisar colinearidad
# - Matrix de corelaciones entre las variables y el Y y entre ellas
# - si la cor es bajita okay
# Revisar evaluar diferentes modelos
# - Anova               (evalua el modelo como un todo F-statistic)
# - Evaluate residuals for normality (shapiro.test(fit$residuals)) if it fails okay
# - Evaluar residuales  (evalua el modelo en detalle - deviance(fit) summ of squared errors of a model)
# - VIF                 (evalua los coeficientes) vif(model) tells you how much of the variance gets inflated by which added coeficient
# Revisar outliers 
#  - hatvalues
#  - dfstudent
#  - dfbeta
# INFERENCIA
#  - Para calcular intervalos de los valores predecidos se puede usar el error estandar del modelo y hace run T-test
#  - para calcular intervals de los coeficientes se usan las variaciones de cada coeficiente.
#  - e.g., sumCoef <- summary(fit)$coefficients  sumCoef[1,1] + c(-1, 1) * qt(.975, df = fit$df) * sumCoef[1, 2]
#  - Ajustar para multiple hipothesis testing

# INTERPRETACION DE COEFICIENTES
# importante, segun el tipo de variable y el tipo de distribucion possion, binaria or normal se hacen diferentes interpretaciones


# MODELOS
# Se pueden hacer modelos con 
#  - variables continuas -  slope cambio en torno a cada variable
#  - - B0 change of Y when the variable is cero
#  - - B1 change of Y when the variable increments in 1
#  - Factores
#  - - ANOVA: Variance analysis. The reference is the one behind the minus in the comparisons
#  - - ASSUMPTIONS: variance equal, the Y data follows a normal dist
#  - - Two levels: B1 is the increase or decrease in the mean comparing those in the group =1 and those not = 0
#  - - For the values of 0 the mean is B0, for the values of 1 the mean is B0+B1
#  - - More than Two levels:  
#  - - - B0: mean of the reference factor.
#  - - - B0+B1 mean of X1 - 1.
#  - - - B0+B2 mean of X2 = 1. 
#  - - - B1: X1=1 vs refernce
#  - - - B2: X2=1 vs refernce
#  - - - B1-B2: X=1 vs X2=1
#  - - - IF you want to see the means, remove the intercept (lm (y ~ factors -1))
#  - - - The t test now evaluate how the differences between the ref and the other means, 
#  - - ANCOVA: 
#  - MULTIPLE LINES: regress different lines one for each group. The paralel lines
#  - - fit two models with the same slope and differnt intercepts
#  - - the intercept is: B0+B2 
#  - - the slope B1 is:
#  - RELATIONS BETWEEN FACTORS AND CONTINUOS - Y = B0+B1X1+B2X2+B3X1*X2
#  - - X2 = 0 -> B0+B1X1 (normal line) (no interaction)
#  - - X2 = 1 -> B0+B1X1 + B2+B3X1     (interaction)
#  - - X2 = 1 -> (B0+B2) + (B1+B3)X1 (line with interaction)
#  - - B2 is the change from X2 = 0 to X2 = 1
#  - - B0 intercept for X2 - 0
#  - - B0+B2 intercept for X2 = 1
#  - - B3 is the change in the slope going from X2=0 to X2=1

# EXPAND: 
# Generalizing linear models
# longitudinal multileveldata. 