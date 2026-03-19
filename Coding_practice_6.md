# Libraries

``` r
library(ggplot2)
library(drc)
```

    ## Loading required package: MASS

    ## 
    ## 'drc' has been loaded.

    ## Please cite R and 'drc' if used for a publication,

    ## for references type 'citation()' and 'citation('drc')'.

    ## 
    ## Attaching package: 'drc'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     gaussian, getInitial

``` r
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.6
    ## ✔ forcats   1.0.1     ✔ stringr   1.6.0
    ## ✔ lubridate 1.9.4     ✔ tibble    3.3.1
    ## ✔ purrr     1.2.1     ✔ tidyr     1.3.2

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ✖ dplyr::select() masks MASS::select()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

# Functions

Functions are useful to simplify your code, and make your data
management as reproducible as possible.

To make a function to convert Fahrenheit to Celsius:

(º𝐹−32)∗59

So if we input 32 degrees Fahrenheit that would equal 0.

``` r
(5*(32 - 32)/9)
```

    ## [1] 0

But now we want to input a different number, say 80ºF and we have to
copy and paste the formula below or overwrite what we just wrote. This
is not very reproducible because it is susceptible to copy and paste
errors.

``` r
(5*(80 - 32)/9)
```

    ## [1] 26.66667

We can solve this by converting it to a function.

``` r
F_to_C <- function(fahrenheit_temp){
  celsius <- (5*(fahrenheit_temp - 32)/9)
  return(celsius)
}

# these do the same thing
F_to_C(32)
```

    ## [1] 0

We first start with naming the function something using the backwards
arrow. Then we type “function()”.

After opening a new function we type the curly brackets. We will type
the code we want to perform within the curly brackets.

Inside the parentheses after function is where we put our variables
separated by commas.

To write a function to convert celsius to fahrenheiht using the
conversion of F = C x (9/5)+32:

``` r
C_to_F <- function(celcius_temp){
  fahrenheit <- (9*(celcius_temp + 32)/5)
  return(fahrenheit)
}

C_to_F(32)
```

    ## [1] 115.2

# Iterations

Iterations are something you do over and over again.

## The rep() function

The rep() function allows you to repeat elements easily.

``` r
rep("A", 3) # repeats A three times 
```

    ## [1] "A" "A" "A"

``` r
rep(c("A", "B"), 5) # repeats A and B, times 
```

    ##  [1] "A" "B" "A" "B" "A" "B" "A" "B" "A" "B"

``` r
rep(c(1,2,3,4), times = 4) # repeats 1,2,3,4, 4 times 
```

    ##  [1] 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4

``` r
rep(c(1,2,5,2), times = 4, each = 4) # repeats 1 four times, 2 four times, 5 four times, and 2 four times. 
```

    ##  [1] 1 1 1 1 2 2 2 2 5 5 5 5 2 2 2 2 1 1 1 1 2 2 2 2 5 5 5 5 2 2 2 2 1 1 1 1 2 2
    ## [39] 2 2 5 5 5 5 2 2 2 2 1 1 1 1 2 2 2 2 5 5 5 5 2 2 2 2

## The seq() command

The seq() command allows you to write sequences of numbers easily.

``` r
seq(from = 1, to = 7) # sequence of numbers 1 to 7
```

    ## [1] 1 2 3 4 5 6 7

``` r
seq(from = 0, to = 10, by = 2) # sequence of numbers from 0 to 10 by 2s 
```

    ## [1]  0  2  4  6  8 10

``` r
# combined seq() and rep()
rep(seq(from = 0, to = 10, by = 2), times = 3, each = 2)
```

    ##  [1]  0  0  2  2  4  4  6  6  8  8 10 10  0  0  2  2  4  4  6  6  8  8 10 10  0
    ## [26]  0  2  2  4  4  6  6  8  8 10 10

## The seq_along() function

The seq_along() function allows you to generate a sequence of numbers
based on non-integer values. This will become very useful when we want
to loop over elements within a dataframe.

``` r
# use the built in LETTERS vector for an example. 
LETTERS
```

    ##  [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S"
    ## [20] "T" "U" "V" "W" "X" "Y" "Z"

``` r
seq_along(LETTERS[1:5]) # will return 1,2,3,4,5 not the actual letters. 
```

    ## [1] 1 2 3 4 5

## The for loop

Lets see a very basic example of how a for loop works.

``` r
for (i in 1:10) {
print(i*2)  
}
```

    ## [1] 2
    ## [1] 4
    ## [1] 6
    ## [1] 8
    ## [1] 10
    ## [1] 12
    ## [1] 14
    ## [1] 16
    ## [1] 18
    ## [1] 20

Lets see a more complicated example where we can also use our functions
in a loop for example.

``` r
for (i in -30:100){
  result <- F_to_C(i)
  print(result)
}
```

    ## [1] -34.44444
    ## [1] -33.88889
    ## [1] -33.33333
    ## [1] -32.77778
    ## [1] -32.22222
    ## [1] -31.66667
    ## [1] -31.11111
    ## [1] -30.55556
    ## [1] -30
    ## [1] -29.44444
    ## [1] -28.88889
    ## [1] -28.33333
    ## [1] -27.77778
    ## [1] -27.22222
    ## [1] -26.66667
    ## [1] -26.11111
    ## [1] -25.55556
    ## [1] -25
    ## [1] -24.44444
    ## [1] -23.88889
    ## [1] -23.33333
    ## [1] -22.77778
    ## [1] -22.22222
    ## [1] -21.66667
    ## [1] -21.11111
    ## [1] -20.55556
    ## [1] -20
    ## [1] -19.44444
    ## [1] -18.88889
    ## [1] -18.33333
    ## [1] -17.77778
    ## [1] -17.22222
    ## [1] -16.66667
    ## [1] -16.11111
    ## [1] -15.55556
    ## [1] -15
    ## [1] -14.44444
    ## [1] -13.88889
    ## [1] -13.33333
    ## [1] -12.77778
    ## [1] -12.22222
    ## [1] -11.66667
    ## [1] -11.11111
    ## [1] -10.55556
    ## [1] -10
    ## [1] -9.444444
    ## [1] -8.888889
    ## [1] -8.333333
    ## [1] -7.777778
    ## [1] -7.222222
    ## [1] -6.666667
    ## [1] -6.111111
    ## [1] -5.555556
    ## [1] -5
    ## [1] -4.444444
    ## [1] -3.888889
    ## [1] -3.333333
    ## [1] -2.777778
    ## [1] -2.222222
    ## [1] -1.666667
    ## [1] -1.111111
    ## [1] -0.5555556
    ## [1] 0
    ## [1] 0.5555556
    ## [1] 1.111111
    ## [1] 1.666667
    ## [1] 2.222222
    ## [1] 2.777778
    ## [1] 3.333333
    ## [1] 3.888889
    ## [1] 4.444444
    ## [1] 5
    ## [1] 5.555556
    ## [1] 6.111111
    ## [1] 6.666667
    ## [1] 7.222222
    ## [1] 7.777778
    ## [1] 8.333333
    ## [1] 8.888889
    ## [1] 9.444444
    ## [1] 10
    ## [1] 10.55556
    ## [1] 11.11111
    ## [1] 11.66667
    ## [1] 12.22222
    ## [1] 12.77778
    ## [1] 13.33333
    ## [1] 13.88889
    ## [1] 14.44444
    ## [1] 15
    ## [1] 15.55556
    ## [1] 16.11111
    ## [1] 16.66667
    ## [1] 17.22222
    ## [1] 17.77778
    ## [1] 18.33333
    ## [1] 18.88889
    ## [1] 19.44444
    ## [1] 20
    ## [1] 20.55556
    ## [1] 21.11111
    ## [1] 21.66667
    ## [1] 22.22222
    ## [1] 22.77778
    ## [1] 23.33333
    ## [1] 23.88889
    ## [1] 24.44444
    ## [1] 25
    ## [1] 25.55556
    ## [1] 26.11111
    ## [1] 26.66667
    ## [1] 27.22222
    ## [1] 27.77778
    ## [1] 28.33333
    ## [1] 28.88889
    ## [1] 29.44444
    ## [1] 30
    ## [1] 30.55556
    ## [1] 31.11111
    ## [1] 31.66667
    ## [1] 32.22222
    ## [1] 32.77778
    ## [1] 33.33333
    ## [1] 33.88889
    ## [1] 34.44444
    ## [1] 35
    ## [1] 35.55556
    ## [1] 36.11111
    ## [1] 36.66667
    ## [1] 37.22222
    ## [1] 37.77778

This was great, but this only printed to the console, and we cannot
really do anything with those values. What if we wanted to do something
with the result of the iteration?

Step 1. Set a R object to NULL

Step 2. Set your for loop

Step 3. Save the result of your for loop into a dataframe each iteration

Step 4. append one row of the dataframe to the null object each
iteration of the loop.

``` r
celcius.df <- NULL 
for (i in -30:100){   
result_i <- data.frame(F_to_C(i), i)   
celcius.df <- rbind.data.frame(celcius.df, result_i) 
}
```
