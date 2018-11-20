#' @importFrom shiny observeEvent callModule
#'
app_server <- function(input, output, session) {
  observeEvent(input$refresh, {
    callModule(mod_cssproperty_page, "page")
  }, ignoreNULL = FALSE)
  callModule(mod_view_renderedpdf, "my_pdf", path = system.file("www", package = "wimpress"))
}
