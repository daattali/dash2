test_that("remove_empty", {
  expect_error(remove_empty())
  expect_null(remove_empty(NULL))
  expect_identical(remove_empty(c(NULL, "A", "B")), c("A", "B"))
  expect_identical(remove_empty(c(NULL, NULL)), c())
  expect_identical(remove_empty(list(NULL, "A", "B")), list("A", "B"))
  expect_identical(remove_empty(list(NULL, "A", NULL, "B")), list("A", "B"))
  expect_identical(remove_empty(list(NULL, NULL)), list())
})

test_that("assert_dash", {
  expect_error(assert_dash())
  expect_error(assert_dash(NULL))
  expect_error(assert_dash("string"))
  expect_true(assert_dash(Dash$new()))
  expect_true(assert_dash(dash_app()))
  expect_true(assert_dash(set_layout(dash_app(), "test")))
})
