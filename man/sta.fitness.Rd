\name{sta.fitness}
\alias{sta.fitness}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
fitness/abundance comparison for neutral versus niche cases for 2-species modeling
}
\description{
using the output form sta.coexistence(), then divide the cases into two groups, one of which has the feature that 
both species have equal growth rates (neutrality or
nearly-neutrality cases); and another group with unequal growth rates (niche cases). 
Then, the function checks the patch number where both species can coexist under each of the conflicting models (neutrality versus niche).
For example, there are 5 patches in the simulation, under neutrality group, assuming we have 2000 parameter combination cases.
Among the parameter combinations, 100 of which allowed both species coexist in all 5 patches, 300 of which allowed species coexist
in 3 of 5 patches. Then, the data will be recorded as two rows.
Output is a matrix, row number=patch number
}
\usage{
sta.fitness(coexistence,island)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{coexistence}{
using the output form sta.coexistence() function
}
  \item{island}{
number of patches in the modeling
}
}

\references{
Chen YH (2012) coexist: an R package for performing species coexistence modeling and analysis under asymmetric dispersal and fluctuating source-sink dynamics.
http://code.google.com/p/coexist.
}
\author{
Youhua Chen <yhchen@zoology.ubc.ca>
}


\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (coexistence) 
{
    neutral <- coexistence[which(coexistence[, 4] == coexistence[, 
        5]), ]
    niche <- coexistence[which(coexistence[, 4] != coexistence[, 
        5]), ]
    neutral.num <- dim(neutral)[1]
    niche.num <- dim(niche)[1]
    conum <- matrix(0, ncol = 2, nrow = island)
    colnames(conum) <- c("neutral", "niche")
    for (i in 1:(island - 1)) {
        conum[i, 1] <- length(which(neutral[, 3] == island - 
            i))
        conum[i, 2] <- length(which(niche[, 3] == island - i))
    }
    conum[island, 1] = neutral.num
    conum[island, 2] = niche.num
    return(conum)
  }
}
