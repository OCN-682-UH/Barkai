### This is my script for my week 5 homework
### Created by: Leah Barkai
### Created on: 2025-09-27

### Load libraries ########## 
install.packages("lubridate") # package to deal with dates and times
library(tidyverse)
library(here)
library(lubridate)
library(ggplot2)
library(ggrepel)
library(here)

### Read in data ###
ConductivityData<-read_csv(here("Week_05","Data","CondData.csv")) 
  #This is temperature and salinity data taken at a site with groundwater while being dragged behind a float. Data were collected every 10 seconds.
Depthdata<-read_csv(here("Week_05","Data","DepthData.csv")) #adding the data in 

### Data Analysis ##### Depth data is already in the right format so only need to do the conductivity data
ConductivityData <-ConductivityData %>% #calling in the data
  mutate(date=mdy_hms(date)) %>% #changing the date column to a different format
  mutate(date = round_date(date, "10 seconds")) %>% #rounding the date to the nearest 10 secs
  inner_join(Depthdata, by = "date") %>%
  #combining the data by the date column where there is data for both data sets 
  ## dont need to add the conductivitydata part cuz you are already changing that data 
  mutate(date = floor_date(date, "minute")) %>%  # rounding down to nearest minute
  group_by(date) %>% #grouping by the date column - basically for each mintue 
  summarize(
    depth = mean(Depth, #finding the average depth each minute and 
                 na.rm = TRUE), #removing anything with a NA
    temperature = mean(Temperature, na.rm = TRUE), #finding other average and removing NAs
    salinity = mean(Salinity, na.rm = TRUE) #finding other average and removing NAs
  )

longData <- ConductivityData %>% #changing the data from wide to long
  pivot_longer(cols = c(salinity, temperature), # These are the columns I am going to change
               names_to = "variable", # Name of new column for variable names
               values_to = "value") # Name of new column for measurements

# Create a ggplot of the long data
ggplot(longData, aes(x = date, y = value, color = variable)) +  
    # Date is going on x axis, value on y and color by variable
  geom_line() + # Draw lines connecting points for each variable
  geom_text_repel( # Removing the legend and putting the names by the lines 
    data = longData %>% #using this data
      group_by(variable) %>% #groups the data by each variable so like salinity and temp
      slice_max(date), #selects dot of the last point so the label can go there
    aes(label = variable), #puts the text here
    show.legend = FALSE) + #no legend 
      labs(
    title = "Salinity and Temperature Over Time", # Title
    x = "Time", # X axis label
    y = "Value (Temp = °C Salinity = PSU)", # Y axis label
    color = "Variable" # legend title
  ) +
  theme_minimal() + # use a clean minimal theme for readability
  theme(legend.position = "none")  # remove legend

#Save plot 
ggsave( filename = here("Week_05", "Output", #where to save it
                        "Salinity_Temperature_Plot.png"), #name to save it
     width = 8, height = 5)
