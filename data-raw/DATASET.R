library(tidyverse)
library(stringr)
HolyokeUrbanRenewal <-
  readxl::read_xlsx("data-raw/riverview_renewal_data_2024_03_01.xlsx") |>
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
    house_or_not = ifelse(stringr::str_detect("[Hhouse]", assessed_text), "House", "Not house")
  )
usethis::use_data(HolyokeUrbanRenewal, overwrite = TRUE)
