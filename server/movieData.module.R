set.seed(1234)
library(recommenderlab)
library(DT)

data("MovieLense")

# Convert the realRatingMatrix to a regular matrix
movie_data_all <- as.data.frame(MovieLenseMeta)

genre_names <- names(movie_data_all)[5:length(names(movie_data_all))]

genre_values <- movie_data_all[1:nrow(movie_data_all), 5:length(names(movie_data_all))]
genre_values

# Get the column names for each row where the value is 1
genre_list <- apply(genre_values, 1, function(row) {
  colnames(genre_values)[which(row == 1)]
})
genre_list

movie_data <- movie_data_all[, c("title", "year", "url")]

movie_data$genres <- genre_list

genre_string <- function(genre){
  paste(genre, collapse = ", ")
}

movie_data$genres <- sapply(movie_data$genre, genre_string)


 
  