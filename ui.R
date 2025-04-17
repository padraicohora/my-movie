#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
# install.packages("bslib")
# install.packages("shinyjs")
# install.packages("shinyRatings")
# install.packages("shinycssloaders")
library(shiny)
library(shinydashboard)
library(bslib)
library(ggplot2)
library(tools)
library(shinyjs)
library(shinyRatings)
library(shinycssloaders)

link_shiny <- tags$a(shiny::icon("github"), "Shiny", href = "https://github.com/rstudio/shiny", target = "_blank")
link_posit <- tags$a(shiny::icon("r-project"), "Posit", href = "https://posit.co", target = "_blank")

link_code <- tags$a( "Code", href = "https://github.com/padraicohora/my-movie", target = "_blank")

source("./ui/pages/About.ui.R")
source("./ui/pages/MovieFinder.ui.R")
source("./ui/pages/MyRatings.ui.R")
source("./ui/pages/MyRecommendations.ui.R")

# Define UI for application that draws a histogram
# shinyUI(
#   dashboardPage(
#     skin="red",
#     dashboardHeader(title = "MyMovies"),
#     dashboardSidebar(
#       sidebarMenu(
#         navset_pill_list(
#           nav_panel(title = "One", one),
#           nav_panel(title = "Two", two),
#           nav_panel(title = "Three", p("Third tab content")),
#           nav_spacer(),
#           nav_menu(
#             title = "Links",
#             nav_item(link_shiny),
#             nav_item(link_posit)
#           )
#         )
#         # menuItem("New Movie", tabName = "movies", icon = icon("star-o")),
#         # menuItem("About", tabName = "about", icon = icon("question-circle")),
#         # menuItem("Source code", icon = icon("file-code-o"),
#         #          href = "https://github.com/suresh/movie-recommendations"),
#         # menuItem(
#         #   list(
#         #     
#         #     selectInput("select", label = h5("Select 3 Movies That You Like"),
#         #                 choices = as.character(movies$title[1:length(unique(movies$movieId))]),
#         #                 selectize = FALSE,
#         #                 selected = "Shawshank Redemption, The (1994)"),
#         #     selectInput("select2", label = NA,
#         #                 choices = as.character(movies$title[1:length(unique(movies$movieId))]),
#         #                 selectize = FALSE,
#         #                 selected = "Forrest Gump (1994)"),
#         #     selectInput("select3", label = NA,
#         #                 choices = as.character(movies$title[1:length(unique(movies$movieId))]),
#         #                 selectize = FALSE,
#         #                 selected = "Silence of the Lambs, The (1991)"),
#         #     submitButton("Submit")
#         #   )
#         # )
#       )
#       # selectInput(
#       #   inputId = "y",
#       #   label = "Y-axis:",
#       #   choices = c(
#       #     "IMDB rating" = "imdb_rating",
#       #     "IMDB number of votes" = "imdb_num_votes",
#       #     "Critics Score" = "critics_score",
#       #     "Audience Score" = "audience_score",
#       #     "Runtime" = "runtime"
#       #   ),
#       #   selected = "audience_score"
#       # ),
#       # 
#       # selectInput(
#       #   inputId = "x",
#       #   label = "X-axis:",
#       #   choices = c(
#       #     "IMDB rating" = "imdb_rating",
#       #     "IMDB number of votes" = "imdb_num_votes",
#       #     "Critics Score" = "critics_score",
#       #     "Audience Score" = "audience_score",
#       #     "Runtime" = "runtime"
#       #   ),
#       #   selected = "critics_score"
#       # ),
#       # 
#       # selectInput(
#       #   inputId = "z",
#       #   label = "Color by:",
#       #   choices = c(
#       #     "Title Type" = "title_type",
#       #     "Genre" = "genre",
#       #     "MPAA Rating" = "mpaa_rating",
#       #     "Critics Rating" = "critics_rating",
#       #     "Audience Rating" = "audience_rating"
#       #   ),
#       #   selected = "mpaa_rating"
#       # ),
#       # 
#       # sliderInput(
#       #   inputId = "alpha",
#       #   label = "Alpha:",
#       #   min = 0, max = 1,
#       #   value = 0.5
#       # ),
#       # 
#       # sliderInput(
#       #   inputId = "size",
#       #   label = "Size:",
#       #   min = 0, max = 5,
#       #   value = 2
#       # ),
#       # 
#       # textInput(
#       #   inputId = "plot_title",
#       #   label = "Plot title",
#       #   placeholder = "Enter text to be used as plot title"
#       # ),
#       # 
#       # actionButton(
#       #   inputId = "update_plot_title",
#       #   label = "Update plot title"
#       # )
#     ),
#     dashboardBody(
#       tags$head(
#         tags$style(type="text/css", "select { max-width: 360px; }"),
#         tags$style(type="text/css", ".span4 { max-width: 360px; }"),
#         tags$style(type="text/css",  ".well { max-width: 360px; }")
#       ),
#       
#       tabItems(
#         tabItem(tabName = "about",
#                 h2("About this App"),
#                 
#                 HTML('<br/>'),
#                 
#                 fluidRow(
#                   box(title = "Author: Suresh Shanmugam", background = "black", width=7, collapsible = TRUE,
#                       
#                       helpText(p(strong("This application a movie recommender using the movielens dataset."))),
#                       
#                       helpText(p("Please contact",
#                                  a(href ="https://twitter.com/suresh_p", "Suresh on twitter",target = "_blank"),
#                                  " or at my",
#                                  a(href ="http://sureshshanmugam.com/", "personal page", target = "_blank"),
#                                  ", for more information, to suggest improvements or report errors.")),
#                       
#                       helpText(p("All code and data is available at ",
#                                  a(href ="https://github.com/suresh/", "my GitHub page",target = "_blank"),
#                                  "or click the 'source code' link on the sidebar on the left."
#                       ))
#                   )
#                 )
#         ),
#         tabItem(tabName = "movies",
#                 fluidRow(
#                   box(
#                     width = 6, status = "info", solidHead = TRUE,
#                     title = "Other Movies You Might Like",
#                     tableOutput("table")),
#                   valueBoxOutput("tableRatings1"),
#                   valueBoxOutput("tableRatings2"),
#                   valueBoxOutput("tableRatings3"),
#                   HTML('<br/>')
#                 )
#         )
#       )
#     )
# )
# )

ui <- page_navbar(
  useShinyjs(),
  title = "My Movies",
  id='pages',
  navbar_options = navbar_options(
    bg = "#0062cc",
    underline = TRUE
  ),
  nav_panel(title = "Movie Finder", movieFinderPage),
  nav_panel(title = "My Recommendations", myReccomendationsPage),
  nav_panel(title = "My Ratings", myRatingsPage),
  nav_panel(title = "About", aboutPage),
  nav_item(link_code),
  nav_spacer(),
  # nav_menu(
  #   title = "Profiles",
  #   align = "right",
  #   nav_item(link_shiny),
  #   nav_item(link_posit)
  # )
)
