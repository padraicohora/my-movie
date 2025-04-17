source("./ui/components/page.component.R")
source("./server/movieFinder.module.R")
movieFinderPage<- page(
  title="Movie Finder", 
  pageInfoText="Pages displays a list of movies for you to rate. 
  Click on the rate button in the table row to open a rating modal. 
  After you have rated enough movies you can click the 'Get Recommendations' button in the modal popover",
  children=navset_tab(
    nav_panel(
      title = "List", 
      movieFinderMovieListUi("finder"),
      style = "padding: 20px 0;",
    ),
    nav_panel(
      title = "Stats", 
      p("Third tab content"),
      style = "padding: 20px 0;",
      ),
  )
)



