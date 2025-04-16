source("ui/components/page.component.R")

myRatingsPage<-page(
  title="My Ratings Page", 
  children=plotOutput("plot")
  )