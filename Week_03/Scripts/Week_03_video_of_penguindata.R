#### This is a script to make a visualization of the palmer penguins data ###
### Created by: Leah Barkai
### Created on: 2025-09-9

### Load libraries ########## 
install.packages("palmerpenguins")
install.packages("praise") ###this is just for fun :)
install.packages("ggplot2") ###redoing this bc it said it went away
library(palmerpenguins)
library(tidyverse)
library(praise) ###this is just for fun :)
install.packages('devtools') ## This is to help install color packages that aren't published yet
devtools::install_github("dill/beyonce") ##this is for fun to add the Beyonce color package from a github page
library(beyonce)
library(ggplot2)
install.packages("ggthemes") # do this in the console
# put the code below in the libraries section of your script
library(ggthemes)


### Load data #####
glimpse(penguins)

### Data Analysis Code - ggplot #####
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species, 
                     color = species)) +
  geom_point()+
  geom_smooth(method="lm")+ ##lm = liner method and this needs to be in quote bc it is specific #se = standard error so this means no standard error to add
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  scale_color_viridis_d()+
  scale_color_manual(values = beyonce_palette(2))+
  coord_flip()

ggplot(diamonds, aes(carat, price)) +
  geom_point() +
  coord_trans(x = "log10", y = "log10") ##coord_trans – changes the coordinate system but keeps the data the same

##Change coordinates: make them polar
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  scale_color_manual(values = beyonce_palette(10)) +
  coord_polar("x") # make the polar

ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  scale_color_manual(values = beyonce_palette(10)) +
  theme_bw() +
  theme(axis.title = element_text(size = 20))

ggsave(here("Week_03","output","penguin.png"))

plot1<-ggplot(data=penguins,
              mapping = aes(x = bill_depth_mm,
                            y = bill_length_mm,
                            group = species,
                            color = species)) + 
  geom_point()+ 
  geom_smooth(method = "lm")+ 
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
  ) +
  scale_color_manual(values = beyonce_palette(2)) +
  theme_bw() +
  theme(axis.title = element_text(size = 20),
        panel.background = element_rect(fill = "linen"))
plot1 # you need to type it out to vi

plot1
