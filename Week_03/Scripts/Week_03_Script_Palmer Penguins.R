#### This is a script to make a visualization of the palmer penguins data ###
### Created by: Leah Barkai
### Created on: 2025-09-9

### Load libraries ########## 
install.packages("palmerpenguins")
library(palmerpenguins)
library(tidyverse)

### Load data #####
glimpse(penguins)

### Data Analysis Code - ggplot #####
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species)) +
  geom_point()+
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill depth (mm)", y = "Bill length (mm)",
       color = "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package")+
  scale_color_viridis_d()