\name{kmCok-class}
\Rdversion{1.1}
\docType{class}
\alias{kmCok-class}

\title{Class \code{"kmCok"}}
\description{
	S4 class for cokriging models derived from \code{km-class}.
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("kmCok", ...)}.
}
\section{Slots}{
  \describe{
    \item{\code{AR.p}:}{object of class \code{"integer"}. The number of regressors for the adjustment coefficient \eqn{\rho_{k-1}} with \eqn{k=2,...,nlevel}. (see \code{"MuFicokm"})}
    \item{\code{AR.formula}:}{object of class \code{"formula"}. A formula specifying the trend as a linear model  for the adjustment coefficient \eqn{\rho_{k-1}} with \eqn{k=2,...,nlevel}. (see \code{"MuFicokm"})}
    \item{\code{AR.Z}:}{object of class \code{"numeric"}. The vector of response values of level \eqn{k-1} at design points of level \eqn{k}. (see \code{"MuFicokm"})}
    \item{\code{AR.F}:}{object of class \code{"matrix"}. The experimental matrix corresponding to the evaluation of the linear trend basis functions of \eqn{\rho_{k-1}} at the design of experiments. (see \code{"MuFicokm"})}
    \item{\code{d}:}{object of class \code{"integer"} see Class \code{"\linkS4class{km}"} } for the other arguments
    \item{\code{n}:}{object of class \code{"integer"}}
    \item{\code{X}:}{object of class \code{"matrix"} }
    \item{\code{y}:}{object of class \code{"matrix"} }
    \item{\code{p}:}{object of class \code{"integer"}}
    \item{\code{F}:}{object of class \code{"matrix"} }
    \item{\code{trend.formula}:}{object of class \code{"formula"} }
    \item{\code{trend.coef}:}{object of class \code{"numeric"} }
    \item{\code{covariance}:}{object of class \code{"covKernel"} }
    \item{\code{noise.flag}:}{object of class \code{"logical"} }
    \item{\code{noise.var}:}{object of class \code{"numeric"} }
    \item{\code{known.param}:}{object of class \code{"character"}} 
    \item{\code{case}:}{object of class \code{"character"} }
    \item{\code{param.estim}:}{object of class \code{"logical"} }
    \item{\code{method}:}{object of class \code{"character"} }
    \item{\code{penalty}:}{object of class \code{"list"} }
    \item{\code{optim.method}:}{object of class \code{"character"} }
    \item{\code{lower}:}{object of class \code{"numeric"} }
    \item{\code{upper}:}{object of class \code{"numeric"} }
    \item{\code{control}:}{object of class \code{"list"} }
    \item{\code{gr}:}{object of class \code{"logical"} }
    \item{\code{call}:}{object of class \code{"language"} }
    \item{\code{parinit}:}{object of class \code{"numeric"} }
    \item{\code{logLik}:}{object of class \code{"numeric"}} 
    \item{\code{T}:}{object of class \code{"matrix"} }
    \item{\code{z}:}{object of class \code{"numeric"} }
    \item{\code{M}:}{object of class \code{"matrix"} }
  }
}

\section{Methods}{
  \describe{
    \item{predict}{\code{signature(object = "kmCok")}: see \code{\link{predict,kmCok-method}} }
	 }
}
\author{
Loic Le Gratiet
}

\seealso{
\code{\linkS4class{km}}, \code{\link{MuFicokm}}
}


