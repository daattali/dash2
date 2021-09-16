#' Create a Dash application
#'
#' This is a convenience function that returns a [`dash::Dash`] R6 object.
#' For advanced usage, you can use the object as an R6 object directly instead
#' of the functions provided by the `{dash2}` package.
#'
#' @param title _(character)_ The browser window title.
#' @param ... Any additional parameters accepted by [`Dash$new()`][dash::Dash].
#' @seealso [`run_app()`]
#' @export
dash_app <- function(title = NULL, ...) {

  app <- dash::Dash$new(...)

  if (!is.null(title)) {
    app$title(title)
  }

  class(app) <- c("dash2", class(app))

  invisible(app)
}

#' Add `<meta>` tags to a Dash app
#'
#' @param app A dash application created with [`dash_app()`].
#' @param meta A single meta tag or a list of meta tags. Each meta tag is a
#' named list with two elements representing a meta tag. See examples below.
#' @examples
#' app <- dash_app()
#'
#' # Add a single meta tag
#' app %>% add_meta(list(name = "description", content = "My App"))
#'
#' # Add multiple meta tags
#' app %>% add_meta(list(
#'   list(name = "keywords", content = "dash, analysis, graphs"),
#'   list(name = "viewport", content = "width=device-width, initial-scale=1.0")
#' ))
#' @export
add_meta <- function(app, meta) {
  assert_dash(app)
  if (!is.list(meta[[1]])) {
    meta <- list(meta)
  }
  app$.__enclos_env__$private$meta_tags <- c(app$.__enclos_env__$private$meta_tags, meta)
  invisible(app)
}

#' Add external (CSS) stylesheets to a Dash app
#'
#' @param app A dash application created with [`dash_app()`].
#' @param stylesheet A single stylesheet or a list of stylesheets. Each
#' stylesheet is either a string (the URL), or a named list with `href` (the
#' URL) and any other valid `<link>` tag attributes. See examples below.
#' Note that this is only used to add **external** stylesheets, not local.
#' @examples
#' app <- dash_app()
#'
#' # Add a single stylesheet with URL
#' app %>% add_stylesheet("https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css")
#'
#' # Add multiple stylesheets with URL
#' app %>% add_stylesheet(list(
#'   "https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css",
#'   "https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"
#' ))
#'
#' # Add a single stylesheet with a list
#' app %>% add_stylesheet(
#'   list(
#'     href = "https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css",
#'     integrity = "sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
#'   )
#' )
#'
#' # Add multiple stylesheets with both URL and list
#' app %>% add_stylesheet(
#'   list(
#'     "https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css",
#'     "https://fonts.googleapis.com/css?family=Lora",
#'     list(
#'       href = "https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css",
#'       integrity = "sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
#'     )
#'   )
#' )
#' @export
add_stylesheet <- function(app, stylesheet) {
  assert_dash(app)
  if (!is.list(stylesheet) || !is.null(names(stylesheet))) {
    stylesheet <- list(stylesheet)
  }
  app$.__enclos_env__$self$config$external_stylesheets <- c(app$.__enclos_env__$self$config$external_stylesheets, stylesheet)
  invisible(app)
}

#' Add external (JavaScript) scripts to a Dash app
#'
#' @param app A dash application created with [`dash_app()`]
#' @param script A single script or a list of scripts. Each script is either
#' a string (the URL), or a named list with `src` (the URL) and any other valid
#' `<script>` tag attributes. See examples below.
#' Note that this is only used to add **external** scripts, not local.
#' @examples
#' app <- dash_app()
#'
#' # Add a single script with URL
#' app %>% add_script("https://stackpath.bootstrapcdn.com/bootstrap/4.4.0/js/bootstrap.min.js")
#'
#' # Add multiple scripts with URL
#' app %>% add_script(list(
#'   "https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js",
#'   "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
#' ))
#'
#' # Add a single script with a list
#' app %>% add_script(
#'   list(
#'     src = "https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js",
#'     integrity = "sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
#'   )
#' )
#'
#' # Add multiple scripts with both URL and list
#' app %>% add_script(
#'   list(
#'     "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js",
#'     "https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js",
#'     list(
#'       src = "https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js",
#'       integrity = "sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
#'     )
#'   )
#' )
#' @export
add_script <- function(app, script) {
  assert_dash(app)
  if (!is.list(script) || !is.null(names(script))) {
    script <- list(script)
  }
  app$.__enclos_env__$self$config$external_scripts <- c(app$.__enclos_env__$self$config$external_scripts, script)
  invisible(app)
}

#' Set the layout of a Dash app
#' @param app A dash application created with [`dash_app()`]
#' @param ... Dash components to create the user interface, provided either as
#' comma-separated components or a list of components. You can also provide a
#' function returning a Dash component if you want the layout to re-render on
#' every page load.
#'
#' @examples
#' app <- dash_app()
#'
#' app %>% set_layout("hello", "Dash")
#' app %>% set_layout(div("hello"), "Dash")
#' app %>% set_layout(list(div("hello"), "Dash"))
#' app %>% set_layout("Conditional UI using an if statement: ",
#'                    if (TRUE) "rendered",
#'                    if (FALSE) "not rendered")
#' app %>% set_layout(function() { div("Current time: ", Sys.time()) })
#' @export
set_layout <- function(app, ...) {
  assert_dash(app)

  tags <- list(...)
  if (length(tags) > 0 && !is.null(names(tags))) {
    stop("dash2: layout cannot have any named parameters")
  }
  if (length(tags) == 1) {
    if (is.function(tags[[1]])) {
      layout <- tags[[1]]
    } else {
      layout <- componentify(tags[[1]])
    }
  } else {
    layout <- componentify(tags)
  }

  app$layout(layout)
  invisible(app)
}

#' Run a Dash app
#' @param app A dash application created with [`dash_app()`]
#' @param host Hostname to run the app.
#' @param port Port number to run the app.
#' @param browser Whether or not to launch a browser to the app's URL.
#' @export
run_app <- function(app,
                    host = Sys.getenv("DASH_HOST", Sys.getenv("HOST", "127.0.0.1")),
                    port = Sys.getenv("DASH_PORT", Sys.getenv("PORT", 8050)),
                    browser = interactive()) {
  assert_dash(app)
  if (browser) {
    url <- paste0(host, ":", port)
    if (!grepl("^(http|https)://", host)) {
      url <- paste0("http://", url)
    }
    utils::browseURL(url)
  }
  app$run_server(host = host, port = port)
}

#' Run a Dash app when explicitly printed to the console
#' @export
#' @keywords internal
print.dash2 <- function(x, ...) {
  run_app(x)
}

#' Is the given object a Dash app?
#' @param x Any object.
#' @export
is_dash_app <- function(x) {
  inherits(x, "Dash")
}
