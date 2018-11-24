getbool <- function(x, what) {
  if (is.null(x)) {
    FALSE
  } else {
    any(x$where() == what)
  }
}


getprop <- function(x, wh) {
  ll <- lapply(unique(x$where()), function(y) paste0(x$prop()[x$where() == y], ": ", x$value()[x$where() == y]))
  ll <- lapply(ll, function(y) gsub("(^:.*|.*:\\s$)", "", y))
  ll <- lapply(ll, function(y) paste(y, collapse = ", "))
  ll <- lapply(ll, function(y) gsub(",,", ",", y))
  ll <- lapply(ll, function(y) paste0("(", y, ")"))
  ll <- paste0("$", wh, tolower(unique(x$where())), ": ", ll)
  ll <- lapply(ll, function(y) {
    if (grepl("^.*:\\s\\(?(,?\\s?)*\\)?$", y)) {
      NULL
    } else {
      paste0(y, ";")
    }
  })
  ll <- lapply(ll, function(y) gsub(", \\)", "\\)", y))
  ll <- lapply(ll, function(y) gsub("\\(,\\s", "\\(", y))
  ll <- paste(unlist(ll), collapse = "\n")
  return(ll)
}


getlist <- function(x, marginname) {
  ll <- lapply(unique(x$where()), function(y) paste0(x$prop()[x$where() == y], ": ", x$value()[x$where() == y]))
  ll <- lapply(ll, function(y) gsub("(^:.*|.*:\\s$)", "", y))
  ll <- lapply(ll, function(y) paste(y, collapse = ", "))
  ll <- lapply(ll, function(y) gsub(",,", ",", y))
  ll <- lapply(ll, function(y) paste0("(", y, ")"))
  ll <- paste0("$prop: ", ll)
  ll <- lapply(ll, function(y) {
    if (grepl("^.*:\\s\\(?(,?\\s?)*\\)?$", y)) {
      NULL
    } else {
      paste0(y, ";")
    }
  })
  names(ll) <- tolower(unique(x$where()))
  ll <- lapply(ll, function(y) {
    if (is.null(y)) {
      y
    } else {
      style <- sass::sass(list(y, paste0("@", marginname, " { @each $var, $val in $prop { #{$var}: $val; } }")))
    }
  })
  return(ll)
}


