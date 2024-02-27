library(tidyverse)
HolyokeUrbanRenewal <-
  readxl::read_xlsx("data-raw/riverview_renewal_data_2024_02_27.xlsx") |>
  janitor::clean_names()
usethis::use_data(HolyokeUrbanRenewal, overwrite = TRUE)
