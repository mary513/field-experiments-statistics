##***********************************************************
##***********************************************************
#Effects of advertising on recall
##***********************************************************
##***********************************************************

rm(list=ls())
library("sandwich")
library("lmtest")
fb <- read.csv("C:/brockgreen.csv", sep =",")
length(fb$treat_ad)
fb[fb==""] <- NA
fb <- na.omit(fb)
length(fb$treat_ad)
# *** Declare cluster function
cl <- function(fm, cluster){
  require(sandwich, quietly = TRUE)
  require(lmtest, quietly = TRUE)
  M <- length(unique(cluster))
  N <- length(cluster)
  K <- fm$rank
  dfc <- (M/(M-1))*((N-1)/(N-K))
  uj <- apply(estfun(fm),2, function(x) tapply(x, cluster, sum))
  vcovCL <- dfc*sandwich(fm, meat=crossprod(uj)/N)
  coeftest(fm, vcovCL)
}
##**************************************************************************
##**************************************************************************

actual_ATE <- mean(fb$name_recall[fb$studyno==1 & fb$treat_ad==1]) - mean(fb$name_recall[fb$studyno==1 & fb$treat_ad==0])
actual_ATE
##Actual ATE [1] -0.009798

##*****Part a)
st1.treat <- fb$treat_ad[fb$studyno==1]
st1.recall <- fb$name_recall[fb$studyno==1]
regr <- lm(st1.recall ~ st1.treat)
regr.summ <- summary(lm(st1.recall ~ st1.treat))
regr.summ
#coef(regr.summ)
#treat.effect <- regr.summ$coefficients[1] ## for validation
st1.se <- coef(regr.summ)["st1.treat", "Std. Error"]
st1.se
## 95% confidence interval is bounded by 
## -0.009798 +/-  1.96*0.021
## -0.009798 + 0.0412 = 0.0314
## -0.009798 - 0.0412 = -0.0510

##*****Part b)
# Results were clustered on age, city/county (but then further clustered on zip code), and gender.
# Clustered results might increase standard errors as clustering will emphasize acute diffrences in clusters
# rather than distributed differences which would result in a more continuous distribution of errors.

##*****Part c)
cluster.st1 <- factor(fb$cluster[fb$studyno==1])
my.cl <- cl(regr, cluster.st1)
my.cl
#Treatment effect is -0.009797 (+/- (1.96*0.0237)) == -0.009797 (+/- 0.0464) for 95% confidence interval


##*****Part d)
st2.treat <- fb$treat_ad[fb$studyno==2]
st2.recall <- fb$name_recall[fb$studyno==2]
regr2 <- lm(st2.recall ~ st2.treat)
regr2.summ <- summary(lm(st2.recall ~ st2.treat))
regr2.summ

cluster.st2 <- factor(fb$cluster[fb$studyno==2])
my.cl2 <- cl(regr2, cluster.st2)
my.cl2
# Clustered treatment effect is -0.0028 (+/- (1.96*0.0355)) == -0.009797 (+/- 0.0696) for 95% confidence interval


##*****Part e)
treat <- fb$treat_ad
recall <- fb$name_recall
regr3 <- lm(recall ~ treat)
regr3.summ <- summary(lm(recall ~ treat))
regr3.summ

cluster <- factor(fb$cluster)
my.cl3 <- cl(regr3, cluster)
my.cl3
# Clustered treatment effect is -0.1551 (+/- (1.96*0.0267)) == -0.009797 (+/- 0.0523) for 95% confidence interval


##*****Part f)
std_1 <- as.numeric(fb$studyno==1)
std_2 <- as.numeric(fb$studyno==2)
regr4 <- lm(recall ~ treat + std_2)
summary(regr4)
regr5 <- lm(recall ~ treat + std_1)
summary(regr5)
#ATE for study 2 is -0.4260 and the inverse for study 1, +0.4260, p-value 0.001, highly significant

##*****Part g)
# the results differ because they are mixing 2 studies. in the latter we are blocking for each study
# in the omnibus regression, we are combining all results into a pool
# The omnibus is more biased as it is potentially comparing apples to oranges in pooling 2 different studies

##*****Part h)
# This study had different outcomes (much higher ATE) for a few reasons:
# it leveraged analytics from facebook 
# using these analytics it targeted specific groups that were heavily invested in the outcome of the 
# vote. In this case, parents of school age children interested in class size.
# Whereas the Broockman/Green study did not target specific groups nor did it 
# leverage facebook analytics for insights

# Examples of targeting from the study:
# "we were able to pinpoint the best message/image for each audience, and move those findings to 
# inform display ad production within a week."  
# The agency also used Facebook to target people who liked politically oriented Facebook 
# Pages or who listed relevant Likes & Interests or Education & Work. For example, 
# it targeted people who listed terms like "teacher," "pta" "math teacher" to reach educators." 