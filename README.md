[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build status](https://travis-ci.org/BenjaminLouis/wimpress.svg?branch=master)](https://travis-ci.org/BenjaminLouis/wimpress)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/BenjaminLouis/wimpress?branch=master&svg=true)](https://ci.appveyor.com/project/BenjaminLouis/wimpress)
[![Coverage status](https://codecov.io/gh/BenjaminLouis/wimpress/branch/master/graph/badge.svg)](https://codecov.io/github/BenjaminLouis/wimpress?branch=master)



# wimpress

The goal of wimpress is to provide a shiny application to help customisation of paged files with [CSS for Paged Media](https://www.w3.org/TR/css-page-3/). Using [CSS for Paged Media](https://www.w3.org/TR/css-page-3/) allows to format HTML file into pages that can be customised through CSS rules making easier to print the document.

## Workflow

This shiny app strongly relies on the very nice package from [Romain Lesur](https://github.com/RLesur), [weasydoc](https://github.com/RLesur/weasydoc), whose goal  is to convert `R Markdown` to `PDF` using [CSS for Paged Media](https://www.w3.org/TR/css-page-3/) converters. As Romain wrote, _`CSS for Paged Media` [...] allows conversion from HTML to PDF using CSS rules._. If you want to learn more about it, Romain gives some usefull references so I strongly recommand to take a look a his package.

Inputs of this shiny app are CSS properties names and values that can be added and changed by users. These inputs became variables for several `sass` language files. [Sass](https://sass-lang.com/) language is a CSS preprocessor language that allows utilisation of variables, loop, conditional statements... with CSS. These files are converted into one CSS file with the help of the [sass](https://github.com/rstudio/sass) [RStudio](https://www.rstudio.com/) package and used in [weasydoc](https://github.com/RLesur/weasydoc) to render the result in a example `PDF` file.

## A brief introduction to CSS for Paged Media

### The @page rule

CSS properties into a `@page` rule are applied to all pages of the document. It is possible to change certain type of pages with pseudo-classes such as `:first`, `:last`, `:left`, `:right` which logically applied CSS properties to the first, last, left and right pages.

### The margin boxes

Inside a page rule, you can change only margin properties with specific margin rules. The margins are split into 16 boxes that can independently received CSS rules : the four corners and a subdivision in three boxes for each of the top, left, bottom and right margins. This allows for example the definition of header and footer. For each of these boxes, there is a rule to wrap CSS properties :

+ corners : `@top-left-corner`, `@top-right-corner`, `@bottom-left-corner`, `@bottom-right-corner`

+ top margin : `@top-left`, `@top-center`, `@top-right`

+ bottom margin : `@bottom-left`, `@bottom-center`, `@bottom-right`

+ left margin : `@left-top`, `@left-middle`, `@left-bottom`

+ right margin : `@right-top`, `@right-middle`, `@right-bottom`

## Installation

You can install the development version of wimpress with:

``` r
#install.packages("devtools")
devtools::install.github("BenjaminLouis/wimpress")
```

Please, be aware that both [weasydoc](https://github.com/RLesur/weasydoc) is in development and you have to install it to use wimpress. Note that [weasydoc](https://github.com/RLesur/weasydoc) needs extra steps as you need to install [WeasyPrint](https://weasyprint.org/), a CSS for Pages Media converter. Please, refer to the repository of [weasydoc](https://github.com/RLesur/weasydoc) for more information.

## Usage

You can run the shiny app with :

```{r example}
wimpress::run_app()
```

On the left panel, there are 5 boxes for the `@page` rule and its combination with the pseudo-classes. In each one, you can add CSS properties by clicking one the `add properties` button. For each property, you need to choose the box where the property is applied (main page or margin boxes), the CSS property and its value. You can remove the property with the red button. The blue button with a question mark is here to help you know wich value you can give for the chosen property (in progress, does not work yet). 

On the right panel, there is the PDF document customised with the CSS rules. To see the effect of the latest chosen properties, you have to click on the refresh button. There is a view code button to see the code you can copy and paste in your custom CSS file.

You will find a more complete (and illustrated) explanation of how to use the shiny app in the dedicated vignette.

```{r vignette}
vignette("using_wimpress", package = "wimpress")
```

## Code of conduct

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
  By participating in this project you agree to abide by its terms.
