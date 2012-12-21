\name{predict.kmCok}
\alias{predict}
\alias{predict,kmCok-method}
\title{
Kriging predictions and confidence intervals used in Multi-Fidelity Cokriging models
}
\description{
An internal function wich provides predicted values and conditional variances based on a \code{kmCok} model. 95\% confidence intervals are given  based on Gaussian process assumption. 
This might be abusive in particular in the case where the number of observations is small.
}
\usage{
	\S4method{predict}{kmCok}(	object, newdata, newZ, type, 
		se.compute = TRUE, cov.compute = FALSE, checkNames = FALSE, ...)
}
\arguments{
  \item{newZ}{
a vector giving the predictions of the level \eqn{k=1,...,(nlevel-1)} at points \code{newdata}.
}
  \item{object}{
see \code{\link{km}}
}
  \item{newdata}{see \code{\link{km}}}
  \item{type}{see \code{\link{km}}}
  \item{se.compute}{see \code{\link{km}}}
  \item{cov.compute}{see \code{\link{km}}}
  \item{checkNames}{see \code{\link{km}}}
  \item{\dots}{see \code{\link{km}}
}
}
\details{
see \code{\link{km}}}
\value{
see \code{\link{km}}
}
\section{Warning}{
see \code{\link{km}}
}
\author{
Olivier Roustant, David Ginsbourger, Ecole des Mines de St-Etienne.

Loic Le Gratiet, Universite Paris VII Denis-Diderot 
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


\seealso{
\code{\link{kmCok}}, \code{\link{predict.MuFicokm}}
}

