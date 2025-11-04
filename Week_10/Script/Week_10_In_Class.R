##In Class Notes 

library(tidyverse)
set.seed(42)  # always produces the same random numbers
df <- tibble(
  a = rnorm(10), # draws 10 random values from a normal distribution
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

head(df)

df<-df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)))

df<-df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)),
         b = (b-min(b, na.rm = TRUE))/(max(b, na.rm = TRUE)-min(b, na.rm = TRUE)),
         c = (c-min(c, na.rm = TRUE))/(max(c, na.rm = TRUE)-min(c, na.rm = TRUE)),
         d = (d-min(d, na.rm = TRUE))/(max(d, na.rm = TRUE)-min(d, na.rm = TRUE)))

#function to covert degrees fahrenheit to celcius
temp_C <- (temp_F - 32) * 5 / 9

fahrenheit_to_celsius <- function() {
}

fahrenheit_to_celsius <- function(temp_F ) {
                                  temp_C <- (temp_F - 32) * 5 / 9 
}
#temp_F this is the input
#temp_C this is the output

fahrenheit_to_celsius <- function(temp_F) { 
  temp_C <- (temp_F - 32) * 5 / 9 
  return(temp_C)
}


fahrenheit_to_celsius(32)

fahrenheit_to_celsius(212)
#name the function
F_degrees_to_K_degrees <- function() {
}
#Put the equation
F_degrees_to_K_degrees <- function() { 
  temp_C <- (temp_C +273.15)
}

C_degrees_to_K_degrees <- function(temp_C) { 
  temp_K <- temp_C +273.15
  return(temp_K)
}

C_degrees_to_K_degrees(43)


library(palmerpenguins)
library(PNWColors) # for the PNW color palette 
# you may need to install the PNWColors library if you haven't used it yet
pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and another example of how to manually change the legend title for colors
  theme_bw()

myplot<-function(){
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

myplot<-function(data, x, y){
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = x, y =y , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

myplot<-function(data, x, y){ 
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

myplot(data = penguins, x = body_mass_g, y = bill_length_mm)

