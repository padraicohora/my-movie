#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(bslib)
library(ggplot2)
library(tools)
library(DT)

source("server/Movies.server.R")

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  new_plot_title <- eventReactive(
    eventExpr = input$update_plot_title,
    valueExpr = {
      toTitleCase(input$plot_title)
    }
  )
  
  output$scatterplot <- renderPlot({
    ggplot(data = movies, aes_string(x = input$x, y = input$y, color = input$z)) +
      geom_point(alpha = input$alpha, size = input$size) +
      labs(title = new_plot_title())
  })
  

  output$input_movieFinder_list <- output_movieFinder_list
  
  newMovieCandidate <- reactiveVal()
  newMovieRatings <- reactiveValues(items=list())
  
  observeEvent(input$movie_list_rating_action, {
    newMovieCandidate(input$movie_list_rating_action)
    
  })
  
  observe({
    if (is.null(newMovieCandidate())) {
      removeModal()
    } else {
      currentMovie <- movie_data_all[newMovieCandidate(), "title"]
      # get movie by index
      showModal(modalDialog(
        title = "Rate Movie",
        tagList(
          paste("You have selected ", currentMovie, " to rate. Provide your rating using the stars below."),
          shinyRatings("star_rating")
         ),
        footer = tagList(
          actionButton("rating_modal_cancel_btn", "Cancel"),
          actionButton("rating_modal_submit_btn", "Submit")
        )
      ))
    }
  })
  
  observeEvent(input$rating_modal_submit_btn, {
    removeModal()
    newMovieRatings$items[[as.character(newMovieCandidate())]] <- input$star_rating
    movieRatings<- sapply(names(newMovieRatings$items), function(key) {
      sprintf("%s, Rating: %s", movie_data_all[key, "title"], newMovieRatings$items[[key]])
    }) 
    output$newMoviesRatingNotification <- renderUI({
      tagList(
        renderText(
          paste("You have rated ", length(newMovieRatings$items), " new movies. You can now generate new recommendations." )
        ),
        lapply(
          movieRatings,
          helpText
        )
      )
    })
    newMovieCandidate(NULL)
  })
  
  observeEvent(input$rating_modal_cancel_btn, {
    removeModal()
    newMovieCandidate(NULL)
  })
  
  observe({
    if (length(newMovieRatings$items) == 0) {
      hide("newMovieRatingsOverlay")
    } else {
      show("newMovieRatingsOverlay")
    }
  })
  
  observeEvent(input$newMoviesRatingNotificationSubmitBtn, {
    newMovieRatings$items = c()
  })
  
  observeEvent(input$newMoviesRatingNotificationClearBtn, {
    newMovieRatings$items = c()
  })
}
