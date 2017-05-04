rm(list=ls())
ebola <- read.csv("C:/ebola.csv", sep =",")
ATE = mean(ebola$vomiting_day14[ebola$treat_zmapp==1])-mean(ebola$vomiting_day14[ebola$treat_zmapp==0])

#Part a) : effect of z-mapp is -0.2377 (+/- 0.0856), p-value is 0.01, statistically significant
summary(lm(ebola$vomiting_day14 ~ ebola$treat_zmapp))

#Part b) : adding covariates: ATE is -0.165 (+/- 0.075), p-value is 0.05, statistically significant
summary(lm(ebola$vomiting_day14 ~ ebola$treat_zmapp + ebola$vomiting_day0 + ebola$temperature_day0))

#Part c) : Prefer the estimate in part B vs. part A as 
# temperature day 0 is a statistically significant covariate 


#Part d) : Adding temp_day_14 as covariate: ATE = -0.12 (+/- 0.077) 
# p-value is no longer significant (larger than 0.1)
summary(lm(ebola$vomiting_day14 ~ ebola$treat_zmapp + ebola$vomiting_day0 + ebola$temperature_day0 + ebola$temperature_day14))

#Part e) : I prefer the estimate in part d as temp day 0 and temp day 14 are both statistically 
# significant covariates. Part b) only conisidered temp day 0 as a covariate

#Part f) Run the regression model twice (with temp day 14 as outcome) once for men and once for women 
# and compare the results. 
# Zmapp has significant effect on reducing men's temperature. ATE = -2.239, significant at 0.0001 p-value
# Zmapp not significant on reducing women's temperature. ATE = -0.229 , p-value not significant

model_men_cov <- lm(ebola$temperature_day14[ebola$male==1] ~ ebola$treat_zmapp[ebola$male==1] + ebola$vomiting_day0[ebola$male==1] + ebola$temperature_day0[ebola$male==1])
summary(model_men_cov)

model_fem_cov <- lm(ebola$temperature_day14[ebola$male==0] ~ ebola$treat_zmapp[ebola$male==0] + ebola$vomiting_day0[ebola$male==0] + ebola$temperature_day0[ebola$male==0])
summary(model_fem_cov)

#Part g)
# Problem of multiple comparisons / fishing for an effect -- similar to the green
# jelly bean example. In order for gender impact on temperature to be statistically
# significant, the required p-value for significance  needs to be equal to 0.05 / by 10,000 comparisons. 
# This is unlikely and wasn't mentioned as part of the study. Skeptical of finding.