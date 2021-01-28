library(tidyverse)

#####Load the data (if you want, you could do this locally from your computer rather than download from Dropbox)

cel <- read_csv(url("https://www.dropbox.com/s/4ebgnkdhhxo5rac/cel_volden_wiseman%20_coursera.csv?raw=1"))

names(cel)
dim(cel)
table(cel$year)
summary(cel$all_bills)

#for making a scatterplot

####filter the data we want
fig115 <- filter(cel,congress==115)
fig115 <- select(fig115,"seniority","all_pass")

####these commands do the same thing as above, just with piping
fig115 <- cel %>% filter(congress==115) %>% select("seniority","all_pass")

###check to make sure the filter worked properly
head(fig115)

####set up the data and aesthetics
ggplot(fig115,aes(x=seniority,y=all_pass))

####add the marks
ggplot(fig115,aes(x=seniority,y=all_pass))+
  geom_point()

####jitter adds random noise to the data to avoid overplotting
ggplot(fig115,aes(x=seniority,y=all_pass))+
  geom_jitter()

####add some labels and a title
ggplot(fig115,aes(x=seniority,y=all_pass))+
  geom_jitter()+
  labs(x="Seniority",y="Bills Passed",title="Seniority and Bills Passed in the 115th Congress")

#####modify filter and select to grab "dem"

fig115 <- cel %>% 
  filter(congress==115) %>% 
  select("seniority","all_pass","dem")

fig115$dem

ggplot(fig115,aes(x=seniority,y=all_pass,color=dem))+
  geom_jitter()+
  labs(x="Seniority",y="Bills Passed",title="Seniority and Bills Passed in the 115th Congress")

####colors are strange, let's fix

#####make dem a categorical variable called "party"
party <- recode(fig115$dem,`1`="Democrat",`0`="Republican")

fig115 <- add_column(fig115,party)

fig115$party

ggplot(fig115,aes(x=seniority,y=all_pass,color=party))+
  geom_jitter()+
  labs(x="Seniority",y="Bills Passed",title="Seniority and Bills Passed in the 115th Congress")

####let's make the colors match traditional blue democrats and red republicans

ggplot(fig115,aes(x=seniority,y=all_pass,color=party))+
  geom_jitter()+
  labs(x="Seniority",y="Bills Passed",title="Seniority and Bills Passed in the 115th Congress")+
  scale_color_manual(values=c("blue","red"))

#####make two separate plots using facet_wrap

ggplot(fig115,aes(x=seniority,y=all_pass,color=party))+
  geom_jitter()+
  labs(x="Seniority",y="Bills Passed",title="Seniority and Bills Passed in the 115th Congress")+
  scale_color_manual(values=c("blue","red"))+
  facet_wrap(~party)

install.packages(c(
  "directlabels", "dplyr", "gameofthrones", "ggforce", "gghighlight", 
  "ggnewscale", "ggplot2", "ggraph", "ggrepel", "ggtext", "ggthemes", 
  "hexbin", "mapproj", "maps", "munsell", "ozmaps", "paletteer", 
  "patchwork", "rmapshaper", "scico", "seriation", "sf", "stars", 
  "tidygraph", "tidyr", "wesanderson" 
))


######################################################################
rm(list=ls())
library(ggplot2)
mpg

#
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()
#
ggplot(mpg, aes(model, manufacturer)) + geom_point()
#
ggplot(mpg, aes(cty, hwy)) + geom_point()
#
ggplot(diamonds, aes(carat, price)) + geom_point()
#
ggplot(economics, aes(date, unemploy)) + geom_line()
#
ggplot(mpg, aes(cty)) + geom_histogram()
#
ggplot(mpg, aes(displ, hwy, colour = class)) + geom_point()
ggplot(mpg, aes(displ, hwy, shape = drv)) + geom_point()
ggplot(mpg, aes(displ, hwy, size = cyl)) + geom_point()
#
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(colour = "blue"))
ggplot(mpg, aes(displ, hwy)) + geom_point(colour = "blue")
#
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  facet_wrap(~class)

##### 2.6 Plot geoms
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth()
#> `geom_smooth()` using method = 'loess' and formula 'y ~ x'

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth(span = 0.2)
#> `geom_smooth()` using method = 'loess' and formula 'y ~ x'

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth(span = 1)
#> `geom_smooth()` using method = 'loess' and formula 'y ~ x'

#
ggplot(mpg, aes(drv, hwy)) + 
  geom_point()
ggplot(mpg, aes(drv, hwy)) + geom_jitter()
ggplot(mpg, aes(drv, hwy)) + geom_boxplot()
ggplot(mpg, aes(drv, hwy)) + geom_violin()
