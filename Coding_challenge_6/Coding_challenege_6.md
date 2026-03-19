# Question 1

## Regarding reproducibility, what is the main point of writing your own functions and iterations?

The main point of writing your own functions and iterations for
reproducibility is to prevent copy/paste errors while writing many of
the same lines of code.

# Question 2

## : In your own words, describe: 1) how to write a function in R, and 2) how to write a for loop in R.

1)  To write a function in R, you insert a code into a variable.
2)  To write a for loop in R, you give the code an “if, then” objective.

# Question 3

## Read the data

``` r
cities <- read.csv("Cities.csv")
```

# Question 4

## Write a function that calculates the distance (in kilometers) between two pairs of geographic coordinates using the Haversine formula.

``` r
haversine_distance <- function(lat1, lon1, lat2, lon2) {
  # convert to radians
rad.lat1 <- lat1 * pi/180
rad.lon1 <- lon1 * pi/180
rad.lat2 <- lat2 * pi/180
rad.lon2 <- lon2 * pi/180

# Haversine formula
delta_lat <- rad.lat2 - rad.lat1
delta_lon <- rad.lon2 - rad.lon1
a <- sin(delta_lat / 2)^2 + cos(rad.lat1) * cos(rad.lat2) * sin(delta_lon / 2)^2
c <- 2 * asin(sqrt(a)) 

# Earth's radius in kilometers
earth_radius <- 6378137

# Calculate the distance
distance_km <- (earth_radius * c)/1000
return(distance_km)
}
```

# Question 5

## . Using your function from question 4, calculate the distance between Auburn, AL and New York City.

``` r
### STEP 1 — Subset Auburn and NYC ###
auburn <- subset(cities, city == "Auburn")
nyc   <- subset(cities, city == "New York")

### STEP 2 — Extract the latitude/longitude values ###
lat1 <- auburn$lat
lon1 <- auburn$long
lat2 <- nyc$lat
lon2 <- nyc$long

### STEP 3 — Calculate the distance ###
distance_auburn_nyc <- haversine_distance(lat1, lon1, lat2, lon2)

### STEP 4 — Print the result ###
distance_auburn_nyc
```

    ## [1] 1367.854

# Question 6

## Use your distance function inside a for loop to calculate the distance between Auburn, AL and every other city in Cities.csv. Each iteration should calculate the distance for one city.

``` r
city_all <- unique(cities$city)

null_df <- NULL
for (i in seq_along(city_all)){
  auburn_lat=auburn$lat
  auburn_long=auburn$long
  city_lat=cities$lat[cities$city == city_all[[i]]]
  city_long=cities$long[cities$city == city_all[[i]]]
  distance <- haversine_distance(auburn_lat, auburn_long, city_lat, city_long)
  
  distance_all <- data.frame(distance, city_all[[i]])
null_df <- rbind.data.frame(null_df, distance_all) 
  }
print(null_df)
```

    ##     distance city_all..i..
    ## 1  1367.8540      New York
    ## 2  3051.8382   Los Angeles
    ## 3  1045.5213       Chicago
    ## 4   916.4138         Miami
    ## 5   993.0298       Houston
    ## 6  1056.0217        Dallas
    ## 7  1239.9732  Philadelphia
    ## 8   162.5121       Atlanta
    ## 9  1036.9900    Washington
    ## 10 1665.6985        Boston
    ## 11 2476.2552       Phoenix
    ## 12 1108.2288       Detroit
    ## 13 3507.9589       Seattle
    ## 14 3388.3656 San Francisco
    ## 15 2951.3816     San Diego
    ## 16 1530.2000   Minneapolis
    ## 17  591.1181         Tampa
    ## 18 1363.2072      Brooklyn
    ## 19 1909.7897        Denver
    ## 20 1380.1382        Queens
    ## 21 2961.1199     Riverside
    ## 22 2752.8142     Las Vegas
    ## 23 1092.2595     Baltimore
    ## 24  796.7541     St. Louis
    ## 25 3479.5376      Portland
    ## 26 1290.5492   San Antonio
    ## 27 3301.9923    Sacramento
    ## 28 1191.6657        Austin
    ## 29  608.2035       Orlando
    ## 30 2504.6312      San Juan
    ## 31 3337.2781      San Jose
    ## 32  800.1452  Indianapolis
    ## 33 1001.0879    Pittsburgh
    ## 34  732.5906    Cincinnati
    ## 35 1371.1633     Manhattan
    ## 36 1091.8970   Kansas City
    ## 37 1043.2727     Cleveland
    ## 38  851.3423      Columbus
    ## 39 1382.3721         Bronx
    ## 40    0.0000        Auburn

# Question 7

## Modify your loop so that each iteration appends one new row to a dataframe with the following columns:

• City1 (the other city) • City2 (Auburn) • Distance_km

``` r
city_all <- unique(cities$city)

# Empty dataframe with correct column names
distance_df <- data.frame(
  City1 = character(),
  City2 = character(),
  Distance_km = numeric(),
  stringsAsFactors = FALSE
)

for (i in seq_along(city_all)) {

  # Coordinates for Auburn (City2)
  auburn_lat  <- auburn$lat
  auburn_long <- auburn$long

  # Coordinates for the other city (City1)
  city_lat  <- cities$lat[cities$city == city_all[i]]
  city_long <- cities$long[cities$city == city_all[i]]

  # Calculate the distance
  distance_km <- haversine_distance(auburn_lat, auburn_long, city_lat, city_long)

  # Create one-row dataframe for this iteration
  new_row <- data.frame(
    City1 = city_all[i],
    City2 = "Auburn",
    Distance_km = distance_km,
    stringsAsFactors = FALSE
  )

  # Append
  distance_df <- rbind(distance_df, new_row)
}

print(distance_df)
```

    ##            City1  City2 Distance_km
    ## 1       New York Auburn   1367.8540
    ## 2    Los Angeles Auburn   3051.8382
    ## 3        Chicago Auburn   1045.5213
    ## 4          Miami Auburn    916.4138
    ## 5        Houston Auburn    993.0298
    ## 6         Dallas Auburn   1056.0217
    ## 7   Philadelphia Auburn   1239.9732
    ## 8        Atlanta Auburn    162.5121
    ## 9     Washington Auburn   1036.9900
    ## 10        Boston Auburn   1665.6985
    ## 11       Phoenix Auburn   2476.2552
    ## 12       Detroit Auburn   1108.2288
    ## 13       Seattle Auburn   3507.9589
    ## 14 San Francisco Auburn   3388.3656
    ## 15     San Diego Auburn   2951.3816
    ## 16   Minneapolis Auburn   1530.2000
    ## 17         Tampa Auburn    591.1181
    ## 18      Brooklyn Auburn   1363.2072
    ## 19        Denver Auburn   1909.7897
    ## 20        Queens Auburn   1380.1382
    ## 21     Riverside Auburn   2961.1199
    ## 22     Las Vegas Auburn   2752.8142
    ## 23     Baltimore Auburn   1092.2595
    ## 24     St. Louis Auburn    796.7541
    ## 25      Portland Auburn   3479.5376
    ## 26   San Antonio Auburn   1290.5492
    ## 27    Sacramento Auburn   3301.9923
    ## 28        Austin Auburn   1191.6657
    ## 29       Orlando Auburn    608.2035
    ## 30      San Juan Auburn   2504.6312
    ## 31      San Jose Auburn   3337.2781
    ## 32  Indianapolis Auburn    800.1452
    ## 33    Pittsburgh Auburn   1001.0879
    ## 34    Cincinnati Auburn    732.5906
    ## 35     Manhattan Auburn   1371.1633
    ## 36   Kansas City Auburn   1091.8970
    ## 37     Cleveland Auburn   1043.2727
    ## 38      Columbus Auburn    851.3423
    ## 39         Bronx Auburn   1382.3721
    ## 40        Auburn Auburn      0.0000

\*This code was written using help from copilot.
