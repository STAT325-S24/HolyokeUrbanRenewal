#' Return tibble of data from file names
#' 
#' Generate data on all buildings in the urban renewal project

#' @details
#' Returns a tibble with all image information (and some additional attributes)
#' 
#' @param none
#' 
#' @examples
#' get_buildings()
#' 
#' @export
get_buildings <- function() {

  image_path <- paste0(
    system.file(package = "HolyokeUrbanRenewal"),
    "/extdata"
  )
  file_names <- list.files(image_path)
  
  # general format: "block_01_parcel_06A_info_01.png" or "block_02_parcel_06_info_01.png"
  parcel_to_end_locations <- stringr::str_locate(file_names, "parcel_[0-9A]{2,3}_")
  type_to_end_locations <- stringr::str_locate(file_names, "_[a-z]*_[0-9]{2}.png$")
  # Adam and Tyler, can we replace base::substr with stringr functions?
  type_to_end <- substr(file_names, type_to_end_locations[,1], type_to_end_locations[,2])
  type_locations <- stringr::str_locate(type_to_end, "_[a-z]*_")
  
  results <- dplyr::tibble(filename = file_names) |>
    dplyr::mutate(
      block = substr(file_names, 7, 8),
      parcel = substr(file_names, 17, parcel_to_end_locations[,2] - 1),
      type = substr(type_to_end, type_locations[,1] + 1, type_locations[,2] - 1),
      file_number = substr(file_names, str_length(file_names) - 5, str_length(file_names) - 4)
    )
  return(results)
}

#' Select building from the Holyoke Urban Renewal project
#' 
#' Generate data on a specific building

#' @details
#' Returns a tibble with all image information (and some additional attributes) for a specified building
#' 
#' @param none
#' 
#' @examples
#' select_building(block = "01", parcel = "01")
#' 
#' @export
select_building <- function(block_val = "03", parcel_val = "01") {
  
  this_building <- get_buildings() |>
    dplyr::filter(block_val == block, parcel_val == parcel)
  # check for invalid arguments? warn the user?
  return(this_building)
}
  
