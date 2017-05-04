rm(list=ls())
draft <- read.csv("C:/draft.csv", sep =",")

#function for std errors on clustered data
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

income<-draft$income
edu<-draft$years_education

#Part a) 
#Each year has an effect of +$5750 on annual income
regr <- lm(income ~ edu)
summary(regr)

#Part b) Some of those with high ranks might have had military careers and made 
#more money than if they had not been drafted. Having a high rank also might have made a person 
#more ambitious, realizing that they might go to war and die. 

#Part c) Problem: calculate effect of high rank on education years and special case for std error 
# Low rank has -2.12 years effect on education
draft$rank <- factor(ifelse(draft$draft_number<81,"high", "low"))
regr2<-lm(edu ~ draft$rank)
summary(regr2)


#Part d)Low rank has -$6637 on income
regr3 <-lm(income ~ draft$rank)
regr3sum<-summary(regr3)
regr3sum

#Part e) Clean change in y over clean change in x..Results show each year in education has +$3122 effect on income
effect_edu_on_income<-coef(regr3)[2]/coef(regr2)[2]
effect_edu_on_income


#Part f) As mentioned above, there might be other endogenous factors driving high rank men to higher income:
# psychological impact of high liklihood of going to war; married earlier, compelled to earn more/
# support a family.