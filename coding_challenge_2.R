#### Question 1 ####
# 3 elements are needed to produce a ggplot:
## data, aesthetics (aes()), and geometry (geom_) 
# a geom defines a layer of the plot, like a line or bar
## example: geom_point()
# a facet specififies which parts of the data to compare
## facet_wrap()
# layering is adding more and more detail to your plot with each line of code
## adding color, points, lines, confidence intervals
# to add x and y variables and map different shapes, colors, and other attributes to the data:
## add to the first like of code for the plot (ggplot(data, aes(x,y,), color)) followed by specifics

#### Question 2 ####
# Make a boxplot using ggplot with DON as the y variable, treatment as the x variable, 
# and color mapped to the wheat cultivar. Change the y label to “DON (ppm)” and make the x label blank

library (tidyverse)
library (ggplot2)

don.concetration <- read.csv("MycotoxinData.csv", na.strings="na")

ggplot(don.concetration, aes(x = Treatment, y = DON, color = Cultivar)) +
  geom_boxplot() +
  xlab("") +
  ylab ("DON (ppm)")

#### Question 3 ####
# Now convert this data into a bar chart with standard-error error bars using the stat_summary() command

ggplot(don.concetration, aes(x = Treatment, y = DON, color = Cultivar)) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge")
  
#### Question 4 ####
# Add points to the foreground of the boxplot and bar chart you made in questions 2 & 3 
# that show the distribution of points. Set the shape = 21 and the outline color black 

ggplot(don.concetration, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot() +
  xlab("") +
  ylab ("DON (ppm)") +
  geom_point(position = position_jitterdodge()) +  
  geom_point(shape = 21) +
  scale_fill_manual(values = c("pink", "red")) +
  scale_color_manual(values = c("black", "black")) 

#### Question 5 ####
# . Add a facet to the plots based on cultivar

ggplot(don.concetration, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot() +
  xlab("") +
  ylab ("DON (ppm)") +
  geom_point(position = position_jitterdodge()) +  
  geom_point(shape = 21) +
  scale_fill_manual(values = c("pink", "red")) +
  scale_color_manual(values = c("black", "black")) +
  facet_wrap(~Cultivar, scales = "free")  

#### Question 6 ####
# Add transparency to the points so you can still see the boxplot or bar in the background
ggplot(don.concetration, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot() +
  xlab("") +
  ylab ("DON (ppm)") +
  geom_point(position = position_jitterdodge()) +  
  geom_point(shape = 21, alpha = 0.5) +
  scale_fill_manual(values = c("pink", "red")) +
  scale_color_manual(values = c("black", "black")) +
  facet_wrap(~Cultivar, scales = "free")  


  





