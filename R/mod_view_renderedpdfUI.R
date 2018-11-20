#' @title mod_view_renderedpdfUI and mod_view_renderedpdf
#' @description A shiny module that displays a PDF file rendered from a Rmd file
#'
#' @param id shiny id
#'
#' @importFrom shiny NS uiOutput tagList
#'
#' @export
#'
#' @examples
#' \dontrun{
#' library(shiny)
#' if (interactive()) {
#' ui <- fluidPage(
#' mod_view_renderedpdfUI("my_pdf")
#' )
#'
#' server <- function(input, output, session) {
#' callModule(mod_view_renderedpdf, "my_pdf", path = system.file("www", package = "wimpress"),
#' filename = "template_report")
#' }
#'
#' shinyApp(ui, server)
#' }
#'}
mod_view_renderedpdfUI <- function(id) {

  ns <- NS(id)

  tagList(
    uiOutput(ns('reportUI'))
  )
}


#' mod_view_renderedpdf server function
#'
#' @param input internal
#' @param output internal
#' @param session inernal
#' @param path character. Path to the file to render
#' @param filename string value. Name without extension of the file to render
#' @param paramsUI reactive. A list of named parameters that override custom params
#' specified within the YAML front-matter (see argument \code{params} in \code{render})
#' @param style_css css file
#'
#' @importFrom shiny reactive renderUI tags
#' @importFrom rmarkdown render
#'
#' @export
#' @rdname mod_view_renderedpdfUI
mod_view_renderedpdf <- function(input, output, session, path, filename = "template_report", paramsUI = reactive(NULL), style_css = reactive(NULL)) {
  output$reportUI <- renderUI({
    params <- paramsUI()
    render(paste0(path, "/", filename, ".Rmd"),
           params = params, output_options = list(css = style_css()),
           envir = new.env(parent = globalenv()),
           encoding = "UTF-8", quiet = TRUE)
    tags$iframe(style = "width: 100%; height:700px; scrolling=yes", src = paste0("www/", filename, ".pdf"))
  })
}
