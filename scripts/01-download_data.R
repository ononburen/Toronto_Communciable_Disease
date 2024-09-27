#### Preamble ####
# Purpose: Downloads and saves the data from 
# Author: Onon Burentuvshin
# Date: 24 September 2024
# Contact: onon.burentuvshin@mail.utoronto.ca
# License: MIT




#### Workspace setup ####
install.packages("opendatatoronto")
install.packages("knitr")
install.packages("tidyverse")
install.packages("janitor")
install.packages("knitr")

library(knitr)
library(janitor)
library(lubridate)
library(opendatatoronto)
library(tidyverse)
library(ggplot2)
library(dplyr)

#### Download data ####
library(knitr)
library(janitor)
library(lubridate)
library(opendatatoronto)
library(tidyverse)
library(ggplot2)
library(dplyr)

resources <- list_package_resources("ec1f8fbb-0296-4eaf-a10d-c58adc0d4245") # get all resources for this package



#### Save data ####
.
write_csv(resources, "data/raw_data/raw_data.csv")

         
