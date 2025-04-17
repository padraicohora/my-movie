library(DT)
# Define the UI for the module
movieFinderMovieListUi <- function(id, dtId) {
  ns <- NS(id)
  tagList(
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
          uiOutput("newMoviesRatingNotification"),
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
}

# Define the server logic for the module
movieFinderMovieListServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {

    renderDT({
      d<- data()
      movie_data<- d$movies
     
      # combine_title_url <- function(title, url) {
      #   cleaned_title <- remove_year(title)
      #   sprintf('<span>%s <a href="%s" target="_blank">Imdb</a></span>', cleaned_title, url)
      # }
      # 
      # movie_data$title <- mapply(combine_title_url, movie_data$title, movie_data$url)
      
      # add_rating_button <- function(title){
      #   sprintf('<span>%s <a href="%s" target="_blank">Imdb</a></span>', cleaned_title, url)
      # }
      
      movie_data$action <- sprintf(
        '<button onclick="Shiny.onInputChange(\'movie_list_rating_action\', %s)" class="btn btn-outline-success btn-sm">
        Rate Movie
        </button>', 
        row.names(movie_data)
      )
    
      
      movie_data <- movie_data[, c("title", "year", "genres", "action")]    

      datatable(
        movie_data,
        escape = FALSE,  # Allow HTML content in the table
        filter = 'top',
        selection = "none",
        options = list(
          columnDefs = list(list(targets = c(4), searchable = FALSE)),
          pageLength = 20
        ),
        colnames = c("Title", "Year", "Genres", "Action")
      )
    })
    
  })
}