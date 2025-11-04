install.packages('reprex') #reproducible example
install.packages('datapasta') #copy and paste
install.packages('styler') # copy and paste in style

library(tidyverse)
mpg %>%
  ggplot(aes(x = displ, y = hwy))%>%
  geom_point(aes(color = class))

lat    long    star_no
33.548    -117.805    10
35.534    -121.083    1
39.503    -123.743    25
32.863    -117.24    22
33.46    -117.671 


df <- tibble::tribble(
                           ~lat....long....star_no,
                        "33.548    -117.805    10",
                         "35.534    -121.083    1",
                        "39.503    -123.743    25",
                         "32.863    -117.24    22",
                          "33.46    -117.671    8",
                         "33.548    -117.805    3"
                        )
   8
33.548    -117.805    3
