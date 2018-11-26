getbool <- function(x, what) {
  if (length(x$prop()) == 0) {
    res <- FALSE
  } else {
    res <- any(x$prop() != "" & x$value() != "")
  }
  paste0("$bool", what,": ", as.character(res), ";\n")
}


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
        sass::sass(list(ll[[i]], paste0("@", newnames[i], " { @each $var, $val in $prop { #{$var}: $val; } }")))
      }
    })
    if (any(sapply(ll, function(y) y != ""))) {
      ll <- sass::sass(as.list(ll))
    }
  }
  return(ll)
}


