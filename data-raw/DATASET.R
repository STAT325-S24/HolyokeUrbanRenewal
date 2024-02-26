library(tidyverse)
HolyokeUrbanRenewal <-
  readxl::read_xlsx("data-raw/riverview_renewal_data_2023_05_08.xlsx") |>
  janitor::clean_names()
usethis::use_data(HolyokeUrbanRenewal)
