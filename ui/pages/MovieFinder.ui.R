library(recommenderlab)
library(DT)

source("ui/components/page.component.R")
source("server/Movies.server.R")

movieFinderPage<- page(
  title="Movie Finder", 
  children=navset_tab(
    nav_panel(title = "List", ui_movieList),
    nav_panel(title = "Genre", p("Second tab content.")),
    nav_panel(title = "Stats", p("Third tab content")),
  )
)



