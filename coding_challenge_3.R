library (tidyverse)
library (ggplot2)
library(ggpubr)
library(ggrepel)


don.concentration <- read.csv("MycotoxinData.csv", na.strings="na")


#### Question 1 #####
# create a boxplot of DON by Treatment

don.treatment <- ggplot(don.concentration, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot() +
  xlab("") +
  ylab ("DON (ppm)") +
  geom_point(position = position_jitterdodge()) +  
  geom_point(shape = 21, alpha = 0.6) +
  scale_fill_manual(values = c("#CC79A7", "#009E73")) +
  scale_color_manual(values = c("#000000", "#000000")) +
  facet_wrap(~Cultivar, scales = "free")  
don.treatment
#### Question 2 ####

don.concentration$Treatment <- as.factor(don.concentration$Treatment)
don.concentration$Treatment <- factor(don.concentration$Treatment, levels = c("NTC", "Fg", "Fg + 37", "Fg + 40", "Fg + 70"))


#### Question 3 ####
# create boxplot for 15ADON by treatment
x15adon.effect <- ggplot(don.concentration, aes(x = Treatment, y = X15ADON, color = Cultivar, fill = Cultivar)) +
  geom_boxplot() +
  xlab("") +
  ylab ("15ADON") +
  geom_point(position = position_jitterdodge()) +  
  geom_point(shape = 21, alpha = 0.6) +
  scale_fill_manual(values = c("#CC79A7", "#009E73")) +
  scale_color_manual(values = c("#000000", "#000000")) +
  facet_wrap(~Cultivar, scales = "free") 
x15adon.effect

# create a boxplot for seed mass by treatment
seed.mass.effect <- ggplot(don.concentration, aes(x = Treatment, y = MassperSeed_mg, color = Cultivar, fill = Cultivar)) +
  geom_boxplot() +
  xlab("") +
  ylab ("Seed Mass (mg)") +
  geom_point(position = position_jitterdodge()) +  
  geom_point(shape = 21, alpha = 0.6) +
  scale_fill_manual(values = c("#CC79A7", "#009E73")) +
  scale_color_manual(values = c("#000000", "#000000")) +
  facet_wrap(~Cultivar, scales = "free") 
seed.mass.effect


#### Question 4 ####
# arrange all figures into one

figure1 <- ggarrange(
  don.treatment,
  x15adon.effect,
  seed.mass.effect,
  labels = "auto",
  nrow = 1, 
  ncol = 3,  
  common.legend = T
)

figure1
  

#### Question 5 ####
## add t-test to each plot

# figure 1a
don.t.test <- don.treatment +
  geom_pwc(aes(group = Treatment), method = "t_test", label = "p.adj.format")
don.t.test

# figure 1b
x15adon.t.test <- x15adon.effect +
  geom_pwc(aes(group = Treatment), method = "t_test", label = "p.adj.format")
x15adon.t.test

# figure 1c
seed.mass.t.test <- seed.mass.effect +
  geom_pwc(aes(group = Treatment), method = "t_test", label = "p.adj.format")
seed.mass.t.test

# put the new plots together

figure2 <- ggarrange(
  don.t.test,
  x15adon.t.test,
  seed.mass.t.test,
  labels = "auto",
  nrow = 1, 
  ncol = 3,  
  common.legend = T
)

figure2
