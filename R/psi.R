#' Quantify psi between two variables.
#'
#' \code{psi} calculates the statistic \eqn{\psi} between two data points.
#'
#' @param a Vector of angles in radians.
#' @return Vector of \eqn{\psi} values between -1 and 1.
psi <- function(a){
  asin(sin(2*a))/ asin(1)
}
