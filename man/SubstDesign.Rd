\name{SubstDesign}
\alias{SubstDesign}
\title{
Imbrication of two experimental design sets
}
\description{
Procedure to nest two experimental design sets.
}
\usage{
SubstDesign(PX2 = NULL,PX1 = NULL)
}
\arguments{
  \item{PX2}{
	a matrix representing the first experimental design set. This design set is not changed during the procedure.
}
  \item{PX1}{
	a matrix representing the second experimental design set. This design set is changed in order to include \code{PX2}.
}
}
\value{
	\item{PX}{
	a matrix representing the  experimental design set \code{PX1} which contains \code{PX2}.
	}
	\item{le}{
	a numeric representing the number of points of \code{PX2}.
	}
}
\details{
The  procedure does not change the experimental design set \code{PX2} which must have a number of points 
smaller than the one of \code{PX1}. During the procedure, the points of \code{PX1} the closest to those of \code{PX2} are
removed and they are replaced by the points of \code{PX2}. Thus, the length of the final \code{PX1} could be larger than the one of the initial \code{PX1}.
}
\author{
Loic Le Gratiet
}

\seealso{
\code{\link{MuFicokm}}, \code{\link{NestedDesignBuild}}, \code{\link{NestedDesign}} 
}

\examples{
	dimension <- 2
	nD1 <- 100
	nD2 <- 50		
	set.seed(1);D1 <- matrix(runif(n=nD1*dimension, 0,1),ncol=dimension)
	set.seed(2);D2 <- matrix(runif(n=nD2*dimension, 0,1),ncol=dimension)
	subDes <- SubstDesign(PX2 = D2, PX1 = D1)

	op <- par(mfrow=c(2,1))
	plot(rbind(D1,D2),col=c(rep(1,nD1),rep(2,nD2)),
		pch=c(rep(1,nD1),rep(2,nD2)),xlab="x1",ylab="x2")
	plot(rbind(subDes$PX,D2),col=c(rep(1,dim(subDes$PX)[1]),rep(2,nD2)),
		pch=c(rep(1,dim(subDes$PX)[1]),rep(2,nD2)),xlab="x1",ylab="x2")
}

