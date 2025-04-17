# install.packages("recommenderlab")
set.seed(1234)
library(recommenderlab)

data("MovieLense")

str(MovieLense)

## look at the first few ratings of the first user
head(as(MovieLense[1,], "list")[[1]])

## visualize part of the matrix
image(MovieLense[1:100,1:100])

## number of ratings per user
hist(rowCounts(MovieLense))

## number of ratings per movie
hist(colCounts(MovieLense))

## mean rating (averaged over users)
mean(rowMeans(MovieLense))

## available movie meta information
head(MovieLenseMeta)

## available user meta information
head(MovieLenseUser)

# Train a user-based collaborative filtering recommender using a small training set.
MovieLense100 <- MovieLense[rowCounts(MovieLense) > 100, ]
MovieLense100

train <- MovieLense100[1:300]
rec <- Recommender(train, method = "UBCF")
rec

# Create top-N recommendations for new users (users 301 and 302).
pre <- predict(rec, MovieLense100[301:302], n = 5)
pre

## Recommendations as 'topNList' with n = 5 for 2 users.
as(pre, "list")
movie_data_all <- as.data.frame(MovieLenseMeta)

genre_names <- names(movie_data_all)[5:length(names(movie_data_all))]

genre_values <- movie_data_all[1:nrow(movie_data_all), 5:length(names(movie_data_all))]
genre_values

# Get the column names for each row where the value is 1
genre_list <- apply(genre_values, 1, function(row) {
  colnames(genre_values)[which(row == 1)]
})
genre_list

# Apply the function to each row
movie_data <- MovieLenseMeta[, c("title", "url")]

movie_data$genres <- genre_list

# Convert the realRatingMatrix to a regular matrix
MovieLense_matrix <-as(MovieLense, "data.frame")

# Remove half-increment ratings from the matrix
MovieLense_matrix[MovieLense_matrix %% 1 != 0] <- NA
