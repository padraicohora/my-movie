source("ui/components/page.component.R")
source("server/movies.module.R")
aboutPage<-page(
  title="About Page", 
  children=tagList(
    textInput("text_test", "Enter text:"),
    mod_display_ui("display1")
  )
)