# You are an employee of a newspaper and are planning an experiment to demonstrate to Apple that 
# online advertising on your website causes people to buy iPhones. Each site visitor shown 
# the ad campaign is exposed to $0.10 worth of advertising for iPhones. (Assume all users could see ads.) 
# There are 1,000,000 users available to be shown ads on your newspaper's 
# website during the one week campaign. 
# Apple indicates that they make a profit of $100 every time an iPhone sells and 
# that 0.5% of visitors to your newspaper's website buy an iPhone in a given week in general, 
# in the absence of any advertising.

#Apple pays:
#ad cost is 0.10 per person
#1m users on website in one week
#Cost of ad campaign = 1m * .1 = $100,000

# $100 profit per phone
# half a percent of site visitors buy an iphone each week or 5000 phones (== 1m * 0.005)
# Base profit is ($100/phone * 5000 phones =) $500,000 in a  week

#need to sell $100,000 (cost of campaign) / $100 (profit on each phone)
# == 1000 additional iphones in campaign

######################Part a)
# By how much does the ad campaign need to increase the probability of purchase in order 
# to be "worth it" and a positive ROI (supposing there are no long-run effects and
# all the effects are measured within that week)?

#Base probability of purchase is .005
#Required probability of purchase is .006
#Increase in probability of purchase is 20%

######################Part b) 
# Assume the measured effect is 0.2 percentage points. If users are split 50:50 
# between the treatment group (exposed to iPhone ads) and control group 
# (exposed to unrelated advertising or nothing; something you can assume has no effect), 
# what will be the confidence interval of your estimate on whether people purchase the phone?

# The observed effect is 0.2 percentage points (200 basis points)
# == 5 additional phones sold in treatment group, see below for methodology
# split 1 million people 50:50
# therefore n1 and n2 are both 500,000
# base purchase probability is half of 1 percent or 2500 phones for control group
# X1 = 2500
# treatment group has .2 percentage point increase in phone purchases 
  # == 2500 * .002 = 5 additional phones. 
  # X2 = 2505

#variables: n1, n2 = 500,000 
# x1 = 2500
# x2 = 2505

#== sqrt (  ((2500+2505)/1,000,000) * (1 - ((2500+2505)/1,000,000)) * ((1/500,000) + (1/500,000))  )
#== sqrt ( (.005005)*(.994995)*(.000004) )
# == .00014
# 95% confidence interval would be .00014 * 1.96 = .00028
# Therfore we have 95% confidence the number of phones sold would be between
# 5.00028 and 4.99972



########################Part c)

# Is this confidence interval precise enough that you would recommend running this experiment? Why or why not?

# The confidence interval can be calculated accurately, but it's not a 
# useful metric when studying a treatment effect of 0.2 percent (200 basis points) 
# on a baseline purchase that is only half a percent of the population itself. 
# Therefore I'm not confident that it makes sense to calculate a confidence interval 
# in this context.

######################Part d)
#Your boss at the newspaper, worried about potential loss of revenue, says he is not willing to 
# hold back a control group any larger than 1% of users. What would be the width of the confidence 
#interval for this experiment if only 1% of users were placed in the control group?

#== sqrt (  ((50+4960)/1,000,000) * (1 - ((50+4960)/1,000,000)) * ((1/10,000) + (1/990,000))  )
#== sqrt ( (.00501)*(.99499)*(.000101) )
#== .00071
# 95% confidence interval would be .00071 * 1.96 = .001391
# Therfore we have 95% confidence the number of phones sold would be between
# 9.998609 and 10.00139
# The confidence interval increased on each side by .0011, not very much at all. 


