
# Define the UI for the module
newRatingsMovieListUi <- function(id) {
  ns <- NS(id)
  uiOutput(ns("display"))
}

# Define the server logic for the module
newRatingsMovieListServer <- function(id, reactive_value) {
  moduleServer(id, function(input, output, session) {
    output$display <- renderUI({
      lapply(
        reactive_value(),
        helpText
      )
    })
  })
}
