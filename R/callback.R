`$.dash_input` <- function(x, i) {
  if (is.null(.subset2(x, i))) {
    new_i <- sprintf("%s.value", i)
    if (!is.null(.subset2(x, new_i))) {
      i <- new_i
    }
  }
  NextMethod()
}

`[[.dash_input` <- function(x, i) {
  if (is.null(.subset2(x, i))) {
    new_i <- sprintf("%s.value", i)
    if (!is.null(.subset2(x, new_i))) {
      i <- new_i
    }
  }
  NextMethod()
}

`[.dash_input` <- function(x, i) {
  for (j in seq_along(i)) {
    if (is.null(.subset2(x, i[j]))) {
      new_i <- sprintf("%s.value", i[j])
      if (!is.null(.subset2(x, new_i))) {
        i[j] <- new_i
      }
    }
  }
  val <- NextMethod()
  structure(val, class = "dash_input")
}

#' TODO document
#' @export
add_callback <- function(app, outputs, inputs, states, callback) {
  if (is.function(states)) {
    warning("add_callback: It looks like the callback was passed into the `states` argument.", call. = FALSE)
    callback <- states
    states <- NULL
  }
  if (inherits(outputs, "dash_dependency")) {
    # do nothing
  } else {
    if (length(outputs) == 1) {
      outputs <- dash::output(outputs, "children")
    } else {
      outputs <- lapply(outputs, function(val) {
        if (is.character(val)) {
          dash::output(val, "children")
        } else {
          val
        }
      })
    }
  }

  if (inherits(inputs, "dash_dependency")) {
    inputs <- list(inputs)
  } else {
    inputs <- lapply(inputs, function(val) {
      if (is.character(val)) {
        dash::input(val, "value")
      } else {
        val
      }
    })
  }
  if (inherits(states, "dash_dependency")) {
    states <- list(states)
  } else {
    states <- lapply(states, function(val) {
      if (is.character(val)) {
        dash::state(val, "value")
      } else {
        val
      }
    })
  }

  cb <- function(...) {
    params <- eval(substitute(alist(...)))
    input_names <- unlist(lapply(inputs, function(val) {
      if (is.null(val[["name"]])) {
        sprintf("%s.%s", val[["id"]], val[["property"]])
      } else {
        val[["name"]]
      }
    }))
    state_names <- unlist(lapply(states, function(val) {
      if (is.null(val[["name"]])) {
        sprintf("%s.%s", val[["id"]], val[["property"]])
      } else {
        val[["name"]]
      }
    }))
    param_names <- c(input_names, state_names)
    input <- structure(
      stats::setNames(params, param_names),
      class = "dash_input"
    )

    callback(input)
  }

  app$callback(
    output = outputs,
    params = c(inputs, states),
    func = cb
  )
  invisible(app)
}

#' TODO document
#' @export
input <- function(id, property = "value", name = NULL) {
  val <- dash::input(id = id, property = property)
  if (!is.null(name)) {
    if (isTRUE(name)) {
      val[["name"]] <- id
    } else {
      val[["name"]] <- name
    }
  }
  val
}

#' TODO document
#' @export
state <- function(id, property = "value", name = NULL) {
  val <- dash::state(id = id, property = property)
  if (!is.null(name)) {
    if (isTRUE(name)) {
      val[["name"]] <- id
    } else {
      val[["name"]] <- name
    }
  }
  val
}
