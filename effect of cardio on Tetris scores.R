rm(list=ls())
running <- read.csv("C:/tetris.csv", sep =",")
run <- running$run
score <- running$tetris

# FE 8.10)
# Part a)	
# In this 'within subjects' experiment, the assumptions that are required are 'no anticipation' and 'no persistence':
#   .	no anticipation: potential outcomes not affected by treatments administered in the future
#   .	no persistence: potential outcomes are not affected by treatments in a prior period
#   .	In assessing the Tetris score the experimenter would need to consider whether 'persistence' of the 
#     effects of the prior day's treatment have an impact current day's Tetris score. 
#   This is plausible.

# Since the subject was performing all aspects of the study, there's no way to verify that treatments were 
# completely randomized and captured accurately. (This is separate from compliance with the other assumptions above.) 
# .	Did the subject accurately generate random treatment. 
#   Was she affected by the prior day's treatment and/or make mistakes recording data because of fatigue?  
# .	Were all measurements recorded accurately? Did she randomize correctly?
# .	etc


# Part b)
#Regression shows statistical significance of running on tetris score that same day: p-value = 0.0103
regr <- lm(score ~ run)
regr.summary <- summary(lm(score ~ run))
regr.summary

# Part c)
#Regression shows statistical significance of running on tetris score the PREVIOUS day: p-value = 0.0103.
# Thus the probability of obtaining an effect at least as extreme as the one we are seeing is 1%. Can not rule
# out the null hypothesis that running is not correlated with previous day Tetris score. 
run2 <- running$run[2:26]
score2 <- running$tetris[1:25]

regr2 <- lm(score2 ~ run2)
regr2.summary <- summary(lm(score ~ run))
regr2.summary

#Part d) 
# Regression is not statistically significant for the effect of running on energy level
# p-value = 0.8727
energy <- running$energy
regr3 <- lm(energy ~ run)
regr3.summary <- summary(lm(energy ~ run))
regr3.summary

# Regression is not statistically significant for the effect of running on gre score
# p-value = 0.3532
gre.score <- running$gre
regr4 <- lm(gre.score ~ run)
regr4.summary <- summary(lm(gre.score ~ run))
regr4.summary
