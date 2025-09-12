#### This is a script to make my own visualization of the palmer penguins data ###
### Created by: Leah Barkai
### Created on: 2025-09-11

### Load libraries ########## 
install.packages("palmerpenguins") #completed - this is the data
install.packages("ggplot2") ###redoing this bc it said it went away
library(palmerpenguins)
library(tidyverse)
library(ggplot2)
install.packages("here")
library(here)

### Load data #####
glimpse(penguins)


what they suggested 
ggplot(penguins, aes(x = bill_length_mm, fill = species)) +
  geom_histogram(binwidth = 2, alpha = 0.7, position = "identity")



### Data Analysis Code - ggplot #####
Pengiun_plot<-ggplot(data=penguins, ##this is the data I am using
       mapping = aes(x = bill_length_mm,    #mapping reminder is stuff in the data #x axis is the bill length 
                     fill = species))+ #want to see the distribution within species
  geom_histogram()+ #settings
  scale_x_continuous(breaks = seq(30, 60, by = 5))+ #range from 30 to 60 and showing every 5 
  scale_fill_manual(values = c("Adelie" = "black","Chinstrap" = "gray70","Gentoo" = "orange"))+ #changed the colors to the colors of the birds but don't love it 
  labs(x = "Bill Length (mm)", 
       y = "Count",
       title = "Distribution of Penguin Bill Lengths by Species") +   # set the names of the axis and title
  theme(
    axis.title.x = element_text(size = 16),     # made x-axis title font size bigger
    axis.title.y = element_text(size = 16),      # made y-axis title font size bigger
    plot.title = element_text(size = 18, face = "bold") #size of the title
  )   

ggsave(here("Week_03", "Output", "Pengiun graph.png"), 
       width = 7, height = 5) #saving it with certain dimensions 

Pengiun_plot #testing it out