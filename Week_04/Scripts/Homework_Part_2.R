### This is homework part 2 for week 4 ####
### Created by: Leah Barkai #############
### Updated on: 2025-09-21 ####################

#### Load Libraries ######
library(tidyverse)
library(here)
install.packages("ggrepel")
library(ggrepel)

### Load data ######
ChemData<-read_csv(here("Week_04","Data", "chemicaldata_maunalua.csv")) #calling the new dataset called ChemData
View(ChemData)
glimpse(ChemData)

### Data Analysis #####
ChemData_Clean<-ChemData %>% ##this is the new name of the data and then 
  drop_na() %>% #filters out (removes) any row that has NA
  separate(col = Tide_time, # I want to separate the Tide_time column out
           into = c("Tide","Time"), # separate it into two columns with names Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>% #this keeps the original Tide_time cloumn in the dataset and then 
  filter(Salinity >= 30) %>% #taking out the salinity less than 30 and then 
  pivot_longer(cols = c(Phosphate, Silicate, NN),  # grouping together these columns
               names_to = "Nutrients", # the name of the new column
               values_to = "Concentrations") # name of the new column with all the values 
ChemData_Salinity_summary <- ChemData_Clean %>% #adding another name
  group_by(Zone, Waypoint) %>% #groups data together by zone and waypoint
  summarize(mean_salinity = mean(Salinity, na.rm = TRUE)) %>% #doing the mean salinity of each group
  write_csv(here("Week_04","Output","ChemData_Salinity_summary.csv"))  # export as a csv to the right folder

Salinity_labels <- ChemData_Salinity_summary %>% #adding another name
  group_by(Zone) %>% #each zone has its own line in the plot to group each zone seapartely not together
  slice_max(Waypoint)  # picks the row with the largest Waypoint for each Zone so we can label on that part

view(Salinity_labels)

# Plot
p<-ggplot(ChemData_Salinity_summary, #naming the plot p
          aes(x = Waypoint, y = mean_salinity, color = Zone, #line and point is done in same color 
              group = Zone)) + #to get each zone its only color
  geom_line(size = 1) + #draws a line connecting the points
  geom_point(size = 2) + #adding data points dot
  geom_text_repel( data = Salinity_labels, aes(label = Zone), #putting labels at the end of the lines
    nudge_x = 0.5, # moves the text a little to the right so it isn't super busy
    direction = "y", #makes the labels not overlap 
    hjust = 0,#this puts the label down a little
    segment.color = NA, #removes the line connecting text to point
    show.legend = FALSE #removing an a in the legend by the color
  ) +
  labs(title = "Salinity Across Zones and Waypoints", #plot title
       x = "Waypoint", #x axis 
       y = "Mean Salinity (ppt)") + #y axis
  theme_light() #light theme for the graph

# Export plot
ggsave( filename = here("Week_04", "Output", #where to save it
    "Salinity_Plot.png"), #name to save it
      plot = p, width = 8, height = 5) #look to it

