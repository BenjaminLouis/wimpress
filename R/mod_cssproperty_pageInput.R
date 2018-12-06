#' @title mod_cssproperty_pageInput and mod_cssproperty_page
#' @description A shiny module that allows to give css property for \code{@Page} rule in CSS for pages media
#'
#' @param id shiny id
#' @param title title of the \code{gradientBox}
#' @param col background color of the \code{gradientBox}
#'
#' @importFrom shiny NS tagList tags fluidRow column h4 actionButton icon hr
#' @importFrom shinydashboardPlus gradientBox
#'
#' @export
#'
#' @examples
#' \dontrun{
#' library(shiny)
#' library(shinydashboardPlus)
#' if (interactive()) {
#' ui <- fluidPage(
#' mod_cssproperty_pageInput("page", title = "page")
#' )
#'
#' server <- function(input, output, session) {
#' callModule(mod_cssproperty_page, "page")
#' }
#'
#' shinyApp(ui, server)
#' }
#'}
mod_cssproperty_pageInput <- function(id, title, col = "black") {

  ns <- NS(id)

  tagList(
    gradientBox(
      title = title,
      icon = "fa fa-file",
      gradientColor = col,
      width = 12,
      boxToolSize = "sm",
      tags$div(id = ns("titleui"),
               fluidRow(
                 column(width = 3, h4("Margin")),
                 column(width = 4, h4("Property")),
                 column(width = 5, h4("Value"))
               )
      ),
      hr(),
      fluidRow(
        column(width = 4, actionButton(ns("add_counter"), "Add page counter", icon = icon("plus", lib = "glyphicon")), offset = 4),
        column(width = 4, actionButton(ns("add_property"), "Add property", icon = icon("plus", lib = "glyphicon")))
      ),
      footer_padding = FALSE
    )
  )

}


#'  mod_cssproperty_page server function
#'
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @importFrom shiny reactiveValues observeEvent insertUI fluidRow column selectInput textInput reactive
#'
#' @export
#' @rdname mod_cssproperty_pageInput
mod_cssproperty_page <- function(input, output, session) {

  ns <- session$ns
  props <- c("size", "color", "background-color", "content", "text-transform", "font-wheight",
             "font-size", "font-style", "text-align", "vertical-align", "line-height",
             "margin", "margin-top", "margin-right", "margin-bottom", "margin-left",
             "border", "border-top", "border-right", "border-bottom", "border-left",
             "padding", "padding-top", "padding-right", "padding-bottom", "padding-left",
             "width", "height", "overflow", "overflox-x", "overflow-y", "display")
  rv <- reactiveValues(where = NULL, prop = NULL, value = NULL)

  observeEvent(input$add_property, {
    insertUI(
      selector = paste0("#", ns("titleui")),
      where = "beforeEnd",
      immediate = TRUE,
      ui = fluidRow(
        column(width = 3, selectInput(ns(paste0("prop_where_",input$add_property)), label = NULL,
                                      choices = c("none", "t-l-co", "t-l", "t-ce", "t-r", "t-r-co",
                                                  "r-t", "r-m", "r-b", "b-r-co", "b-r",
                                                  "b-ce", "b-l", "b-l-co", "l-b", "l-m", "l-t"))),
        column(width = 4, selectInput(ns(paste0("prop_selected_",input$add_property)),
                                      label = NULL, choices = c("", sort(props)))),
        column(width = 5, textInput(ns(paste0("prop_value_",input$add_property)), label = NULL))
      )
    )
  })

  observeEvent(input$add_counter, {
    insertUI(
      selector = paste0("#", ns("titleui")),
      where = "beforeEnd",
      immediate = TRUE,
      ui = fluidRow(
        column(width = 3, selectInput(ns("prop_where_0"), label = NULL,
                                      choices = c("none", "t-l-co", "t-l", "t-ce", "t-r", "t-r-co",
                                                  "r-t", "r-m", "r-b", "b-r-co", "b-r",
                                                  "b-ce", "b-l", "b-l-co", "l-b", "l-m", "l-t"))),
        column(width = 4, selectInput(ns("prop_selected_0"), label = NULL, choices = c("content"))),
        column(width = 5, selectInput(ns("prop_value_0"),
                                      label = NULL, choices = c("1", "1/10", "Page 1", "Page 1/10")))
      )
    )
  })

  rv$where = reactive(sapply(grep(pattern = "^prop_where_[[:digit:]]$", x = names(input), value = TRUE), function(x) input[[x]]))
  rv$prop = reactive(sapply(grep(pattern = "^prop_selected_[[:digit:]]$", x = names(input), value = TRUE), function(x) input[[x]]))
  rv$value <- reactive({
    res <- sapply(grep(pattern = "^prop_value_[[:digit:]]$", x = names(input), value = TRUE), function(x) input[[x]])
    res[grep("content", rv$prop())] <- paste0("'", res[grep("content", rv$prop())], "'")
    res[res == "'1'"] <- "counter(page)"
    res[res == "'1/10'"] <- "counter(page) '/' counter(pages)"
    res[res == "'Page 1'"] <- "'Page ' counter(page)"
    res[res == "'Page 1/10'"] <- "'Page ' counter(page) '/' counter(pages)"
    res
  })
  return(rv)
}
