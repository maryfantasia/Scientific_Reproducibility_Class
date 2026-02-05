## load packages
library (tidyverse)
library (ggplot2)

#### Car Data ####

## load data
mtcars #data frame in R

## plot data (line over points)
ggplot(mtcars, aes(x=wt, y=mpg)) +         #add x & y axis
  geom_point() +                           #add points on plot
  geom_smooth(method = lm, se = FALSE)     #add line through points, remove confidence interval

## plot data (points over line {layering}) 
ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_smooth(method = lm, se = FALSE) +
  geom_point() +
  xlab("Weight (tons)") +                  #change name of x axis
  ylab ("Miles per gallon")                #change name of y axis

## plot data with size range (manipulating point size AND line size)
ggplot(mtcars, aes(x=wt, y=mpg, size = wt)) +
  geom_smooth(method = lm, se = FALSE) +
  geom_point() +
  xlab("Weight (tons)") + 
  ylab ("Miles per gallon")

## plot data with size range (manipulating point size only)
ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_smooth(method = lm, se = FALSE) +
  geom_point(aes(size = wt)) +
  xlab("Weight (tons)") + 
  ylab ("Miles per gallon")

## add a color gradient
ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_smooth(method = lm, se = FALSE) +
  geom_point(aes(color = hp, size = hp)) +
  xlab("Weight (tons)") + 
  ylab ("Miles per gallon") +
  scale_color_gradient(low = "green", high = "yellow")


#### Bull Data ####

## load data
bull.richness <- read.csv("Bull_richness.csv")


## plot data (BOX PLOT)
ggplot(bull.richness, aes(x = GrowthStage, y = richness, color = Fungicide)) +
  geom_boxplot()

## i dont like the color, but i want to add points to the plot
ggplot(bull.richness, aes(x = GrowthStage, y = richness)) +
  geom_boxplot() +
  geom_point(position = position_jitterdodge())     #this adds points to the plot

## okay i need the color and the points
ggplot(bull.richness, aes(x = GrowthStage, y = richness, fill = Fungicide, color = Crop)) +
  geom_boxplot() +
  geom_point(position = position_jitterdodge()) +  
  scale_fill_manual(values = c("pink", "red")) +     #this adds color fill in the boxes
  scale_color_manual(values = c("orange", "brown"))  #this adds colorful outline on the boxes


## plot bar chart of mean with standard error
ggplot(bull.richness, aes(x = GrowthStage, y = richness, fill = Fungicide)) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +                    #plots mean bars
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") +       #adds standard error
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = "dodge")  #add confidence interval (you dont need both se and ci)


## facetting
ggplot(bull.richness, aes(x = GrowthStage, y = richness, group = Fungicide, color = Fungicide)) +
  stat_summary(fun = mean, geom = "line") +
  stat_summary(fun.data = mean_cl_normal, geom = "errorbar") +
  facet_wrap(~Treatment*Crop, scales = "free")     #look at crops per treatment and auto scales plots







