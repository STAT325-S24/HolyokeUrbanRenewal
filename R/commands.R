#' Return tibble of data from file names
#' 
#' Generate data on all buildings in the urban renewal project

#' @details
#' Returns a tibble with all image information (and some additional attributes) for the Holyoke Urban Renewal project
#'
#' @source \url{https://github.com/STAT210-S23/STAT210-Holyoke-History-Room/tree/main/Riverview_Renewal_Project}
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
  image_path <- paste0(
    system.file(package = "HolyokeUrbanRenewal"),
    "/extdata"
  )
  
  results <- dplyr::tibble(filename = file_names) |>
    dplyr::mutate(
      block = substr(file_names, 7, 8),
      parcel = substr(file_names, 17, parcel_to_end_locations[,2] - 1),
      type = substr(type_to_end, type_locations[,1] + 1, type_locations[,2] - 1),
      file_number = substr(
        file_names, 
        stringr::str_length(file_names) - 5, 
        stringr::str_length(file_names) - 4),
      full_path = paste0(image_path, "/", file_names)
    )
  return(results)
}

#' Select building from the Holyoke Urban Renewal project
#' 
#' Generate data on a specific building

#' @details
#' Returns a tibble with all image information (and some additional attributes) for a specified building
#' 
#' @param block_val character value for block number
#' @param parcel_val character value for parcel
#' 
#' @examples
#' select_building(block_val = "01", parcel_val = "01")
#' 
#' @export
select_building <- function(block_val = "03", parcel_val = "01") {
  this_building <- get_buildings() |>
    dplyr::filter(block_val == block, parcel_val == parcel)
  # check for invalid arguments? warn the user?
  return(this_building)
}

#' @details
#' Returns a summary of the available images of a property.
#' 
#' @examples
#' summarize_property(02, 01)
#' 
#' @export
summarize_property <- function(block, parcel) {
  property <- select_building(block, parcel)
  print(property)
  if (nrow(property) == 0) {
    res <- ("Property doesn't exist")
    return (res)
  }
  info_num <- dplyr::filter(property, type == "info") |> nrow()
  photo_num <- dplyr::filter(property, type == "photo") |> nrow()
  map_num <- dplyr::filter(property, type == "map") |> nrow()
  
  l1 <- "This property file has:\n"
  l2 <- paste(info_num, " information page(s)\n")
  l3 <- paste(photo_num, "photo(s)\n")
  l4 <- paste(map_num, " map(s)\n")

return(paste(l1, "\t", l2, "\t", l3, "\t", l4))
}
