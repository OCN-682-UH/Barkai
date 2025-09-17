### Today we are going to plot penguin data ####
### Created by: Leah Barkai #############
### Updated on: 2025-09-16 ####################

#### Load Libraries ######
library(palmerpenguins)
library(tidyverse)
library(here)

### Load data ######
# The data is part of the package and is called penguins
glimpse(penguins)

### Functions ###
filter(.data = penguins, sex == "female" )

### Read in data ###
filter(.data=penguins, year == 2008) ### Penguins measured in the year 2008 or you can do in quotes too "2008"
filter(.data=penguins, body_mass_g > 5000) ####	Penguins that have a body mass greater than 5000

filter(.data=penguins, year==2008 | year==2009)  ##Penguins that were collected in either 2008 or 2009
filter(.data=penguins, year %in% c(2008, 2009)) ## can do this instead
filter(.data=penguins, islands != "Dream") ## Penguins that are not from the island Dream
filter(.data=penguins, species %in% c("Adelie", "Gentoo")) ## Penguins in the species Adelie and Gentoo

data<-mutate(.data=penguins, ###Use mutate to create a new column to add flipper length and body mass together
            adding = flipper_length_mm + body_mass_g)      
view(data)       

data2 <- mutate(penguins, 
       size=ifelse(body_mass_g > 400, "big", "small")) ###Use mutate and ifelse to create a new column where body mass greater than 4000 is labeled as big and everything else is small
view(data2)
