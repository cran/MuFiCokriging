\name{summary.MuFicokm}
\alias{summary.MuFicokm}

\title{
Function summary for Multi-Fidelity Cokriging models
}
\description{
Provide a summary of a multi-fidelity cokriging model. In particular, it provides the parameter estimations and the results of the 
cross-validation procedure.
}
\usage{
\method{summary}{MuFicokm}(object, CrossValidation = FALSE, ...)
}

\arguments{
  \item{object}{
an object of class S3 (\code{"MuFicokm"}) provided by the function \code{MuFicokm} corresponding to the multi-fidelity cokriging model.
}
  \item{CrossValidation}{
a Boolean. If \code{TRUE}, a Leave-One-Out cross validation procedure is performed. For the LOO procedure, the responses are removed  from all code levels and the trend, adjustment and variance parameters are re-estimated after each removed observation.
}
\item{\dots}{
no other argument for this method.
}
}


\value{
A list with following  items (see \code{"MuFicokm"}):
\item{CovNames }{a list of character strings giving the covariance structures used for the cokriging model. The element \eqn{i} of the list corresponds to the covariance structure of the Gaussian process \eqn{\delta_i(x)}  with \eqn{\delta_1(x) = Z_1(x)}. (see \code{"MuFicokm"})}
\item{Cov.val }{a list of vectors giving the values of the hyper-parameters of the cokriging model. The element \eqn{i} of the list corresponds to the hyper-parameters of the Gaussian process \eqn{\delta_i(x)}  with \eqn{\delta_1(x) = Z_1(x)}. (see \code{"MuFicokm"})}
\item{Var.val }{a list of numerics giving the values of the variance parameters of the cokriging model. The element \eqn{i} of the list corresponds to the variance of the  Gaussian process \eqn{\delta_i(x)}  with \eqn{\delta_1(x) = Z_1(x)}. (see \code{"MuFicokm"})}
\item{Rho.val }{a list of vectors giving the values of the trends \eqn{\gamma_i} of the  adjustment parameters \eqn{\rho_i} of the cokriging model. The element \eqn{i} of the list corresponds to the adjustment parameter between \eqn{Z_i} and \eqn{\delta_i(x)}. (see \code{"MuFicokm"})}
\item{Trend.val }{a list of vectors giving the values of the trend parameters of the Gaussian processes \eqn{\delta_i(x)} and \eqn{Z_1(x)}. }
}
\details{
\code{"summary.MuFicokm"} return the parameter estimations for each level  and the result of the Leave-One-Out Cross-Validation 
	(\code{RMSE=Root Mean Squared Error} ; \code{Std RMSE=Standardized RMSE };
	\code{ Q2=explained variance}).
}

\author{
Loic Le Gratiet
}

\examples{
#--- test functions (see [Le GRATIET, L. 2012])
	Funcf <- function(x){return(0.5*(6*x-2)^2*sin(12*x-4)+sin(10*cos(5*x)))}
	Funcc <- function(x){return((6*x-2)^2*sin(12*x-4)+10*(x-0.5)-5)}
#--- Data
	Dc <- seq(0,1,0.1)
	indDf <- c(1,3,7,11)
	DNest <- NestedDesign(Dc, nlevel=2 , indices = list(indDf) )
	zc <- Funcc(DNest$PX)
	Df <- ExtractNestDesign(DNest,2)
	zf <- Funcf(Df)
#--- Multi-fidelity cokriging creation without parameter estimations
		mymodel <- MuFicokm(
				formula = list(~1,~1), 
				MuFidesign = DNest, 
				response = list(zc,zf), 
				nlevel = 2)

		sum <- summary(object = mymodel, CrossValidation = TRUE)
		names(sum)
#--- Saving parameters
	#--covariance parameters
		sum$Cov.Val
	#--variance parameters
		sum$Var.Val
	#--trend parameters
		sum$Trend.Val
	#-- adjustment parameters
		sum$Rho.Val
}

