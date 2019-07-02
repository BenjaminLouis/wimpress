#' UI function
#'
#' @importFrom shiny fluidRow column h3 actionButton icon tags hr br
#' @importFrom shinydashboard dashboardPage dashboardHeader dashboardSidebar dashboardBody
#' @importFrom shinydashboardPlus gradientBox loadingState
#' @importFrom shinycssloaders withSpinner
#'
app_ui <- function() {

  dashboardPage(skin = "purple",

    dashboardHeader(title = "Pimp your PDF with wimpress", titleWidth = "100%"),

    dashboardSidebar(disable = TRUE),

    dashboardBody(

      tags$head(
        tags$link(rel = "stylesheet", href = "www/my-style.css"),
        tags$link(rel = "stylesheet", href = "www/icopaged/style.css"),
        #tags$link(rel = "stylesheet", href = "www/icopaged/ie7/ie7.css"),
        tags$link(rel = "stylesheet",
                  href = "//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.9.0/styles/agate.min.css"),
        tags$script(src = "//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.9.0/highlight.min.js"),
        tags$script("hljs.initHighlightingOnLoad();")
      ),

      fluidRow(
        column(width = 5,
               h3("CSS properties"),
               hr(),
               mod_cssproperty_pageInput("all", title = "@page"),
               mod_cssproperty_pageInput("first", title = "@page :first"),
               mod_cssproperty_pageInput("last", title = "@page :last"),
               mod_cssproperty_pageInput("left", title = "@page :left"),
               mod_cssproperty_pageInput("right", title = "@page :right")
               ),
        column(width = 7,
               h3("PDF File"),
               hr(),
               actionButton("refresh", label = "Refresh", icon = icon("redo"), class = "btn btn-primary"),
               actionButton("view_css", label = "View CSS code", icon = icon("code"), class = "btn btn-primary"),
               br(),
               withSpinner(mod_view_renderedpdfUI("my_pdf"))
        )
      )
    )
  )
}
