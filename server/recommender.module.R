library(proxy)
library(recommenderlab)
library(reshape2)
# movies <- read.csv("movies.csv", header = TRUE, stringsAsFactors=FALSE)
# ratings <- read.csv("ratings.csv", header = TRUE)
# movies2 <- movies[-which((movies$movieId %in% ratings$movieId) == FALSE),]
source("server/Movies.server.R")
data("MovieLense")
movie_recommendation <- function(user_selection) {
  #input = "Gladiator (2000)"
  #input2 = "Aeon Flux (2005)"
  #input3 = "Alexander (2004)"
  # row_num <- which(movies2[,2] == input)
  # row_num2 <- which(movies2[,2] == input2)
  # row_num3 <- which(movies2[,2] == input3)
  movieLense100_matrix <- as(MovieLense100, "matrix")
  
  
  null_matrix <- matrix(NA,nrow=1, ncol=1664)
  
  # colnames(null_matrix) <- colnames(movieLense100_matrix)
  
  
  for (key in names(user_selection)) {
    index <- as.numeric(key)+1
    null_matrix[1,index] <- user_selection[[key]]
  }

  
  # Calculate the column means, ignoring NA values
  column_means <- colMeans(movieLense100_matrix)
  
  # Replace NA values in the first row with column means
  null_matrix[1, ] <- ifelse(is.na(null_matrix[1, ]), column_means, null_matrix[1, ])
  
  # print(head(null_matrix))
  # transpose matrix orientation
  # userSelect <- t(null_matrix)

  # 
  # ratingmat <- dcast(ratings, userId~movieId, value.var = "rating", na.rm=FALSE)
  # ratingmat <- ratingmat[,-1]
  # colnames(userSelect) <- colnames(ratingmat)
  # MovieLense100_matrix <- as(MovieLense100, "matrix")

  movieLense100_matrix <- rbind(movieLense100_matrix, null_matrix)
  print(head(t(null_matrix)))
  print(movieLense100_matrix[nrow(movieLense100_matrix)])
  # print(nrow(movieLense100_matrix))
  # print("userselect", str(userSelect))
  # print("movieLense100_matrix", str(movieLense100_matrix))
  
  # ratingmat2 <- as.matrix(ratingmat2)
  # 
  # #Convert rating matrix into a sparse matrix
  ratingMatrix <- as(movieLense100_matrix, "realRatingMatrix")
  
  # 
  
  # #Create Recommender Model. "UBCF" stands for user-based collaborative filtering
  recommender_model <- Recommender(ratingMatrix, method = "SVDF")
  recom <- predict(recommender_model, ratingMatrix[nrow(movieLense100_matrix)], n=5)
  recom_list <- as(recom, "list")
 print(recom_list)
  no_result <- data.frame(matrix(NA,1))
  recom_result <- data.frame(matrix(NA,10))
  if (as.character(recom_list[1])=='character(0)'){
    no_result[1,1] <- "Sorry, there is not enough information in our database on the movies you've selected. Try to select different movies you like."
    colnames(no_result) <- "No results"
    return(no_result)
  } else {
    for (i in c(1:10)){
      recom_result[i,1] <- as.character(subset(movie_data,
                                               movie_data$title == as.integer(recom_list[[1]][i]))$title)
    }
    colnames(recom_result) <- "User-Based Collaborative Filtering Recommended Titles"
    return(recom_result)
  }
  # return(user_selection)
}