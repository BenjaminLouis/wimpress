#' @importFrom shiny observeEvent callModule
#'
app_server <- function(input, output, session) {

  observeEvent(input$refresh, {
    callModule(mod_view_renderedpdf, "my_pdf", path = system.file("www", package = "wimpress"))
  }, ignoreNULL = FALSE)
  pageprop <- callModule(mod_cssproperty_page, "page")
  tlc <- callModule(mod_cssproperty_margin, "top-left-corner")
  tl <- callModule(mod_cssproperty_margin, "top-left")
  tc <- callModule(mod_cssproperty_margin, "top-center")
  tr <- callModule(mod_cssproperty_margin, "top-right")
  trc <- callModule(mod_cssproperty_margin, "top-right-corner")
  rt <- callModule(mod_cssproperty_margin, "right-top")
  rm <- callModule(mod_cssproperty_margin, "right-middle")
  rb <- callModule(mod_cssproperty_margin, "right-bottom")
  brc <- callModule(mod_cssproperty_margin, "bottom-right-corner")
  br <- callModule(mod_cssproperty_margin, "bottom-right")
  bc <- callModule(mod_cssproperty_margin, "bottom-center")
  bl <- callModule(mod_cssproperty_margin, "bottom-left")
  blc <- callModule(mod_cssproperty_margin, "bottom-left-corner")
  lb <- callModule(mod_cssproperty_margin, "left-bottom")
  lm <- callModule(mod_cssproperty_margin, "left-middle")
  lt <- callModule(mod_cssproperty_margin, "left-top")
}
