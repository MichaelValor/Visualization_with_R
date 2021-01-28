####Importing Data in R

rm(list = ls())

####Import CSV
cces_sample <- read.csv("Sample data.csv")
View(cces_sample)

####Write CSV
write.csv(cces_sample,"D:/dropbox/Dropbox/data_viz_coursera/test.csv")

####type in your directory path in setwd() or use the Session-->Set Working Directory menu options

getwd()

setwd("D:/dropbox/Dropbox/data_viz_coursera/")

#### Don't need the whole file path now
cces_sample <- read.csv("cces_sample_coursera.csv")

class(cces_sample)

median(cces_sample$pew_religimp,na.rm=T)

table(cces_sample$race)



######################## Testing #######################

home <- c("computer","calculator","scanner")
office <- c("paper","pens","pencils")

inventory <- data.frame(home,office)

inventory$annex <- c("printer","stapler")
