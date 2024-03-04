#' Holyoke Urban Renewal archival materials
#'
#' Building information from 1960's era urban renewal project in Holyoke, MA.
#'
#' @docType data
#' @name HolyokeUrbanRenewal
#' @usage data(HolyokeUrbanRenewal)
#'
#' @keywords datasets
#'
#' @source Holyoke Public Library History Room, see https://github.com/STAT210-S23/STAT210-Holyoke-History-Room/tree/main/Riverview_Renewal_Project
#' @format
#'   A data frame with 114 observations on the following variables.
#'   \itemize{
#'     \item{\code{file_name}} {File name of scanned image (in extdata)}
#'     \item{\code{block}} {block (string, e.g., "12")}
#'     \item{\code{parcel}} {parcel (string, e.g., "06" or "06A")}
#'     \item{\code{property_location}} {Address in Holyoke, MA}
#'     \item{\code{owner}}{Property owner}
#'     \item{\code{owner_address}}{Property owner address}
#'     \item{\code{date_acquired}}{Date acquired}
#'     \item{\code{data_acquired2}}{Second date acquired (rare)}
#'     \item{\code{grantor}}{Grantor}
#'     \item{\code{deed_reference_book}}{Deed information}
#'     \item{\code{deed_reference_page}}{Deed information}
#'     \item{\code{tax_year}}{Tax information}
#'     \item{\code{tax_remarks}}{Tax information}
#'     \item{\code{assessed_text}}{Assessment information}
#'     \item{\code{assessed_value}}{Total assessment amount (see text for components)}
#'     \item{\code{stamps}}{Tax information}
#'     \item{\code{remarks}}{Tax remarks}
#'     \item{\code{building_description}}{Building information (various formats)}
#'     \item{\code{building_data}}{Building information (various formats)}
#'     \item{\code{house_or_not}}{House string in description (coarse way to identify houses)}
#'   }
#'
"HolyokeUrbanRenewal"
