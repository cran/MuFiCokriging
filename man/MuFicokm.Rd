\name{MuFicokm}
\alias{MuFicokm}
\title{
Creation of  Multi-Fidelity Cokriging models
}
\description{
Create multi-fidelity cokriging models when parameters are unknown  or known.
If parameters are unknown, they are estimated by Maximum Likelihood. \code{"MuFicokm"} is based on the function \code{"km"} of the package \code{"DiceKriging"} and its usage is similar.
}
\usage{
MuFicokm(	formula, MuFidesign, response, nlevel, formula.rho = ~1, 
		covtype = "matern5_2", coef.trend = NULL, coef.rho = NULL,
		coef.cov = NULL, coef.var = NULL, nugget = NULL, nugget.estim = FALSE, 
		noise.var = NULL, estim.method = "MLE", penalty = NULL, optim.method = "BFGS", 
		lower = NULL, upper = NULL, parinit = NULL, control = NULL, 
		gr = TRUE, iso = FALSE, scaling = FALSE, knots = NULL)
}
\arguments{
  \item{formula}{
a list of objects of class \code{"formula"} specifying the linear trends of the Gaussian processes \eqn{\delta_k(x)} with 
\eqn{k = 1,...,nlevel}. We use the convention \eqn{Z_1(x) = \delta_1(x)}. 
The length of the list has to be equal to the number of levels.
This formula should concern only the input variables, and not the output (response).
}
  \item{MuFidesign}{
an object of class \code{"MuFiDesign"} (see \code{\link{NestedDesign}})  representing the nested experimental design sets  for the different code levels. 
}
  \item{response}{
a list of vectors (or 1-column matrix or data frame) containing the values of the 1-dimensional outputs given by the different code levels.
The length of the list has to be equal to the number of levels.
}
  \item{nlevel}{
the number of levels for the responses.
}
  \item{formula.rho}{
a list of objects of class \code{"formula"} specifying the linear trends of the adjustment coefficients (i.e. it corresponds to \eqn{g_{k-1}^T(x) }, see details). 
The default is \code{~1}, which defines a constant trend.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{covtype}{
an optional list of character strings specifying the covariance structure to be used for the Gaussian processes \eqn{\delta_k(x)} with 
\eqn{k = 1,...,nlevel}(we use the convention \eqn{Z_1(x) = \delta_1(x)}), to be chosen between \code{"gauss"}, \code{"matern5_2"}, \code{"matern3_2"}, \code{"exp"} or \code{"powexp"}. 
See a full description of available covariance kernels in \code{covTensorProduct-class} in package \code{DiceKriging}. Default is \code{"matern5_2"}.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{coef.trend}{an optional list of vectors containing the values for the trend of the Gaussian processes \eqn{\delta_k(x)} with 
\eqn{k = 1,...,nlevel}. We use the convention \eqn{Z_1(x) = \delta_1(x)} .
(see below and details)
}
  \item{coef.rho}{an optional list of vectors containing the values of \eqn{\gamma_{k-1}} for  the adjustment coefficients \eqn{\rho_{k-1}} with \eqn{k = 2,...,nlevel}.
(see below and details)
}
  \item{coef.cov}{an optional list of vectors containing the values for the covariance parameters of the Gaussian processes \eqn{\delta_k(x)} with 
\eqn{k = 1,...,nlevel}. We use the convention \eqn{Z_1(x) = \delta_1(x)} .
(see below and details)
}
  \item{coef.var}{
an optional list of vectors containing the values for the variance parameters of the Gaussian processes \eqn{\delta_k(x)} with 
\eqn{k = 1,...,nlevel}. We use the convention \eqn{Z_1(x) = \delta_1(x)} (see details).
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
For estimation, there are 4 cases: 
1. (All unknown) If all are missing, all are estimated.
2. (All known) If all are provided, no estimation is performed.
3. (Known trend) If \code{coef.trend} and \code{coef.rho} is provided but at least one of \code{coef.cov} or \code{coef.var} is missing, then BOTH \code{coef.cov} and \code{coef.var} are estimated.
4. (Unknown trend) If \code{coef.cov} and \code{coef.var} are provided but \code{coef.trend} and \code{coef.rho}  are missing, then \code{coef.trend} and \code{coef.rho} are estimated.
}
  \item{nugget}{
an optional list of  variance values standing for the homogeneous nugget effect for the Gaussian processes modelling the biases.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{nugget.estim}{
an optional list of  booleans indicating whether the nugget effect should be estimated. Note that this option does not concern the case of heterogeneous noisy observations (see noise.var below). If nugget is given, it is used as an initial value. Default is \code{FALSE}.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{noise.var}{
for noisy observations : an optional list of vectors containing the noise variance at each observation for each level.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{estim.method}{
a list of character strings specifying the method by which unknown parameters are estimated. Default is "MLE" (Maximum Likelihood). 
At this stage, a beta version of leave-One-Out estimation (estim.method="LOO") is also implemented for noise-free observations.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{penalty}{
(beta version) an optional list of  lists suitable for Penalized Maximum Likelihood Estimation. 
The list must contain the item fun indicating the penalty function, and the item value equal to the value of the penalty parameter. 
At this stage the only available fun is \code{"SCAD"}, and covtype must be \code{"gauss"}. 
Default is \code{NULL}, corresponding to (un-penalized) Maximum Likelihood Estimation.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{optim.method}{
an optional list of character strings indicating which optimization method is chosen for the likelihood maximization for each level.
 \code{"BFGS"} is the optim quasi-Newton procedure of package stats, with the method \code{"L-BFGS-B"}. 
\code{"gen"} is the genoud genetic algorithm (using derivatives) from package rgenoud (>= 5.3.3).
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{lower}{
(see below)
}
  \item{upper}{
optional list of vectors containing the bounds of the correlation parameters for optimization for each level. 
The default values are given by \code{covParametersBounds}.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{parinit}{
a list of n optional vectors containing the initial values for the variables to be optimized over for each level. 
If no vector is given, an initial point is generated as follows. 
For method \code{"gen"}, the initial point is generated uniformly inside the hyper-rectangle domain defined by \code{lower} and \code{upper}. 
For method \code{"BFGS"}, some points (see control below) are generated uniformly in the domain. 
Then the best point with respect to the likelihood (or penalized likelihood, see \code{penalty}) criterion is chosen.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{control}{
an optional list of lists of control parameters for optimization for each level. 
To avoid printing information in the command line during optimization progress, indicate \code{trace=FALSE}. 
For method \code{"BFGS"}, \code{pop.size} is the number of candidate initial points generated before optimization starts (see \code{parinit} above). 
Default is 20. For method \code{"gen"}, one can control \code{pop.size} (default : min(20, 4+3*log(nb of variables) ), \code{max.generations} (5), \code{wait.generations} (2) and \code{BFGSburnin} (0) of function \code{genoud} (see \code{"genoud"}). Another tunable paramater is \code{upper.alpha} (1-1e-8) for nugget estimation (see \code{"km1Nugget"}). Numbers into brackets are the default values.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{gr}{
an optional list of booleans indicating whether the analytical gradient should be used. Default is \code{TRUE}.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{iso}{
an optional list  of booleans that can be used to force a tensor-product covariance structure (see \code{covTensorProduct-class}) to have a range parameter common to all dimensions. Default is \code{FALSE}. Not used (at this stage) for the power-exponential type.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{scaling}{
an optional list of booleans indicating whether a scaling on the covariance structure should be used.
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
  \item{knots}{
an optional list of lists of knots for scaling. The j-th element is a vector containing the knots for dimension j. If \code{scaling=TRUE} and \code{knots} are not specified, than \code{knots} are fixed to 0 and 1 in each dimension (which corresponds to affine scaling for the domain [0,1]^d).
The length of the list must be either the number of levels or one. If the length is one, the same argument is repeated for all levels.
}
}
\value{
An object of class S3 MuFicokm.
\item{cok }{a list containing objects of class S4 (\code{"km"}) and (\code{"kmCok"}).}
\item{ZD }{a list containing the responses of the conditionned Gaussian processes of level \eqn{k=2,...,nlevel} at the experimental design set of level \eqn{k-1}.}
\item{response  }{a list of vectors containing the known responses at each code level.}
\item{nlevel  }{a numeric representing the number of code levels.}
\item{Dnest  }{an object of class (\code{"NestDesign"}) representing the nested experimental design sets. }
\item{nuggets  }{a list of numeric representing the nugget effects used to regularize the covariance matrices at each level.}
}
\details{
The assumed model is the one presented in the paper [LE GRATIET, L. (2012)]. 
Let us denote by \eqn{Z_k(x)} the Gaussian process modelling the code  level \eqn{k}.
We consider the following autoregressive model:
\deqn{
Z_k(x) = \rho_{k-1}Z_{k-1}(x) + \delta_k(x)
}
where \eqn{\rho_{k-1}} is the adjustment coefficient between levels \eqn{k} and \eqn{k-1} and \eqn{\delta_k(x)} models
the bias between the level \eqn{k} and the level \eqn{k-1} adjusted.
When \eqn{\rho_{k-1}} depends on \eqn{x}, it has the following form:
\deqn{
\rho_{k-1}(x) = g_{k-1}^T(x) \gamma_{k-1}
}
where the regressors \eqn{g_{k-1}(x)} are defined thanks to the parameter \code{formula.rho}.
Furthermore, the experimental design sets \eqn{D_k} for each level \eqn{k=2,...,nlevel} must be nested.
\deqn{
D_k \subset D_{k-1}
}
}
\references{
KENNEDY, M.C. & O'HAGAN, A. (2000), Predicting the output from a complex computer code when fast approximations are available. \emph{Biometrika} 87, 1-13.

FORRESTER, A.I.J, SOBESTER A. & KEAN, A.J. (2007), Multi-Fidelity optimization via surrogate modelling. \emph{Proc. R. Soc. A} 463, 3251-3269.

LE GRATIET, L. & GARNIER, J. (2012), Recursive co-kriging model for Design of Computer Experiments with multiple levels of fidelity, \emph{arXiv:1210.0686}.

LE GRATIET, L. (2012), Bayesian analysis of hierarchical multi-fidelity codes, \emph{arXiv:1112.5389}.
}
\author{
Loic Le Gratiet, Universite Paris VII Denis-Diderot - CEA, DAM, DIF
}


\seealso{
\code{\link{predict.MuFicokm}}, \code{\link{summary.MuFicokm}}, \code{\link{NestedDesign}}, \code{\link{CrossValidationMuFicokmAll}}
}
\examples{

#-------------------------------------------------------------------
#- 3 Dimensional test with 3 levels of response
#-------------------------------------------------------------------
#--- test functions
	myfunc1 <- function(x){sin(2*pi*x[,1])*0.2*(x[,2]+2)^2+cos(4*pi*x[,3])^2}
	myfunc2 <- function(x){2*myfunc1(x)+x[,3]}
	myfunc3 <- function(x){3*myfunc2(x)+x[,2]+x[,1]}
#--- Data
	#-- Nested Experimental design sets
		nD1 <- 100
		nD2 <- 50		
		nD3 <- 20
		set.seed(1);D1 <- matrix(runif(n=nD1*3, 0,1),ncol=3)
		set.seed(2);D2 <- matrix(runif(n=nD2*3, 0,1),ncol=3)
		set.seed(3);D3 <- matrix(runif(n=nD3*3, 0,1),ncol=3)
		NestDesign  <- NestedDesignBuild(design = list(D1,D2,D3))
	#-- observations
		z1 <- myfunc1(NestDesign$PX)
		z2 <- myfunc2(ExtractNestDesign(NestDesign,2))
		z3 <- myfunc3(ExtractNestDesign(NestDesign,3))
#--- Multi-fidelity cokriging creation
		mymodel <- MuFicokm(
			formula = list(~1,~1+X2,~1+X3), 
			MuFidesign = NestDesign, 
			response = list(z1,z2,z3), 
			nlevel = 3)
#--- Multi-fidelity cokriging prediction
		newdata <- matrix(runif(333,0,1),ncol=3)
		predictions <- predict(mymodel, newdata, "UK")
		z.pred <- predictions$mean
#--- Multi-fidelity cokriging cross Validation
		set.seed(1);indice <- sample(1:nD3)[1:10]
	#-- Observations removing from the highest level
		resCV.cok <- CrossValidationMuFicokm(mymodel,indice)
	#-- Observations removing from all levels
		resCV.cok.all <- CrossValidationMuFicokmAll(mymodel,indice)
#--- Multi-fidelity cokriging summary
		sum <- summary(mymodel)

#-------------------------------------------------------------------
#- 1 Dimensional test with 2 levels of response
#-------------------------------------------------------------------

#--- test functions
	Funcf <- function(x){return((6*x-2)^2*sin(12*x-4))}
	Funcc <- function(x){return(0.5*Funcf(x)+10*(x-0.5)-5)}
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
				nlevel = 2,
				covtype = list("gauss","matern5_2"),
				coef.trend=list(-5,3),
				coef.rho=list(2),
				coef.var=list(2,2),
				coef.cov=list(0.1,0.2))
		predictions <- predict(
				object = mymodel, 
				newdata = seq(0,1,le=100),
				type = "SK")
#--- Multi-fidelity cokriging creation with parameter estimations
		mymodel <- MuFicokm(
				formula = list(~1,~1+X1), 
				MuFidesign = DNest, 
				response = list(zc,zf), 
				nlevel = 2,
				covtype = "matern5_2")
		predictions <- predict(
				object = mymodel, 
				newdata = seq(0,1,le=100),
				type="UK")
}


