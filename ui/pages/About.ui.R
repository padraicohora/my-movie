source("ui/components/page.component.R")

aboutPage<-page(
  title="About Page", 
  children=tagList(
    
    p("This Shiny R project creates an interactive movie recommendation system. Users can rate a list of movies, and the system provides personalized movie recommendations based on their ratings. The project leverages the ",
      a("recommenderlab package", href = "https://cran.r-project.org/web/packages/recommenderlab/index.html"),
      ", utilizing the ",
      a("Funk SVD model", href = "https://www.rdocumentation.org/packages/recommenderlab/versions/1.0.6/topics/funkSVD"),
      " to generate accurate and relevant recommendations. The user interface is designed to be intuitive, allowing users to easily input their ratings and view their recommended movies in real-time.")
    
      )
  )