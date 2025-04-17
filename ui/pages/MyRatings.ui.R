source("./ui/components/page.component.R")
source("./server/myratings.module.R")
myRatingsPage<-page(
  title="My Ratings Page", 
  # pageInfoText="Pages displays your past movie ratings you have added from the Movie Finder page",
  children=myRatingsMovieListUi("ratings", "myRatingsDataTable"),
  )
