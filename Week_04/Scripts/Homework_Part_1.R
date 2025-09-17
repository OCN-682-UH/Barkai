### This is a script of homework Part 1 ####
### Created by: Leah Barkai #############
### Updated on: 2025-09-16 ####################

#### Load Libraries ######
library(palmerpenguins)
library(tidyverse)
library(here)
library(ggplot2)

### Load data ######
# The data is part of the package and is called penguins
glimpse(penguins)

### Functions ###
#homework part 1: 
penguins %>% #calling the dataset and then
  group_by(species, island, sex) %>% #creates groups with species, island and sex
  summarise( #summarizing per group
    mean_body_mass = mean(body_mass_g, na.rm = TRUE), #Creating new column named mean body mass with the averages (mean) for each group 
                                                      ##na.rm = TRUE means to ignore the NAs when calculating the mean
                                                      ##*remember - each line needs a comma in summarise
    var_body_mass = var(body_mass_g, na.rm = TRUE)) #Creating new column named variance body mass with the variances for each group

#homework part 2:
penguins_female <- penguins %>% #Calling the new dataset and then using penguins dataset and then 
  filter(sex != "male") %>% #Keeps only rows where the sex is not a male so excluding males 
  mutate(log_body_mass = log(body_mass_g)) %>% #mutate will create new columns or change the existing columns in the data frame but the rest is the same and this is added to the new dataset then changing the old one
                                               #taking the logarithm of each value in the body mass column
  select(species, island, sex, log_body_mass) #taking only species, etc. columns that you need including the log one I made in the step before

view(penguins_female)

#plot
g<-ggplot(penguins_female, #using the female penguin dataset I created above 
       aes(x = species, y = log_body_mass, fill = species)) + #mapping the x and y axis then filling each species its own color 
  geom_violin(trim = FALSE) + #using a violin plot then not trimming off any data and showing the whole shape 
  labs(title = "Distribution of Log Body Mass for Female Penguins", #then labeled title, x and y axis
       x = "Penguin Species", 
       y = "Log Body Mass (g)")+
  theme_minimal(base_size = 12) #used the minimal theme (no gray boxes) and put the font size to 12

ggsave(here("Week_04", "Output","Distribution_of_Log_Body_Mass_for_Female_Penguins.png"), #This is where I am saving it and what it will be called
       plot=g, #I am saving plot g I made
       width = 6, height = 4) #this is the dimensions

       