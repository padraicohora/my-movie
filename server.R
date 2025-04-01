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
  
  observeEvent(input$action_button, {
    showModal(modalDialog(
      title = "Action Button Clicked",
      paste("You clicked the action button for row", input$action_button)
    ))
  })
}
