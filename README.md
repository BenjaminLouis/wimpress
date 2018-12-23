[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build status](https://travis-ci.org/BenjaminLouis/wimpress.svg?branch=master)](https://travis-ci.org/BenjaminLouis/wimpress)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/BenjaminLouis/wimpress?branch=master&svg=true)](https://ci.appveyor.com/project/BenjaminLouis/wimpress)
[![Coverage status](https://codecov.io/gh/BenjaminLouis/wimpress/branch/master/graph/badge.svg)](https://codecov.io/github/BenjaminLouis/wimpress?branch=master)



# wimpress

The goal of wimpress is to provide a shiny application to help customisation of `PDF` files with [CSS for Paged Media](https://www.w3.org/TR/css-page-3/).

## Workflow

This shiny app strongly relies on the very nice package from [Romain Lesur](https://github.com/RLesur), [weasydoc](https://github.com/RLesur/weasydoc), whose goal  is to convert `R Markdown` to `PDF` using [CSS for Paged Media](https://www.w3.org/TR/css-page-3/) converters. As Romain wrote, _`CSS for Paged Media` [...] allows conversion from HTML to PDF using CSS rules._. If you want to learn more about it, Romain gives some usefull references so I strongly recommand to take a look a his package.

Inputs of this shiny app are CSS properties names and values that can be added and changed by users. These inputs became variables for several `sass` language files. [Sass](https://sass-lang.com/) language is a CSS preprocessor language that allows utilisation of variables, loop, conditional statements... with CSS. These files are converted into one CSS file with the help of the [sass](https://github.com/rstudio/sass) [RStudio](https://www.rstudio.com/) package and used in [weasydoc](https://github.com/RLesur/weasydoc) to render the result in a example `PDF` file.

## Installation

You can install the development version of wimpress with:

``` r
#install.packages("devtools")
devtools::install.github("BenjaminLouis/wimpress")
```

Please, be aware that both [weasydoc](https://github.com/RLesur/weasydoc) and [sass](https://github.com/rstudio/sass) are in development and you have to install them to use wimpress. Note that [weasydoc](https://github.com/RLesur/weasydoc) needs extra steps as you need to install [WeasyPrint](https://weasyprint.org/), a CSS for Pages Media converter. Please, refer to the repository of [weasydoc](https://github.com/RLesur/weasydoc) for more information.

## Usage

You can run the shiny app with :

```{r example}
wimpress::run_app()
```

[CSS for Paged Media](https://www.w3.org/TR/css-page-3/) allows to change properties for all PDF pages or only the first, last, left or right pages. Besides, you can change only margin properties of these pages. The margins are split into 16 boxes that can independently received CSS rules : the four corners and a subdivision in three boxes of the top, left, bottom and right margins. This allows for example the definition of header and footer. The example document used to see the results of CSS rules is an explanation of how [CSS for Paged Media](https://www.w3.org/TR/css-page-3/) works and how to use it in this app.


## Code of conduct

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
  By participating in this project you agree to abide by its terms.
