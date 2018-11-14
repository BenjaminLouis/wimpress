mod_cssproperty_pageInput <- function(id) {

  ns <- NS(id)

  gradientBox(
    title = "My gradient Box",
    icon = "fa fa-th",
    gradientColor = "teal",
    boxToolSize = "sm",
    plotOutput("distPlot")
  )

}
