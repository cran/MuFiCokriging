\name{kmCok}
\alias{kmCok}
\title{
Construction of kriging models included in Multi-Fidelity cokriging models
}
\description{
An internal function used to build kriging models included in the multi-fidelity cokriging models.
}
\usage{
kmCok(	formula = ~1, design, response, formula.rho = ~1, Z = NULL, 
		covtype = "matern5_2", coef.trend = NULL, coef.cov = NULL, 
		coef.var = NULL, nugget = NULL, nugget.estim = FALSE, 
		noise.var = NULL, estim.method="MLE", penalty = NULL, 
		optim.method = "BFGS", lower = NULL, upper = NULL, parinit = NULL, 
		control = NULL, gr = TRUE, iso = FALSE, scaling = FALSE, knots = NULL)
}
\arguments{
  \item{formula.rho }{
an object of class (\code{"formula"}) specifying the linear trends of the adjustment coefficients. This formula should concern only the input variables, and not the output (response). If there is any,  it is automatically dropped. The default is \code{~1}, which defines a constant trend.
}
  \item{Z}{
a vector (or 1-column matrix or data frame) containing the values of the 1-dimensional output given by the function of level k at the design points of level k-1.
}
  \item{formula}{
see \code{\link{km}}
}
  \item{design}{ see \code{\link{km}}}
  \item{response}{ see \code{\link{km}}}
  \item{covtype}{ see \code{\link{km}}}
  \item{coef.trend}{see \code{\link{km}} }
  \item{coef.cov}{see \code{\link{km}} }
  \item{coef.var}{see \code{\link{km}} }
  \item{estim.method}{see \code{\link{km}} }
  \item{nugget}{see \code{\link{km}} }
  \item{nugget.estim}{see \code{\link{km}} }
  \item{noise.var}{see \code{\link{km}} }
  \item{penalty}{ see \code{\link{km}}}
  \item{optim.method}{ see \code{\link{km}}}
  \item{lower}{see \code{\link{km}} }
  \item{upper}{ see \code{\link{km}}}
  \item{parinit}{see \code{\link{km}} }
  \item{control}{see \code{\link{km}} }
  \item{gr}{see \code{\link{km}} }
  \item{iso}{ see \code{\link{km}}}
  \item{scaling}{ see \code{\link{km}}}
  \item{knots}{see \code{\link{km}} }
}
\value{
An object with S4 class \code{"kmCok"} (see \code{kmCok-class}).
}
\references{
KRIGE, D.G. (1951), A statistical approach to some basic mine valuation problems on the witwatersrand, \emph{J. of the Chem., Metal. and Mining Soc. of South Africa}, 52 no. 6, 119-139.

MATHERON, G.  (1969), Le krigeage universel, \emph{Les Cahiers du Centre de Morphologie Mathematique de Fontainebleau}, 1.

RASMUSSEN, C.E.  and WILLIAMS, C.K.I.  (2006), Gaussian Processes for Machine Learning, \emph{the MIT Press}, \url{http://www.GaussianProcess.org/gpml}

SANTNER, T.J., WILLIAMS, B.J. and NOTZ, W.I. (2003), The Design and Analysis of Computer Experiments, \emph{New York: Springer}.

STEIN, L.M. (1999), Interpolation of Spatial Data, \emph{Springer Series in Statistics}.

LE GRATIET, L. & GARNIER, J. (2012), Recursive co-kriging model for Design of Computer Experiments with multiple levels of fidelity, \emph{arXiv:1210.0686}

LE GRATIET, L. (2012), Bayesian analysis of hierarchical multi-fidelity codes, \emph{arXiv:1112.5389}
}
\author{
Olivier Roustant, David Ginsbourger, Ecole des Mines de St-Etienne.

Loic Le Gratiet, Universite Paris VII Denis-Diderot
}

\seealso{
\code{\link{predict,kmCok-method}}
}

