source("./server/recommender.module.R")

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
  # uiOutput(ns("recommendationButton"))
   tableOutput(ns("recommendations"))
 
  
}


movieRecommendationsServer <- function(id, reactive_user_selection) {
  moduleServer(id, function(input, output, session) {
   
    output$recommendations <- renderTable({
      
      list<- reactive_user_selection();
      user_selection<- list$movies$ratings

      # pass user selected list of ratings to the recommender model
      # recommendations<- movie_recommendation(list$items)
      no_result <- data.frame(matrix(NA,1))
      no_result[1,1] <- "Sorry, there is not enough information in our database on the movies you've selected. Try to select different movies you like."
      
      if(length(user_selection) ==0 ){
        return(no_result)
      }
      
      movieLense_matrix <- as(MovieLense, "matrix")
      
      null_matrix <- matrix(NA,nrow=1, ncol=1664)
      
      for (key in user_selection) {
        index <- as.numeric(key)+1
        null_matrix[1,index] <- user_selection[[key]]
      }
      
      # Calculate the column means, ignoring NA values
      # column_means <- colMeans(movieLense_matrix)
      
      # Replace NA values in the first row with column means
      # null_matrix[1, ] <- ifelse(is.na(null_matrix[1, ]), column_means, null_matrix[1, ])
      
      movieLense_matrix <- rbind(movieLense_matrix, null_matrix)
      # #Convert rating matrix into a sparse matrix
      ratingMatrix <- as(movieLense_matrix, "realRatingMatrix")
      
      recommender_model <- Recommender(ratingMatrix, method = "SVDF")
      recom <- predict(recommender_model, ratingMatrix[nrow(movieLense_matrix)], n=10)
      recom_list <- as(recom, "list")
      
      recom_result <- data.frame(matrix(NA,10))
      
      observe({
        hidePageSpinner()
      })
      
      if (as.character(recom_list[1])=='character(0)'){
        
        return(no_result)
        # results<- no_result
      } else {
        for (i in c(1:10)){
          recom_result[i,1] <- as.character(subset(MovieLenseMeta,MovieLenseMeta$title == recom_list[[1]][i])$title)
        }
        
        return(recom_result)
        # results<-recom_result
      }
      
    })
    
    output$recommendationButton <- renderUI({
      list<- reactive_user_selection();
      user_selection<- list$movies$ratings
         print(length(user_selection))
      if(length(user_selection) > 0 ){
        actionButton("newMoviesRatingNotificationSubmitBtn", "Get Recommendations")
      }
      
    })
  })
}

