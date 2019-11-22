library(datasets)
data("ChickWeight")
library(reshape2)
wideCw <- dcast(ChickWeight,Diet + Chick ~ Time, value.var = "weight")
names(wideCw)[-(1:2)] <- paste("time", names(wideCw)[-(1:2)], sep = "")
library(dplyr)
wideCw <- mutate(wideCw,
                 gain = time21-time0
                 )


names(ChickWeight) <- tolower(names(ChickWeight))
chick_m <- melt(ChickWeight, id=2:4, na.rm=TRUE)
dcast(chick_m, time ~ variable, mean) # average effect of time
dcast(chick_m, diet ~ variable, mean) # average effect of diet


wideCw12 <- subset(wideCw,Diet %in% c(1,2))
wideCw13 <- subset(wideCw,Diet %in% c(1,3))
wideCw14 <- subset(wideCw,Diet %in% c(1,4))
wideCw23 <- subset(wideCw,Diet %in% c(2,3))
wideCw24 <- subset(wideCw,Diet %in% c(2,4))
wideCw34 <- subset(wideCw,Diet %in% c(3,4))

rbind(
  t.test(gain ~ Diet, paired = F, var.equal = T, data = wideCw14)$conf,
  t.test(gain ~ Diet, paired = F, var.equal = F, data = wideCw14)$conf,
  t.test(gain ~ Diet, paired = F, var.equal = F, data = wideCw12)$conf,
  t.test(gain ~ Diet, paired = F, var.equal = F, data = wideCw23)$conf,
  t.test(gain ~ Diet, paired = F, var.equal = F, data = wideCw24)$conf,
  t.test(gain ~ Diet, paired = F, var.equal = F, data = wideCw34)$conf
)
#T test plays with maximum two datasets
t.test(gain ~ Diet, paired = F, var.equal = F, data = wideCw14)


library(UsingR)
data(father.son)
t.test(father.son$sheight - father.son$fheight)
