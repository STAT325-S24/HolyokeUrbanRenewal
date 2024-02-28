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
  result <- tibble(
    filename = character(),
    block = numeric(),
    parcel = character(),
    type = character(),
    file_number = numeric()
  )
  image_path <- paste0(
    system.file(package = "HolyokeUrbanRenewal"),
    "/extdata"
  )
  file_names <- list.files(image_path)
  
  # general format: "block_01_parcel_06A_info_01.png" or "block_02_parcel_06_info_01.png"
  result$filename <- file_names
  result$block <- substr(file_names, 7, 8)
  parcel_to_end_locations <- str_locate(file_names, "parcel_[0-9A]{2,3}_")
  result$parcel <- substr(file_names, 17, parcel_to_end_locations[,2] - 1)
  type_to_end_locations <- str_locate(file_names, "_[a-z]*_[0-9]{2}.png$")
  type_to_end <- substr(file_names, type_to_end_locations[,1], type_to_end_locations[,2])
  type_locations <- str_locate(type_to_end, "_[a-z]*_")
  result$type <- substr(type_to_end, type_locations[,1] + 1, type_locations[,2] - 1)
  result$file_number <- substr(file_names, str_length(file_names) - 5, str_length(file_names) - 4)
  return(result)
}
