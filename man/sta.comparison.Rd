\name{sta.comparison}
\alias{sta.comparison}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
posterior different parameter rate comparison for a single scenario of 2-species modeling
}
\description{
Analyze and compare the number of patches that have allowed the coexistence of both species
for each of the sampling points of the single focused parameter (while partialling out the influence
of other parameters by taking average).
}
\usage{
sta.comparison(coexistence, parameters,island)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{coexistence}{
the basic statistics generated from sta.coexistence() function
}
  \item{parameters}{
a parameter sampling point vector,for example parameters=c(.2,.5,.9), indicating three sampling points in a single
parameter. The function will thus compare the number of patches where coexistence emerged (coexisting species number>=2) under the cases when the parameter (for example,
growth rate for species 1)=0.2,0.5 and 0.9 respectively.
}
  \item{island}{
number of patches in the model
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
\code{\link{sta.mcomparison}}, 
\code{\link{sta.coexistence}},
\code{\link{batch.coexistence}},
\code{\link{batch.onepar}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (coexistence, parameters,island) 
{
    comparisonlist <- list()
    length(comparisonlist) <- dim(coexistence)[2] - 3
    conum <- matrix(0, ncol = length(parameters) + 1, nrow = island)
    for (pars in 1:length(comparisonlist)) {
        for (i in 1:(island - 1)) {
            conum[i, 1] = island - i
            for (j in 1:length(parameters)) {
                conum[i, j + 1] <- length(which(coexistence[, 
                  3] == island - i & coexistence[, pars + 3] == 
                  parameters[j]))
            }
        }
        for (j in 1:length(parameters)) {
            conum[island, j + 1] = length(which(coexistence[, 
                pars + 3] == parameters[j]))
        }
        comparisonlist[[pars]] <- conum
    }
    names(comparisonlist) <- colnames(coexistence[, 4:dim(coexistence)[2]])
    return(comparisonlist)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
