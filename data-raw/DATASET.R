library(tidyverse)
library(stringr)
HolyokeUrbanRenewal <-
  readxl::read_xlsx("data-raw/riverview_renewal_data_2024_02_27.xlsx") |>
  janitor::clean_names() |>
  mutate(
    parcel = str_replace(parcel, "\\.0$", ""), # parcel should be "01" not "1"
    info_1 = str_detect(file_name, "info$", negate = FALSE),
    parcel = str_replace(str_extract(file_name, "parcel_[0-9A]{2,3}"), "parcel_", ""), # parcel number
    block = str_replace(str_extract(file_name, "block_[0-9]{2}"), "block_", "") # block number
    
    # block should be "02" not "2"
    #deed_reference_book = str_replace(deed_reference_book, "\\.0$", ""),
    #deed_reference_page = str_replace(deed_reference_page, "\\.0$", ""),
    #assessed_value = readr::parse_number(str_extract_all(assessed_value, "\\$.*")) # pulls off the last value, may not be all that we want?
  ) |>
  select(-c(
    value_estimate_before_taking, 
    value_estimate_after_taking,
    value_estimate_total
  )) # almost no data here
usethis::use_data(HolyokeUrbanRenewal, overwrite = TRUE)
