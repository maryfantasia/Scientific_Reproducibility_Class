here is a link to my github repository for this challenge

[github](https://github.com/maryfantasia/Scientific_Reproducibility_Class/tree/main/Coding_chalenge_4)

# Question 1

### A YAMIL header displays the title of the Rmarkdown, the author of the document, the date it was last edited, and the output documents it will create.

the YAMIL header for the document looks like:

``` r
---
title: "Coding Challenge 4"
author: "Mary Fantasia"
date: "2026-02-19"
output: 
  md_document:
    variant: gfm
  html_document:
    toc: true
---
```

### Literate programming is a key player in reproducible code.

includes annotating code, using programming settings to make the
document easy to read

# Question 2

### Adding code to the document is easy, just add a code chunk

[Link to
data](Noel,%20Z.A.,%20Roze,%20L.V.,%20Breunig,%20M.,%20Trail,%20F.%202022.%20Endophytic%20fungi%20as%20promising%20biocontrol%20agent%20to%20protect%20wheat%20from%20Fusarium%20graminearum%20head%20blight.%20Plant%20Disease.%20https://doi.org/10.1094/PDIS-06-21-1253-RE)

### Code chunk 1

``` r
library (tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.6
    ## ✔ forcats   1.0.1     ✔ stringr   1.6.0
    ## ✔ ggplot2   4.0.1     ✔ tibble    3.3.1
    ## ✔ lubridate 1.9.4     ✔ tidyr     1.3.2
    ## ✔ purrr     1.2.1     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library (ggplot2)
library(ggpubr)
library(ggrepel)

don.concentration <- read.csv("MycotoxinData.csv", na.strings="na")
```

### Code chunk 2

``` r
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
```

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).
    ## Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](Coding_challenge_4_files/figure-gfm/Plot%20DON%20data-1.png)<!-- -->

``` r
don.concentration$Treatment <- as.factor(don.concentration$Treatment)
don.concentration$Treatment <- factor(don.concentration$Treatment, levels = c("NTC", "Fg", "Fg + 37", "Fg + 40", "Fg + 70"))
```

### Code chunk 3

``` r
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
```

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 10 rows containing missing values or values outside the scale range
    ## (`geom_point()`).
    ## Removed 10 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](Coding_challenge_4_files/figure-gfm/Plot%2015ADON%20data-1.png)<!-- -->

### Code chunk 4

``` r
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
```

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 2 rows containing missing values or values outside the scale range
    ## (`geom_point()`).
    ## Removed 2 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](Coding_challenge_4_files/figure-gfm/Plot%20seed%20mass%20data-1.png)<!-- -->

### Code chunk 5

``` r
# figure 1a
don.t.test <- don.treatment +
  geom_pwc(aes(group = Treatment), method = "t_test", label = "p.adj.format")
don.t.test
```

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).
    ## Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](Coding_challenge_4_files/figure-gfm/Add%20t-test%20to%20all%20data-1.png)<!-- -->

``` r
# figure 1b
x15adon.t.test <- x15adon.effect +
  geom_pwc(aes(group = Treatment), method = "t_test", label = "p.adj.format")
x15adon.t.test
```

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 10 rows containing missing values or values outside the scale range
    ## (`geom_point()`).
    ## Removed 10 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](Coding_challenge_4_files/figure-gfm/Add%20t-test%20to%20all%20data-2.png)<!-- -->

``` r
# figure 1c
seed.mass.t.test <- seed.mass.effect +
  geom_pwc(aes(group = Treatment), method = "t_test", label = "p.adj.format")
seed.mass.t.test
```

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 2 rows containing missing values or values outside the scale range
    ## (`geom_point()`).
    ## Removed 2 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](Coding_challenge_4_files/figure-gfm/Add%20t-test%20to%20all%20data-3.png)<!-- -->

### Code chunk 6

``` r
figure1 <- ggarrange(
  don.t.test,
  x15adon.t.test,
  seed.mass.t.test,
  labels = "auto",
  nrow = 1, 
  ncol = 3,  
  common.legend = T
)
```

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).
    ## Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 8 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).
    ## Removed 8 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 10 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 10 rows containing missing values or values outside the scale range
    ## (`geom_point()`).
    ## Removed 10 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 2 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 2 rows containing missing values or values outside the scale range
    ## (`geom_point()`).
    ## Removed 2 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

``` r
figure1
```

![](Coding_challenge_4_files/figure-gfm/Combining%20all%20plots%20into%20one-1.png)<!-- -->
