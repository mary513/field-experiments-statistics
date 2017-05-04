rm(list=ls())
library(foreign)
senate = read.dta("C:/senate.dta")
###Part a)
texas_control <- senate$bills_introduced[senate$term2year==0 & senate$texas0_arkansas1==0]
texas_treat <- senate$bills_introduced[senate$term2year==1 & senate$texas0_arkansas1==0]
ark_control <- senate$bills_introduced[senate$term2year==0 & senate$texas0_arkansas1==1]
ark_treat <- senate$bills_introduced[senate$term2year==1 & senate$texas0_arkansas1==1]
tex.2.year.impact <- mean(texas_treat) - mean(texas_control)
ark.2.year.impact <- mean(ark_treat) - mean(ark_control)


## Estimate effect of 2 year term on # of bills introduced
tex.2.year.impact
ark.2.year.impact

### Additional histograms for treament/control grouop in each state
hist(texas_control)
hist(texas_treat)
hist(ark_control)
hist(ark_treat)

###Part b) Standard error of effect of a 2 year term term by state
mean(texas_treat)
sd(texas_treat)
tex.se <- sd(texas_treat)/sqrt(length(texas_treat))
##*****Estimated std error for texas:
tex.se

mean(ark_treat)
sd(ark_treat)
ark.se <- sd(ark_treat)/sqrt(length(ark_treat))
##*****Estimated std error for arkansas:
ark.se

###Part c) Standard error of effect of a 2 year term term for both states combined
len.tot.trt <- 33
len.tex.trt <- 15
len.ark.trt <- 18
total.ATE <- tex.2.year.impact*(len.tex.trt/len.tot.trt) + ark.2.year.impact*(len.ark.trt/len.tot.trt)
##**** Total ATE
total.ATE

###Part d)
# Simply pooling the data would result in biased estimate because the 2 states 
# have significantly different baselines in the respective control groups (4 year terms).
# Texas has a much higher number of bills introduced on average than Arkansas in control gp.
# Variation in the treatment would be correlated with the control group of each,
# in other words, Arkansas 2 year senators behave more like Arkansas 4 year senators than 
# Texas senators and should be compared only with Arkansas senators.

#Examine pooled data for the sake of it anyway
control <- senate$bills_introduced[senate$term2year==0]
treat <- senate$bills_introduced[senate$term2year==1]
pooled.ATE <- mean(treat)-mean(control)
pooled.ATE
# pooled result is not terribly far from the correct ATE,
# but this is coincidence, the error could be worse in another situation.

###Part e) generate Std Error for overal ATE using textbook formula
se.ate <- sqrt( (tex.se)^2*(len.tex.trt/len.tot.trt)^2 + (ark.se)^2*(len.ark.trt/len.tot.trt)^2  )
##***Standard error for overall ATE:
se.ate

###Part f) Use randomization inference to test the sharp null hypothesis 
#that 2 yr term effect is 0 for both states
allvalues.tex <- senate$bills_introduced[senate$texas0_arkansas1==0]
allvalues.ark <- senate$bills_introduced[senate$texas0_arkansas1==1]
randomize.tex <- function() c(sample(c(rep(0,15),rep(1,15))), sample(0:1, 1))
randomize.ark <- function() c(sample(c(rep(0,17),rep(1,17))),sample(0:1, 1))
est.ate <- function(outcome, treat) mean(outcome[treat==1]) - mean(outcome[treat==0])
##for texas
distribution.under.sharp.null <- replicate(10000, est.ate(allvalues.tex, randomize.tex()))
plot(density(distribution.under.sharp.null))
abline(v=tex.2.year.impact) 
mean(tex.2.year.impact <= distribution.under.sharp.null) 
#*******p-value for texas for one tail is .9544 
# this is not adequate to show statistical significance for two tails


## for arkansas
distribution.under.sharp.null <- replicate(10000, est.ate(allvalues.ark, randomize.ark()))
plot(density(distribution.under.sharp.null))
abline(v=ark.2.year.impact) 
mean(ark.2.year.impact <= distribution.under.sharp.null) #p-value
#*******p-value for arkansas is .9982, shows statistically significant difference in means
#Using randomization inference, we see effect is statistically significant in arkansas, but not in texas.