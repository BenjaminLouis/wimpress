#' Server function
#'
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @importFrom shiny observeEvent callModule reactive showModal modalDialog modalButton pre code tags
#' @importFrom sass sass sass_import
#'
app_server <- function(input, output, session) {

  # Copying template_style.scss in tempfiles directory
  file.copy(normalizePath(file.path(system.file("www", package = "wimpress"), "template_style.scss"),
                          winslash = "/", mustWork = FALSE),
            normalizePath(file.path(tempdir(), "template_style.scss"), winslash = "/", mustWork = FALSE))


  # Module to get css properties input for each at-rule page
  all <- callModule(mod_cssproperty_page, "all")
  first <- callModule(mod_cssproperty_page, "first")
  last <- callModule(mod_cssproperty_page, "last")
  left <- callModule(mod_cssproperty_page, "left")
  right <- callModule(mod_cssproperty_page, "right")


  # List of all at-rule pages
  wholelist <- reactive(list("all" = all, "first" = first, "last" = last,
                             "left" = left, "right" = right))


  # Which at-rule pages have css property
  boolevar <- reactive({
    ll <- lapply(1:length(wholelist()), function(i) {
      getbool(wholelist()[[i]], names(wholelist())[i])
    })
    paste0(ll, collapse = "")
  })
  observeEvent(boolevar(), {
    # Writing boolean variables
    write(x = boolevar(), file = normalizePath(file.path(tempdir(), "_boolevar.scss"), mustWork = FALSE, winslash = "/"))
  }, ignoreNULL = FALSE)


  # Variables of CSS properties for each at-rule page
  genprop <- reactive({
    ll <- lapply(1:length(wholelist()), function(i) {
      getprop(wholelist()[[i]], names(wholelist())[i])
    })
    paste0(ll[ll != ""], collapse = "\n")
  })
  observeEvent(genprop(), {
    # Writing pages general css property
    write(x = genprop(), file = normalizePath(file.path(tempdir(), "_genprop.scss"), mustWork = FALSE, winslash = "/"))
  }, ignoreNULL = FALSE)


  # Mixins of CSS properties for each at-rule margin in each at-rule page
  allmarginlist <- reactive({
    ll <- lapply(wholelist(), getlist)
    res <- lapply(1:length(ll), function(i) paste0("@mixin margin", names(ll)[i], " {\n", as.character(ll[[i]]), "\n}\n"))
    names(res) <- names(ll)
    res
  })
  observeEvent(allmarginlist(), {
    #writing margins css property
    lapply(1:length(allmarginlist()), function(i) {
      write(x = allmarginlist()[[i]],
            file = normalizePath(file.path(tempdir(), paste0("_margin", names(allmarginlist())[i], ".scss")),
                                 mustWork = FALSE, winslash = "/"))
    })
  }, ignoreNULL = FALSE)


  #Refresh to see result
  observeEvent(input$refresh, {

    # Compiling SCSS to CSS
    sass(input = sass_import(normalizePath(file.path(tempdir(), "template_style.scss"),
                                                       winslash = "/", mustWork = FALSE)),
               output = normalizePath(file.path(system.file("www", package = "wimpress"), "style.css"),
                                      winslash = "/", mustWork = FALSE))

    #rendered the pdf
    cssstyle <- reactive(normalizePath(file.path(system.file("www", package = "wimpress"), "style.css"),
                           winslash = "/", mustWork = FALSE))
    callModule(mod_view_renderedpdf, "my_pdf", path = system.file("www", package = "wimpress"),
               style_css = cssstyle)

  }, ignoreNULL = FALSE)


  #View CSS file
  observeEvent(input$view_css, {

    # Compiling SCSS to CSS
    cssstyle <- sass(input = sass_import(normalizePath(file.path(tempdir(), "template_style.scss"),
                                           winslash = "/", mustWork = FALSE)))

    #show Modal with CSS file
    showModal(modalDialog(
      title = "You can copy-paste the CSS properties code",
      tags$script("$('pre code').each(function(i, block) { hljs.highlightBlock(block);});"),
      pre(code(class = "css", cssstyle)),
      easyClose = TRUE,
      footer = modalButton("Close")
    ))
  })

}
