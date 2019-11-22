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