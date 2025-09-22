### Today I am going to practice tidy with biogeochemistry data from Hawaii ####
### Created by: Leah Barkai #############
### Updated on: 2025-09-21 ####################

#### Load Libraries ######
library(tidyverse)
library(here)

### Load data ######
ChemData<-read_csv(here("Week_04","Data", "chemicaldata_maunalua.csv")) #calling the new dataset called ChemData
View(ChemData)
glimpse(ChemData)

### Data Analysis #####
ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row basically all the NAs
  separate(col = Tide_time, # choose the tide time column which is the one we want to separate
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_" ) # separate by _ bc in the dataset the tide_time is separated by the _
head(ChemData_clean) #you see the new column of tide and time separated 

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) # keep the original tide_time column
head(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>% # keep the original tide_time column
  unite(col = "Site_Zone", # the name of the NEW column *needs to be in quotations!
        c(Site,Zone), # the columns to unite
        sep = ".", # lets put a . in the middle – you are seeing here what it is like if you join it together with a period
        remove = FALSE) # keep the original
head(ChemData_clean)

ChemData_long <-ChemData_clean %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot or call from. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the new column names
               values_to = "Values") # names of the new column with all the values
View(ChemData_long)

ChemData_long %>% ###now taking the data we just made the long data
  group_by(Variables, Site) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean #na.rm = TRUE to get rid of the NAs
            Param_vars = var(Values, na.rm = TRUE)) # get variance

ChemData_long %>%
  group_by(Variables, Site, Zone, Tide) %>% # group by everything we want 
  summarise(
    Param_means = mean(Values, na.rm = TRUE), # get mean 
    Param_vars = var(Values, na.rm = TRUE), # get variance
    Param_sd = sd(Values, na.rm = TRUE)) # get standard deviation

ChemData_wide<-ChemData_long %>%
  pivot_wider(names_from = Variables, # column with the names for the new columns
              values_from = Values) # column with the values
View(ChemData_wide)

ChemData_clean<-ChemData %>%
  drop_na()  #filters out everything that is not a complete row
View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE)
View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") # names of the new column with all the values
View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols  
               names_to = "Variables", # the names of the new cols with all the column names 
               values_to = "Values") %>% # names of the new column with all the values 
  group_by(Variables, Site, Time) %>%
  summarise(mean_vals = mean(Values, na.rm = TRUE))
View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols  
               names_to = "Variables", # the names of the new cols with all the column names 
               values_to = "Values") %>% # names of the new column with all the values 
  group_by(Variables, Site, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables,
              values_from = mean_vals) # notice it is now mean_vals as the col name
View(ChemData_clean)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols  
               names_to = "Variables", # the names of the new cols with all the column names 
               values_to = "Values") %>% # names of the new column with all the values 
  group_by(Variables, Site, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables, 
              values_from = mean_vals) %>% # notice it is now mean_vals as the col name
  write_csv(here("Week_04","output","summary.csv"))  # export as a csv to the right folder
## summarise() has grouped output by 'Variables', 'Site'. You can override using
## the .groups argument.


