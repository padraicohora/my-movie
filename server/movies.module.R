newRatingsMovieListUi <- function(id) {
  ns <- NS(id)
  tagList(
    # actionButton(ns("button"), label = label),
    verbatimTextOutput(ns("out"))
  )
}

newRatingsMovieListServer <- function(id, movies) {
  moduleServer(
    id,
    function(input, output, session) {
      count <- reactive({movies()})
      # observeEvent(input$button, {
      #   count(count() + 1)
      # })
      value <- count()
      print(value())
      # str(value)
      output$out <- renderText({
        "test"
      })
      # count
    }
  )
}

# Define the UI for the module
mod_display_ui <- function(id) {
  ns <- NS(id)
  tagList(
    uiOutput(ns("display"))
  )
}

# Define the server logic for the module
mod_display_server <- function(id, reactive_value) {
  moduleServer(id, function(input, output, session) {
    output$display <- renderUI({
      reactive_value()
    })
  })
}
