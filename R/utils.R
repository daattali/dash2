assert_dash <- function(x) {
  if (!is_dash_app(x)) {
      stop("You must provide a Dash app object (created with `dash::Dash$new()` or `dash2::dash_app()`)", call. = FALSE)
  }
  invisible(TRUE)
}

componentify <- function(x) {
  if (asNamespace("dash")$is.component(x)) {
    x
  } else if (inherits(x, "shiny.tag") || inherits(x, "shiny.tag.list")) {
    stop("dash2: layout cannot include Shiny tags (you might have loaded the {shiny} package after loading {dash2})", call. = FALSE)
  } else if (is.list(x)) {
    dashHtmlComponents::htmlDiv(children = lapply(x, componentify))
  } else if (length(x) == 1) {
    dashHtmlComponents::htmlSpan(children = x)
  } else {
    stop("dash2: layout must be a dash component or list of dash components", call. = FALSE)
  }
}

remove_empty <- function(x) {
  Filter(Negate(is.null), x)
}
