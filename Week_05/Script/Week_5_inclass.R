### Today we are going to practice joins with data from Becker and Silbiger (2020) ####
### Created by: Dr. Nyssa Silbiger #############
### Updated on: 2025-09-24 ####################

#### Load Libraries ######
library(tidyverse)
library(here)

### Load data ######
# Environmental data from each site
EnviroData<-read_csv(here("Week_05","Data","site.characteristics.data.csv"))

#Thermal performance data
TPCData<-read_csv(here("Week_05","data","Topt_data.csv"))
glimpse(EnviroData)
glimpse(TPCData)

### Data Analysis #####
EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured, # pivot the data wider
              values_from = values) %>%
  arrange(site.letter) # arrange the dataframe by site
View(EnviroData_wide)

FullData_left<- left_join(TPCData, EnviroData_wide)
## Joining with by = join_by(site.letter)
head(FullData_left)

FullData_left<- left_join(TPCData, EnviroData_wide) %>%
  relocate(where(is.numeric), .after = where(is.character)) # relocate all the numeric data after the character data
## Joining with by = join_by(site.letter)
head(FullData_left)

view(FullData_left)

FullData_long <- FullData_left %>%
  pivot_longer(cols = -Site, names_to = "Variable", values_to = "Value")

FullData_long <- FullData_left %>%
  pivot_longer(cols = rate.type:name, names_to = "Variable", values_to = "Value")


view(FullData_long)

FullData_long <- FullData_left %>%
  pivot_longer(
    cols = where(is.numeric),    # pivot all numeric columns
    names_to = "variable",       # name of the new "variable" column
    values_to = "value"          # name of the new "value" column
  )

FullData_summary <- FullData_long %>%
  group_by(name, variable) %>%
  summarise(
    mean = mean(value),
    var = var(value),
    .groups = "drop"
  )

view(FullData_summary)    

# Make 1 tibble
T1 <- tibble(Site.ID = c("A", "B", "C", "D"), 
             Temperature = c(14.1, 16.7, 15.3, 12.8))
T1

# make another tibble
T2 <-tibble(Site.ID = c("A", "B", "D", "E"), 
            pH = c(7.3, 7.8, 8.1, 7.9))
T2

left_join(T1, T2)
## Joining with by = join_by(Site.ID)
## # A tibble: 4 × 3
##   Site.ID Temperature    pH
##   <chr>         <dbl> <dbl>
## 1 A              14.1   7.3
## 2 B              16.7   7.8
## 3 C              15.3  NA  
## 4 D              12.8   8.1
right_join(T1, T2)
## Joining with by = join_by(Site.ID)
## # A tibble: 4 × 3
##   Site.ID Temperature    pH
##   <chr>         <dbl> <dbl>
## 1 A              14.1   7.3
## 2 B              16.7   7.8
## 3 D              12.8   8.1
## 4 E              NA     7.9

install.packages("cowsay")
library(cowsay)
28 / 32

# I want a shark to say hello
say("hello", by = "shark")
say("Hi, my name is Elle", by = "dog")
