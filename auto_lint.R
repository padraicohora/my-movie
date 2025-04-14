library(lintr)
library(rstudioapi)

lint_on_save <- function() {
  lintr::use_lintr(type = "tidyverse")
  context <- rstudioapi::getActiveDocumentContext()
  lint_results <- lintr::lint(context$path)
  print(lint_results)
}

rstudioapi::addDocumentSaveListener(lint_on_save)
