#' Get a boolean to know which at-rule pages have css property
#'
#' @param x list of property for a at-rule page
#' @param what character. Name of at-rule page (all, first, last, left or right)
#'
#' @noRd
getbool <- function(x, what) {
  if (length(x$prop()) == 0) {
    res <- FALSE
  } else {
    res <- any(x$prop() != "" & x$value() != "")
  }
  paste0("$bool", what,": ", as.character(res), ";\n")
}


#' Get a variable of css property to sass compilation for a at-rule page
#'
#' @param x list of property for a at-rule page
#' @param wh character. Name of at-rule page (all, first, last, left or right)
#'
#' @noRd
getprop <- function(x, wh) {
  if (length(x$prop()) == 0) {
    ll <- ""
  } else {
    ll <- paste0(x$prop()[x$where() == "none"], ": ", x$value()[x$where() == "none"])
    ll <- gsub("(^:.*|.*:\\s$)", "", ll)
    ll <- paste(ll, collapse = ", ")
    ll <- gsub(",,", ",", ll)
    ll <- paste0("(", ll, ")")
    ll <- paste0("$prop", wh, ": ", ll)
    ll <- if (grepl("^.*:\\s\\(?(,?\\s?)*\\)?$", ll)) {
         ""
       } else {
         paste0(ll, ";")
       }
    ll <- gsub(", \\)", "\\)", ll)
    ll <- gsub("\\(,\\s", "\\(", ll)
  }
  return(ll)
}


#' Get css properties for all at-rule margins in a at-rule page
#'
#' @param x list of property for a at-rule page
#'
#' @importFrom sass sass
#'
#' @noRd
getlist <- function(x) {
  if (length(x$prop()) == 0 | length(setdiff(unique(x$where()), "none")) == 0) {
    ll <- ""
  } else {
    ll <- lapply(setdiff(unique(x$where()), "none"), function(y) {
      paste0(x$prop()[x$where() == y], ": ", x$value()[x$where() == y])
    })
    ll <- lapply(ll, function(y) gsub("(^:.*|.*:\\s$)", "", y))
    ll <- lapply(ll, function(y) paste(y, collapse = ", "))
    ll <- lapply(ll, function(y) gsub(",,", ",", y))
    ll <- lapply(ll, function(y) paste0("(", y, ")"))
    ll <- paste0("$prop: ", ll)
    ll <- lapply(ll, function(y) {
      if (grepl("^.*:\\s\\(?(,?\\s?)*\\)?$", y)) {
        ""
      } else {
        paste0(y, ";")
      }
    })
    newnames <- strsplit(setdiff(unique(x$where()), "none"), "-")
    newnames <- lapply(newnames, gsub, pattern = "^t$", replacement = "top")
    newnames <- lapply(newnames, gsub, pattern = "^b$", replacement = "bottom")
    newnames <- lapply(newnames, gsub, pattern = "^l$", replacement = "left")
    newnames <- lapply(newnames, gsub, pattern = "^r$", replacement = "right")
    newnames <- lapply(newnames, gsub, pattern = "^m$", replacement = "middle")
    newnames <- lapply(newnames, gsub, pattern = "^ce$", replacement = "center")
    newnames <- lapply(newnames, gsub, pattern = "^co$", replacement = "corner")
    newnames <- sapply(newnames, paste0, collapse = "-")
    ll <- lapply(1:length(ll), function(i) {
      if (ll[[i]] == "") {
        ll[[i]]
      } else {
        sass(list(ll[[i]], paste0("@", newnames[i], " { @each $var, $val in $prop { #{$var}: $val; } }")))
      }
    })
    if (any(sapply(ll, function(y) y != ""))) {
      ll <- sass(as.list(ll))
    }
  }
  return(ll)
}


