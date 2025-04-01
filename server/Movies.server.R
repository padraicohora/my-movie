set.seed(1234)
library(recommenderlab)
library(DT)

data("MovieLense")

ui_movieList<- DTOutput('input_movieFinder_list')

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

# remove_year <- function(title) {
#   sub("\\s*\\(\\d{4}\\)$", "", title)
# }
# 
# movie_data$title <- sapply(movie_data$title, remove_year)

combine_title_url <- function(title, url) {
  cleaned_title <- remove_year(title)
  sprintf('<span>%s <a href="%s" target="_blank">Imdb</a></span>', cleaned_title, url)
}

movie_data$title <- mapply(combine_title_url, movie_data$title, movie_data$url)

movie_data$genres <- genre_list

genre_string <- function(genre){
  paste(genre, collapse = ", ")
}

movie_data$genres <- sapply(movie_data$genre, genre_string)


movie_data$action <- sprintf(
  '<button onclick="Shiny.onInputChange(\'action_button\', %d)">Action</button>', 
  seq_len(nrow(movie_data))
  )

movie_data <- movie_data[, c("title", "year", "genres", "action")]

# movie_data$url <- sprintf('<a href="%s" target="_blank">IMDB</a>', movie_data$url)

output_movieFinder_list <- renderDT({
    datatable(
      movie_data,
      escape = FALSE,  # Allow HTML content in the table
      filter = 'top',
      options = list(
    
      ),
      colnames = c("Title", "Year", "Genres", "Action")

    )
  })

 
  