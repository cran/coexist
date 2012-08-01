\name{batch.coexistence}
\alias{batch.coexistence}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
batch anlaysis of coexistence summary tables
}
\description{
batch analysis of basic statistics for each of the output scenarios under 2-species model as follows: 
number of parameter combination that lead to s1 species survive across the patches, while s2 species was extinct;
number of parameter combination that lead to s2 species survive across the patches, while s1 species was extinct;
number of parameter combination that lead to coexsistence of both both species across the patches;
The other five parameters were "r1","r2","disp","comp1","comp2" respectively, representing the growth rates, patch
connectivity, and competition ability of species 1 and 2.
}
\usage{
batch.coexistence(out, island = 10)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{out}{
a list of output scenarios for two-species model, each of which should be the combination of species' abundance across the sites by varying the parameters.
}
  \item{island}{
number of patches used in the modeling
}
}
\details{
it is a batch form of sta.coexistence() function to handle different coexistence scenarios.
}
\value{
will return a list of matrices, each of which is identical to the output of sta.coexistence() function
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
\code{\link{batch.monepar}},
\code{\link{batch.onepar}},
\code{\link{batch.mcoexistence}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (out, island = 10) 
{
    colist <- list()
    scenarionum <- length(out)
    length(colist) <- scenarionum
    for (i in 1:scenarionum) {
        colist[[i]] <- sta.coexistence(out[[i]], island)
    }
    return(colist)
  }
}

