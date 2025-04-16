
# Define the UI for the module
myRatingsMovieListUi <- function(id, dtId) {
  ns <- NS(id)
  DTOutput(dtId)
}

# Define the server logic for the module
myRatingsMovieListServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    
   
    # movieLense_matrix <- as(MovieLense, "matrix")
    # movie_data_all <- as.data.frame(MovieLenseMeta)
    
    # matrix_data <- matrix()
    
    matrix_data <- matrix( ncol = 4)
    
    # matrix_data <- matrix(ncol = 4)
    
    

    renderDT({
      # matrix_data <- matrix()
      list<- data();
      user_ratings<- list$movies[, c("title", "genres", "rating")]
      # movie_data <- movie_data_all[, c("title", "genres", "rating")]
      print(user_ratings)
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
        # options = list(
        #   columnDefs = list(
        #     list(
        #       targets = 4,
        #       render = JS(
        #         "function(data, type, row, meta) {",
        #         "console.log({data, type, row, meta})",
        #         "return data;",
        #         "}"
        #       )
        #     )
        #   )
        # ),
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