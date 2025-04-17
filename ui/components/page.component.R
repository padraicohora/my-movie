library(bslib)
library(shiny)
library(bsicons)

page <- function(
    title="Page Title",
    pageInfoText= "Page Info Text",
    children=p("Page Content")
    ) {
  page_fillable(
    fluidRow(
      column(
        width = 9,
        h2(title)
      ),
      column(
        width = 3,
        style = "
          display: flex;
          flex-direction: row;
          justify-content: flex-end;
          ",
        actionButton(
          "btn_pop",
          "Info",
          icon=icon("info-circle"), 
          style = "
          padding: 5px 10px;
          font-size: 12px;
          "
        ) |>
          popover(
            style = "padding: 0 10px;",
            helpText(pageInfoText),
            title = "Page Information",
          )
      )
    ),
    fluidRow(
      column(
        width = 12,
        children
        )
    )
  )
}

