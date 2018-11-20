
#' @importFrom shiny actionButton icon fluidRow column
#' @importFrom shinydashboard dashboardPage dashboardSidebar dashboardBody
app_ui <- function() {

  dashboardPage(

    dashboardHeader(title = "Pimp your PDF with wimpress", titleWidth = "100%"),

    dashboardSidebar(disable = TRUE),

    dashboardBody(

      fluidRow(
        column(width = 4,
               mod_cssproperty_pageInput("page")
               ),
        column(width = 8,
               actionButton("refresh", label = "Refresh", icon = icon("redo")),
               mod_view_renderedpdfUI("my_pdf")
        )
      )
    )
  )
}
