# Library
library(tidyverse)
library(hrbrthemes)
library(viridis)

# Dummy data
x <- LETTERS[1:20]
y <- paste0("var", seq(1,20))

?expand.grid
dat <- expand.grid(X=x, Y=y)

?runif
dat$Z <- runif(400, 0, 5)

# Heatmap 
ggplot(dat, aes(x=X, y=Y, fill= Z)) + 
  geom_tile() +
  scale_fill_gradient(low="white", high="pink")

#####practice again using a more substantive example

players <- c("Michael","LeBron","Kobe")
points <- c(35, 40,45)
assists <- c(10,12,5)
rebounds <- c(15,12,5)

basketball <- tibble(players,points,assists,rebounds)

#####standardize the values

basketball$stanardize_points <- basketball$points/max(basketball$points)
basketball$stanardize_assists <- basketball$assists/max(basketball$assists)
basketball$stanardize_rebounds <- basketball$rebounds/max(basketball$rebounds)

basketball_stanardize <- select(basketball,"players","stanardize_points","stanardize_assists","stanardize_rebounds")

long_basketball_scaled <- pivot_longer(basketball_stanardize,c("stanardize_points","stanardize_assists","stanardize_rebounds"),names_to="stats",values_to = "values")

ggplot(long_basketball_scaled, aes(x=players,y=stats,fill=values)) + 
  geom_tile() + 
  scale_fill_distiller(palette = "RdPu")

ggplot(long_basketball_scaled, aes(x=players,y=stats,fill=values)) + 
  geom_tile() + 
  scale_fill_viridis(discrete=FALSE)


# Library
library(ggplot2)
library(tidyr)
library(tibble)
library(hrbrthemes)
library(dplyr)

# Volcano dataset
volcano

# Heatmap 
volcano %>%
  
  # Data wrangling
  as_tibble() %>%
  rowid_to_column(var="X") %>%
  gather(key="Y", value="Z", -1) %>%
  
  # Change Y to numeric
  mutate(Y=as.numeric(gsub("V","",Y))) %>%
  
  # Viz
  ggplot(aes(X, Y, fill= Z)) + 
  geom_tile() +
  theme_ipsum() +
  theme(legend.position="none")


# Library
library(ggplot2)
library(hrbrthemes)
library(plotly)

# Dummy data
x <- LETTERS[1:20]
y <- paste0("var", seq(1,20))
data <- expand.grid(X=x, Y=y)
data$Z <- runif(400, 0, 5)

# new column: text for tooltip:
data <- data %>%
  mutate(text = paste0("x: ", x, "\n", "y: ", y, "\n", "Value: ",round(Z,2), "\n", "What else?"))

# classic ggplot, with text in aes
p <- ggplot(data, aes(X, Y, fill= Z, text=text)) + 
  geom_tile() +
  theme_ipsum()

ggplotly(p, tooltip="text")

# save the widget
# library(htmlwidgets)
# saveWidget(pp, file=paste0( getwd(), "/HtmlWidget/ggplotlyHeatmap.html"))