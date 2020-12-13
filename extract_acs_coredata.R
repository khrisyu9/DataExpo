library(tidyverse)
library(httr)
library(jsonlite)
# make the URL
url_dc <- "https://api.census.gov/data/2019/acs/acs1?get=NAME,B01001_001E&for=county:*&in=state:11"
url_md <- "https://api.census.gov/data/2019/acs/acs1?get=NAME,B01001_001E&for=county:*&in=state:24"
url_va <- "https://api.census.gov/data/2019/acs/acs1?get=NAME,B01001_001E&for=county:*&in=state:51"

# use the URL to make a request from the API
pop_json_dc <- GET(url = url_dc)
pop_json_md <- GET(url = url_md)
pop_json_va <- GET(url = url_va)

# check for a server error in the response
http_status(pop_json_dc)
http_status(pop_json_md)
http_status(pop_json_va)

# get the contents of the response as a text string
pop_json_dc <- content(pop_json_dc, as = "text")
pop_json_md <- content(pop_json_md, as = "text")
pop_json_va <- content(pop_json_va, as = "text")

# create a character matrix from the JSON
pop_matrix_dc <- fromJSON(pop_json_dc)
pop_matrix_md <- fromJSON(pop_json_md)
pop_matrix_va <- fromJSON(pop_json_va)

# turn the body of the character matrix into a tibble
pop_data_dc <- as_tibble(pop_matrix_dc[2:nrow(pop_matrix_dc), ],
                         .name_repair = "minimal")
pop_data_md <- as_tibble(pop_matrix_md[2:nrow(pop_matrix_md), ],
                         .name_repair = "minimal")
pop_data_va <- as_tibble(pop_matrix_va[2:nrow(pop_matrix_va), ],
                      .name_repair = "minimal")

# add variable names to the tibble
names(pop_data_dc) <- pop_matrix_dc[1, ]
names(pop_data_md) <- pop_matrix_md[1, ]
names(pop_data_va) <- pop_matrix_va[1, ]
pop_data_dc <- pop_data_dc %>% pull(NAME) 

pop_data_dmv <- rbind(pop_data_md, pop_data_va)
pop_data_dmv <- rbind(pop_data_dc, pop_data_dmv)

write.csv(pop_data_dmv, "D:/dataexpo/processed_data/pop_data_dmv.csv")
