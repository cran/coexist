\name{make.parcomb}
\alias{make.parcomb}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
make the parameter combination index matrix
}
\description{
make the parameter combination index matrix, this matrix is the index matrix that can be used in the read.data()
function or batch.read() functions to 
}
\usage{
make.parcomb(prange, parnum, path = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{prange}{
sampling points' vector for the parameter space interval[0~1], for example c(0.1,.3,.6,.9)
}
  \item{parnum}{
number of parameters in the model
}
  \item{path}{
local filen/path to save the parameter combination matrix
}
}
\references{
Chen YH (2012) coexist: an R package for performing species coexistence modeling and analysis under asymmetric dispersal and fluctuating source-sink dynamics.
http://code.google.com/p/coexist.
}
\author{
Youhua Chen <yhchen@zoology.ubc.ca>
}

\seealso{
\code{\link{read.data}}, 
\code{\link{batch.read}},
\code{\link{read.patchdata}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (prange, parnum, path = NULL) 
{
    if (!is.list(prange)) {
        parcomb <- comblist(prange, parnum)
    }
    if (is.list(prange)) {
        parcomb <- comblist2(prange)
    }
    if (length(path) != 0) {
        path = filename.check(path)
        write.table(parcomb, path, sep = "\t")
    }
    return(parcomb)
  }
}
