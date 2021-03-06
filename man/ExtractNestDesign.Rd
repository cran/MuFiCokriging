\name{ExtractNestDesign}
\alias{ExtractNestDesign}
\title{
Extraction of  the experimental design set of a level from an object of class (\code{"NestedDesign"})
}
\description{
Extract the experimental design set of level number i from an object of class 
  (\code{"NestedDesign"}) representing a nested experimental design set.
}
\usage{
ExtractNestDesign(NestDes,level)
}
\arguments{
  \item{NestDes}{an object of class (\code{"NestedDesign"}). }
  \item{level}{an integer indicating the level from which we want to extract the experimental
		design set.}
}
\value{
	a matrix corresponding to the extracted experimental design set.
}
\author{
Loic Le Gratiet
}

\seealso{
\code{\link{MuFicokm}}, \code{\link{NestedDesign}}
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

