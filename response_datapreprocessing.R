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

covid_cases <- read.csv("D:/dataexpo/data/covidcast/covid_cases_20200301_20201231.csv")

covid_cases_new <- merge(covid_cases, county_code, by = "geo_value")

covid_cases_new$geo_value <- as.factor(covid_cases_new$geo_value)

covid_cases_new_ <- covid_cases_new[,c(1,4,7,10,11)]

# apply spline models to all counties and save coefficients
coef_1 <- 0
coef_2 <- 0
coef_3 <- 0
coef_4 <- 0
coef_5 <- 0
coef_6 <- 0
coef_7 <- 0
coef_df <- data.frame(coef_1, coef_2, coef_3, coef_4, coef_5, coef_6, coef_7)

county_geo <- unique(covid_cases_new_[c("geo_value")]) #%>% pull(geo_value)

for (i in 1:length(county_geo)){
  county_data <- filter(covid_cases_new_, geo_value == county_geo[i])
  fit <- lm(value ~ bs(time_value, df = 6), data = county_data)
  coef_df <- rbind(coef_df, fit$coefficients)
}

coef_df <- coef_df[-1,]

covid_cases_by_county <- as_tibble(covid_cases_new_) %>%
  nest(-geo_value, -county_name, -state)

covid_cases_splines <- covid_cases_by_county %>%
  mutate(fit = map(data, lm(.$value ~ bs(.$time_value, df = 6))))

  
  
  