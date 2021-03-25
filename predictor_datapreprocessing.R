# load library
library(plyr)
library(rvest)
library(tidyverse)
library(readr)
library(ggplot2)
library (splines)
library(stringr)

#read all .csv documents
setwd("D:/dataexpo/data/acs_2019/county_1yr/demographic")
temp = list.files(pattern="*.csv")

coln171 <- c("HH_Total_households",
             "HH_Married-couple_family",
             "HH_Married-couple_family_With_own_children_of_the_householder_under_18_years",
             "HH_Cohabiting_couple_household",
             "HH_Cohabiting_couple_household_With_own_children_of_the_householder_under_18_years",
             "HH_Male_householder_no_spouse_or_partner_present",
             "HH_Male_householder_no_spouse_or_partner_present_With_own_children_of_the_householder_under_18_years",
             "HH_Male_householder_no_spouse_or_partner_present_Householder_living_alone",
             "HH_Male_householder_no_spouse_or_partner_present_65_years_and_over",
             "HH_Female_householder_no_spouse_or_partner_present",
             "HH_Female_householder_no_spouse_or_partner_present_With_own_children_of_the_householder_under_18_years",
             "HH_Female_householder_no_spouse_or_partner_present_Householder_living_alone",
             "HH_Female_householder_no_spouse_or_partner_present_65_years_and_over",
             "HH_Households_with_one_or_more_people_under_18_years",
             "HH_Households with one or more people 65 years and over",
             "HH_Average_household_size",
             "HH_Average_family_size",
             "RS_Population_in_households",
             "RS_Householder",
             "RS_Spouse",
             "RS_Unmarried_partner",
             "RS_Child",
             "RS_Other_relatives",
             "RS_Other_nonrelatives",
             "MS_Males_15_years_and_over",
             "MS_Males_Never_married",
             "MS_Males_Now married, except separated",
             "MS_Males_Separated",
             "MS_Males_Widowed",
             "MS_Males_Divorced",
             "MS_"
             
)

for (i in 1:length(temp)) {
  df <- read.csv(temp[i])
  names(df)[1] <- "Label"
  # first remember the names
  coln <- df$Label
  # transpose all but the first column (name)
  df <- as.data.frame(t(df[,-1]))
  colnames(df) <- coln
  if (ncol(df) == 171) {
    df_ <- df[,-c(1,19,27,40,48,51,59,66,77,80,89,98,106,110,118,126,139,168,169)]
    colnames(df_) <- coln171
  }
  elseif (ncol(df) == 94) {
    
  }
  assign(temp[i], df[c(TRUE,FALSE,FALSE,FALSE),]) 
  
}

