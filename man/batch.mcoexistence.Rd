\name{batch.mcoexistence}
\alias{batch.mcoexistence}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
batch anlaysis of multiple coexistence summary tables, the batch form for sta.mcoexistence() function
}
\description{
batch analysis of basic statistics for each of the output scenarios under multiple-species model as follows: 
number of parameter combination that lead to s1 species survive across the patches, while s2 species was extinct;
number of parameter combination that lead to s2 species survive across the patches, while s1 species was extinct;
number of parameter combination that lead to coexsistence of both both species across the patches;
The other five parameters were "r1","r2","disp","comp1","comp2" respectively, representing the growth rates, patch
connectivity, and competition ability of species 1 and 2.
}
\usage{
batch.mcoexistence(out, island = 10, spnum = 2)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{out}{
%%     ~~Describe \code{out} here~~
}
  \item{island}{
number of patches in the simulation, default is 10
}
  \item{spnum}{
number of species in the simulation (>=2), default is 2
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
\code{\link{sta.mcoexistence}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (out, island = island, spnum = 2) 
{
    colist <- list()
    scenarionum <- length(out)
    length(colist) <- scenarionum
    for (i in 1:scenarionum) {
        colist[[i]] <- sta.mcoexistence(out[[i]], island = island, 
            spnum = spnum)
    }
    return(colist)
  }
}
