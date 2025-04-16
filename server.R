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
source("server/movieRecommendations.module.R")
source("server/recommender.module.R")
source("server/myratings.module.R")
source("server/movieFinder.module.R")
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
  

 
  
  allMovies <- reactiveValues(movies=movie_data)
  movieFinderMovies <- reactiveValues(movies=movie_data)
  myRatingsMovies <- reactiveValues()
  
  newMovieCandidate <- reactiveVal()
  newMovieRatings <- reactiveValues(items=list())
  movieRatings <- reactiveValues(items=list())
  
  observeEvent(input$movie_list_rating_action, {
    newMovieCandidate(input$movie_list_rating_action)
    
  })
  
  observe({
    allMoviesReactive<- allMovies$movies
    if (is.null(newMovieCandidate())) {
      removeModal()
    } else {
 
      currentMovie <- allMoviesReactive[newMovieCandidate(), "title"]
      
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
  observeEvent(input$star_rating, {
    newMovieRatings$items[[as.character(newMovieCandidate())]] <- input$star_rating
  })

  
  observeEvent(input$rating_modal_submit_btn, {
    allMoviesReactive<- allMovies$movies
    removeModal()
    ratingCandidate <- newMovieCandidate()
   
    newMovieRatings$items[[as.character(ratingCandidate)]] <- input$star_rating
    movies_test<- sapply(names(newMovieRatings$items), function(key) {
      sprintf("%s, Rating: %s", allMoviesReactive[key, "title"], newMovieRatings$items[[key]])
    })
    output$newMoviesRatingNotification <- renderUI({
      tagList(
        renderText(
          paste("You have rated ", length(newMovieRatings$items), " new movies. You can now generate new recommendations." )
        ),
        lapply(
          movies_test,
          helpText
        )
      )
    })
    movieRatings$items <- c(newMovieRatings$items, movieRatings$items)
    item_to_remove <- which(movieFinderMovies$movies$title == allMoviesReactive[ratingCandidate, ]$title)

    rating<- allMoviesReactive[ratingCandidate, ]
    rating$rating <- input$star_rating
    myRatingsMovies$movies<-rbind(myRatingsMovies$movies, rating)
    movieFinderMovies$movies<- movieFinderMovies$movies[-item_to_remove, ]
    
    newMovieCandidate(NULL)
  })
  
    
  # Create a reactive value
  reactive_text_2 <- reactive({
    allMoviesReactive<- allMovies$movies
    sapply(names(newMovieRatings$items), function(key) {
      sprintf("%s, Rating: %s", allMoviesReactive[key, "title"], newMovieRatings$items[[key]])
    })
  })
  
  output$input_movieFinder_list <- movieFinderMovieListServer(
    "finder", 
    reactive({
      movieFinderMovies
    })
  )
  
  newRatingsMovieListServer("display1", reactive_text_2)
  
  recs<- reactive({sapply(names(newMovieRatings$items), function(key) {
    allMoviesReactive<- allMovies$movies
    sprintf("%s", allMoviesReactive[key, "title"])
  })})
  
  movieRecommendationsServer(
    "recommendations", 
    reactive({
      myRatingsMovies
    }), 
    reactive({
      allMovies
    })
  )
  
  observeEvent(input$rating_modal_cancel_btn, {
    removeModal()
    newMovieCandidate(NULL)
  })
  
  observe({
    if (length(newMovieRatings$items) == 0) {
      shinyjs::hide("newMovieRatingsOverlay")
    } else {
      shinyjs::show("newMovieRatingsOverlay")
    }
  })
  
  observeEvent(input$newMoviesRatingNotificationSubmitBtn, {
    nav_select(
      id='pages',
      selected = "My Recommendations"
    )
    newMovieRatings$items <- list()
    showPageSpinner(caption="Getting your recommendations ... this takes a while")
  })
  
  observeEvent(input$newMoviesRatingNotificationClearBtn, {
    newMovieRatings$items <- list()
  })
  
  output$myRatingsDataTable <-   myRatingsMovieListServer(
    "ratings", 
    reactive({
      myRatingsMovies
    })
  )
  
}
