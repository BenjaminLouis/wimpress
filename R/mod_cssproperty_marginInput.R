#' @title mod_cssproperty_marginInput and mod_cssproperty_margin
#' @description A shiny module that allows to give css property for \code{@Page} rule in CSS for pages media
#'
#' @param id shiny id
#' @param title title of the \code{gradientBox}
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
#' mod_cssproperty_marginInput("left-corner")
#' )
#'
#' server <- function(input, output, session) {
#' callModule(mod_cssproperty_margin, "left-corner")
#' }
#'
#' shinyApp(ui, server)
#' }
#'}
mod_cssproperty_marginInput <- function(id, title) {

  ns <- NS(id)

  tagList(
    gradientBox(
      title = title,
      icon = NULL,
      gradientColor = "yellow",
      width = 12,
      boxToolSize = "sm",
      tags$div(id = ns("titleui"),
               fluidRow(
                 column(width = 3, h4("Page")),
                 column(width = 4, h4("Property")),
                 column(width = 5, h4("Value"))
               )
      ),
      fluidRow(
        column(width = 4, actionButton(ns("add_counter"), "Add page counter", icon = icon("plus", lib = "glyphicon")), offset = 4),
        column(width = 4, actionButton(ns("add_property"), "Add property", icon = icon("plus", lib = "glyphicon")))
      ),
      footer_padding = FALSE
    )
  )

}


#'  mod_cssproperty_margin server function
#'
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @importFrom dplyr recode
#' @importFrom shiny reactiveValues observeEvent insertUI fluidRow column selectInput textInput reactive
#'
#' @export
#' @rdname mod_cssproperty_marginInput
mod_cssproperty_margin <- function(input, output, session) {

  ns <- session$ns
  props <- c("content", "color", "background-color", "text-transform", "font-wheight",
             "font-size", "font-style", "text-align", "vertical-align", "line-height",
             "margin", "margin-top", "margin-right", "margin-bottom", "margin-left",
             "border", "border-top", "border-right", "border-bottom", "border-left",
             "padding", "padding-top", "padding-right", "padding-bottom", "padding-left")
  rv <- reactiveValues(where = NULL, prop = NULL, value = NULL)

  observeEvent(input$add_property, {
    insertUI(
      selector = paste0("#", ns("titleui")),
      where = "beforeEnd",
      immediate = TRUE,
      ui = fluidRow(
        column(width = 3, selectInput(ns(paste0("prop_where_",input$add_property)),
                                      label = NULL, choices = c("All", "First", "Last", "Left", "Right"))),
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
        column(width = 3, selectInput(ns("prop_where_0"),
                                      label = NULL, choices = c("All", "First", "Last", "Left", "Right"))),
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
    recode(res,
           "1" = "counter(page)",
           "1/10" = "counter(page) '/' counter(pages))",
           "Page 1" = "'Page ' counter(page)",
           "Page 1/10" = "'Page ' counter(page) '/' counter(pages))")
    })

  return(rv)
}
