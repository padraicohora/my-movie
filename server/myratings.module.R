
# Define the UI for the module
myRatingsMovieListUi <- function(id, dtId) {
  ns <- NS(id)
  
  uiOutput(ns("table_ui"))
}

# Define the server logic for the module
myRatingsMovieListServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    
    output$table_ui <- renderUI({
      list<- data();
      user_ratings<- list$movies
      if (length(user_ratings) ==0) {
        tagList(h3("No data available"), 
        p("You need to rate movies on the movie finder page first "))
      } else {
        DTOutput(session$ns("table"))
      }
    })
  
    output$table <- renderDT({
      matrix_data <- matrix( ncol = 4)
      list<- data();
      user_ratings<- list$movies[, c("title", "genres", "rating")]
      # movie_data <- movie_data_all[, c("title", "genres", "rating")]
   
      # print(user_ratings)
      # 
      # for (key in names(user_ratings)) {
      # 
      #   index <- as.numeric(key)
      #   rating <- as.numeric(user_ratings[[key]])
      #   item <- movie_data_all[index, ]
      # 
      #   movie_row <- c(item[, 1:3])
      #   movie_row$rating <- rating
      # 
      #   # Bind the new row to the matrix_data
      #   matrix_data <- rbind(matrix_data, movie_row)
      # 
      #   
      # }
  
      datatable(
        user_ratings,
        escape = FALSE,  # Allow HTML content in the table
        filter = 'top',
        selection = "none",
        colnames = c("Title", "Genres", "Rating")
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