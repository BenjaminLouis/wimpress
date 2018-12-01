#' @importFrom shiny observeEvent callModule
#'
app_server <- function(input, output, session) {

  init <- reactive(0)

  all <- callModule(mod_cssproperty_page, "all")
  first <- callModule(mod_cssproperty_page, "first")
  last <- callModule(mod_cssproperty_page, "last")
  left <- callModule(mod_cssproperty_page, "left")
  right <- callModule(mod_cssproperty_page, "right")

  wholelist <- reactive(list("all" = all, "first" = first, "last" = last,
                             "left" = left, "right" = right))


  boolevar <- reactive({
    ll <- lapply(1:length(wholelist()), function(i) {
        getbool(wholelist()[[i]], names(wholelist())[i])
    })
    paste0(ll, collapse = "")
  })


  genprop <- reactive({
    ll <- lapply(1:length(wholelist()), function(i) {
      getprop(wholelist()[[i]], names(wholelist())[i])
    })
    paste0(ll[ll != ""], collapse = "\n")
  })

observe(print(genprop()))

  allmarginlist <- reactive({
    ll <- lapply(wholelist(), getlist)
    res <- lapply(1:length(ll), function(i) paste0("@mixin margin", names(ll)[i], " {\n", as.character(ll[[i]]), "\n}\n"))
    names(res) <- names(ll)
    res
  })

  # Only when the button is clicked on
  observeEvent(input$refresh, {
    # Writing boolean variables
    write(x = boolevar(), file = normalizePath(file.path(system.file("www", package = "wimpress"), "_boolevar.scss"), mustWork = FALSE, winslash = "/"))
    # Writing pages general css property
    write(x = genprop(), file = normalizePath(file.path(system.file("www", package = "wimpress"), "_genprop.scss"), mustWork = FALSE, winslash = "/"))
    #writing margins css property
    lapply(1:length(allmarginlist()), function(i) {
      write(x = allmarginlist()[[i]], file = normalizePath(file.path(system.file("www", package = "wimpress"), paste0("_margin", names(allmarginlist())[i], ".scss")), mustWork = FALSE, winslash = "/"))
    })
    init <- reactive(init() + 1)
  }, ignoreNULL = FALSE)

  observeEvent(input$refresh, {
    # Writing boolean variables
    write(x = boolevar(), file = normalizePath(file.path(tempdir(), "_boolevar.scss"), mustWork = FALSE, winslash = "/"))
    # Writing pages general css property
    write(x = genprop(), file = normalizePath(file.path(tempdir(), "_genprop.scss"), mustWork = FALSE, winslash = "/"))
    #writing margins css property
    lapply(1:length(allmarginlist()), function(i) {
      write(x = allmarginlist()[[i]], file = normalizePath(file.path(tempdir(), paste0("_margin", names(allmarginlist())[i], ".scss")), mustWork = FALSE, winslash = "/"))
    })
file.copy(normalizePath(file.path(system.file("www", package = "wimpress"), "template_style.scss"), winslash = "/", mustWork = FALSE),
          normalizePath(file.path(tempdir(), "template_style.scss"), winslash = "/", mustWork = FALSE))
#Compiling SCSS to CSS
sass::sass(input = sass::sass_import(normalizePath(file.path(tempdir(), "template_style.scss"), winslash = "/", mustWork = FALSE)),
           output = normalizePath(file.path(system.file("www", package = "wimpress"), "style.css")))
#rendered the pdf
callModule(mod_view_renderedpdf, "my_pdf", path = system.file("www", package = "wimpress"),
           style_css = reactive(normalizePath(file.path(system.file("www", package = "wimpress"), "style.css"), winslash = "/", mustWork = FALSE)))
  }, ignoreNULL = FALSE)


  observeEvent(input$test, {

  })


}
