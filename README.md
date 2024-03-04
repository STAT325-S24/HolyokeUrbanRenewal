Holyoke Urban Renewal data
================
STAT210 and STAT325 classes at Amherst College (Nicholas Horton)
2024-03-04

This file describes the `HolyokeUrbanRenewal` package. It provides
access to archival materials from the Holyoke Public Library History
Room Riverview Prospect Heights Urban Renewal Project.

See
https://github.com/STAT210-S23/STAT210-Holyoke-History-Room/tree/main/Riverview_Renewal_Project
for more information.

The package allows users to explore this archival dataset.

There is a Shiny app (in the `shiny` folder).

The package can be installed by running:

    devtools::install_github("STAT325-S24/HolyokeUrbanRenewal")
    library(HolyokeUrbanRenewal)

Because of the size of the package (approximately 1.8GB), it may be
necessary to increase the default timeouts:

change: `options(timeout=60)`

to

`options(timeout=300)`

This change ensures that the GitHub transaction, which is longer than
the default timeout (60 seconds), can complete in time.

If that workaround doesn’t succeeed it may be necessary to clone the
repo and install from within the RStudio `Build` tab.

``` r
suppressPackageStartupMessages(library(tidyverse))
citation(package = "HolyokeUrbanRenewal")
```

    To cite package 'HolyokeUrbanRenewal' in publications use:

      Horton N, Flores-Mejia F, Nguyen C, Papagelis J, Knightly T, Rogers
      A, Crary C (2024). _HolyokeUrbanRenewal: Data and Images From The
      Holyoke Urban Renewal Files_. R package version 0.9.0.

    A BibTeX entry for LaTeX users is

      @Manual{,
        title = {HolyokeUrbanRenewal: Data and Images From The Holyoke Urban Renewal Files},
        author = {Nicholas J. Horton and Francisco J. Flores-Mejia and Cuong Nguyen and Justin Papagelis and Tyler Knightly and Adam Rogers and Casey Crary},
        year = {2024},
        note = {R package version 0.9.0},
      }

``` r
glimpse(HolyokeUrbanRenewal)
```

    Rows: 114
    Columns: 21
    $ file_name            <chr> "block_02_parcel_01_info_01.png", "block_02_parce…
    $ block                <chr> "02", "02", "03", "03", "03", "03", "03", "03", "…
    $ parcel               <chr> "01", "05", "01", "02", "03", "04", "05", "06", "…
    $ property_location    <chr> "Union & Prospect Streets", "Westerly side Front …
    $ owner                <chr> "Whiting Oil Corp.", "Whiting Oil Corporation", "…
    $ owner_address        <chr> "1 Fountain Street, Holyoke, Mass.", "458 Dwight …
    $ date_acquired        <dttm> NA, NA, NA, 1967-06-28, 1954-05-10, 1954-09-07, …
    $ date_acquired2       <dttm> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
    $ grantor              <chr> NA, NA, NA, "Thomas & Alice Giguere", "Leopold J.…
    $ deed_reference_book  <chr> NA, NA, NA, "3267", "2309", "2334", "2695", "2171…
    $ deed_reference_page  <chr> NA, NA, NA, "489", "116", "596", "522", "578", "5…
    $ tax_year             <dbl> NA, NA, NA, 1969, 1969, 1969, 1969, 1969, 1969, 1…
    $ tax_amount           <chr> NA, NA, NA, "354.9", "373.1", "564.20000000000005…
    $ tax_remarks          <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ assessed_text        <chr> NA, NA, NA, "Wood Block - $2,400.\r\nLand - $1,50…
    $ assessed_value       <dbl> 28000, 13500, 12000, 3900, 4100, 6200, 9800, 5900…
    $ stamps               <chr> NA, NA, NA, "None", "8.25", "22", "20.9", "13.75"…
    $ remarks              <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "Several HA p…
    $ building_description <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "…
    $ building_data        <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    $ house_or_not         <chr> NA, NA, NA, "Not house", "Not house", "Not house"…

``` r
get_buildings()
```

    # A tibble: 408 × 6
       filename                         block parcel type  file_number full_path    
       <chr>                            <chr> <chr>  <chr> <chr>       <chr>        
     1 block_01_parcel_04_photo_01.jpeg 01    04     <NA>  1.          /Library/Fra…
     2 block_02_parcel_01_info_01.jpeg  02    01     <NA>  1.          /Library/Fra…
     3 block_02_parcel_05_info_01.jpeg  02    05     <NA>  1.          /Library/Fra…
     4 block_02_parcel_05_map_01.jpeg   02    05     <NA>  1.          /Library/Fra…
     5 block_03_parcel_01_info_01.jpeg  03    01     <NA>  1.          /Library/Fra…
     6 block_03_parcel_01_map_01.jpeg   03    01     <NA>  1.          /Library/Fra…
     7 block_03_parcel_01_photo_01.jpeg 03    01     <NA>  1.          /Library/Fra…
     8 block_03_parcel_02_info_01.jpeg  03    02     <NA>  1.          /Library/Fra…
     9 block_03_parcel_02_map_01.jpeg   03    02     <NA>  1.          /Library/Fra…
    10 block_03_parcel_02_photo_01.jpeg 03    02     <NA>  1.          /Library/Fra…
    # ℹ 398 more rows

Kudos to Eileen Crosby, the STAT210 and STAT325 classes at Amherst
College, Zoe Jacobs Feinstein, Julia Riseman, and Steffen Plotner for
their assistance with this project.
