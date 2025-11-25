####Week_13_Inclass_pt2

install.packages('modelsummary') # to show model output
install.packages('tidymodels') # for tidy models
install.packages('broom') # for clean model output
install.packages('flextable') # to look at model results in a nice table
install.packages('peformance') # to check model assumptions
install.packages('see') # needs to be installed, but does not need to be loaded in the library, required for performance
library(tidyverse)
library(here)
library(palmerpenguins)
library(broom)
library(performance) 
library(modelsummary)
library(tidymodels)

# Linear model of Bill depth ~ Bill length by species
Peng_mod<-lm(bill_length_mm ~ bill_depth_mm*species, data = penguins)

# New model
Peng_mod_noX<-lm(bill_length_mm ~ bill_depth_mm, data = penguins)
#Make a list of models and name them
models<-list("Model with interaction" = Peng_mod,
             "Model with no interaction" = Peng_mod_noX)
#Save the results as a .docx
modelsummary(models, output = here("Week_13","output","table.docx"))

