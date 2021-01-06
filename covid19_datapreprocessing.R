# load library
library(rvest)
library(dplyr)
library(readr)

# read page
countyurl <- "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"
countydata <- read_csv(url(countyurl))

write.csv(countydata, "D:/dataexpo/data/covid19_cases_and_deaths/countylevel.csv")

# merge acs data

# variable selection

# different selection

# quadratic spline models

# acs models to predict covid-19

# models with pulse data


