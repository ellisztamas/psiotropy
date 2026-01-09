#' Quantify pleiotropic effects on two variables.
#'
#' \code{psiotropy} calculates vector length, angle \eqn{\psi} for vectors
#' \emph{x} and \emph{y}.
#'
#' Calculate basic summary statistics about a pair of vectors.
#' This can also be used to calculate bootstrap values for each parameter by
#' providing matrices rather than vectors of input values.
#'
#' @param x,y Values along the \emph{x}- and \emph{y}-axes. This will usually be
#' single floats or vectors of floats of observed values. Alternatively, supply
#' matrices of floats to calculate psi for a sample of bootstrapped *x* and *y*
#' values, or values drawn from a posterior distribution in a Bayesian analysis.
#' In this case, matrices should have a row for every observation, and a column
#' for every bootstrap/posterior draw.
#'
#' @return Data frame including input data, vector norm angle, and \eqn{\psi}.
#' If matrices were supplied, this returns a list of these data.
#'
#' @export
psiotropy <- function(x, y, calculate_zstar=FALSE, zstar_ref=NULL){
  if(is.vector(x) & is.vector(y)){
    if(length(x) != length(y)) stop(paste("Vector x has", length(x),"elements but y has", length(y)))
  } else {
    if(is.matrix(x) & is.matrix(y)){
      if(any(dim(x) != dim(y))){
        stop(paste("Matrix x has dimensions {", nrow(x),",", ncol(x),"} but y has dimensions {", nrow(y),",", ncol(y),"}.", sep=""))
      }
    if( calculate_zstar ){
      warning("calculate_zstar is not currently implemented for matrices. Run the function for rows or columns individually.")
    }
    }
  }

  rad <- angle360(x,y) # calculate angles in radians
  output <- list(
    x       = x, # return input data
    y       = y,
    norm    = vector_norm(x,y), # vector length
    radians = rad,   # the angle of the norm in radians
    degrees = (rad * 180) / (pi), # express angles in degrees.
    psi     = psi(rad)
  )

  # If the input data were vectors, collapse output into a data.frame.
  if(is.vector(x) & is.vector(y)){
    output <- do.call('cbind', output)
    output <- as.data.frame(output)
    if( calculate_zstar ){
      if( is.null(zstar_ref) ) {
        zstar_ref <- c( mean(output$x), mean(output$y) )
      }
      output$zstar <- z_star(samples = output, ref = zstar_ref)
    }
  }
  return(output)
}

# test_that("Using matrices return matrices")
# n <- 1000
# xmat <- t(sapply(0:10, function(i) rnorm(n, mean=i)))
# ymat <- t(sapply(0:10, function(i) rnorm(n, mean=i)))
#
# psio <- psiotropy(xmat, ymat)
#
# psio$zstar <- sapply(1:nrow(psio$x), function(i){
#   z_star( samples  = data.frame(x = psio$x[i,], y = psio$y[i,] ))
# })
#
# dim(psio$zstar)
# dim(psio$x)
# colMeans(zs) - sqrt(2*(0:10)^2)
#
