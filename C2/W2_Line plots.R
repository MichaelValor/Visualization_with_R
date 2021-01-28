rm(list=ls())
library(tidyverse)

####create a sequence of years

years <- seq(from=2001,to=2020,by=1)

####create "fake" data for price (note, your values will be different)

price <- rnorm(20,mean=15,sd=5)

####put years and price together

fig_data <- tibble("year"=years,"stock_price"=price)

ggplot(fig_data,(aes(x=years,y=stock_price)))+
  geom_line()

####make data for the first of two stocks

fig_data$stock_id=rep("Stock_1",20)

stock_1_time_series <- fig_data

#####create data for the second company
########same approach as with the last company
stock_id <- rep("Stock_2",20)

years <- seq(from=2001,to=2020,by=1)

price <- rnorm(20,mean=10,sd=3)

stock_2_time_series <- tibble("stock_id"=stock_id,"year"=years,"stock_price"=price)

####combine with bind_rows()

all_stocks_time_series <- bind_rows(stock_1_time_series,stock_2_time_series)

View(all_stocks_time_series)

####make the plot, setting group to stock_id

ggplot(all_stocks_time_series,(aes(x=year,y=stock_price,group=stock_id)))+
  geom_line()

####modify group, linetype, color, and add facet_wrap()

ggplot(all_stocks_time_series,(aes(x=year,y=stock_price,group=stock_id,linetype=stock_id,color=stock_id)))+
  geom_line()+
  facet_wrap(~stock_id)

#####Practice with another data set

cel <- read_csv(url("https://www.dropbox.com/s/4ebgnkdhhxo5rac/cel_volden_wiseman%20_coursera.csv?raw=1"))

cel$Party <- recode(cel$dem,`1`="Democrat",`0`="Republican")

fig_data <- cel %>% 
  group_by(Party,year) %>% 
  summarize("Ideology"=mean(dwnom1,na.rm=T))
  
View(fig_data)

ggplot(fig_data,(aes(x=year,y=Ideology,group=Party,color=Party)))+
  geom_line()+
  scale_color_manual(values=c("blue","red"))

#########################################
plot(pressure$temperature, pressure$pressure, type = "l")

plot(pressure$temperature, pressure$pressure, type = "l")
points(pressure$temperature, pressure$pressure)

lines(pressure$temperature, pressure$pressure/2, col = "red")
points(pressure$temperature, pressure$pressure/2, col = "red")

#
library(ggplot2)
ggplot(pressure, aes(x = temperature, y = pressure)) +
  geom_line()

ggplot(pressure, aes(x = temperature, y = pressure)) +
  geom_line() +
  geom_point()

#
ggplot(BOD, aes(x = Time, y = demand)) +
  geom_line()

BOD1 <- BOD  # Make a copy of the data
BOD1$Time <- factor(BOD1$Time)

ggplot(BOD1, aes(x = Time, y = demand, group = 1)) +
  geom_line()

# These have the same result
ggplot(BOD, aes(x = Time, y = demand)) +
  geom_line() +
  ylim(0, max(BOD$demand))

ggplot(BOD, aes(x = Time, y = demand)) +
  geom_line() +
  expand_limits(y = 0)

library(gcookbook) # Load gcookbook for the tg data set

# Map supp to colour
ggplot(tg, aes(x = dose, y = length, colour = supp)) +
  geom_line()

# Map supp to linetype
ggplot(tg, aes(x = dose, y = length, linetype = supp)) +
  geom_line()

ggplot(tg, aes(x = dose, y = length, shape = supp)) +
  geom_line() +
  geom_point(size = 4)  # Make the points a little larger

ggplot(tg, aes(x = dose, y = length, fill = supp)) +
  geom_line() +
  geom_point(size = 4, shape = 21)  # Also use a point with a color fill

# If both lines have the same properties, you need to specify a variable to
# use for grouping
ggplot(tg, aes(x = dose, y = length, group = supp)) +
  geom_line(colour = "darkgreen", size = 1.5)

# Since supp is mapped to colour, it will automatically be used for grouping
ggplot(tg, aes(x = dose, y = length, colour = supp)) +
  geom_line(linetype = "dashed") +
  geom_point(shape = 22, size = 3, fill = "white")
