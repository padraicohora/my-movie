source("./ui/components/page.component.R")

myReccomendationsPage<-page(
  title="Recommendations Page", 
  children=tagList(
    movieRecommendationsUi("recommendations"),
  ),
  # pageInfoText="Pages displays recommendations based on the movie ratings. 
  # Click on the 'Get Recommendations' to generate a recommendations",
)
