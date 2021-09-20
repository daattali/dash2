#' Add a callback to a Dash app
#'
#' @param app A dash application created with [`dash_app()`].
#' TODO document
#' TODO make sure clientside callbacks work https://dashr.plotly.com/clientside-callbacks
#' TODO consider making property=value and property=children the default for input/output (looking through many example apps, it's very common)
#' TODO consider allowing user to pass in a string instead of a input/output object
#' @export
add_callback <- function(app, outputs, params, callback) {
  if (inherits(params, "dash_dependency")) {
    params <- list(params)
  }

  params_flat <- flatten(params)

  # determine if the callback arguments match the first level of parameters
  cb_args <- methods::formalArgs(callback)
  if (length(cb_args) != length(params)) {
    stop("add_callback: Number of params does not match the number of arguments in the callback function", call. = FALSE)
  }
  if (!is.null(names(params))) {
    if (!setequal(cb_args, names(params))) {
      stop("add_callback: Arguments in callback do not match the names of the params",
           call. = FALSE)
    }
  }

  cb <- function(...) {
    callback_params <- eval(substitute(alist(...)))

    # the callback moves states to the end after inputs, so we need to fix the positions
    state_idx <- which(unlist(lapply(params_flat, function(x) inherits(x, "state"))))
    num_states <- length(state_idx)
    if (num_states > 0) {
      num_inputs <- length(callback_params) - num_states
      for (i in seq_len(num_states)) {
        idx <- num_inputs + i
        callback_params <- append(callback_params, callback_params[[idx]], state_idx[i] - 1)
        callback_params <- callback_params[-(idx + 1)]
      }
    }

    callback_params <- params_to_keys(callback_params, params)
    do.call(callback, callback_params)
  }

  app$callback(
    output = outputs,
    params = params_flat,
    func = cb
  )
  invisible(app)
}

# test <- list(
#   ab = list(
#     input("a", "value"),
#     state("b", "value")
#   ),
#   cdef = list(
#     cde = list(
#       input("c", "value"),
#       state("d", "value"),
#       input("e", "value")
#     ),
#     f = input("f", "value")
#   ),
#   g = input("g", "value")
# )
# str(flatten(test))
flatten <- function(x) {
  if (!inherits(x, "list")) return(list(x))

  key_names <- rlang::names2(x)
  key_names_exist <- nzchar(key_names)
  if (all(key_names_exist)) {
    if (any(duplicated(key_names))) {
      stop("Named params must have unique names", call. = FALSE)
    }
    x <- unname(x)
  } else if (any(key_names_exist)) {
    stop("Cannot mix named and unnamed params", call. = FALSE)
  }

  unlist(lapply(x, flatten), recursive = FALSE)
}

# test <- list(
#   ab = list(
#     input("a", "value"),
#     state("b", "value")
#   ),
#   cdef = list(
#     cde = list(
#       input("c", "value"),
#       state("d", "value"),
#       input("e", "value")
#     ),
#     f = input("f", "value")
#   ),
#   g = input("g", "value")
# )
# str(params_to_keys(as.list(LETTERS[1:7]), test))
params_to_keys <- function(params, keys) {
  params_to_key_helper <- function(keys) {
    for (item_idx in seq_along(keys)) {
      if (inherits(keys[[item_idx]], "dash_dependency")) {
        keys[[item_idx]] <- params[[1]]
        params <<- params[-1]
      } else {
        keys[[item_idx]] <- params_to_key_helper(keys[[item_idx]])
      }
    }
    keys
  }
  params_to_key_helper(keys)
}
