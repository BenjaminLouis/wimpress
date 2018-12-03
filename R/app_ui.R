
#' @importFrom shiny fluidRow column h3 actionButton icon
#' @importFrom shinydashboard dashboardPage dashboardHeader dashboardSidebar dashboardBody
#' @importFrom shinydashboardPlus gradientBox
#'
app_ui <- function() {

  dashboardPage(

    dashboardHeader(title = "Pimp your PDF with wimpress", titleWidth = "100%"),

    dashboardSidebar(disable = TRUE),

    dashboardBody(

      fluidRow(
        column(width = 5,
               h3("CSS properties"),
               mod_cssproperty_pageInput("all", title = "@page"),
               mod_cssproperty_pageInput("first", title = "@page :first"),
               mod_cssproperty_pageInput("last", title = "@page :last"),
               mod_cssproperty_pageInput("left", title = "@page :left"),
               mod_cssproperty_pageInput("right", title = "@page :right")
               ),
        column(width = 7,
               actionButton("refresh", label = "Refresh", icon = icon("redo")),
               mod_view_renderedpdfUI("my_pdf")
        )
      )
    )
  )
}
