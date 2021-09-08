#' TODO document
#' @examples
#' dash_app() %>%
#'   set_layout(
#'     button('Button 1', id='btn1'),
#'     button('Button 2', id='btn2'),
#'     button('Button 3', id='btn3'),
#'     div(id='container')
#'   ) %>%
#'   add_callback(
#'     "container",
#'     list(
#'       input("btn1", "n_clicks"),
#'       input("btn2", "n_clicks"),
#'       input("btn3", "n_clicks")
#'     ),
#'     function(input) {
#'       ctx <- callback_context()
#'       prevent_update(is.null(ctx))
#'       sprintf("Triggered: %s, btn1: %s, btn2: %s, btn3: %s",
#'               ctx$triggered$prop_id, input$btn1, input$btn2, input$btn3)
#'     }
#'   ) %>%
#'   run_app()
#' @export
callback_context <- function() {
  get("app", envir = parent.frame(2))$callback_context()
}

#' Prevent a callback from updating its output
#'
#' When used inside Dash callbacks, if any of the arguments evaluate to `TRUE`,
#' then the callback's outputs do not update.
#'
#' @param ... Values to check
#' @examples
#' app <- dash_app()
#'
#' app %>% set_layout(
#'   button('Click here', id = 'btn'),
#'   p('The number of times the button was clicked does not update when the number is divisible by 5'),
#'   div(id = 'body-div')
#' )
#' app$callback(
#'   output(id='body-div', property='children'),
#'   list(
#'     input(id='btn', property='n_clicks')
#'   ),
#'   function(n_clicks) {
#'     prevent_update(is.null(n_clicks[[1]]), n_clicks[[1]] %% 5 == 0)
#'     paste(n_clicks[[1]], "clicks")
#'   }
#' )
#'
#' app %>% run_app()
#'
#' @export
prevent_update <- function(...) {
  checks <- unlist(list(...))
  if (any(checks)) {
    rlang::eval_bare(rlang::expr(invisible(return(structure(list(NULL), class = "no_update")))) , env = parent.frame())
  } else {
    return()
  }
}
