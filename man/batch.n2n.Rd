\name{batch.n2n}
\alias{batch.n2n}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
batch analysis of niche and neutral/nearly-neutral cases for two or multiple species modeling
}
\description{
output will be used by plot_n2n() function to compare species coexistence status under niche and nearly-neutral parameter cases
}
\usage{
batch.n2n(colist,island)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{colist}{
output data from batch.coexistence() function for 2-species model, or batch.mcoexistence() funciton for multiple-species model
}
\item{island}{
number of patches
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
\code{\link{plot_n2n}}, 
\code{\link{batch.coexistence}},
\code{\link{batch.mcoexistence}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (colist,island) 
{
    resultlist <- list()
    scenarionum = length(colist)
    length(resultlist) <- scenarionum
    for (i in 1:scenarionum) {
        resultlist[[i]] <- sta.fitness(colist[[i]],island)
    }
    return(resultlist)
  }
}