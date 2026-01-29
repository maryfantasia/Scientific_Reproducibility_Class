# this comment gets skipped

#### this section is collapsable ####
#this comment can hide

# case sensitive, X does not equal x

#### Learning Objectives ####
# Use basic mathematical operators in R
# Know some of the data types
# Install packages
# Load data into R from .csv or .txt files

#### Exercise One ####
# R is a big calculator
2+2
2-2
2/2
2*2


#### Exercise Two ####
# Objects

#numeric variables
x <- 2
y = 3

x + y
x - y
x/y
x * y

#character variables
name <- "Mary"
seven <- "7"

# let's try to combine them
x + seven

# error since one is numeric and one is character
# fix it with this

seven <- 7

x + seven

#### Exercise 3 ####
# Functions

# can also double check using class function
class(seven)
class(x)

#Concatinate function
vec <- c(1, 2, 3, 4, 5, 6, 7)
vec1 <- c(1:7)
vec <- 1:7
vec2 <- c("Mary","Jack", "Hannah")
vec3 <- c(TRUE, FALSE, TRUE)

vec[4]
vec2[2]

vec + 2

# Basic functions in R
vec
mean(vec)
sd(vec)
median(vec)
min(vec)
max(vec)
summary(vec)
abs(vec)
sqrt(vec)
sqrt(sum(vec))
log(vec) #natural log
log10(vec)
exp(vec)

#### Exercise 4 ####
# Logical Operators

# > greater than
# < less than
# | or
# & and
# = equals (used to assign values from left to right)
# == exactly equal to (used for showing equality between values)
# >= greater than or equal to
# != not equal to

1 > 2
1 < 2
1 >= 2
1 == 1 #asking if 1 is equal to 1
1 = 1 #does not work

t <- 1:10

# values of t such that t is greater than 8 or less than 5
t[(t > 8) | (t < 5)]

# values of t such that t is greater than 8 and less than 10
t[(t > 8) & (t < 10)]

# elements of t that are not exactly equal to 2
t[t != 2]

# ask R if a number exists in a vector
2 %in% t
32 %in% t


#### Exercise 5 ####
# Data Types

# scholar objects
x

# vectors
t

# matrix
##numeric matrix
mat1 <- matrix(data = c(1, 2, 3), nrow = 3, ncol = 3)

##character matrix
mat2 <- matrix(data = c("Mary", "Jack", "Hannah"), nrow = 3, ncol = 3)

mat1[1]
mat1[2]
mat1[3]
mat1[4]
mat1[9]

mat1[1,3] # row 1, column 3
mat1[1,]
mat1[,3]


#### Exercise 6 ####
# Data frames
##like matricies but with multiple data types (logical AND numerical)

df <- data.frame(mat1[,1],mat2[,1])
df

colnames(df) <- c("value", "name")

df[1] #first column
df[1,2] #first row, second column
df[, "value"]

df$value #accessing columns

df$value[1]
df$name[3]

# Subsetting or indexing

#the element of the column value such that name is equal to Jack
df$value[df$name == "Jack"]
df$value[df$name %in% c("Jack", "Hannah")]

#return the elements in the column value within the data frame df such that the name is not equal to Mary
df$value[df$name != "Mary"]
df$value[!df$name %in% c("Jack", "Hannah")]

# Subset function
subset(df, name == "Mary")

# Making a new column in a data frame
df$log_value <- log(df$value)
df


#### Exercise 7 ####
# Installing packages

#tidyverse
#ggplot2
#purrr

install.packages("tidyverse") #install package

library(tidyverse) #load package


#### Exercise 8 ###
# Reading data into R

#CSV file or TXT file

csv <- read.csv("C:/Users/meo0040/Downloads/CUKES/collection_data.csv", na.strings = "na")

csv2 <- file.choose() #opens browser to find file