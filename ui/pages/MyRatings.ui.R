source("ui/components/page.component.R")
source("server/myratings.module.R")
myRatingsPage<-page(
  title="My Ratings Page", 
  children=myRatingsMovieListUi("ratings", "myRatingsDataTable")
  )