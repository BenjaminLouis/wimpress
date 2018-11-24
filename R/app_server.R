#' @importFrom shiny observeEvent callModule
#'
app_server <- function(input, output, session) {

  page <- callModule(mod_cssproperty_page, "page")
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

  wholelist <- reactive(list("page" = page, "top-left-corner" = tlc, "top-left" = tl,
    "top-center" = tc, "top-right" = tr, "top-right-corner" = trc, "right-top" = rt,
    "right-middle" = rm, "right-bottom" = rb, "bottom-right-corner" = brc, "bottom-right" = br,
    "bottom-center" = bc, "bottom-left" = bl, "bottom-left-corner" = blc, "left-bottom" = lb,
    "left-middle" = lm, "left-top" = lt))
  boolevar <- reactive({
    paste0(
      "$boolall: ", any(sapply(wholelist(), getbool, what = "All")), ";\n",
      "$boolfirst: ", any(sapply(wholelist(), getbool, what = "First")), ";\n",
      "$boollast: ", any(sapply(wholelist(), getbool, what = "Last")), ";\n",
      "$boolleft: ", any(sapply(wholelist(), getbool, what = "Left")), ";\n",
      "$boolright: ", any(sapply(wholelist(), getbool, what = "Right")), ";\n"
    )
  })

  genprop <- reactive(getprop(page, wh = "prop"))

  # allmarginlist <- reactive({
  #   res <- lapply(1:(length(wholelist()) - 1), function(i) getlist(wholelist()[[i + 1]], marginname = names(wholelist())[i + 1]))
  #   pagetype <- unlist(sapply(res, names))
  #   pagetype <- unique(pagetype[!is.na(pagetype)])
  #
  # })
  #
  # observe(print(allmarginlist()))


  observeEvent(input$refresh, {
    write(x = boolevar(), file = normalizePath(file.path(system.file("www", package = "wimpress"), "_boolevar.scss"), mustWork = FALSE, winslash = "/"))
    write(x = genprop(), file = normalizePath(file.path(system.file("www", package = "wimpress"), "_genprop.scss"), mustWork = FALSE, winslash = "/"))
    callModule(mod_view_renderedpdf, "my_pdf", path = system.file("www", package = "wimpress"))
  }, ignoreNULL = FALSE)
}
