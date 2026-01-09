context("psiotropy function")

n <- 100
# for vectors
x <- rnorm(n)
y <- rnorm(n)
# # For matrices
xmat <- matrix(x, nrow=10)
ymat <- matrix(y, nrow=10)

test_that('psiotropy returns either data frame, or list', {
  expect_is(psiotropy(3, 4), "data.frame")
  expect_is(psiotropy(x, y), "data.frame")
  expect_is(psiotropy(xmat, ymat), "list")
})

test_that("psiotropy fails if inputs are different sizes", {
  expect_error(psiotropy(x, y[1:10]), "Vector x has 100 elements but y has 10")
  expect_error(psiotropy(xmat, head(ymat)), "has dimensions")
})
