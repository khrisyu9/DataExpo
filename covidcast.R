library(covidcast)

#daily new COVID-19 Delphi's indicators combination at county level
covid_indicator_combo <- suppressMessages(
  covidcast_signal(data_source = "indicator-combination", signal = "nmf_day_doc_fbc_fbs_ght",
                   start_day = "2020-03-01", end_day = "2020-12-31",
                   geo_type = "county")
)
write.csv(covid_indicator_combo, "D:/dataexpo/data/covidcast/covid_indicator_combo_20200301_20201231.csv")

#daily new COVID-19 cases per 100k people at county level
covid_cases <- suppressMessages(
  covidcast_signal(data_source = "indicator-combination", signal = "confirmed_incidence_prop",
                   start_day = "2020-03-01", end_day = "2020-12-31",
                   geo_type = "county")
)
write.csv(covid_cases, "D:/dataexpo/data/covidcast/covid_cases_20200301_20201231.csv")

#daily new death of COVID-19 cases per 100k people at county level
covid_deaths <- suppressMessages(
  covidcast_signal(data_source = "indicator-combination", signal = "confirmed_incidence_prop",
                   start_day = "2020-03-01", end_day = "2020-12-31",
                   geo_type = "county")
)
write.csv(covid_deaths, "D:/dataexpo/data/covidcast/covid_deaths_20200301_20201231.csv")

#COVID-related doctor visits
doctor_visits <- suppressMessages(
  covidcast_signal(data_source = "doctor-visits", signal = "smoothed_adj_cli",
                   start_day = "2020-03-01", end_day = "2020-12-31",
                   geo_type = "county")
)

write.csv(doctor_visits, "D:/dataexpo/data/covidcast/doctor_visits_20200301_20201231.csv")

#COVID-19 hospital admissions
hospital_admissions <- suppressMessages(
  covidcast_signal(data_source = "hospital-admissions", signal = "smoothed_adj_covid19_from_claims",
                   start_day = "2020-03-01", end_day = "2020-12-31",
                   geo_type = "county")
)

write.csv(hospital_admissions, "D:/dataexpo/data/covidcast/hospital_admissions_20200301_20201231.csv")




