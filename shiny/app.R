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


clean_files <- files[str_detect(files, "\\.jpeg")]  # check for correct format
# not clear that this next line is needed (or what it is testing for)
# file_names <- lapply(clean_files, get_Filename, pattern = "[.]") |> unlist()

ui <-
  navbarPage("Holyoke Riverview Prospect Heights Urban Renewal project",
    tabPanel(
      title = "Select Building",
      mainPanel(
        p("This app displays information about the Holyoke Riverview Prospect Heights Urban Renewal project."),
        p("This project would not have been made possible without the efforts of Eileen Crosby (Holyoke Public Library History Room)."),
        uiOutput("tab"),
        wellPanel(
          radioButtons("building", "Select a building:", unique_buildings$property_label, selected = unique_buildings$property_label[1])
        )
    )),

    tabPanel(
      title = "Explore Building",
      helpText("Image output:"),
    
      fluidRow(
        column(
          3, 
          wellPanel(
            uiOutput("building_images"),
          )
        ),
        column(
          7,
          textOutput("bldg_info"),
          imageOutput("image")
        )
      )
    ),
    tabPanel(
      title = "Explore Spreadsheet",
      helpText("Spreadsheet information:"),
      
      mainPanel(
        p("This is where the spreadsheet will be displayed."),
        DT::dataTableOutput("table")
      )
    )
  )
  
server <- function(input, output, session) {
  
  output$bldg_info <- renderText({
    return(paste0("Displaying information for ", input$building))
  })
  
  output$image <- renderImage({
    # width  <- session$clientData$output_image_width
    #cat("width: ", width, "\n")
    width <- 630
    #height <- session$clientData$output_image_height
    #cat("height: ", height, "\n")
    height <- 840
    index <- which(clean_files == input$picture)
    src <- paste0(image_path, "/", files[index])
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
    href="https://github.com/STAT210-S23/STAT210-Holyoke-History-Room/tree/main/Riverview_Renewal_Project"
  )
  output$tab <- renderUI({
    tagList("Link to scanned images:", url)
  })
  
  output$building_images <- renderUI({
    this_building <- unique_buildings |>
      filter(property_label == input$building)
    my_parcel <- this_building |> pull(parcel)
    my_block <- this_building |> pull(block)
    building_files <- all_buildings |>
      filter(parcel == my_parcel, block == my_block)
    radioButtons("picture", "Select an image:", building_files$filename, selected = building_files$filename[1])
  })
  
  output$table <- DT::renderDT(
    HolyokeUrbanRenewal::HolyokeUrbanRenewal |>
      select(-file_name))
}


# Run the application 
shinyApp(ui = ui, server = server)

