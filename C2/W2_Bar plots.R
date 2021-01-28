# Load ggplot2
library(ggplot2)

# Create data
data <- data.frame(
  name=c("A","B","C","D","E") ,  
  value=c(3,12,5,18,45)
)

# Barplot
ggplot(data, aes(x=name, y=value)) + 
  geom_bar(stat = "identity")
ggplot(data, aes(y=value)) + 
  geom_bar()


# Libraries
library(ggplot2)

# 1: uniform color. Color is for the border, fill is for the inside
ggplot(mtcars, aes(x=as.factor(cyl) )) +
  geom_bar(color="blue", fill=rgb(0.1,0.4,0.5,0.7) )

# 2: Using Hue
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) + 
  geom_bar( ) +
  scale_fill_hue(c = 40) +
  theme(legend.position="none")

# 3: Using RColorBrewer
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) + 
  geom_bar( ) +
  scale_fill_brewer(palette = "Set1") +
  theme(legend.position="none")


# 4: Using greyscale:
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) + 
  geom_bar( ) +
  scale_fill_grey(start = 0.25, end = 0.75) +
  theme(legend.position="none")


# 5: Set manualy
ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +  
  geom_bar( ) +
  scale_fill_manual(values = c("red", "green", "blue") ) +
  theme(legend.position="none")


# Barplot
ggplot(data, aes(x=name, y=value)) + 
  geom_bar(stat = "identity") +
  coord_flip()

# Barplot
ggplot(data, aes(x=name, y=value)) + 
  geom_bar(stat = "identity", width=0.2) 

###############################################################
library(tidyverse)

cel <- read_csv(url("https://www.dropbox.com/s/4ebgnkdhhxo5rac/cel_volden_wiseman%20_coursera.csv?raw=1"))

####bar plot for dems variable in the 115th Congress. 0=Republican, 1=Democrat

cel %>% 
  filter(congress==115) %>% 
  ggplot(aes(x=dem))+
  geom_bar()

###prove to yourself your bar plot is right by comparing with a frequency table:
table(filter(cel,congress==115)$dem)


###use st_name instead, so how counts of how many members of Congress from each state:

cel %>% filter(congress==115) %>% ggplot(aes(x=st_name))+geom_bar()

###flip the figure by setting y aesthetic rather than the x

cel %>% filter(congress==115) %>% ggplot(aes(y=st_name))+geom_bar()

###let's go back and recode the dem variable to be a categorical variable

party <- recode(cel$dem,`1`="Democrat",`0`="Republican")

cel <- add_column(cel,party)

cel %>% filter(congress==115)%>% ggplot(aes(x=party))+
  geom_bar()

####now add some visual touches

###add axis labels
cel %>% filter(congress==115)%>% ggplot(aes(x=party))+
  geom_bar()+
  labs(x="Party",y="Number of Members")

###add colors for the two different bars
cel %>% filter(congress==115)%>% ggplot(aes(x=party,fill=party))+
  geom_bar()+
  labs(x="Party",y="Number of Members")

###manually change the colors of the bars
cel %>% filter(congress==115)%>% ggplot(aes(x=party,fill=party))+
  geom_bar()+
  labs(x="Party",y="Number of Members")+
  scale_fill_manual(values=c("blue","red"))

###drop the legend with the "guides" command
cel %>% filter(congress==115)%>% ggplot(aes(x=party,fill=party))+
  geom_bar()+
  labs(x="Party",y="Number of Members")+
  scale_fill_manual(values=c("blue","red"))+
  guides(fill=FALSE)


#####Making more barplots and manipulating more data in R

####Making a barplot of proportions

#####a toy demonstration
#####a bowl of fruit
apple <- rep("apple",6)
orange <- rep("orange",3)
banana <- rep("banana",1)

###put together the fruits in a dataframe
###creates a single columns with fruits
fruit_bowl <- tibble("fruits"=c(apple,orange,banana))

########Let's calculate proportions instead

#####create a table that counts fruits in a second column
fruit_bowl_summary <- fruit_bowl %>% 
  group_by(fruits) %>% 
  summarize("count"=n())

fruit_bowl %>% group_by(fruits) %>% summarize("count"=n())

fruit_bowl_summary

####calculate proportions
fruit_bowl_summary$proportion <- fruit_bowl_summary$count/sum(fruit_bowl_summary$count)

fruit_bowl_summary

####add the geom_bar, using "stat" to tell command to plot the exact value for proportion
ggplot(fruit_bowl_summary,aes(x=fruits,y=proportion))+
  geom_bar(stat="identity")

ggplot(fruit_bowl_summary,aes(x=fruits,y=proportion,fill=fruits))+
  geom_bar(stat="identity")+
  scale_fill_manual(values=c("red","yellow","orange"))+
  guides(fill=FALSE)+
  labs(x="Fruits",y="Proportion of Fruits")



####More practice with barplots!

#####
cces <- read_csv(url("https://www.dropbox.com/s/ahmt12y39unicd2/cces_sample_coursera.csv?raw=1"))

####create counts of Ds, Rs, and Is by region

dem_rep <- recode(cces$pid7,`1`="Democrat",`2`="Democrat",`3`="Democrat",`4`="Independent",`5`="Republican",`6`="Republican",`7`="Republican")

table(dem_rep)

cces <- add_column(cces,dem_rep)

###stacked bars
ggplot(cces,aes(x=region,fill=dem_rep))+
  geom_bar()

###grouped bars
ggplot(cces,aes(x=region,fill=dem_rep))+
  geom_bar(position="dodge")

##visual touches like relabeling the axes
ggplot(cces,aes(x=region,fill=dem_rep))+
  geom_bar(position="dodge")+
  labs(x="Region",y="Count")

#######################################################
dat <- data.frame(
  time = factor(c("Lunch","Dinner"), levels=c("Lunch","Dinner")),
  total_bill = c(14.89, 17.23)
)
dat


# Very basic bar graph
ggplot(data=dat, aes(x=time, y=total_bill)) +
  geom_bar(stat="identity")


# Map the time of day to different fill colors
ggplot(data=dat, aes(x=time, y=total_bill, fill=time)) +
  geom_bar(stat="identity")

## This would have the same result as above
# ggplot(data=dat, aes(x=time, y=total_bill)) +
#    geom_bar(aes(fill=time), stat="identity")


# Add a black outline
ggplot(data=dat, aes(x=time, y=total_bill, fill=time)) +
  geom_bar(colour="black", stat="identity")


# No legend, since the information is redundant
ggplot(data=dat, aes(x=time, y=total_bill, fill=time)) +
  geom_bar(colour="black", stat="identity") +
  guides(fill=FALSE)

## The desired bar graph might look something like this:
# Add title, narrower bars, fill color, and change axis labels
ggplot(data=dat, aes(x=time, y=total_bill, fill=time)) + 
  geom_bar(colour="black", fill="#DD8888", width=0.8, stat="identity") + 
  guides(fill=FALSE) +
  xlab("Time of day") + ylab("Total bill") +
  ggtitle("Average bill for 2 people")



library(reshape2)
# Look at fist several rows
head(tips)
# Bar graph of counts
ggplot(data=tips, aes(x=day)) +
  geom_bar(stat="count")
## Equivalent to this, since stat="bin" is the default:
# ggplot(data=tips, aes(x=day)) +
#    geom_bar()

# Basic line graph
ggplot(data=dat, aes(x=time, y=total_bill, group=1)) +
  geom_line()
## This would have the same result as above
# ggplot(data=dat, aes(x=time, y=total_bill)) +
#     geom_line(aes(group=1))

# Add points
ggplot(data=dat, aes(x=time, y=total_bill, group=1)) +
  geom_line() +
  geom_point()

# Change color of both line and points
# Change line type and point type, and use thicker line and larger points
# Change points to circles with white fill
ggplot(data=dat, aes(x=time, y=total_bill, group=1)) + 
  geom_line(colour="red", linetype="dashed", size=1.5) + 
  geom_point(colour="red", size=4, shape=21, fill="white")

## The desired line graph might look something like this:
# Change the y-range to go from 0 to the maximum value in the total_bill column,
# and change axis labels
ggplot(data=dat, aes(x=time, y=total_bill, group=1)) +
  geom_line() +
  geom_point() +
  expand_limits(y=0) +
  xlab("Time of day") + ylab("Total bill") +
  ggtitle("Average bill for 2 people")


########################################################
dat1 <- data.frame(
  sex = factor(c("Female","Female","Male","Male")),
  time = factor(c("Lunch","Dinner","Lunch","Dinner"), levels=c("Lunch","Dinner")),
  total_bill = c(13.53, 16.81, 16.24, 17.42)
)
dat1

# Stacked bar graph -- this is probably not what you want
ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) +
  geom_bar(stat="identity")

# Bar graph, time on x-axis, color fill grouped by sex -- use position_dodge()
ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) +
  geom_bar(stat="identity", position=position_dodge())

ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black")

# Change colors
ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black") +
  scale_fill_manual(values=c("#999999", "#E69F00"))

# Bar graph, time on x-axis, color fill grouped by sex -- use position_dodge()
ggplot(data=dat1, aes(x=sex, y=total_bill, fill=time)) +
  geom_bar(stat="identity", position=position_dodge(), colour="black")


# Basic line graph with points
ggplot(data=dat1, aes(x=time, y=total_bill, group=sex)) +
  geom_line() +
  geom_point()

# Map sex to color
ggplot(data=dat1, aes(x=time, y=total_bill, group=sex, colour=sex)) +
  geom_line() +
  geom_point()

# Map sex to different point shape, and use larger points
ggplot(data=dat1, aes(x=time, y=total_bill, group=sex, shape=sex)) +
  geom_line() +
  geom_point()


# Use thicker lines and larger points, and hollow white-filled points
ggplot(data=dat1, aes(x=time, y=total_bill, group=sex, shape=sex)) + 
  geom_line(size=1.5) + 
  geom_point(size=3, fill="white") +
  scale_shape_manual(values=c(22,21))


## The finished graphs might look like these:
# A bar graph
ggplot(data=dat1, aes(x=time, y=total_bill, fill=sex)) + 
  geom_bar(colour="black", stat="identity",
           position=position_dodge(),
           size=1.3) +                        # Thinner lines
  scale_fill_hue(name="Sex of payer") +      # Set legend title
  xlab("Time of day") + ylab("Total bill") + # Set axis labels
  ggtitle("Average bill for 2 people") +     # Set title
  theme_bw()


# A line graph
ggplot(data=dat1, aes(x=time, y=total_bill, group=sex, shape=sex, colour=sex)) + 
  geom_line(aes(linetype=sex), size=1) +     # Set linetype by sex
  geom_point(size=3, fill="white") +         # Use larger points, fill with white
  expand_limits(y=0) +                       # Set y range to include 0
  scale_colour_hue(name="Sex of payer",      # Set legend title
                   l=30)  +                  # Use darker colors (lightness=30)
  scale_shape_manual(name="Sex of payer",
                     values=c(22,21)) +      # Use points with a fill color
  scale_linetype_discrete(name="Sex of payer") +
  xlab("Time of day") + ylab("Total bill") + # Set axis labels
  ggtitle("Average bill for 2 people") +     # Set title
  theme_bw() +
  theme(legend.position=c(.8, .4))           # Position legend inside
# This must go after theme_bw

