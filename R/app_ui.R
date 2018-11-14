
#' @importFrom shiny fluidPage titlePanel sidebarLayout sidebarPanel mainPanel actionButton icon
app_ui <- function() {
  fluidPage(
    titlePanel("Pimp your PDF with wimpress"),
    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
      ),

      # Show a plot of the generated distribution
      mainPanel(
        actionButton("refresh", label = "Refresh", icon = icon("redo")),
        mod_view_renderedpdfUI("my_pdf")
      )
    )
  )
}
