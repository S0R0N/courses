##################################################
##               INTERSTING COMMANDS            ##
##################################################
# command geom_density(colour="blue")  to see the density line, super cute
# command stat_fun allows you to run functions and graph their result

##################################################
##                  BOX PLOT                    ##  
##################################################
data(ToothGrowth)
ggplot(data=ToothGrowth,aes(x=factor(dose),y=len)) +
  geom_boxplot(aes(fill=factor(dose)))+ facet_grid(~supp,
                                                   labeller = as_labeller(c('OJ'='Orange Juice', 'VC'='Ascorbic Acid'))) +
  theme(legend.position = "none") +
  labs(y = "Length of Odontoblasts", x = "Dose [mg/day]")

##################################################
## manipulate a normal distribution parameters ###
##################################################
var
mu0 <- 30  #null hopohtesis
mua <- 32 # how powerful it is in respect to 32
sigma <- 4 # estimated variance of the pop
n <- 16    # expected number of samples 
alpha <- 0.05
z = qnorm(1-alpha) # hipo test
myplot <- function(sigma, mua, n, alpha){
  g <- ggplot(data.frame(mu = c(27,36)),aes(x=mu))
  g = g+stat_function(fun=dnorm, geom = "line",
                      args=list(mean = mu0,sd=sigma/sqrt(n)),
                      size = 2,col = "red"
  )
  g = g+stat_function(fun = dnorm, geom = "line",
                      args=list(mean = mua,sd=sigma/sqrt(n)),
                      size = 2,col = "blue"
  )
  xitc = mu0+qnorm(1-alpha)*sigma/sqrt(n)
  g = g+geom_vline(xintercept = xitc, size = 3)
  g
}
manipulate(
  myplot(sigma, mua, n, alpha),
  sigma = slider(1,10, step = 1, initial = 4),
  mua = slider(30,35,step = 1, initial = 32),
  n = slider(1,50,step = 1, initial = 16),
  alpha = slider(0.01,0.1,step = 0.01, initial = 0.05) 
)