\name{comblist}
\alias{comblist}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
construct a full list of all combinations of parameters
}
\description{
similar to comblist2() function
}
\usage{
comblist(parvector, parnum)
}
\arguments{
  \item{parvector}{
parvector is a parameter sampling point vector
}
  \item{parnum}{
parnum is the number of parameters
}
}
\value{
return all combinations of parameter sampling point spaces
}
\references{
Chen YH (2012) coexist: an R package for performing species coexistence modeling and analysis under asymmetric dispersal and fluctuating source-sink dynamics.
http://code.google.com/p/coexist.
}
\author{
Youhua Chen <yhchen@zoology.ubc.ca>
}

\seealso{
\code{\link{comblist2}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (parvector, parnum) 
{
    combnum <- length(parvector)^parnum
    mat <- matrix(0, ncol = parnum, nrow = combnum)
    for (i in 1:parnum) {
        leg <- length(parvector)^(parnum - i)
        period = length(parvector)^i
        repeated = length(parvector)^(i - 1)
        fullcircle = leg * length(parvector)
        temp <- vector()
        length(temp) <- fullcircle
        for (k in 1:length(parvector)) {
            temp[((k - 1) * leg + 1):(k * leg)] = parvector[k]
        }
        for (ii in 1:repeated) {
            mat[((ii - 1) * fullcircle + 1):(ii * fullcircle), 
                i] = temp
        }
    }
    return(mat)
  }
}