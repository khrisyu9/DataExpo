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
             "MS_Males_Now_married_except_separated",
             "MS_Males_Separated",
             "MS_Males_Widowed",
             "MS_Males_Divorced",
             "MS_Females_15_years_and_over",
             "MS_Females_Never_married",
             "MS_Females_Now_married_except_separated",
             "MS_Females_Separated",
             "MS_Females_Widowed",
             "MS_Females_Divorced",
             "FY_Number_of_women_15_to_50_years_old_who_had_a_birth_in_the_past_12_months",
             "FY_Number_of_women_15_to_50_years_old_who_had_a_birth_in_the_past_12_months_Unmarried_women",
             "FY_Number_of_women_15_to_50_years_old_who_had_a_birth_in_the_past_12_months_Unmarried_women_Per_1000_unmarried_women",
             "FY_Number_of_women_15_to_50_years_old_who_had_a_birth_in_the_past_12_months_Per_1000_women_15_to_50_years_old",
             "FY_Number_of_women_15_to_50_years_old_who_had_a_birth_in_the_past_12_months_Per_1000_women_15_to_19_years_old",
             "FY_Number_of_women_15_to_50_years_old_who_had_a_birth_in_the_past_12_months_Per_1000_women_20_to_34_years_old",
             "FY_Number_of_women_15_to_50_years_old_who_had_a_birth_in_the_past_12_months_Per_1000_women_35_to_50_years_old",
             "GP_Number_of_grandparents_living_with_own_grandchildren_under_18_years",
             "GP_Number_of_grandparents_living_with_own_grandchildren_under_18_years_Grandparents_responsible_for_grandchildren",
             "GP_Number_of_grandparents_living_with_own_grandchildren_under_18_years_Grandparents_responsible_for_grandchildren_Years_responsible_for_grandchildren_Less_than_1_year",
             "GP_Number_of_grandparents_living_with_own_grandchildren_under_18_years_Grandparents_responsible_for_grandchildren_Years_responsible_for_grandchildren_1_or_2_years",
             "GP_Number_of_grandparents_living_with_own_grandchildren_under_18_years_Grandparents_responsible_for_grandchildren_Years_responsible_for_grandchildren_3_or_4_years",
             "GP_Number_of_grandparents_living_with_own_grandchildren_under_18_years_Grandparents_responsible_for_grandchildren_Years_responsible_for_grandchildren_5_or_more_years",
             "GP_Number_of_grandparents_responsible_for_own_grandchildren_under_18_years",
             "GP_Number_of_grandparents_responsible_for_own_grandchildren_under_18_years_Who_are_female",
             "GP_Number_of_grandparents_responsible_for_own_grandchildren_under_18_years_Who_are_married",
             "SE_Population_3_years_and_over_enrolled_in_school",
             "SE_Population_3_years_and_over_enrolled_in_school_Nursery_school_preschool",
             "SE_Population_3_years_and_over_enrolled_in_school_Kindergarten",
             "SE_Population_3_years_and_over_enrolled_in_school_Elementary_school_grades_1-8",
             "SE_Population_3_years_and_over_enrolled_in_school_High_school_grades_9-12",
             "SE_Population_3_years_and_over_enrolled_in_school_College_or_graduate_school",
             ""
             
             
             
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

