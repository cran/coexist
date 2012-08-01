\name{spabundance}
\alias{spabundance}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
initialization of species' abundance across the patches/islands
}
\description{
initialization of species' abundance across the patches/islands prior to dispersal/competition interactions
}
\usage{
spabundance(island, abund = 1000)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{island}{
number of patches
}
  \item{abund}{
initial abundance of species at the source patch (leftmost)
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
\code{\link{flexsim}},
\code{\link{sim.coarse}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (island, abund = 1000) 
{
    sabund <- vector()
    length(sabund) <- island
    sabund[1] = abund
    sabund[2:island] = 0
    return(sabund)
  }
}
