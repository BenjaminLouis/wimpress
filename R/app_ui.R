
#' @importFrom shiny actionButton icon fluidRow column h3
#' @importFrom shinydashboard dashboardPage dashboardHeader dashboardSidebar dashboardBody
app_ui <- function() {

  dashboardPage(

    dashboardHeader(title = "Pimp your PDF with wimpress", titleWidth = "100%"),

    dashboardSidebar(disable = TRUE),

    dashboardBody(

      fluidRow(
        column(width = 5,
               h3("Pages properties"),
               mod_cssproperty_pageInput("page")
               ),
        column(width = 7,
               actionButton("refresh", label = "Refresh", icon = icon("redo")),
               mod_view_renderedpdfUI("my_pdf")
        )
      )
    )
  )
}
