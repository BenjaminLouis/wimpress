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
                 column(width = 3, h4("Page")),
                 column(width = 4, h4("Property")),
                 column(width = 5, h4("Value"))
               )
      ),
      actionButton(ns("add_property"), "Add property", icon = icon("plus", lib = "glyphicon")),
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
#' @importFrom shiny observeEvent insertUI fluidRow column selectInput textInput
#'
#' @export
#' @rdname mod_view_renderedpdfUI
mod_cssproperty_page <- function(input, output, session) {

  ns <- session$ns
  props <- c("size", "color", "background-color",
             "font-size", "font-style", "text-align", "vertical-align", "line-height",
             "margin", "margin-top", "margin-right", "margin-bottom", "margin-left",
             "border", "border-top", "border-right", "border-bottom", "border-left",
             "padding", "padding-top", "padding-right", "padding-bottom", "padding-left")
  observeEvent(input$add_property, {
    insertUI(
      selector = "#titleui",
      where = "beforeEnd",
      immediate = TRUE,
      ui = fluidRow(
        column(width = 3, selectInput(ns(paste0("prop_where_",input$add_property)),
                                      label = NULL, choices = c("All", "First", "Last", "Left", "Right"))),
        column(width = 4, selectInput(ns(paste0("prop_selected_",input$add_property)),
                                      label = NULL, choices = c("", props))),
        column(width = 5, textInput(ns(paste0("prop_value_",input$add_property)), label = NULL))
      )
    )
  })

  rv <- reactiveValues(where = NULL, prop = NULL, value = NULL)
  rv$where= reactive(sapply(grep(pattern = "^prop_where_[[:digit:]]$", x = names(input), value = TRUE), function(x) input[[x]]))
  rv$prop = reactive(sapply(grep(pattern = "^prop_selected_[[:digit:]]$", x = names(input), value = TRUE), function(x) input[[x]]))
  rv$value = reactive(sapply(grep(pattern = "^prop_value_[[:digit:]]$", x = names(input), value = TRUE), function(x) input[[x]]))
  return(rv)
}
