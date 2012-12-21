\name{NestedDesign}
\alias{NestedDesign}
\title{
Definition of  nested experimental design sets for Multi-Fidelity Cokriging models
}
\description{
Build an object of class S3 (\code{"NestDesign"})  defining nested experimental design sets used to build multi-fidelity Cokriging models.
}
\usage{
	NestedDesign(x, nlevel , indices = NULL, n = NULL)
}

\arguments{
  \item{x}{a matrix representing the experimental design set of the code level \eqn{1}.}
  \item{nlevel }{an integer representing the number of code levels.}
  \item{indices}{a list of vectors. The \eqn{i}th element of the list contains the indices of the points 
			in the experimental design set of the level \eqn{i-1} constituting the experimental design set of the level i. 
			If \code{indices = NULL} they are randomly sampled according to the number of observations defining in \code{n}.}
  \item{n}{a vector containing the number of observations at level \eqn{k=2,...,nlevel}. It is not taking
		into account if \code{indices} is different from \code{NULL}.}
}
\value{
	an object of class (\code{"NestDesign"}) representing a nested experimental design set.
}
\details{
The  procedure does not change the experimental design set of the highest code level. During the procedure, the points of \eqn{D_{k-1}} the closest to those of \eqn{D_k} with \eqn{k=2,...,nlevel} are
removed and they are replaced by the points of \eqn{D_k} . Thus, the length of the final \eqn{D_{k-1}} could be larger than the one of the initial \eqn{D_{k-1}}. (see \code{"MuFicokm"})
}

\author{
Loic Le Gratiet
}

\references{
LE GRATIET, L. & GARNIER, J. (2012), Recursive co-kriging model for Design of Computer Experiments with multiple levels of fidelity, \emph{arXiv:1210.0686}.
}

\seealso{
\code{\link{MuFicokm}}, \code{\link{ExtractNestDesign}}, \code{\link{NestedDesignBuild}}

}

\examples{
#-- Nested Experimental design sets
	dimension <- 3
	nD1 <- 100
	nD2 <- 50		
	nD3 <- 20
	set.seed(1);D1 <- matrix(runif(n=nD1*dimension, 0,1),ncol=dimension)
	NestDesign <- NestedDesign(D1, nlevel=3 , n = c(nD2,nD3))
}

