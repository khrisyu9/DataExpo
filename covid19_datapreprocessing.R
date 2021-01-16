# load library
library(rvest)
library(dplyr)
library(readr)
library(ggplot2)

# read page
countyurl <- "https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"
countydata <- read_csv(url(countyurl))

write.csv(countydata, "D:/dataexpo/data/covid19_cases_and_deaths/countylevel.csv")

################# quadratic spline models #############################
#test in one state
arlington_va <- countydata %>% 
  filter(county == "Arlington" & state == "Virginia")
arlington_va$newcases <- seq(0, nrow(arlington_va))
arlington_va$newcases[1] <- arlington_va$cases[1]

for (i in 2:nrow(arlington_va)){
  arlington_va$newcases[i] = arlington_va$cases[i]-arlington_va$cases[i-1]
}

ggplot(arlington_va, aes(date, newcases)) +
  geom_line() + 
  xlab("")




# merge acs data

# variable selection

# different selection

# quadratic spline models


# acs models to predict covid-19

# models with pulse data


