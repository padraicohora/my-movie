library(recommenderlab)
source("ui/components/page.component.R")

movieFinderPage<- page(
  title="Movie Finder", 
  children="Movie Finder content"
  )


movieFinderPageOld<-page_fillable(
  fluidRow(
    h1("fluid row")
),
fluidRow(
  box(title = "Author: Suresh Shanmugam", background = "black", width=7, collapsible = TRUE,

      helpText(p(strong("This application a movie recommender using the movielens dataset."))),

      helpText(p("Please contact",
                 a(href ="https://twitter.com/suresh_p", "Suresh on twitter",target = "_blank"),
                 " or at my",
                 a(href ="http://sureshshanmugam.com/", "personal page", target = "_blank"),
                 ", for more information, to suggest improvements or report errors.")),

      helpText(p("All code and data is available at ",
                 a(href ="https://github.com/suresh/", "my GitHub page",target = "_blank"),
                 "or click the 'source code' link on the sidebar on the left."
      ))
  )
),
  card(
    full_screen = TRUE,
    card_header("Weight vs. Quarter Mile Time"),
    layout_sidebar(
      sidebar = sidebar(
        varSelectInput("var_x", "Compare to qsec:", mtcars[-7], "wt"),
        varSelectInput("color", "Color by:", mtcars[-7], "cyl"),
        position = "right"
      ),
      plotOutput("var_vs_qsec")
    )
  )
)



