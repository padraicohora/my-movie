source("server/recommender.module.R")

# Define the UI for the module
newRatingsMovieListUi <- function(id) {
  ns <- NS(id)
  uiOutput(ns("display"))
}

# Define the server logic for the module
newRatingsMovieListServer <- function(id, reactive_value) {
  moduleServer(id, function(input, output, session) {
    output$display <- renderUI({
      displayMovieSelection(
        reactive_value()
      )
    })
  })
}

displayMovieSelection <- function(selection){
  lapply(
    selection,
    helpText
  )
}


movieRecommendationsUi <- function(id) {
  ns <- NS(id)
  tableOutput(ns("recommendations"))
}


movieRecommendationsServer <- function(id, reactive_user_selection) {
  moduleServer(id, function(input, output, session) {
    
    my_list <- list(Name = c("Alice", "Bob", "Charlie"), Age = c(25, 30, 35))

    output$recommendations <- renderTable({
       # my_df <- as.data.frame(reactive_user_selection())
      list<- reactive_user_selection();
      
       # rendered<- sapply(names(list$items), function(key) {
       #   sprintf("%s, ")
       # })
       # displayMovieSelection(rendered)
      
      movie_recommendation(list$items)
    })
  })
}

