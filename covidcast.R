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

#daily death of COVID-19 cases per 100k people at county level
covid_deaths <- suppressMessages(
  covidcast_signal(data_source = "indicator-combination", signal = "confirmed_incidence_prop",
                   start_day = "2020-03-01", end_day = "2020-12-31",
                   geo_type = "county")
)
write.csv(covid_deaths, "D:/dataexpo/data/covidcast/covid_deaths_20200301_20201231.csv")

