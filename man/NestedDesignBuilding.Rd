\name{NestedDesignBuild}
\alias{NestedDesignBuild}
\title{
Nested experimental design sets building
}
\description{
Procedure to build nested experimental design sets from a list of non-nested experimental design sets.
}
\usage{
	NestedDesignBuild(design = NULL)
}
\arguments{
  \item{design}{
	a list of matrices representing the experimental design sets of each level.
}

}
\value{
  an object of class (\code{"NestDesign"}) representing the nested experimental design sets.
}

\author{
Loic Le Gratiet
}

\seealso{
\code{\link{MuFicokm}}, \code{\link{NestedDesign}}, \code{\link{SubstDesign}}, \code{\link{CrossValidationMuFicokmAll}}
}

\examples{
#-- Nested Experimental design sets
	dimension <- 3
	nD1 <- 100
	nD2 <- 50		
	nD3 <- 20
	set.seed(1);D1 <- matrix(runif(n=nD1*dimension, 0,1),ncol=dimension)
	set.seed(2);D2 <- matrix(runif(n=nD2*dimension, 0,1),ncol=dimension)
	set.seed(3);D3 <- matrix(runif(n=nD3*dimension, 0,1),ncol=dimension)
	NestDesign  <- NestedDesignBuild(design = list(D1,D2,D3))
#-- Design set at level 1
	NestDesign$PX
#-- Extraction of design sets at level 2 and 3
	ExtractNestDesign(NestDesign,2)
	ExtractNestDesign(NestDesign,3)
}