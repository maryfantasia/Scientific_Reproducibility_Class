#### Question 1 ####
#Type code into the R script(this box!), create a new script here
#The output of the code goes below this box, into the console
#Plots show up under the Plots tab to the lower left of this box
#A global environment is the workspace where R stores variables, data frames, functions and packages.
#The function will normally tell you what it needs to work before you try to use it.
#An R package is a sort of software that you download to perform certain tasks, like statistical analyses and creating plots.
#A function is a line of code that performs a specific task that it is assigned to.
#Show packages under the View tab above this box to find packages.
#A working directory is whatever directory you want to run your code in, you find it by using a simple command to tell you where you are in your computer.
#A relative file path tells you where the file is in a downloaded set of files, different from an absolute file path that shows exactly where the file is located on your own computer.

#### Question 2 ####
# Step 1
##create new R script
# Step 2
##connect your github account through the global environment
# Step 3
##choose which project on github to connect to
# Step 4
##commit and push any changes made to the project on R

#### Question 3 ####
# Similarities between vector, dataframe, and matrix
##all contain data
##all go to environment

# Differences between vector, dataframe, and matrix
##vector assigns a value to a variable, is an object
##matrix creates a table of data using rows and columns with the same data type
##dataframe creates a table of data using rows and columns with different data types

#### Question 4 ####
# Create a vector named 'z' with the values 1 to 200
z <- 1:200

# Print the mean and sd of z on the console
mean(z)
sd(z)

# Create a logical vector named zlog that is TRUE for z values greater than 30, FALSE otherwise
zlog <- z>30

# Create a dataframe with z and zlog as columns
zdf <- data.frame(z=z, zlog=zlog)

# Change column names to "zvec" and "zlogic"
colnames(zdf) <- c("zvec", "zlogic")

# Create new column equal to zvec squared
zdf$zsquared <- zdf$zvec ^2

# Subsetting to include values greater than 10 but less than 100
##with subset() funtion
subset(zdf, zsquared > 10 & zsquared < 100)

##without subset() funtion
zdf$zsquared[zdf$zsquared > 10 & zdf$zsquared < 100]

# Subset to only include values on row 26
subset(zdf[26,])

# Subset to only include values in the column zsquared in row 180
subset(zdf, zsquared[,180])




#### Question 5 ####
# Read data
csv <- read.csv("C:/Users/meo0040/Downloads/TipsR.csv", na.strings = "na")

##data was read correctly because it went to the environment