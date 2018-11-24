
#' @importFrom shiny fluidRow column h3 actionButton icon
#' @importFrom shinydashboard dashboardPage dashboardHeader dashboardSidebar dashboardBody
#' @importFrom shinydashboardPlus gradientBox
#'
app_ui <- function() {

  dashboardPage(

    dashboardHeader(title = "@Pimp your PDF with wimpress", titleWidth = "100%"),

    dashboardSidebar(disable = TRUE),

    dashboardBody(

      fluidRow(
        column(width = 5,
               h3("CSS properties"),
               mod_cssproperty_pageInput("page"),
               gradientBox(
                 title = "Margin properties",
                 icon = "fa fa-th",
                 gradientColor = "black",
                 width = 12,
                 boxToolSize = "sm",
                 mod_cssproperty_marginInput("top-left-corner", title = "@top-left-corner"),
                 mod_cssproperty_marginInput("top-left", title = "@top-left"),
                 mod_cssproperty_marginInput("top-center", title = "@top-center"),
                 mod_cssproperty_marginInput("top-right", title = "@top-right"),
                 mod_cssproperty_marginInput("top-right-corner", title = "@top-right-corner"),
                 mod_cssproperty_marginInput("right-top", title = "@right-top"),
                 mod_cssproperty_marginInput("right-middle", title = "@right-middle"),
                 mod_cssproperty_marginInput("right-bottom", title = "@right-bottom"),
                 mod_cssproperty_marginInput("bottom-right-corner", title = "@bottom-right-corner"),
                 mod_cssproperty_marginInput("bottom-right", title = "@bottom-right"),
                 mod_cssproperty_marginInput("bottom-center", title = "@bottom-center"),
                 mod_cssproperty_marginInput("bottom-left", title = "@bottom-left"),
                 mod_cssproperty_marginInput("bottom-left-corner", title = "@bottom-left-corner"),
                 mod_cssproperty_marginInput("left-bottom", title = "@left-bottom"),
                 mod_cssproperty_marginInput("left-middle", title = "@left-middle"),
                 mod_cssproperty_marginInput("left-top", title = "@left-top")
               )),
        column(width = 7,
               actionButton("refresh", label = "Refresh", icon = icon("redo")),
               mod_view_renderedpdfUI("my_pdf")
        )
      )
    )
  )
}
