#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers
# Author: Onon Burentuvshin
# Date: 24 September 2024
# Contact: onon.burentuvshin@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(knitr)
library(janitor)
library(lubridate)
library(opendatatoronto)
library(tidyverse)
library(ggplot2)
library(dplyr)

#### Clean data ####
raw_data <- read_csv("data/raw_data/raw_data.csv")

# For the purposes of our research, we want to filter these files by year and obtain only 2016-2018 and 2022-2024.

data_2016 <- get_resource("4208259c-2d01-4b6b-8bbc-85fbb45d70c3")
data_2017 <- get_resource("249b423e-bba8-4c31-8a4d-6f97b66eacd2")
data_2018 <- get_resource("0564bbf2-828c-487c-80b5-c250968210f2")


data_2022 <- get_resource("63b62ca8-54de-4acb-8417-9cdf4e795424")
data_2023 <- get_resource("38454ad6-b6f8-4235-9fed-8c10fcde3471")
data_2024 <- get_resource("45575e74-2a6e-4165-bf6c-fc1b59795e93")

#To get rid of bias of including Covid-19 in our 2022-2024 data set, we remove the Covid row altogether.
data_2022 <- data_2022[-39, ]
data_2023 <- data_2023[-39, ]
data_2024 <- data_2024[-39, ]

#Ultimately, we want to have columns where we have a given year and disease counts in the rows.

data_2016_selected <- data_2016 %>%
  select(3, 4)

data_2017_selected <- data_2017 %>%
  select(3, 4)

data_2018_selected <- data_2018 %>%
    select(3, 4)

#Select only releveant columns
data_2022_selected <- data_2022 %>%
  select(2, 3)
data_2023_selected <- data_2023 %>%
  select(2, 3)
data_2024_selected <- data_2024 %>%
  select(2, 3)



#Get rid of N/A rows that provide no data
data_2016_clean <- na.omit(data_2016_selected)
data_2017_clean <- na.omit(data_2017_selected)
data_2018_clean <- na.omit(data_2018_selected)

data_2022_clean <- na.omit(data_2022_selected)
data_2023_clean <- na.omit(data_2023_selected)
data_2024_clean <- na.omit(data_2024_selected)

data_2016_clean <- data_2016_clean[-1, ]
data_2016_clean <- data_2016_clean %>%
  rename('2016 YTD Cases' = ...3,
         '2016 YTD Rate' = ...4)

data_2017_clean <- data_2017_clean[-1, ]
data_2017_clean <- data_2017_clean %>%
  rename('2017 YTD Cases' = ...3,
         '2017 YTD Rate' = ...4)

data_2018_clean <- data_2018_clean[-1, ]
data_2018_clean <- data_2018_clean %>%
  rename('2018 YTD Cases' = ...3,
         '2018 YTD Rate' = ...4)

data_2022_clean <- data_2022_clean[-1, ]
data_2022_clean <- data_2022_clean %>%
  rename('2022 YTD Cases' = ...2,
         '2022 YTD Rate' = ...3)

data_2023_clean <- data_2023_clean[-1, ]
data_2023_clean <- data_2023_clean %>%
  rename('2023 YTD Cases' = ...2,
         '2023 YTD Rate' = ...3)
data_2024_clean <- data_2024_clean[-1, ]
data_2024_clean <- data_2024_clean %>%
  rename('2024 YTD Cases' = ...2,
         '2024 YTD Rate' = ...3)

#This data will be used later to produce distributions of rate per 100,000

#We want pure count comparisons between years of YTD cases.
 
data_2016_clean <- data_2016_clean %>%
  select(-2)  
data_2016_clean[[1]] <- as.numeric(as.character(data_2016_clean[[1]]))
total_sum <- sum(data_2016_clean[[1]], na.rm = TRUE)
data_2016_clean[1, 1] <- total_sum
data_2016_clean <- data_2016_clean[1, , drop = FALSE]

data_2017_clean <- data_2017_clean %>%
  select(-2)  
data_2017_clean[[1]] <- as.numeric(as.character(data_2017_clean[[1]]))
total_sum <- sum(data_2017_clean[[1]], na.rm = TRUE)
data_2017_clean[1, 1] <- total_sum
data_2017_clean <- data_2017_clean[1, , drop = FALSE]

data_2018_clean <- data_2018_clean %>%
  select(-2)  
data_2018_clean[[1]] <- as.numeric(as.character(data_2018_clean[[1]]))
total_sum <- sum(data_2018_clean[[1]], na.rm = TRUE)
data_2018_clean[1, 1] <- total_sum
data_2018_clean <- data_2018_clean[1, , drop = FALSE]

data_2022_clean <- data_2022_clean %>%
  select(-2)  
data_2022_clean[[1]] <- as.numeric(as.character(data_2022_clean[[1]]))
total_sum <- sum(data_2022_clean[[1]], na.rm = TRUE)
data_2022_clean[1, 1] <- total_sum
data_2022_clean <- data_2022_clean[1, , drop = FALSE]

data_2023_clean <- data_2023_clean %>%
  select(-2)  
data_2023_clean[[1]] <- as.numeric(as.character(data_2023_clean[[1]]))
total_sum <- sum(data_2023_clean[[1]], na.rm = TRUE)
data_2023_clean[1, 1] <- total_sum
data_2023_clean <- data_2023_clean[1, , drop = FALSE]

data_2024_clean <- data_2024_clean %>%
  select(-2)  
data_2024_clean[[1]] <- as.numeric(as.character(data_2024_clean[[1]]))
total_sum <- sum(data_2024_clean[[1]], na.rm = TRUE)
data_2024_clean[1, 1] <- total_sum
data_2024_clean <- data_2024_clean[1, , drop = FALSE]


#Combine them to gain a coherent data set.

combined_data <- cbind(data_2016_clean, data_2017_clean, data_2018_clean, data_2022_clean, data_2023_clean, data_2024_clean)

#### Save data ####

write_csv(combined_data, "data/analysis_data/analysis_data.csv")





