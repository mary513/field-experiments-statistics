rm(list=ls())
mecca <- read.csv("C:/lottery.csv", sep =",")
actual_ATE <- mean(mecca$views[mecca$success==1]) - mean(mecca$views[mecca$success==0])
actual_ATE
#set up the random inference
allvalues <- mecca$views
randomize <- function() sample(c(rep(0,479),rep(1,479)))
est.ate <- function(outcome, treat) mean(outcome[treat==1]) - mean(outcome[treat==0])
distribution.under.sharp.null <- replicate(10000, est.ate(allvalues, randomize()))
plot(density(distribution.under.sharp.null))
abline(v=actual_ATE) 
mean(actual_ATE <= distribution.under.sharp.null) #p-value
count.simulations.larger.than.actual.ATE <- sum(distribution.under.sharp.null>actual_ATE)
# Number of simulated random assignments that are at least as large 
# as the actual estimate of the ATE is about 16 (or 17 depending)
count.simulations.larger.than.actual.ATE
# one tailed p-value is .0017

#Highly significant result, a pakistani who wins the lottery to travel to mecca has more 
#favorable views of muslims from other countries than one who doesn't win the lottery

#Number of simulated random assignments that are at least 
#as large in ABSOLUTE value as the actual estimate of the ATE (~16 or 17 depending)
abs.count.simulations.larger.than.actual.ATE <- sum(abs(distribution.under.sharp.null)>actual_ATE)
abs.count.simulations.larger.than.actual.ATE
# count of absolute values is 34 , which is what we would expect as it's about double the pure values
# implied 2-tailed p-value is double or 0.0034

summary(lm(allvalues ~ mecca$success))
