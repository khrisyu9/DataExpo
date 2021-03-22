# load library
library(plyr)
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

covid_cases_new_ <- covid_cases_new[,c(1,5,8,11,12)]

covid_cases_new_$geo_value <- as.character(covid_cases_new_$geo_value)

# apply spline models to all counties and save coefficients
#coef_1 <- 0
#coef_2 <- 0
#coef_3 <- 0
#coef_4 <- 0
#coef_5 <- 0
#coef_6 <- 0
#coef_7 <- 0
#coef_df <- data.frame(coef_1, coef_2, coef_3, coef_4, coef_5, coef_6, coef_7)

county_list <- unique(covid_cases_new_[c("geo_value")])

covid_cases_new_$days <- as.numeric(julian(as.Date(covid_cases_new_$time_value), origin=as.Date("2020-03-01")))

models <- dlply(covid_cases_new_, "geo_value", function(bycounty) 
  lm(value ~ bs(days, df = 6), data = bycounty))

# Apply coef to each model and return a data frame
coef_df <- ldply(models, coef)

write.csv(coef_df, "D:/dataexpo/data/covidcast/coef_bsmodel_6df_20200301_20201231.csv")

# for (i in 1:length(county_geo)){
#   county_data <- covid_cases_new_[which(covid_cases_new_$geo_value==county_geo[i]),]
#   fit <- lm(value ~ bs(time_value, df = 6), data = county_data)
#   coef_df <- rbind(coef_df, fit$coefficients)
# }
# 
# coef_df <- coef_df[-1,]
# 
# covid_cases_by_county <- as_tibble(covid_cases_new_) %>%
#   nest(-geo_value, -county_name, -state)
# 
# covid_cases_splines <- covid_cases_by_county %>%
#   mutate(fit = map(data, lm(.$value ~ bs(.$time_value, df = 6))))

  
  
  