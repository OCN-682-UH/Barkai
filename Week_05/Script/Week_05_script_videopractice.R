### This is my script to practice lubridate. 
### Created by: Leah Barkai
### Created on: 2025-09-27

### Load libraries ########## 
install.packages("lubridate") # package to deal with dates and times
library(tidyverse)
library(here)
library(lubridate)

### Read in data ###
EnviroData<-read_csv(here("Week_05","Data","site.characteristics.data.csv"))
ConductivityData<-read_csv(here("Week_05","Data","CondData.csv"))

### Data Analysis #####
now() #what time is it now?
now(tzone = "EST") # what time is it on the east coast
now(tzone = "GMT") # what time in GMT
today()
today(tzone = "GMT")
am(now()) # is it morning?
leap_year(now()) # is it a leap year?

ymd("2021-02-24")
mdy("02/24/2021")
mdy("February 24 2021")
dmy("24/02/2021")

ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20")
mdy_hm("February 24 2021 10:22 PM")

# make a character string
datetimes<-c("02/24/2021 22:22:20",
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")
datetimes <- mdy_hms(datetimes)
month(datetimes)

datetimes <- mdy_hms(datetimes) 
month(datetimes, label = TRUE)

# convert to datetimes
datetimes <- mdy_hms(datetimes) 
month(datetimes, label = TRUE, abbr = FALSE) #Spell it out the month not just feb 

datetimes <- mdy_hms(datetimes) 
month(datetimes, label = TRUE, abbr = FALSE) #Spell it out 
day(datetimes) # extract day 
wday(datetimes, label = TRUE) # extract day of week
hour(datetimes)
minute(datetimes)
second(datetimes)

datetimes + hours(4) # this adds 4 hours

## Read in the conductivity data (CondData.csv) and convert the date column to a datetime. Use the %>% to keep everything clean.
glimpse(ConductivityData) #looking at the data
class(ConductivityData$date) #look at the class of the data column 
#class is character so dont need to change it
ConductivityData <- ConductivityData %>% #taking in the data - you need to do this for the first step
  mutate(date = mdy(date),              # parse Month/Day/Year
         date = as_datetime(date))      # convert Date → POSIXct (datetime)

  
head(ConductivityData$date)
  
class(ConductivityData$date)

view (ConductivityData)

library(devtools)
install_github("Gibbsdavidl/CatterPlots") # install the data
library(CatterPlots)
x <-c(1:10)# make up some data
y<-c(1:10)
catplot(xs=x, ys=y, cat=3, catcolor='blue')

