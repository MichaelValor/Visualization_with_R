#
setwd("D:/pjt_R/Data visualization")

rm(list=ls())

library(nycflights13)
library(tidyverse)
dim(flights)

#
filter(flights, month == 1, day == 1)
jan1 <- filter(flights, month == 1, day == 1)
(dec25 <- filter(flights, month == 12, day == 25))

# Camparisons
near(sqrt(2) ^ 2,  2)
filter(flights, month == 11 | month == 12)
#
filter(flights, month == (11 | 12))

#
nov_dec <- filter(flights, month %in% c(11, 12))

#
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

#
arrange(flights, year, month, day, desc(dep_delay))

# Select columns by name
select(flights, year, month, day)
# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))
