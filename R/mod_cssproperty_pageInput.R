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
                 column(width = 2, h4("Margin")),
                 column(width = 3, h4("Property")),
                 column(width = 4, h4("Value"))
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
#' @importFrom shiny reactiveValues observeEvent insertUI fluidRow column selectInput textInput reactive removeUI
#' @importFrom shinyWidgets pickerInput actionBttn
#' @importFrom htmltools tags
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
  marginchoices <- c("none", "top-left-corner", "top-left", "top-center", "top-rright",
                     "top-right-corner", "right-top", "right-middle", "right-bottom",
                     "bottom-right-corner", "bottom-right","bottom-center", "bottom-left",
                     "bottom-left-corner", "left-bottom", "left-middle", "left-top")
  rv <- reactiveValues(where = NULL, prop = NULL, value = NULL, nremoved = NULL)

  observeEvent(input$add_property, {
    nr <- input$add_property
    insertUI(
      selector = paste0("#", ns("titleui")),
      where = "beforeEnd",
      immediate = TRUE,
      ui = tags$div(id = ns(paste0("ui_property_", nr)),
                    fluidRow(
        column(width = 2, pickerInput(ns(paste0("prop_where_",nr)), label = NULL,
                                      choices = marginchoices,
                                      choicesOpt = list(icon = paste0("icon-", marginchoices)),
                                      options = list(`icon-base` = "", tickIcon = ""))),
        column(width = 4, selectInput(ns(paste0("prop_selected_",nr)),
                                      label = NULL, choices = c("", sort(props)))),
        column(width = 3, textInput(ns(paste0("prop_value_",nr)), label = NULL)),
        column(width = 1,  actionBttn(inputId = ns(paste0("info_",nr)), label = NULL, size = "sm",
                                     style = "material-circle", color = "primary", icon = icon("question"))),
        column(width = 1,  actionBttn(inputId = ns(paste0("remove_",nr)), label = NULL, size = "sm",
                                      style = "material-circle", color = "danger", icon = icon("times")))

      ))
    )
    observeEvent(input[[paste0("remove_", nr)]],{
      removeUI(
        selector = paste0("#", ns(paste0("ui_property_", nr)))
      )
      rv$nremoved <- c(rv$nremoved, nr)
    })
  })

  observeEvent(input$add_counter, {
    nc <- paste0("c", input$add_counter)
    insertUI(
      selector = paste0("#", ns("titleui")),
      where = "beforeEnd",
      immediate = TRUE,
      ui = tags$div(id = ns(paste0("ui_counter_", nc)),
                    fluidRow(
        column(width = 2, pickerInput(ns(paste0("prop_where_", nc)), label = NULL,
                                      choices = marginchoices,
                                      choicesOpt = list(icon = paste0("icon-", marginchoices)),
                                      options = list(`icon-base` = "", tickIcon = ""))),
        column(width = 4, selectInput(ns(paste0("prop_selected_", nc)), label = NULL, choices = c("content"))),
        column(width = 3, selectInput(ns(paste0("prop_value_", nc)),
                                      label = NULL, choices = c("1", "1/10", "Page 1", "Page 1/10"))),
        column(width = 1,  actionBttn(inputId = ns(paste0("info_",nc)), label = NULL, size = "sm",
                                      style = "material-circle", color = "primary", icon = icon("question"))),
        column(width = 1,  actionBttn(inputId = ns(paste0("remove_",nc)), label = NULL, size = "sm",
                                      style = "material-circle", color = "danger", icon = icon("times")))
      ))
    )
    observeEvent(input[[paste0("remove_", nc)]],{
      removeUI(
        selector = paste0("#", ns(paste0("ui_counter_", nc)))
      )
      rv$nremoved <- c(rv$nremoved, nc)
    })
  })


  nm <- reactive({
    if (!is.null(rv$nremoved)) {
      pat <- paste0("(", paste0(c(rv$nremoved, rv$countremoved), collapse = "|"), ")")
      nmint <- names(input)[!grepl(pat, names(input))]
    } else {
      nmint <- names(input)
    }
    print(nmint)
    nmint
  })

  rv$where <- reactive(sapply(grep(pattern = "^prop_where_c?[[:digit:]]+$", x = nm(), value = TRUE), function(x) input[[x]]))
  rv$prop = reactive(sapply(grep(pattern = "^prop_selected_c?[[:digit:]]+$", x = nm(), value = TRUE), function(x) input[[x]]))
  rv$value <- reactive({
    res <- sapply(grep(pattern = "^prop_value_c?[[:digit:]]+$", x = nm(), value = TRUE), function(x) input[[x]])
    res[grep("content", rv$prop())] <- paste0("'", res[grep("content", rv$prop())], "'")
    res[res == "'1'"] <- "counter(page)"
    res[res == "'1/10'"] <- "counter(page) '/' counter(pages)"
    res[res == "'Page 1'"] <- "'Page ' counter(page)"
    res[res == "'Page 1/10'"] <- "'Page ' counter(page) '/' counter(pages)"
    res
  })
  return(rv)
}
