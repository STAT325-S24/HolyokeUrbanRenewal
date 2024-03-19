library(tidyverse)
# library(png) # For writePNG function
library(shiny)
library(stringr)
# usethis::install_github("STAT325-S24/HolyokeUrbanRenewal")
library(HolyokeUrbanRenewal)

get_Filename <- function(string = "", pattern = "[.]"){
  header <- str_split(string = string, pattern = pattern)[[1]][1]
  display <- paste("Image:", header)
  return(display)
}

image_path <- paste0(
  system.file(package = "HolyokeUrbanRenewal"),
  "/extdata"
)

all_buildings <- HolyokeUrbanRenewal::get_buildings()
files <- all_buildings$filename

unique_buildings <- all_buildings |>
  select(block, parcel) |>
  mutate(property_label = paste0("Block ", block, ", Parcel ", parcel)) |>
  unique()

unique_blocks <- unique(unique_buildings$block)
unique_blocks <- unique_blocks[! unique_blocks %in% c("", ".m")]


clean_files <- files[str_detect(files, "\\.jpeg")]  # check for correct format
# not clear that this next line is needed (or what it is testing for)
# file_names <- lapply(clean_files, get_Filename, pattern = "[.]") |> unlist()

ui <-
  navbarPage("Holyoke Riverview Prospect Heights Urban Renewal project",
    tabPanel(
      title = "Select Block and Parcel (Building)",
      mainPanel(
        p("This app displays information about the Holyoke Riverview Prospect Heights Urban Renewal project."),
        p("This project would not have been made possible without the efforts of Eileen Crosby (Holyoke Public Library History Room)."),
        p("Last updated 2024-03-19."),
        
        uiOutput("scan_link"),
        wellPanel(
          radioButtons(
            "block",
            "Select a block:", 
            unique_blocks, 
            selected = unique_blocks[1]
          ),
          uiOutput("parcel")
        )
    )),

    tabPanel(
      title = "Explore Building",
      mainPanel(
        textOutput("bldg_info"),
        uiOutput("building_images"),
        imageOutput("image")
      )
    ),
    tabPanel(
      title = "Explore Spreadsheet",
      helpText("Information for all buildings:"),
      
      mainPanel(
        DT::dataTableOutput("table")
      )
    )
  )
  
server <- function(input, output, session) {
  
  output$bldg_info <- renderText({
    this_building <- unique_buildings |>
      filter(property_label == input$parcel)
    my_parcel <- this_building |> pull(parcel)
    my_block <- this_building |> pull(block)
    spreadsheet_line <- filter(HolyokeUrbanRenewal::HolyokeUrbanRenewal, block == my_block, parcel == my_parcel)
    lines_vector <- c(
      paste0("Displaying information for ", input$building, ":"),
      paste0("LOCATION: ", spreadsheet_line$property_location),
      paste0("OWNER: ", spreadsheet_line$owner),
      paste0("(", spreadsheet_line$owner_address, ")")
    )
    return(paste(lines_vector, collapse = " "))
  })
  
  output$image <- renderImage({
    req(input$picture)
    # width  <- session$clientData$output_image_width
    width <- 840
    #height <- session$clientData$output_image_height
    height <- 1120
    src <- paste0(image_path, "/", input$picture)
    results <- file.exists(src)
    if (!results) {
      showNotification(paste0("unable to open ", src, "\n"))
    }
    return(list(
      src = src,
      width = width,
      height = height,
      contentType = "image/jpeg",
      alt = paste("This is", input$picture)
    ))
  }, deleteFile = FALSE)
  
  url <- a(
    "For more information click here", 
    href="https://github.com/STAT325-S24/HolyokeUrbanRenewal"
  )
  output$scan_link <- renderUI({
    tagList("Link to scanned images:", url)
  })
  
  output$parcel <- renderUI({
    this_block <- unique_buildings |>
      filter(block == input$block)
    radioButtons(
      "parcel", 
      "Select a parcel:", 
      this_block$property_label, 
      selected = this_block$property_label[1]
    )
  })
  
  output$building_images <- renderUI({
    this_building <- unique_buildings |>
      filter(property_label == input$parcel)
    my_parcel <- this_building |> pull(parcel)
    my_block <- this_building |> pull(block)
    building_files <- all_buildings |>
      filter(block == my_block, parcel == my_parcel)
    radioButtons(
      "picture", 
      "Select an image:", 
      building_files$filename, 
      selected = building_files$filename[1]
    )
  })
  
  output$table <- DT::renderDT(
    HolyokeUrbanRenewal::HolyokeUrbanRenewal |>
      select(-file_name))
}

# Run the application 
shinyApp(ui = ui, server = server)

