\name{batch.onepar}
\alias{batch.onepar}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
batch analysis to explore coexistence density for handling multiple model scenarios outputs for a varying parameter, for 2-species model
}
\description{
batch version of sta.comparison() function
}
\usage{
batch.onepar(coexistlist, parameters)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{coexistlist}{
the basic statistics generated from batch.coexistence() function
}
  \item{parameters}{
a parameter sampling point vector,for example parameters=c(.2,.5,.9), indicating three sampling points in a single
parameter. The function will thus compare the coexistence patch numbers under the cases when the parameter (for example,
growth rate for species 1)=0.2,0.5 and 0.9 respectively.
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
\code{\link{sta.coexistence}},
\code{\link{batch.coexistence}},
\code{\link{sta.comparison}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (coexistlist, parameters = parspace) 
{
    scenarionum <- length(coexistlist)
    pairlist <- list()
    length(pairlist) <- scenarionum
    for (i in 1:scenarionum) {
        pairlist[[i]] <- sta.comparison(coexistlist[[i]], parameters = parameters)
    }
    return(pairlist)
  }
}
