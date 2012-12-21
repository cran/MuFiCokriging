\name{CrossValidationMuFicokm}
\alias{CrossValidationMuFicokm}
\title{
Cross Validation Procedure for Multi-Fidelity Cokriging models when  the observations are removed from the code with the highest level of fidelity
}
\description{
Provide the predictive errors and variances of a cross validation procedure when observations (not necessarily one) are removed only from the code with the highest level of fidelity.
}
\usage{
CrossValidationMuFicokm(model, indice)
}
\arguments{
  \item{model}{
an object of class S3 (\code{"MuFicokm"})  provided by the function \code{"MuFicokm"} corresponding to the multi-fidelity cokriging model.}
  \item{indice}{
a vector containing the indices of the observations removed from  the highest code level for   the cross-validation procedure.
}
}
\value{
  \item{CVerr	}{a vector containing the predictive errors of the cross-validation procedure.}
  \item{CVvar	}{a vector containing the predictive variances of the cross-validation procedure.}
  \item{CVCov	}{a matrix representing the predictive covariance matrix of the cross-validation procedure.}
}
\references{
DUBRULE, O. (1983), Cross Validation in a Unique Neightborhood. \emph{Mathematical Geology} 15. Mo.6

ZHANG, H. and WANG, Y. (2009), Kriging and cross-validation for massive spatial data. \emph{Environmetrics} 21, 290-304.

LE GRATIET, L. & GARNIER, J. (2012), Recursive co-kriging model for Design of Computer Experiments with multiple levels of fidelity, \emph{arXiv:1210.0686}
}
\author{
Loic Le Gratiet
}

\seealso{
\code{\link{MuFicokm}}, \code{\link{CrossValidationMuFicokmAll}}
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
	zf <- Funcf(ExtractNestDesign(DNest,2))

#--- Model creation
		mymodel <- MuFicokm(
				formula = list(~1,~1+X1), 
				MuFidesign = DNest, 
				response = list(zc,zf), 
				nlevel = 2,
				covtype = "matern5_2")
#--- Cross Validation on points number  1 and 3
		indice <- c(1,3)
		CrossValidationMuFicokm(mymodel,indice)
#--- Leave-One-Out Cross Validation
	#-- LOO CV predictive errors
		apply(matrix(1:DNest$n),1,function(x) CrossValidationMuFicokm(mymodel,x)$CVerr)
	#-- LOO CV predictive variances
		apply(matrix(1:DNest$n),1,function(x) CrossValidationMuFicokm(mymodel,x)$CVvar)
}


