#####Data Wrangling with the tidyverse

### install the tidyverse if you don't have it installed. You only have to do this once.
#install.packages("tidyverse")

###load the tidyverse functions #### Do this everytime you want to use tidyverse commands

library(tidyverse)

####Use read_csv instead of read.csv

#### make sure you have the file in your working directory, or use the complete file path. Use setwd() if you need to.

setwd("D:/pjt_R/Data visualization")

cces <- read_csv("cces_sample_coursera.csv")

#### read_csv produces a tibble rather than a dataframe.

class(cces)

vignette("tibble")

##### if you need to switch back and forth between tibble and dataframe for some reason

cces_dataframe <- as.data.frame(cces)
class(cces_dataframe)
cces_tibble <- as_tibble(cces_dataframe)
class(cces_tibble)

####drop rows with missing data
cces <- drop_na(cces)

##### Use the filter function
####selects only women respondents
women <- filter(cces,gender==2)

####remember the other logical operators

# >
# <
# <=
# >=
# &
# |
# %in%
dim(cces)
dim(women)

table(cces$gender)

women$gender

republican_women <- filter(cces,gender==2 & pid7>4)

dim(republican_women)
table(republican_women$pid7)

republican_women$gender
republican_women$pid7

head(republican_women)

####select certain columns from the data

select(republican_women,"educ","employ")

####combine multiple commands using piping

#x %>% f(y) is the same as f(x, y) 
#y %>% f(x, ., z) is the same as f(x, y, z)

women_republicans_educ_employ <- cces %>% filter(gender==2 & pid7>4) %>% select("educ","employ")

####recode variables

party <- recode(cces$pid7,`1`="Democrat",`2`="Democrat",`3`="Democrat",`4`="Independent",`5`="Republican",`6`="Republican",`7`="Republican")

cces$party <- party

####rename variables

test <- rename(cces,trump_approval=CC18_308a)

test$trump_approval

cces <- test
cces$trump_approval

####calculate new numeric variables

rec_sen1_01 <- recode(cces$CC18_310b,`1`=0,`5`=0,`2`=1,`3`=1,`4`=1)

rec_sen2_01 <- recode(cces$CC18_310c,`1`=0,`5`=0,`2`=1,`3`=1,`4`=1)

cces$rec_sen1_01<- rec_sen1_01

cces$rec_sen2_01<- rec_sen2_01

cces <- mutate(cces, know_sens=rec_sen1_01+rec_sen2_01)
cces$know_sens

##### reorder rows by column values

sorted_by_gender_and_party <- cces %>% arrange(gender,pid7)

View(sorted_by_gender_and_party)

sorted_by_gender_and_party <- cces %>% arrange(gender,desc(pid7))

View(sorted_by_gender_and_party)

##### add grouping to data

grouped_gender_pid7 <- cces %>% group_by(gender,pid7)
grouped_gender_pid7
ungroup(grouped_gender_pid7)
###remove grouping with ungroup
#ungroup(grouped_gender_pid7)

##### summarize the data
?summarise
summarise(cces,mean_pid7=mean(pid7),mean_faminc=mean(faminc_new))

#####you could do the same thing with piping
#cces %>% summarise(mean_pid7=mean(pid7),mean_faminc=mean(faminc_new))

###when you summarise grouped data, you get summaries by group

grouped_gender <- cces %>% group_by(gender)
summarise(grouped_gender,mean_pid7=mean(pid7),mean_faminc=mean(faminc_new))

####combine all of this with piping if you want to look like a pro and have fewer lines of code
#cces %>% group_by(gender) %>% summarise(mean=mean(pid7))


#####################################################################
library(tidyverse)
tibble1 <- as_tibble(iris)
View(tibble1)

#
tibble(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
)

#
tb <- tibble(
`:)` = "smile", 
` ` = "space",
`2000` = "number"
)
tb

#
tb2 <- tibble(
  "column a" = c(1,2,3,"k"),
  "column b" = c(3,6,9,"j"),
  "column c" = c(8,12,16,"i"),
)

#
tribble(
  ~x, ~y, ~z,
  "a", 2, 3.6,
  "b", 1, 8.5
)

#
tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)

#
nycflights13::flights %>% 
  print(n = 10, width = Inf)

#
df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

# Extract by name
df$x
df[["x"]]

# Extract by position
df[[1]]

#
df %>% .$x
df %>% .[["x"]]
