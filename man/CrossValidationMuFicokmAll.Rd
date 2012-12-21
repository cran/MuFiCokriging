\name{CrossValidationMuFicokmAll}
\alias{CrossValidationMuFicokmAll}

\title{
Cross Validation Procedure for Multi-Fidelity Cokriging models when  the observations are removed from all code levels.
}
\description{
Provide the predictive errors and variances of the cross validation procedure when observations are removed from all code levels.
}
\usage{
CrossValidationMuFicokmAll(model, indice)
}
\arguments{
  \item{model}{
an object of class S3 (\code{"MuFicokm"})  provided by the function \code{"MuFicokm"} corresponding to the multi-fidelity cokriging model.}
  \item{indice}{
a vector containing the indices of the observations removed from the highest code level for the cross-validation procedure.
}
}
\value{
  \item{CVerr	}{a list of vectors indexed by q containing the predictive errors of the cross-validation procedure when the  observations are removed from the q highest code levels.}
  \item{CVvar	}{a list of vectors indexed by q containing the predictive variances of the cross-validation procedure when  the  observations are removed from the q highest code levels.}
  \item{CVCov	}{a list indexed by q  of the predictive covariance matrices of the cross-validation procedure when  the  observations are removed  from the q highest code levels.}
  \item{CVerrall	}{a vector containing the predictive errors of the cross-validation procedure when  the  observations are removed  from all code levels.}
  \item{CVvarall	}{a vector containing the predictive variances of the cross-validation procedure when the  observations are removed  from all code levels.}
  \item{CVCovall	}{the predictive covariance matrix of the cross-validation procedure when  the  observations are removed  from all code levels.}
}
\references{

LE GRATIET, L. & GARNIER, J. (2012), Recursive co-kriging model for Design of Computer Experiments with multiple levels of fidelity, \emph{arXiv:1210.0686}

}
\author{
Loic Le Gratiet
}

\seealso{
\code{\link{MuFicokm}}, \code{\link{CrossValidationMuFicokm}}
}
\details{
This function performs all the possible cross-validation procedures. Indeed, due to the nested property of the experimental design sets, we can choose to remove observations only from the highest code level or the two highest code levels   and so on. 
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

#--- Model creation with parameter estimations
		mymodel <- MuFicokm(
				formula = list(~1,~1+X1), 
				MuFidesign = DNest, 
				response = list(zc,zf), 
				nlevel = 2,
				covtype = "matern5_2")
#--- Cross Validation
		indice <- c(1,3)
		CVAll <- CrossValidationMuFicokmAll(mymodel,indice)
	#-- predictive errors when we remove the observations from Funcf and Funcc
		CVAll$CVerrall
	#-- predictive variances when we remove the observations from Funcf and Funcc
		CVAll$CVvarall
	#-- predictive covariance matrix when we remove the observations from Funcf and Funcc
		CVAll$CVCovall
	#-- predictive errors when we remove the observations from Funcf
		CVAll$CVerr[[1]]
	#-- predictive variances when we remove the observations from Funcf
		CVAll$CVvar[[1]]
	#-- predictive covariance matrix when we remove the observations from Funcf
		CVAll$CVCov[[1]]

#--- Leave-One-Out Cross Validation
	#-- LOO CV predictive errors
		apply(matrix(1:DNest$n),1,function(x) CrossValidationMuFicokmAll(mymodel,x)$CVerrall)
}



