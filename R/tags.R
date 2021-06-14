#' @export
dash_tag <- function(tag_name, content = list(), n_clicks = NULL, n_clicks_timestamp = NULL, key = NULL, loading_state = NULL) {
  content_names <- rlang::names2(content)
  content_named_idx <- nzchar(content_names)
  attributes <- remove_empty(content[content_named_idx])
  children <- unname(content[!content_named_idx])

  tag_params <- attributes
  tag_params[["children"]] <- children
  tag_params[["n_clicks"]] <- n_clicks
  tag_params[["n_clicks_timestamp"]] <- n_clicks_timestamp
  tag_params[["key"]] <- key
  tag_params[["loading_state"]] <- loading_state

  dash_html_fx <- paste0("html", toupper(substring(tag_name, 1, 1)), substring(tag_name, 2))

  do.call(getExportedValue("dashHtmlComponents", dash_html_fx), tag_params)
}

#' @export
html <- lapply(all_tags, function(tag_name) {
  rlang::new_function(
    args = alist(... = , n_clicks = NULL, n_clicks_timestamp = NULL, key = NULL, loading_state = NULL),
    body = rlang::expr({
      dash_tag(!!tag_name, list(...), n_clicks = n_clicks, n_clicks_timestamp = n_clicks_timestamp, key = key, loading_state = loading_state)
    }),
    env = asNamespace("dash2")
  )
})

#' @export
h1 <- html$h1

#' @export
h2 <- html$h2

#' @export
h3 <- html$h3

#' @export
h4 <- html$h4

#' @export
div <- html$div

#' @export
span <- html$span

#' @export
p <- html$p

#' @export
strong <- html$strong

#' @export
br <- html$br

#' @export
button <- html$button
