\name{predict.MuFicokm}
\alias{predict.MuFicokm}

\title{
Predictions and confidence intervals of Multi-Kriging Cokriging models at new data
}
\description{
Provide predictive mean, variance and covariance  of a multi-fidelity cokriging model. 
95 \% confidence intervals are given based on Gaussian process assumption. 
This might be abusive in particular in the case where the number of observations is small.
}
\usage{
\method{predict}{MuFicokm}(	object, newdata,  type,  
		se.compute = TRUE, cov.compute = FALSE, checkNames = FALSE, ...)
}

\arguments{
  \item{object}{
an object of class S3 (\code{"MuFicokm"})  provided by the function \code{"MuFicokm"} corresponding to the multi-fidelity cokriging model.
}
  \item{newdata}{
a vector, matrix or data frame containing the points where to perform predictions.
}
  \item{type}{
a  list of character strings corresponding to the kriging family of the Gaussian processes \eqn{\delta_k(x)} with \eqn{k=1,...,nlevel} (we use the convention \eqn{\delta_1(x) = Z_1(x)}), to be chosen between simple kriging (\code{"SK"}), or universal kriging (\code{"UK"}). (see \code{"MuFicokm"})
}

  \item{se.compute}{
a list of optional booleans for each level. If \code{FALSE}, only the kriging mean is computed. If \code{TRUE}, the kriging variance  and confidence intervals are computed too.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{cov.compute}{
a list of optional booleans for each level. If \code{TRUE}, the conditional covariance matrix is computed.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{checkNames}{
a list of optional booleans for each level. If \code{TRUE}, a consistency test is performed between the names of newdata and the names of the experimental design (contained in \code{object@X}). The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}  
\item{\dots}{
no other argument for this method.
}
}

\value{
\item{mean	}{multi-fidelity co-kriging predictive mean computed at \code{newdata}.}
\item{sig2	}{multi-fidelity co-kriging predictive  variance computed at \code{newdata}.}
\item{C	}{multi-fidelity co-kriging predictive  conditional covariance matrix. Not computed if \code{cov.compute=FALSE} (default).}
\item{mux	}{multi-fidelity co-kriging predictive  means at each level.}
\item{varx	}{multi-fidelity co-kriging predictive variances at each level.}
\item{CovMat	}{multi-fidelity co-kriging predictive conditional covariance matrices at each level.}
}

\references{
KENNEDY, M.C. & O'HAGAN, A. (2000), Predicting the output from a complex computer code when fast approximations are available. \emph{Biometrika} 87, 1-13

FORRESTER, A.I.J, SOBESTER A. & KEAN, A.J. (2007), Multi-Fidelity optimization via surrogate modelling. \emph{Proc. R. Soc. A} 463, 3251-3269.

LE GRATIET, L. & GARNIER, J. (2012), Recursive co-kriging model for Design of Computer Experiments with multiple levels of fidelity, \emph{arXiv:1210.0686}

LE GRATIET, L. (2012), Bayesian analysis of hierarchical multi-fidelity codes, \emph{arXiv:1112.5389}}
\author{
Loic Le Gratiet
}

\seealso{
\code{\link{MuFicokm}}, \code{\link{summary.MuFicokm}}
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
#--- "SK" : Simple CoKriging, i.e. when parameters are known
#--- "UK" : Universal CoKriging, i.e. when parameters are estimated
	#-- model creation
		mymodelSK <- MuFicokm(
				formula = list(~1,~1), 
				MuFidesign = DNest, 
				response = list(zc,zf), 
				nlevel = 2,
				coef.trend=list(0,2),
				coef.rho=list(0.5),
				coef.var=list(2,2),
				coef.cov=list(0.1,0.2))
	#-- predictions with "SK"
		predictionsSK <- predict(
				object = mymodelSK, 
				newdata = seq(0,1,le=100),
				type = "SK")

#--- Multi-fidelity co-kriging building with parameter estimations
	#-- model creation
		mymodelUK <- MuFicokm(
				formula = list(~1,~1), 
				MuFidesign = DNest, 
				response = list(zc,zf), 
				nlevel = 2)
	#-- predictions with "UK" 
		predictionsUK <- predict(
				object = mymodelUK, 
				newdata = seq(0,1,le=100),
				type = "UK")

#--- Multi-fidelity co-kriging building with known and unknown parameters
	#-- model creation
		mymodelSK_UK <- MuFicokm(
				formula = list(~1,~1),
				MuFidesign = DNest,
				response = list(zc,zf),
				nlevel = 2,
				coef.trend=list(-5,NULL),
				coef.rho=list(NULL),
				coef.var=list(2,NULL),
				coef.cov=list(0.1,NULL))
	#-- predictions with "UK" 
		predictionsSK_UK <- predict(
				object = mymodelSK_UK, 
				newdata = seq(0,1,le=100),
				type = list("SK","UK"))

#--- plot
	op <- par(mfrow=c(3,1))
		x <- seq(0,1,le=100)
		curve(Funcf,ylim=c(-5,10),main="SK")
		polygon(c(x,rev(x)), c(predictionsSK$mean+2*sqrt(predictionsSK$sig2), 
						rev(predictionsSK$mean-2*sqrt(predictionsSK$sig2))),
		col="gray", border = "red",density=20 )
		lines(seq(0,1,le=100), predictionsSK$mean,col=2,lty=2,lwd=2)

		curve(Funcf,ylim=c(-5,10),main="UK")
		polygon(c(x,rev(x)), c(predictionsUK$mean+2*sqrt(predictionsUK$sig2), 
						rev(predictionsUK$mean-2*sqrt(predictionsUK$sig2))),
		col="gray", border = "red",density=20 )
		lines(seq(0,1,le=100), predictionsUK$mean,col=2,lty=2,lwd=2)

		curve(Funcf,ylim=c(-5,10),main="mix SK & UK")
		polygon(c(x,rev(x)), c(predictionsSK_UK$mean+2*sqrt(predictionsSK_UK$sig2), 
						rev(predictionsSK_UK$mean-2*sqrt(predictionsSK_UK$sig2))),
		col="gray", border = "red",density=20 )
		lines(seq(0,1,le=100), predictionsSK_UK$mean,col=2,lty=2,lwd=2)
	par(op)
}


