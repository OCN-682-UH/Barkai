##Online Video for Week 8 - advanced plotting

#Load libraries
install.packages("patchwork") # for bringing plots together
install.packages("ggrepel") # for repelling labels
install.packages("gganimate") # animations
install.packages("magick") # for images
library(tidyverse)
library(here)
library(patchwork)
library(ggrepel)
library(gganimate)
library(magick)
library(palmerpenguins)

#Data Analysis
# plot 1
p1<-penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_length_mm, 
             color = species))+
  geom_point()
p1

# plot 2
p2<-penguins %>%
  ggplot(aes(x = sex, 
             y = body_mass_g, 
             color = species))+
  geom_jitter(width = 0.2)
p2

#bring the plots together 
p1+p2

p1+p2 +
  plot_layout(guides = 'collect')

p1+p2 +
  plot_layout(guides = 'collect')+
  plot_annotation(tag_levels = 'A')
