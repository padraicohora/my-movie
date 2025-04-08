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
  
  newMovieCandidate <- reactiveVal(0)
  newMovieRatings <- reactiveValues(items=c())
  
  observeEvent(input$movie_list_rating_action, {
    newMovieCandidate(input$movie_list_rating_action)
    currentMovie <- movie_data_all[input$movie_list_rating_action, "title"]
    # get movie by index
    showModal(modalDialog(
      title = "Rate Movie",
      paste("You clicked the action button for row", currentMovie),
     
      # show a rating star icon
      footer = tagList(
        actionButton("rating_modal_cancel_btn", "Cancel"),
        actionButton("rating_modal_submit_btn", "Submit")
      )
    ))
  })
  
  observeEvent(input$rating_modal_submit_btn, {
    removeModal()
    newMovieRatings$items = c(newMovieCandidate(), newMovieRatings$items)
    output$result <- renderText(paste("You have rated the movies ", paste(newMovieRatings$items, collapse= ", ")))
  })
  
  observeEvent(input$rating_modal_cancel_btn, {
    removeModal()
  })
}
