
movieFinderPage<-p("Movie Finder Page")
one<- p("First tab content test.")
two<-fluidRow(
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
)



Tab1 <- tabItem(tabName = "about",
                h2("About this App"),
                
                HTML('<br/>'),
                
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
                )
)

Tab2 <-    tabItem(tabName = "movies",
                   fluidRow(
                     box(
                       width = 6, status = "info", solidHead = TRUE,
                       title = "Other Movies You Might Like",
                       tableOutput("table")),
                     valueBoxOutput("tableRatings1"),
                     valueBoxOutput("tableRatings2"),
                     valueBoxOutput("tableRatings3"),
                     HTML('<br/>')
                   )
)