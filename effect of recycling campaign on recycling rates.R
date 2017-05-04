##**************************************************************************
##**************************************************************************
## Effect of recycling communication on recycling effects
# Discussion based on textbook example
##**************************************************************************
##**************************************************************************
#a)
# estimated ATE of providing a bin = 0.187
# std err = .032
# 95% interval, z value of 1.96
# 0.187 +/- 1.96*(0.032)
# 95% confidence interval is:
# min = .12428
# max = .24972

# #b)
# estimated ATE of a text msg = -0.024
# std err = 0.039
# 95% interval, z value of 1.96
# -0.024 +/- 1.96*(0.039)
# min = -0.10044	
# max = 0.05244

#c)
# 4 out of the 5 effects are significant at the 1% level, so implied they are significant at the 5% (lower) level
# the effects are:
# Percentage of visits turned in bag
# Avg. no. of bins turned in per week
# Avg. weight (in kg) of recyclables turned in per week
# Avg. market value of recyclables given per week

#d)
# No outcome measures show statistically significant effects of sending a text message - at any level of significance

#e)
# It would depend on the number of bins that each family turned in per week. e.g. was the 2 lbs in one bin or 2 bins?
# Increase in recyclables is measured in lbs per bin. Need more information to answer this. 

#f)
# If the baseline was left out of the regression (in other words if the baseline was zero) , the effect of  
# providing a bin would appear to be higer and the effect would appear to include the baseline 
# (.374 + .045 = .419). 
# So the ATE itself would wrongly appear to be the total amount recycled when having a bin,  
# rather than just the increased effect of a bin.(i.e. ATE would appear to be very high.)
# The standard error would also increase since it would be across total recycling (zero to .419), 
#  not across the smaller "treatment effect" of having a bin, which is 0.045

#g) 
# "Has cell phone" is an important control because the study is measuring people's tendency to act 
# on a messages they have received. If a person can't receive the message there is no chance they can act. 
# However a better control would be 'can receive SMS messages' and/or 'can head of household receive SMS msgs'

#h)
# If 'has cell phone' was removed, we would expect the coefficient for SMS messaging to drop, because  
# messaging itself has a very slight positive effect. 
# To combine all those who get messages (slight positive)
# with all those who don't get messages, the total effect/coefficient would be diluted/decreaed. 

##********************************************************************************
##********************************************************************************

# Problem 3
#a) 
#On table 4B Bin dimensions = 2, SMS dimensions = 2, has cell phone = 1
# adding null values for them all, yields a fully saturated model:
# Bin dimensions: 3 (no bin, bin, bin with sticker)
# Sms dimensions: 3 (no message, personal msg, generic msg)
# 2 additional dimensions for no phone : (bin, bin with sticker)
# Full dimensions : 3 * 3 = 9 + 2 additional for no phone == 11 dimensions

#b) 
# the baseline category are people who may/may not have a cell phone but who have not been treated 
# in any way: haven't received a bin/ bin with sticker/personal or generic sms. It is the control group. 

#c)
# The magnitude of coefficient for bin without sticker is 0.035. It means that people who received a bin 
# without a sticker increased the percentage of times during a visit that they turned in a recycling bag by 3.5%.
# The baseline is 0.374 (34.7%) so we would expect these people, under this treatment, to turn in a bag 
# 34.7 + 3.5 = 38.2% of the time. 

#d)
# Bin with sticker has a larger treatment effect at 0.055. This is 2 percentage points higher than
# bin with no sticker at 0.035.

#e) 
# The difference in the effect between bin and bin with label is not statistically significant, 
# based on the F-test  p-value at the bottom of the column. 
# P-value should be 0.05 or less for significance. 

#f) 
# The model is fully saturated because it presents all permutations of the dimensions described in part a) above