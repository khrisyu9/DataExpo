# load library
library(rvest)
library(dplyr)
library(readr)
library(ggplot2)
library (splines)

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

fit=lm(newcases ~ bs(date, df = 6),data=arlington_va)
summary(fit)

pred=predict(fit,newdata =list(date=arlington_va$date),se=T)

date.cases.plot <- ggplot(arlington_va, aes(date, newcases)) + 
  geom_point() + 
  theme_minimal() 

date.cases.plot + geom_line(aes(arlington_va$date, pred$fit), color = "blue")
 
# apply to all counties in Virginia
va <- countydata %>% 
  filter(state == "Virginia")
va_county <- unique(va[c("county")])
va_countyname = va_county %>% pull(county)

coef_1 <- 0
coef_2 <- 0
coef_3 <- 0
coef_4 <- 0
coef_5 <- 0
coef_6 <- 0
coef_7 <- 0
coef_df <- data.frame(coef_1, coef_2, coef_3, coef_4, coef_5, coef_6, coef_7)

for (i in 1:length(va_countyname)){
  county_data <- filter(countydata, county == va_countyname[i])
  county_data$newcases <- seq(0, nrow(county_data)-1)
  county_data$newcases[1] <- county_data$cases[1]
  for (j in 2:nrow(county_data)){
    county_data$newcases[j] = county_data$cases[j]-county_data$cases[j-1]
  }
  fit <- lm(newcases ~ bs(date, df = 6), data = county_data)
  coef_df <- rbind(coef_df, fit$coefficients)
}

coef_df <- coef_df[-1,]
coef_df_va <- cbind(va_county, coef_df)

# merge acs data


# variable selection

# different selection

# quadratic spline models


# acs models to predict covid-19

# models with pulse data


