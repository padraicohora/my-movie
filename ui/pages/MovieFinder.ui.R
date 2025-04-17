source("ui/components/page.component.R")
source("server/movieFinder.module.R")
movieFinderPage<- page(
  title="Movie Finder", 
  children=navset_tab(
    nav_panel(
      title = "List", 
      movieFinderMovieListUi("finder"),
    ),
    # nav_panel(title = "Genre", p("Second tab content.")),
    nav_panel(title = "Stats", p("Third tab content")),
  )
)



