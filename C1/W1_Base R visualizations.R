#####Visualizations with Base R

####Univariate Statistics

numbers1<- c(1,1,1,2,2,3,3,3,4,4,4,4,5,5,5,5,6,6,6)

hist(numbers1)

boxplot(numbers1)

numbers2<- c(5,5,5,5,5,6,6,6,7,7,7,8,8,8,9,9,9)

boxplot(numbers1,numbers2)

######Bivariate Statistics

#####make some fake data to create a scatterplot

#rnorm - normal distribution
#rpois - poisson
#rbinom - binomial
#runif - uniform



variable1<-runif(50,0,100)
variable2<-runif(50,0,100)
my_dat<-data.frame(variable1,variable2)

#####this does the same thing as the previous three lines
my_dat<-data.frame("variable1"=runif(50,0,100),"variable2"=runif(50,0,100))

#### Scatterplot
plot(my_dat$variable1,my_dat$variable2)

#####this does the same thing
plot(x=my_dat$variable1,y=my_dat$variable2)

###Base R has some limited graphics customization ability
plot(my_dat$variable1,my_dat$variable2,
     main="My First Plot", ###add main title
     xlab="Variable 1", ### x axis label
     ylab="Variable 2",### y axis label
     ylim=c(0,150),xlim=c(0,150))### set the length of the x and y axes.

?plot

hist(my_dat$variable1)
hist(my_dat$variable2)

boxplot(my_dat$variable1,my_dat$variable2)

######################################
head(ToothGrowth)
View(ToothGrowth)
boxplot(len ~ supp, data=ToothGrowth)
boxplot(len ~ dose, data=ToothGrowth)

boxplot(len ~ interaction(dose,supp), data=ToothGrowth)
#####################################
set.seed(955)
dat <- data.frame(xvar = 1:20 + rnorm(20,sd=3),
                  yvar = 1:20 + rnorm(20,sd=3),
                  zvar = 1:20 + rnorm(20,sd=3))
View(dat)
# Plot the points using the vectors xvar and yvar
plot(dat$xvar, dat$yvar)
# Same as previous, but with formula interface
plot(yvar ~ xvar, dat)
# Add a regression line
fitline <- lm(dat$yvar ~ dat$xvar)
abline(fitline)

# A scatterplot matrix
plot(dat[,1:3])

library(car)
scatterplotMatrix(dat[,1:3],
                  diagonal="histogram",
                  smooth=FALSE)
######################################
set.seed(1234)
rating  <- rnorm(200)
rating2 <- rnorm(200, mean=.8)
# Make a column to indicate which group each value is in
cond <- factor( rep(c("A","B"), each=200) )
data <- data.frame(cond, rating = c(rating, rating2))
View(data)

# Histogram
hist(rating)

# Use 8 bins (this is only approximate - it places boundaries on nice round numbers)
# Make it light blue #CCCCFF
# Instead of showing count, make area sum to 1, (freq=FALSE)
hist(rating, breaks=8, col="#CCCCFF", freq=FALSE)

# Put breaks at every 0.6
boundaries <- seq(-3, 3.6, by=.6)
boundaries
hist(rating, breaks=boundaries)

# Kernel density plot
plot(density(rating))

plot.multi.dens <- function(s)
{
  junk.x = NULL
  junk.y = NULL
  for(i in 1:length(s)) {
    junk.x = c(junk.x, density(s[[i]])$x)
    junk.y = c(junk.y, density(s[[i]])$y)
  }
  xr <- range(junk.x)
  yr <- range(junk.y)
  plot(density(s[[1]]), xlim = xr, ylim = yr, main = "")
  for(i in 1:length(s)) {
    lines(density(s[[i]]), xlim = xr, ylim = yr, col = i)
  }
}

# the input of the following function MUST be a numeric list
plot.multi.dens( list(rating, rating2))

library(sm)
sm.density.compare(data$rating, data$cond)
# Add a legend (the color numbers start from 2 and go up)
legend("topright", levels(data$cond), fill=2+(0:nlevels(data$cond)))
