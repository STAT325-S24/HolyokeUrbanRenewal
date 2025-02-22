% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/commands.R
\name{select_building}
\alias{select_building}
\title{Select building from the Holyoke Urban Renewal project}
\usage{
select_building(block_val = "03", parcel_val = "01")
}
\arguments{
\item{block_val}{character value for block number}

\item{parcel_val}{character value for parcel}
}
\description{
Generate data on a specific building
}
\details{
Returns a tibble with all image information (and some additional attributes) for a specified building
}
\examples{
select_building(block_val = "01", parcel_val = "01")

}
