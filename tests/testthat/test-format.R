context("Test formatting")

test_that("formatting", {
  love <- readRDS("love.rds")
  expect_output_file(print(love), "output/love.txt", update = TRUE)
})
