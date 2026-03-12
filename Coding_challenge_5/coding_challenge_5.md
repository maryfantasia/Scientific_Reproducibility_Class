# Question 1

Download two .csv files from Canvas called DiversityData.csv and
Metadata.csv, and read them into R using relative file paths.

``` r
library(tidyverse)
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
library(dplyr)
library(tidyr)
library(ggplot2)

DiversityData <- read.csv("DiversityData.csv")
str(DiversityData)
```

    ## 'data.frame':    70 obs. of  5 variables:
    ##  $ Code      : chr  "S01_13" "S02_16" "S03_19" "S04_22" ...
    ##  $ shannon   : num  6.62 6.61 6.66 6.66 6.61 ...
    ##  $ invsimpson: num  211 207 213 205 200 ...
    ##  $ simpson   : num  0.995 0.995 0.995 0.995 0.995 ...
    ##  $ richness  : int  3319 3079 3935 3922 3196 3481 3250 3170 3657 3177 ...

``` r
Metadata <- read.csv("Metadata.csv")
str(Metadata)
```

    ## 'data.frame':    70 obs. of  5 variables:
    ##  $ Code         : chr  "S01_13" "S02_16" "S03_19" "S04_22" ...
    ##  $ Crop         : chr  "Soil" "Soil" "Soil" "Soil" ...
    ##  $ Time_Point   : int  0 0 0 0 0 0 6 6 6 6 ...
    ##  $ Replicate    : int  1 2 3 4 5 6 1 2 3 4 ...
    ##  $ Water_Imbibed: chr  "na" "na" "na" "na" ...

# Question 2

Join the two dataframes together by the common column ‘Code’. Name the
resulting dataframe alpha.

``` r
alpha <- DiversityData %>%
  left_join(Metadata, by = "Code")
```

# Question 3

## Calculate Pielou’s evenness index: Pielou’s evenness is an ecological parameter calculated by the Shannon diversity index (column Shannon) divided by the log of the richness column.

A. Using mutate, create a new column to calculate Pielou’s evenness
index. B. Name the resulting dataframe alpha_even.

``` r
head(mutate(alpha, alpha_even = log(richness)))
```

    ##     Code  shannon invsimpson   simpson richness Crop Time_Point Replicate
    ## 1 S01_13 6.624921   210.7279 0.9952545     3319 Soil          0         1
    ## 2 S02_16 6.612413   206.8666 0.9951660     3079 Soil          0         2
    ## 3 S03_19 6.660853   213.0184 0.9953056     3935 Soil          0         3
    ## 4 S04_22 6.660671   204.6908 0.9951146     3922 Soil          0         4
    ## 5 S05_25 6.610965   200.2552 0.9950064     3196 Soil          0         5
    ## 6 S06_28 6.650812   199.3211 0.9949830     3481 Soil          0         6
    ##   Water_Imbibed alpha_even
    ## 1            na   8.107419
    ## 2            na   8.032360
    ## 3            na   8.277666
    ## 4            na   8.274357
    ## 5            na   8.069655
    ## 6            na   8.155075

# Question 4

## Using tidyverse language of functions and the pipe, use the summarise function and tell me the mean and standard error evenness grouped by crop over time.

A. Start with the alpha_even dataframe B. Group the data: group the data
by Crop and Time_Point. C. Summarize the data: Calculate the mean,
count, standard deviation, and standard error for the even variable
within each group. D. Name the resulting dataframe alpha_average

``` r
alpha_average <- alpha %>%                              # THIS CODE WAS WRITTEN WITH HELP FROM COPILOT.
  select(Code, Crop, Time_Point, richness) %>%          # select just what you need
  mutate(alpha_even = log(richness)) %>%                # create the log-evenness column
  group_by(Crop, Time_Point) %>%                        # group by crop over time
  summarise(
    n         = sum(!is.na(alpha_even)),                # count of non-missing values
    mean_even = mean(alpha_even, na.rm = TRUE),         # mean
    sd_even   = sd(alpha_even, na.rm = TRUE),           # standard deviation
    se_even   = sd_even / sqrt(n),                      # standard error
    .groups   = "drop"
  )
alpha_average
```

    ## # A tibble: 12 × 6
    ##    Crop    Time_Point     n mean_even sd_even se_even
    ##    <chr>        <int> <int>     <dbl>   <dbl>   <dbl>
    ##  1 Cotton           0     6      8.09  0.0777  0.0317
    ##  2 Cotton           6     6      8.08  0.107   0.0439
    ##  3 Cotton          12     6      7.99  0.0476  0.0194
    ##  4 Cotton          18     5      7.93  0.188   0.0839
    ##  5 Soil             0     6      8.15  0.104   0.0424
    ##  6 Soil             6     6      8.06  0.0925  0.0378
    ##  7 Soil            12     6      8.01  0.0859  0.0351
    ##  8 Soil            18     5      7.87  0.125   0.0561
    ##  9 Soybean          0     6      8.08  0.0546  0.0223
    ## 10 Soybean          6     6      7.95  0.109   0.0445
    ## 11 Soybean         12     6      7.91  0.101   0.0413
    ## 12 Soybean         18     6      7.82  0.117   0.0478

# Question 5

## Calculate the difference between the soybean column, the soil column, and the difference between the cotton column and the soil column

A. Start with the alpha_average dataframe B. Select relevant columns:
select the columns Time_Point, Crop, and mean.even. C. Reshape the data:
Use the pivot_wider function to transform the data from long to wide
format, creating new columns for each Crop with values from mean.even.
D. Calculate differences: Create new columns named diff.cotton.even and
diff.soybean.even by calculating the difference between Soil and Cotton,
and Soil and Soybean, respectively. E. Name the resulting dataframe
alpha_average2

``` r
alpha_average2 <- alpha_average %>% #THIS CODE WAS WRItTEN WITH HELP FROM COPILOT.
  # B) Select relevant columns (supports either mean_even or mean.even)
  select(Time_Point, Crop, any_of(c("mean_even", "mean.even"))) %>%
  # Standardize the mean column name to mean_even for the rest of the pipeline
  rename(mean_even = any_of(c("mean_even", "mean.even"))) %>%
  # C) Go from long (one row per Crop) to wide (one column per Crop)
  pivot_wider(
    names_from  = Crop,
    values_from = mean_even
  ) %>%
  # D) Compute differences (Soil − Cotton, Soil − Soybean)
  mutate(
    diff.cotton.even  = Soil - Cotton,
    diff.soybean.even = Soil - Soybean
  )
alpha_average2
```

    ## # A tibble: 4 × 6
    ##   Time_Point Cotton  Soil Soybean diff.cotton.even diff.soybean.even
    ##        <int>  <dbl> <dbl>   <dbl>            <dbl>             <dbl>
    ## 1          0   8.09  8.15    8.08           0.0623            0.0685
    ## 2          6   8.08  8.06    7.95          -0.0197            0.108 
    ## 3         12   7.99  8.01    7.91           0.0220            0.0994
    ## 4         18   7.93  7.87    7.82          -0.0525            0.0501

# Question 6

## Connecting it to plots

A. Start with the alpha_average2 dataframe B. Select relevant columns:
select the columns Time_Point, diff.cotton.even, and diff.soybean.even.
C. Reshape the data: Use the pivot_longer function to transform the data
from wide to long format, creating a new column named diff that contains
the values from diff.cotton.even and diff.soybean.even. D. Create the
plot: Use ggplot and geom_line() with ‘Time_Point’ on the x-axis, the
column ‘values’ on the y-axis, and different colors for each ‘diff’
category. The column named ‘values’ come from the pivot_longer.

``` r
# THIS CODE WAS WRITTEN WITH HELP FROM COPILOT
plot_data <- alpha_average2 %>%
  select(Time_Point, diff.cotton.even, diff.soybean.even) %>%
  pivot_longer(c(diff.cotton.even, diff.soybean.even),names_to = "diff", values_to ="values") %>%
  mutate(Time_Point = suppressWarnings(as.numeric(Time_Point)))
plot_data
```

    ## # A tibble: 8 × 3
    ##   Time_Point diff               values
    ##        <dbl> <chr>               <dbl>
    ## 1          0 diff.cotton.even   0.0623
    ## 2          0 diff.soybean.even  0.0685
    ## 3          6 diff.cotton.even  -0.0197
    ## 4          6 diff.soybean.even  0.108 
    ## 5         12 diff.cotton.even   0.0220
    ## 6         12 diff.soybean.even  0.0994
    ## 7         18 diff.cotton.even  -0.0525
    ## 8         18 diff.soybean.even  0.0501

``` r
ggplot(plot_data, aes(x = Time_Point, y = values, color = diff, group = diff)) +
  geom_line(linewidth = 1) +         # the requested line plot
  geom_point(size = 2) +             # optional: shows points at each time
  labs(
    x = "Time Point",
    y = "Difference in Mean Log Evenness",
    color = "Difference Type",
    title = "Differences in Evenness Over Time"
  )
```

![](coding_challenge_5_files/figure-gfm/Plotting%20the%20data-1.png)<!-- -->

# Github link

Here is a link to my Github where this is in the coding_challenge_5
directory

<https://github.com/maryfantasia/Scientific_Reproducibility_Class>
