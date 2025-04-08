library(recommenderlab)
library(DT)

source("ui/components/page.component.R")
source("server/Movies.server.R")

movieFinderPage<- page(
  title="Movie Finder", 
  children=navset_tab(
    nav_panel(
      title = "List", 
      ui_movieList,
      # tagList(
      #   absolutePanel(
      #     id = "newMovieRatingsOverlay",
      #     fixed = TRUE,
      #     top = 100, left = 100, width = 300, height = 100,
      #     style = "
      #         width: calc(100vw - 200px);
      #         z-index:9;
      #         border-radius: 8px;
      #         cursor: inherit;
      #         background-color: transparent;
      #         border: 0px solid rgb(204, 204, 204);
      #     ",
      #     card(
      #       card_header(
      #         "New Movies Rated"
      #       ),
      #       card_body(
      #         fillable = TRUE,
      #         textOutput("newMoviesRatingNotification"),
      #       ),
      #       card_body(
      #         fillable = FALSE,
      #         actionButton("newMoviesRatingNotificationSubmitBtn", "Get Recommendations"),
      #         actionButton("newMoviesRatingNotificationClearBtn", "Clear Ratings")
      #       )
      #     )
      #   ),
      #   DTOutput('input_movieFinder_list')
      # ),
    ),
    nav_panel(title = "Genre", p("Second tab content.")),
    nav_panel(title = "Stats", p("Third tab content")),
  )
)



