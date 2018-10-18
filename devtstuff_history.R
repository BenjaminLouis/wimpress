# the goal of this file is to keep track of all devtools/usethis
# call you make for yout project

# Feel free to cherry pick what you need and add elements

# install.packages("desc")
# install.packages("devtools")
# install.packages("usethis")

# Hide this file from build
usethis::use_build_ignore("devstuff_history.R")

# DESCRIPTION

library(desc)
# Create and clean desc
my_desc <- description$new("DESCRIPTION")
# Set your package name
my_desc$set("Package", "wimpress")

#Set your name
my_desc$set("Authors@R", "person('Benjamin', 'Louis', email = 'contact@benjaminlouis-stat.fr', role = c('aut', 'cre'))")

# Remove some author fields
my_desc$del("Maintainer")

# Set the version
my_desc$set_version("0.0.0.9000")

# The title of your package
my_desc$set(Title = "Shiny module to prepare PDF template with CSS for Paged Media")
# The description of your package
my_desc$set(Description = "Inputs of this shiny module are variables for a Sass CSS preprocessor file used as CSS paged media to print PDF.")

# The urls
my_desc$set("URL", "https://github.com/BenjaminLouis/wimpress")
my_desc$set("BugReports", "https://github.com/BenjaminLouis/wimpress/issues")
# Save everyting
my_desc$write(file = "DESCRIPTION")

# If you want to use the MIT licence, code of conduct, lifecycle badge, and README
usethis::use_mit_license(name = "Benjamin Louis")
usethis::use_readme_rmd()
usethis::use_code_of_conduct()
usethis::use_lifecycle_badge("Experimental")
usethis::use_news_md()

# For data
#usethis::use_data_raw()

# For tests
#usethis::use_testthat()
#usethis::use_test("app")

# Dependencies
usethis::use_package("shiny")

# Reorder your DESC
usethis::use_tidy_description()

# Vignette
#usethis::use_vignette("wimpress")
#devtools::build_vignettes()

# Versionning
usethis::use_git()
usethis::use_github()

# Codecov
usethis::use_travis()
usethis::use_appveyor()
usethis::use_coverage()

# Test with rhub
#rhub::check_for_cran()




