source("ui/components/page.component.R")

myReccomendationsPage<-page(
  title="Recommendations Page", 
  children=tagList(
    newRatingsMovieListUi("display1"),
    movieRecommendationsUi("recommendations")
  )
)