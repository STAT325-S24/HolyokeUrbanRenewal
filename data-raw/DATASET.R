library(tidyverse)
HolyokeUrbanRenewal <-
  readxl::read_xlsx("data-raw/riverview_renewal_data_2024_02_27.xlsx") |>
  janitor::clean_names() |>
  mutate(parcel = str_replace(parcel, "\\.0$", ""),
         deed_reference_book = str_replace(deed_reference_book, "\\.0$", ""),
         deed_reference_page = str_replace(deed_reference_page, "\\.0$", ""),
         assessed_value = str_extract_all(assessed_value, "\\$.*"))
usethis::use_data(HolyokeUrbanRenewal, overwrite = TRUE)
