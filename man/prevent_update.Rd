% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/callbacks-advanced.R
\name{prevent_update}
\alias{prevent_update}
\title{Prevent a callback from updating its output}
\usage{
prevent_update(...)
}
\arguments{
\item{...}{Values to check}
}
\description{
When used inside Dash callbacks, if any of the arguments evaluate to \code{TRUE},
then the callback's outputs do not update.
}
\examples{
app <- dash_app()

app \%>\% set_layout(
  button('Click here', id = 'btn'),
  p('The number of times the button was clicked does not update when the number is divisible by 5'),
  div(id = 'body-div')
)
app \%>\% add_callback(
  output(id='body-div', property='children'),
  list(
    input(id='btn', property='n_clicks')
  ),
  function(n_clicks) {
    prevent_update(is.null(n_clicks[[1]]), n_clicks[[1]] \%\% 5 == 0)
    paste(n_clicks[[1]], "clicks")
  }
)

app \%>\% run_app()

}
