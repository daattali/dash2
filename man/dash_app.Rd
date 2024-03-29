% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dash_app.R
\name{dash_app}
\alias{dash_app}
\title{Create a Dash application}
\usage{
dash_app(title = NULL, ...)
}
\arguments{
\item{title}{\emph{(character)} The browser window title.}

\item{...}{Any additional parameters accepted by \code{\link[dash:Dash]{Dash$new()}}.}
}
\description{
This is a convenience function that returns a \code{\link[dash:Dash]{dash::Dash}} R6 object.
For advanced usage, you can use the object as an R6 object directly instead
of the functions provided by the \code{{dash2}} package.
}
\seealso{
\code{\link[=run_app]{run_app()}}
}
