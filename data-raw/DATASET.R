library(tidyverse)
library(stringr)
HolyokeUrbanRenewal <-
  readxl::read_xlsx("data-raw/riverview_renewal_data_2024_02_27.xlsx") |>
  janitor::clean_names() |>
  mutate(
    file_name = ifelse(
      stringr::str_detect(file_name, "info$"),
      paste0(file_name, "_01"),
      file_name),
    file_name = paste0(file_name, ".png"),
    block = stringr::str_extract(file_name, "[0-9]{2}"),
    parcel = stringr::str_extract(
      stringr::str_extract(file_name, "parcel_[0-9A]{2,3}_"), 
      "[0-9A]{2,3}"
    ),
    house_or_not = ifelse(grepl("[Hhouse]", assessed_value), 1, 0),
    assessed_value = purr::pluck(str_extract_all(assessed_value, "\\$.*"), tail) # pulls off the last value, may not be all that we want?
  ) |>
  select(-c(
    value_estimate_before_taking, 
    value_estimate_after_taking,
    value_estimate_total
  )) # almost no data here, let's get rid of them (and perhaps others)
usethis::use_data(HolyokeUrbanRenewal, overwrite = TRUE)
