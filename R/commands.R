#' Return tibble of data from file names
#' 
#' XX

#' @details
#' XX
#' 
#' @param files the vector of file names
#' 
#' @examples
#' get_buildings()
#' 
#' @export
get_buildings() <- function(files) {
  result <- tibble(
    filename = character(),
    block = numeric(),
    parcel = character(),
    type = character(),
    file_number = numeric()
  )
  
  locations <- str_locate(files, "_")
  result$block <- substr(files, 7, 8)
  parcel_to_end_locations <- str_locate(files, "parcel_[0-9A]{2,3}_")
  result$parcel <- substr(files, 17, parcel_to_end_locations[,2] - 1)
  type_to_end_locations <- str_locate(files, "_[a-z]*_[0-9]{2}.png$")
  type_to_end <- substr(files, type_to_end_locations[,1], type_to_end_locations[,2])
  type_locations <- str_locate(type_to_end, "_[a-z]*_")
  result$type <- substr(type_to_end, type_locations[,1] + 1, type_locations[,2] - 1)
  result$file_number <- substr(files, str_length(files) - 5, str_length(files) - 4)
  return(result)
}

