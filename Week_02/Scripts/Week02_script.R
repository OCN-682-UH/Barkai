### This is my first script.  I am learning how to import data
### Created by: Leah Barkai
### Created on: 2025-09-05


### Load libraries ########## 
library(tidyverse)
library(here)


### Read in data ###
WeightData<-read_csv(here("Week_02","Data","weightdata.csv"))

### Data Analysis #####
head(WeightData)
tail(WeightData)
view(WeightData)
