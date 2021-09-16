test_that("add_meta", {

  get_meta <- function(app) {
    app$.__enclos_env__$private$meta_tags
  }

  meta1 <- list(name = "keywords", content = "foo, analysis, graphs")
  meta2 <- list(name = "viewport", content = "width=device-width, initial-scale=1.0")

  expect_error(add_meta(meta1))
  expect_identical(
    dash_app() %>% add_meta(meta1) %>% get_meta(),
    Dash$new(meta_tags = list(meta1)) %>% get_meta()
  )
  expect_identical(
    dash_app() %>% add_meta(meta1) %>% get_meta(),
    dash_app() %>% add_meta(list(meta1)) %>% get_meta()
  )
  expect_identical(
    dash_app() %>% add_meta(list(meta1, meta2)) %>% get_meta(),
    Dash$new(meta_tags = list(meta1, meta2)) %>% get_meta()
  )
  expect_identical(
    dash_app() %>% add_meta(meta1) %>% add_meta(meta2) %>% get_meta(),
    dash_app() %>% add_meta(list(meta1, meta2)) %>% get_meta()
  )
})

test_that("add_stylesheet", {

  get_sheets <- function(app) {
    app$.__enclos_env__$self$config$external_stylesheets
  }

  sheet_simple1 <- "https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
  sheet_simple2 <- "https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"
  sheet_full <- list(
    href = "https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css",
    integrity = "sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
  )


})

test_that("add_script", {
})
