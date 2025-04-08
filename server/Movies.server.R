set.seed(1234)
library(recommenderlab)
library(DT)

data("MovieLense")

ui_movieList<- tagList(
  absolutePanel(
    id = "newMovieRatingsOverlay",
    fixed = TRUE,
    top = 100, left = 100, width = 300, height = 100,
    style = "
              width: calc(100vw - 200px);
              z-index:9;
              border-radius: 8px;
              cursor: inherit;
              background-color: transparent;
              border: 0px solid rgb(204, 204, 204);
          ",
    card(
      card_header(
        "New Movies Rated"
      ),
      card_body(
        fillable = TRUE,
        textOutput("newMoviesRatingNotification"),
      ),
      card_body(
        fillable = FALSE,
        actionButton("newMoviesRatingNotificationSubmitBtn", "Get Recommendations"),
        actionButton("newMoviesRatingNotificationClearBtn", "Clear Ratings")
      )
    )
  ),
  DTOutput('input_movieFinder_list')
)

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

add_rating_button <- function(title){
  sprintf('<span>%s <a href="%s" target="_blank">Imdb</a></span>', cleaned_title, url)
}

movie_data$action <- sprintf(
  '<button onclick="Shiny.onInputChange(\'movie_list_rating_action\', %s)">Rate Movie</button>', 
  row.names(movie_data)
  )

movie_data <- movie_data[, c("title", "year", "genres", "action")]

# movie_data$url <- sprintf('<a href="%s" target="_blank">IMDB</a>', movie_data$url)

output_movieFinder_list <- renderDT({
    datatable(
      movie_data,
      escape = FALSE,  # Allow HTML content in the table
      filter = 'top',
      options = list(
        columnDefs = list(
          list(
            targets = 4,
            render = JS(
              "function(data, type, row, meta) {",
              "console.log({data, type, row, meta})",
              "return data;",
              "}"
            )
          )
        )
      ),
      colnames = c("Title", "Year", "Genres", "Action")
    )
  })

 
  