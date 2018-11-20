#' @title mod_cssproperty_pageInput and mod_cssproperty_page
#' @description A shiny module that allows to give css property for \code{@Page} rule in CSS for pages media
#'
#' @param id shiny id
#'
#' @importFrom shiny NS tagList tags fluidRow column h4 actionButton icon
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
#' mod_cssproperty_pageInput("page")
#' )
#'
#' server <- function(input, output, session) {
#' callModule(mod_cssproperty_page, "page")
#' }
#'
#' shinyApp(ui, server)
#' }
#'}
mod_cssproperty_pageInput <- function(id) {

  ns <- NS(id)

  tagList(
  gradientBox(
    title = "Page properties",
    icon = "fa fa-th",
    gradientColor = "teal",
    width = 12,
    boxToolSize = "sm",
    tags$div(id = "titleui",
    fluidRow(
      column(width = 6, h4("Property")),
      column(width = 6, h4("Value"))
    )
    ),
    footer = actionButton(ns("add_property"), "Add property", icon = icon("plus", lib = "glyphicon"))
  )
  )

}


#'  mod_cssproperty_page server function
#'
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @importFrom shiny observeEvent insertUI fluidRow column selectInput textInput
#'
#' @export
#' @rdname mod_view_renderedpdfUI
mod_cssproperty_page <- function(input, output, session) {

  ns <- session$ns

  observeEvent(input$add_property, {
    insertUI(
      selector = "#titleui",
      where = "beforeEnd",
      immediate = TRUE,
      ui =fluidRow(
        column(width = 6, selectInput(ns("prop_selected"), label = NULL, choices = c("prop1", "prop2"))),
        column(width = 6, textInput(ns("prop_value"), label = NULL))
      )
    )
  })

}
