# load library
library(rvest)
library(tidyverse)
library(readr)
library(ggplot2)
library (splines)
library(stringr)

county_code <- read.csv("D:/dataexpo/data/county_code.csv")
  
county_code <- county_code[,-1]

county_code$geo_value <- str_pad(county_code$geo_value, 5, pad = "0")

covid_cases_new <- merge(covid_cases, county_code, by = "geo_value")

covid_cases_new$geo_value <- as.factor(covid_cases_new$geo_value)

covid_cases_new_ <- covid_cases_new[,c(1,4,7,10,11)]

covid_cases_by_county <- as_tibble(covid_cases_new_) %>%
  nest(-geo_value, -county_name, -state)

covid_cases_splines <- covid_cases_by_county %>%
  mutate(fit = map(data, lm(.$value ~ bs(.$time_value, df = 6))))

  
  
  