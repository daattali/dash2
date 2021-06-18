#' Document that className and htmlFor is used instead of class and for
#' Document that style is given as a list rather than a string
#' @export
dash_tag <- function(tag_name, content = list(), n_clicks = NULL) {
  content_names <- rlang::names2(content)
  content_named_idx <- nzchar(content_names)
  attributes <- remove_empty(content[content_named_idx])
  children <- unname(content[!content_named_idx])

  # Support empty attributes
  attributes[is.na(attributes)] <- names(attributes[is.na(attributes)])
  attributes[attributes == ""] <- names(attributes[attributes == ""])

  tag_params <- attributes
  tag_params[["children"]] <- children
  tag_params[["n_clicks"]] <- n_clicks

  dash_html_fx <- paste0("html", toupper(substring(tag_name, 1, 1)), substring(tag_name, 2))
  if (tag_name %in% c("map", "object")) {
    dash_html_fx <- paste0(dash_html_fx, "El")
  }

  do.call(getExportedValue("dashHtmlComponents", dash_html_fx), tag_params)
}

#' @export
html <- lapply(all_tags, function(tag_name) {
  rlang::new_function(
    args = alist(... = , n_clicks = NULL),
    body = rlang::expr({
      dash_tag(!!tag_name, list(...), n_clicks = n_clicks)
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
