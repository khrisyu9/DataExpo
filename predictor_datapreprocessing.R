# load library
library(plyr)
library(rvest)
library(tidyverse)
library(readr)
library(ggplot2)
library (splines)
library(stringr)

# data source: https://www.census.gov/acs/www/data/data-tables-and-tools/data-profiles/

###################################Demographic Variables#####################################
#read all .csv documents
setwd("D:/dataexpo/data/acs_2019/county_1yr/demographic")
temp1 = list.files(pattern="*.csv")

colDC <- c("DC_SA_Total_population_Male",
           "DC_SA_Total_population_Female",
           "DC_SA_Total_population_Median_age_years",
           "DC_RC_Total_population_Two_or_more_races",
           "DC_RC_Total_population_One_race_White",
           "DC_RC_Total_population_One_race_Black_or_African_American",
           "DC_RC_Total_population_One_race_American_Indian_and_Alaska_Native",
           "DC_RC_Total_population_One_race_Asian",
           "DC_RC_Total_population_One_race_Native_Hawaiian_and_Other_Pacific_Islander",
           "DC_HP_Total_population_Hispanic_or_Latino_of_any_race",
           "DC_CZ_Citizen_18_and_over_population_Male",
           "DC_CZ_Citizen_18_and_over_population_Female"
)

for (i in 1:length(temp1)) {
  df <- read.csv(temp1[i])
  names(df)[1] <- "Label"
  # first remember the column names
  coln <- df$Label
  # transpose all but the first column (name)
  df <- as.data.frame(t(df[,-1]))
  colnames(df) <- coln
  df_ <- df[,c(3,4,19,37,39,40,41,46,54,75,93,94)]
  colnames(df_) <- colDC
  df_final <- df_[c(TRUE,FALSE,FALSE,FALSE),]
  df_final$State <- substr(temp1[i], start = 1, stop = 2)
  df_final <- df_final %>% relocate(State)
  assign(temp1[i], df_final)
}

################################### Economic Variables #####################################
#read all .csv documents
setwd("D:/dataexpo/data/acs_2019/county_1yr/economic")
temp2 = list.files(pattern="*.csv")

colEC <- c("EC_ES_Population_16_years_and_over_In_labor_force",
           "EC_ES_Females_16_years_and_over_In_labor_force",
           "EC_ES_Own_children_of_the_householder_under_6_years",
           "EC_ES_Own_children_of_the_householder_6_to_17_years",
           "EC_CW_Workers_16_years_and_over_Car_truck_or_van_drove_alone",
           "EC_CW_Workers_16_years_and_over_Worked_from_home",
           "EC_CW_Workers_16_years_and_over_Mean_travel_time_to_work_minutes",
           "EC_OC_Management_business_science_and_arts_occupations",
           "EC_OC_Service_occupations",
           "EC_OC_Sales_and_office_occupations",
           "EC_OC_Natural_resources_construction_and_maintenance",
           "EC_OC_Production_transportation_and_material_moving",
           "EC_CL_Civilian_employed_population_16_years_and_over_Private_wage_and_salary_workers",
           "EC_IB_Total_households_Median_household_income_dollars",
           "EC_IB_Families",
           "EC_IB_Families_Median_family_income_dollars",
           "EC_IB_Per_capita_income_dollars",
           "EC_IB_Nonfamily_households",
           "EC_IB_Nonfamily_households_Median_nonfamily_income_dollars"
)

for (i in 1:length(temp2)) {
  df <- read.csv(temp2[i])
  names(df)[1] <- "Label"
  # first remember the column names
  coln <- df$Label
  # transpose all but the first column (name)
  df <- as.data.frame(t(df[,-1]))
  colnames(df) <- coln
  df_ <- df[,c(3,12,15,17,21,26,27,30,31,32,33,34,52,68,81,92,94,95,96)]
  colnames(df_) <- colEC
  assign(temp2[i], df_[c(TRUE,FALSE,FALSE,FALSE),])
}

################################### Housing Variables #####################################
#read all .csv documents
setwd("D:/dataexpo/data/acs_2019/county_1yr/housing")
temp3 = list.files(pattern="*.csv")
for (i in 1:length(temp3)) {
  df <- read.csv(temp3[i])
  names(df)[1] <- "Label"
  # first remember the column names
  coln <- df$Label
  # transpose all but the first column (name)
  df <- as.data.frame(t(df[,-1]))
  colnames(df) <- coln
  df_ <- df[,-c(1,19,27,40,48,51,59,66,77,80,89,98,106,110,118,126,139,168)]
  colnames(df_) <- coln153
  assign(temp3[i], df_[c(TRUE,FALSE,FALSE,FALSE),])
  
}

################################### Social Variables #####################################
#read all .csv documents
setwd("D:/dataexpo/data/acs_2019/county_1yr/social")
temp4 = list.files(pattern="*.csv")

colSL <- c("SL_HH_Married-couple_family",
           "SL_HH_Married-couple_family_With_own_children_of_the_householder_under_18_years",
           "SL_HH_Households_with_one_or_more_people_under_18_years",
           "SL_HH_Households_with_one_or_more_people_65_years_and_over",
           "SL_HH_Average_household_size",
           "SL_HH_Average_family_size",
           "SL_RS_Spouse",
           "SL_RS_Unmarried_partner",
           "SL_RS_Child",
           "SL_RS_Other_relatives",
           "SL_RS_Other_nonrelatives",
           "SL_MS_Males_15_years_and_over",
           "SL_MS_Males_15_years_and_over_Never_married",
           "SL_MS_Males_15_years_and_over_Now_married_except_separated",
           "SL_MS_Females_15_years_and_over",
           "SL_MS_Females_15_years_and_over_Never_married",
           "SL_MS_Females_15_years_and_over_Now_married_except_separated",
           "SL_SE_Population_3_years_and_over_enrolled_in_school",
           "SL_SE_Population_3_years_and_over_enrolled_in_school_Elementary_school_grades_1-8",
           "SL_SE_Population_3_years_and_over_enrolled_in_school_High_school_grades_9-12",
           "SL_SE_Population_3_years_and_over_enrolled_in_school_College_or_graduate_school",
           "SL_EA_Population_25_years_and_over_High_school_graduate_or_higher",
           "SL_EA_Population_25_years_and_over_High_Bachelors_degree_or_higher",
           "SL_VS_Civilian_population_18_years_and_over_Civilian_veterans",
           "SL_DS_Total_Civilian_Noninstitutionalized_Population_With_a_disability",
           "SL_R1_Population_1_year_and_over_Same_house",
           "SL_R1_Population_1_year_and_over_Different_house_in_the_US",
           "SL_PB_Total_population_Foreign_born",
           "SL_LS_Population_5_years_and_over_Language_other_than_English",
           "SL_CI_Total_households_With_a_computer",
           "SL_CI_Total_households_With_a_broadband_Internet_subscription"
)

for (i in 1:length(temp4)) {
  df <- read.csv(temp4[i])
  names(df)[1] <- "Label"
  # first remember the column names
  coln <- df$Label
  # transpose all but the first column (name)
  df <- as.data.frame(t(df[,-1]))
  colnames(df) <- coln
  df_ <- df[,c(3,4,15,16,17,18,22,23,24,25,26,28,29,30,34,35,36,60,63,64,65,75,76,79,82,91,92,105,129,170,171)]
  colnames(df_) <- colSL
  assign(temp4[i], df_[c(TRUE,FALSE,FALSE,FALSE),])
}

###################################merge data frames 2,3,4######################################
temp1_ = mget(ls(pattern="*.csv"))
temp2_ = mget(ls(pattern="*2.csv"))
temp3_ = mget(ls(pattern="*3.csv"))
temp4_ = mget(ls(pattern="*4.csv"))

big_data1 = dplyr::bind_rows(temp1_)
big_data2 = dplyr::bind_rows(temp2_)
big_data3 = dplyr::bind_rows(temp3_)
big_data4 = dplyr::bind_rows(temp4_)

big_data <- cbind(big_data1, big_data2)
big_data <- cbind(big_data, big_data3)
big_data <- cbind(big_data, big_data4)

#################################full raw variables below#######################################
#demographic
coln82 <- c("SA_Total_population",
            "SA_Total_population_Male",
            "SA_Total_population_Female",
            "SA_Total_population_Sex_ratio_males_per_100_females",
            "SA_Total_population_Under_5_years",
            "SA_Total_population_5_to_9_years",
            "SA_Total_population_10_to_14_years",
            "SA_Total_population_15_to_19_years",
            "SA_Total_population_20_to_24_years",
            "SA_Total_population_25_to_34_years",
            "SA_Total_population_35_to_44_years",
            "SA_Total_population_45_to_54_years",
            "SA_Total_population_55_to_59_years",
            "SA_Total_population_60_to_64_years",
            "SA_Total_population_65_to_74_years",
            "SA_Total_population_75_to_84_years",
            "SA_Total_population_85_years_and_over",
            "SA_Total_population_Median_age_years",
            "SA_Total_population_Under_18_years",
            "SA_Total_population_16_years_and_over",
            "SA_Total_population_18_years_and_over",
            "SA_Total_population_21_years_and_over",
            "SA_Total_population_62_years_and_over",
            "SA_Total_population_65_years_and_over",
            "SA_Total_population_18_years_and_over_Male",
            "SA_Total_population_18_years_and_over_Female",
            "SA_Total_population_18_years_and_over_Sex_ratio_males_per_100_females",
            "SA_Total_population_65_years_and_over_Male",
            "SA_Total_population_65_years_and_over_Female",
            "SA_Total_population_65_years_and_over_Sex_ratio_males_per_100_females",
            "RC_Total_population_One_race",
            "RC_Total_population_Two_or_more_races",
            "RC_Total_population_One_race_White",
            "RC_Total_population_One_race_Black_or_African_American",
            "RC_Total_population_One_race_American_Indian_and_Alaska_Native",
            "RC_Total_population_One_race_American_Indian_and_Alaska_Native_Cherokee_tribal_grouping",
            "RC_Total_population_One_race_American_Indian_and_Alaska_Native_Chippewa_tribal_grouping",
            "RC_Total_population_One_race_American_Indian_and_Alaska_Native_Navajo_tribal_grouping",
            "RC_Total_population_One_race_American_Indian_and_Alaska_Native_Sioux_tribal_grouping",
            "RC_Total_population_One_race_Asian",
            "RC_Total_population_One_race_Asian_Asian_Indian",
            "RC_Total_population_One_race_Asian_Chinese",
            "RC_Total_population_One_race_Asian_Filipino",
            "RC_Total_population_One_race_Asian_Japanese",
            "RC_Total_population_One_race_Asian_Korean",
            "RC_Total_population_One_race_Asian_Vietnamese",
            "RC_Total_population_One_race_Asian_Other_Asian",
            "RC_Total_population_One_race_Native_Hawaiian_and_Other_Pacific_Islander",
            "RC_Total_population_One_race_Native_Hawaiian_and_Other_Pacific_Islander_Native_Hawaiian",
            "RC_Total_population_One_race_Native_Hawaiian_and_Other_Pacific_Islander_Guamanian_or_Chamorro",
            "RC_Total_population_One_race_Native_Hawaiian_and_Other_Pacific_Islander_Samoan",
            "RC_Total_population_One_race_Native_Hawaiian_and_Other_Pacific_Islander_Other_Pacific_Islander",
            "RC_Total_population_One_race_Some_other_race",
            "RC_Total_population_Two_or_more_races_White_and_Black_or_African_American",
            "RC_Total_population_Two_or_more_races_White_and_American_Indian_and_Alaska_Native",
            "RC_Total_population_Two_or_more_races_White_and_Asian",
            "RC_Total_population_Two_or_more_races_Black_or_African_American_and_American_Indian_and_Alaska_Native",
            "RC_Race_alone_or_in_combination_with_one_or_more_other_races_Total_population_White",
            "RC_Race_alone_or_in_combination_with_one_or_more_other_races_Total_population_Black_or_African_American",
            "RC_Race_alone_or_in_combination_with_one_or_more_other_races_Total_population_American_Indian_and_Alaska_Native",
            "RC_Race_alone_or_in_combination_with_one_or_more_other_races_Total_population_Asian",
            "RC_Race_alone_or_in_combination_with_one_or_more_other_races_Total_population_Native_Hawaiian_and_Other_Pacific_Islander",
            "RC_Race_alone_or_in_combination_with_one_or_more_other_races_Total_population_Some_other_race",
            "HP_Total_population_Hispanic_or_Latino_of_any_race",
            "HP_Total_population_Hispanic_or_Latino_of_any_race_Mexican",
            "HP_Total_population_Hispanic_or_Latino_of_any_race_Puerto_Rican",
            "HP_Total_population_Hispanic_or_Latino_of_any_race_Cuban",
            "HP_Total_population_Hispanic_or_Latino_of_any_race_Other_Hispanic_or_Latino",
            "HP_Total_population_Not_Hispanic_or_Latino",
            "HP_Total_population_Not_Hispanic_or_Latino_White_alone",
            "HP_Total_population_Not_Hispanic_or_Latino_Black_or_African_American_alone",
            "HP_Total_population_Not_Hispanic_or_Latino_American_Indian_and_Alaska_Native_alone",
            "HP_Total_population_Not_Hispanic_or_Latino_Asian_alone",
            "HP_Total_population_Not_Hispanic_or_Latino_Native_Hawaiian_and_Other_Pacific_Islander_alone",
            "HP_Total_population_Not_Hispanic_or_Latino_Some_other_race_alone",
            "HP_Total_population_Not_Hispanic_or_Latino_Two_or_more_races",
            "HP_Total_population_Not_Hispanic_or_Latino_Two_or_more_races_Two_races_including_Some_other_race",
            "HP_Total_population_Not_Hispanic_or_Latino_Two_or_more_races_Two_races_excluding_Some_other_race_and_Three_or_more_races",
            "HP_Total_housing_units",
            "CZ_Citizen_18_and_over_population",
            "CZ_Citizen_18_and_over_population_Male",
            "CZ_Citizen_18_and_over_population_Female"
)

#social
coln153 <- c("HH_Total_households",
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
             "EA_Population_25_years_and_over",
             "EA_Population_25_years_and_over_Less_than_9th_grade",
             "EA_Population_25_years_and_over_9th_to_12th_grade_no_diploma",
             "EA_Population_25_years_and_over_High_school_graduate_includes_equivalency",
             "EA_Population_25_years_and_over_Some_college_no_degree",
             "EA_Population_25_years_and_over_Associates_degree",
             "EA_Population_25_years_and_over_Bachelors_degree",
             "EA_Population_25_years_and_over_Graduate_or_professional_degree",
             "EA_Population_25_years_and_over_High_school_graduate_or_higher",
             "EA_Population_25_years_and_over_High_Bachelors_degree_or_higher",
             "VS_Civilian_population_18_years_and_over",
             "VS_Civilian_population_18_years_and_over_Civilian veterans",
             "DS_Total_Civilian_Noninstitutionalized_Population",
             "DS_Total_Civilian_Noninstitutionalized_Population_With_a_disability",
             "DS_Under_18_years",
             "DS_Under_18_years_With_a_disability",
             "DS_Under_18_to_64_years",
             "DS_Under_18_to_64_years_With_a_disability",
             "DS_Under_65_years_and_over",
             "DS_Under_65_years_and_over_With_a_disability",
             "R1_Population_1_year_and_over",
             "R1_Population_1_year_and_over_Same_house",
             "R1_Population_1_year_and_over_Different_house_in_the_US",
             "R1_Population_1_year_and_over_Different_house_in_the_US_Same_county",
             "R1_Population_1_year_and_over_Different_house_in_the_US_Different_county",
             "R1_Population_1_year_and_over_Different_house_in_the_US_Different_county_Same_state",
             "R1_Population_1_year_and_over_Different_house_in_the_US_Different_county_Different_state",
             "R1_Population_1_year_and_over_Abroad",
             "PB_Total_population",
             "PB_Total_population_Native",
             "PB_Total_population_Native_Born_in_United_States",
             "PB_Total_population_Native_Born_in_United_States_State_of_residence",
             "PB_Total_population_Native_Born_in_United_States_Different_state",
             "PB_Total_population_Native_Born_in_Puerto_Rico_US_Island_areas_or_born_abroad_to_American_parents",
             "PB_Total_population_Foreign_born",
             "CS_Foreign-born_population",
             "CS_Foreign-born_population_Naturalized_US_citizen",
             "CS_Foreign-born_population_Not_a_US_citizen",
             "YE_Population_born_outside_the_United_States",
             "YE_Population_born_outside_the_United_States_Native",
             "YE_Population_born_outside_the_United_States_Native_Entered_2010_or_later",
             "YE_Population_born_outside_the_United_States_Native_Entered_before_2010",
             "YE_Population_born_outside_the_United_States_Foreign_born",
             "YE_Population_born_outside_the_United_States_Foreign_born_Entered_2010_or_later",
             "YE_Population_born_outside_the_United_States_Foreign_born_Entered_before_2010",
             "FB_Foreign-born_population_excluding_population_born_at_sea",
             "FB_Foreign-born_population_excluding_population_born_at_sea_Europe",
             "FB_Foreign-born_population_excluding_population_born_at_sea_Asia",
             "FB_Foreign-born_population_excluding_population_born_at_sea_Africa",
             "FB_Foreign-born_population_excluding_population_born_at_sea_Oceania",
             "FB_Foreign-born_population_excluding_population_born_at_sea_Latin_America",
             "FB_Foreign-born_population_excluding_population_born_at_sea_Northern_America",
             "LS_Population_5_years_and_over",
             "LS_Population_5_years_and_over_English_only",
             "LS_Population_5_years_and_over_Language_other_than_English",
             "LS_Population_5_years_and_over_Language_other_than_English_Speak_English_less_than_very_well",
             "LS_Population_5_years_and_over_Spanish",
             "LS_Population_5_years_and_over_Spanish_Speak_English_less_than_very_well",
             "LS_Population_5_years_and_over_Other_Indo-European_languages",
             "LS_Population_5_years_and_over_Other_Indo-European_languages_Speak_English_less_than_very_well",
             "LS_Population_5_years_and_over_Asian_and_Pacific_Islander_languages",
             "LS_Population_5_years_and_over_Asian_and_Pacific_Islander_languages_Speak_English_less_than_very_well",
             "LS_Population_5_years_and_over_Other_languages",
             "LS_Population_5_years_and_over_Other_languages_Speak_English_less_than_very_well",
             "AY_Total_population",
             "AY_Total_population_American",
             "AY_Total_population_Arab",
             "AY_Total_population_Czech",
             "AY_Total_population_Danish",
             "AY_Total_population_Dutch",
             "AY_Total_population_English",
             "AY_Total_population_French_except_Basque",
             "AY_Total_population_French_Canadian",
             "AY_Total_population_German",
             "AY_Total_population_Greek",
             "AY_Total_population_Hungarian",
             "AY_Total_population_Irish",
             "AY_Total_population_Italian",
             "AY_Total_population_Lithuanian",
             "AY_Total_population_Norwegian",
             "AY_Total_population_Polish",
             "AY_Total_population_Portuguese",
             "AY_Total_population_Russian",
             "AY_Total_population_Scotch-Irish",
             "AY_Total_population_Scottish",
             "AY_Total_population_Slovak",
             "AY_Total_population_Subsaharan_African",
             "AY_Total_population_Swedish",
             "AY_Total_population_Swiss",
             "AY_Total_population_Ukrainian",
             "AY_Total_population_Welsh",
             "AY_Total_population_West_Indian_excluding_Hispanic_origin_groups",
             "CI_Total_households",
             "CI_Total_households_With_a_computer",
             "CI_Total_households_With_a_broadband_Internet_subscription"
)
