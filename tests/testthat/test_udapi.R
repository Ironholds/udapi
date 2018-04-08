context("Test udapi's internal functions")

test_that("specific content can be retrieved", {
  result <- get_term("friendly fade")
  expect_that(ncol(result), equals(10))
})

test_that("random content can be retrieved", {
  result <- random_term()
  expect_that(ncol(result), equals(10))
  expect_that(nrow(result), equals(10))
})