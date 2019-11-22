# OPTIONAL ASSIGMENT
#“Is there an association between college major category and income?”
# Y = college major category
# X = income
install.packages("devtools")
devtools::install_github("jhudsl/collegeIncome")
library(collegeIncome)
data(college)


devtools::install_github("jhudsl/matahari")
library(matahari)

#dance_start(value = FALSE, contents = FALSE)
# variables for college major
summary(college)
# College major is explicit

# Reduce dimension from majors to major categories
# income represented in the three columns, p25th, median and p75th

# Characterize the samples then calcualte the sample sizes power propotion and power
## Calculate the employed sample size proportion and power     (maybe too small)
## calculate the male, female sample size proportion and power (maybe too small)
## check their effects on the analysis
data <- college
data$samplep <- mapply(function(x,y){(x/y)*100}, x = data$sample_size, y = data$total)
data$samplepemplo <- mapply(function(x,y){(x/y)*100}, x = data$sample_size*data$perc_employed, y = data$total)
hist(data$samplepemplo)
## Also test if your data is normal
## They are somehow normal - > okay
## WAIT!! to calculate power , I need first a null hipothesis to test, which is the differences between the means. 
## The null hipothesis is that all majors have the same income. i.e., they have the same mean.
## But, which would be an acceptable null mean?
## see the means of income of each sample
mcat.unique  <- unique(data$major_category)
# visual inspection of variance of their income according to major
boxplot(p25th ~ major_category, data = data) # there is 
boxplot(median ~ major_category, data = data)# there is 
boxplot(p75th ~ major_category, data = data) # there is
# now? is it significant??

# Calculate the basic statistics to do the hipothesis test
data.bycat.list <- lapply(mcat.unique,function(x,y){subset(y,major_category==x) }, y = data)
data.bycat.list.bstats <- lapply(data.bycat.list,function(x){cbind(x, p25thm = mean(x$p25th),
                                                                    medianm = mean(x$median),
                                                                    p75thm = mean(x$p75th),
                                                                    p25thsd = sd(x$p25th),
                                                                    mediansd = sd(x$median),
                                                                    p75thsd = sd(x$p75th)
                                                                    )})
# The null hipothesis would be that all majors have the same mean or median
# Take as the null hipothesis each other is one equal to the other? are the differences between their means real?
# This gives me a matrix of comparisons
# singe comparison would look like this
mcat.unique  <- unique(data$major_category)
temp<- t.test(data.bycat.list[1][[1]]$p25th,data.bycat.list[2][[1]]$p25th)
temp$p.value
# matrix of p-values
pv.matrix <- matrix(0, nrow = length(mcat.unique), ncol = length(mcat.unique), dimnames = list(mcat.unique, mcat.unique))
length(data.bycat.list[1][[1]]$p25th) >1 && length(data.bycat.list[16][[1]]$p25th) >1 

fill_pv_matrix <- function(m,dl){
  for(i in 1:nrow(m)){
    for(j in 1:nrow(m)){
      if(i!=j){
        if(length(dl[i][[1]]$p25th) >1 && length(dl[j][[1]]$p25th) >1 ){
          m[i,j] <- t.test(dl[i][[1]]$p25th, dl[j][[1]]$p25th)$p.value
        }else{
          # error when there is not engough data to calculate the test
          m[i,j] <- 0
        }

      }else{
        # skipping the vable vs itself calculation
        m[i,j] <- 0
      }
      
    }
  }
  output <- m
  return(output)
}


pv.matrix <- fill_pv_matrix(pv.matrix,data.bycat.list)
write.csv(pv.matrix, "pvmatrix.csv")
qqnorm(data$p25th)
qqnorm(rnorm(n = 100))








