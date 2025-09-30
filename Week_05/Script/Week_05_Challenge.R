### This is my script for the challenge
### Created by: Leah Barkai
### Created on: 2025-09-27

### Load libraries ########## 
install.packages("lubridate") # package to deal with dates and times
library(tidyverse)
library(here)
library(lubridate)

### Read in data ###
ConductivityData<-read_csv(here("Week_05","Data","CondData.csv"))

### Data Analysis #####
view(ConductivityData) #this showed - 1/15/2021 8:24:42 which means - mdy hms - m → month (1) d → day (15) y → year (2021) hms → hours:minutes:seconds (8:24:42)
class(ConductivityData$date) #make sure it is a character
ConductivityData <- ConductivityData %>% #calling the data and then 
  mutate( # mutate it to create a new column or modify existing one and then 
    date = mdy_hms(date)   # take the current date column and(=) apply mdy_hms() to date thats why it is inside
  )

view(ConductivityData)
