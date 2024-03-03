library(tidyverse)
library(png) # For writePNG function
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
  unique()


clean_files <- files[str_detect(files, "\\.jpeg")]  # check for correct format
# not clear that this next line is needed (or what it is testing for)
file_names <- lapply(clean_files, get_Filename, pattern = "[.]") |> unlist()

ui <-
  navbarPage("Holyoke Riverview Prospect Heights Urban Renewal project",
    tabPanel(
      title = "Select Building",
      mainPanel(
        p("This app displays information about the Holyoke Riverview Prospect Heights Urban Renewal project."),
        p("This project would not have been made possible without the efforts of Eileen Crosby (Holyoke Public Library History Room)."),
        uiOutput("tab")
    )),

    tabPanel(
      title = "Explore Building",
      helpText("Image output:"),
    
      fluidRow(
        column(
          3, 
          wellPanel(
            radioButtons("picture", "Picture:", file_names)
          )
        ),
        column(
          6,
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
    return(paste0("XX summary goes here! XX This is ", input$picture))
  })
  
  output$image <- renderImage({
    width  <- session$clientData$output_image_width
    height <- session$clientData$output_image_height
    index <- which(file_names == input$picture)
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
  
  url <- 
    a("For more information click here", href="https://github.com/STAT210-S23/STAT210-Holyoke-History-Room/tree/main/Riverview_Renewal_Project")
  output$tab <- renderUI({
    tagList("Link to scanned images:", url)
  })
  
  output$table <- DT::renderDT(
    HolyokeUrbanRenewal::HolyokeUrbanRenewal |>
      select(-file_name))
  
}


# Run the application 
shinyApp(ui = ui, server = server)

