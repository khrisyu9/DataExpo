library(covidcast)
cc_data <- suppressMessages(
  covidcast_signal(data_source = "indicator-combination", signal = "confirmed_7dav_incidence_prop",
                   start_day = "2021-01-15", end_day = "2021-02-15",
                   geo_type = "county")
)

