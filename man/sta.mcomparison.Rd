\name{sta.mcomparison}
\alias{sta.mcomparison}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
posterior different parameter rate comparison for a single scenario of multiple-species modeling
}
\description{
Analyze and compare the number of patches that allowed different coexistence cases (for example 2 species coexistence,
3 species coexistence and so on) for the sampling points of the focused parameter (while partialling out the influence
of other parameters by taking average).
}
\usage{
sta.mcomparison(coexistence, coenum, island, spnum, parameters)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{coexistence}{
The output from sta.mcoexistence() function,which is a matrix, of columns from left to right are the countings of patch numbers that only allowed the survival of
a single species (each of the total species number), then followed by the countings of patches that allowed the coexistence of 2 species, 3 species,...
until the column that all the species can coexist. After these columns, the others are values for each parameter combination.
}
  \item{coenum}{
coexisting species number in a patch you want to explore. Should be >=2 and <=total species number
}
  \item{island}{
number of patches in the model
}
  \item{spnum}{
number of species in the model
}
  \item{parameters}{
a vector for showing sampling points for a parameter, for example c(.2,.5,.9), indicating three sampling points in a single
parameter
}
}

\value{
will return a list, each list member is a matrix for one parameter.
}
\references{
Chen YH (2012) coexist: an R package for performing species coexistence modeling and analysis under asymmetric dispersal and fluctuating source-sink dynamics.
http://code.google.com/p/coexist.
}
\author{
Youhua Chen <yhchen@zoology.ubc.ca>
}

\seealso{
\code{\link{sta.comparison}}, 
\code{\link{batch.monepar}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (coexistence, coenum, island, spnum, parameters = parspace) 
{
    comparisonlist <- list()
    length(comparisonlist) <- dim(coexistence)[2] - 2 * spnum
    conum <- matrix(0, ncol = length(parameters) + 1, nrow = island)
    colnames(conum) <- c("coe.num", paste("=", parameters, sep = ""))
    for (pars in 1:length(comparisonlist)) {
        for (i in 1:(island - 1)) {
            conum[i, 1] = island - i
            for (j in 1:length(parameters)) {
                conum[i, j + 1] <- length(which(coexistence[, 
                  spnum + coenum] == island - i & coexistence[, 
                  pars + 2 * spnum] == parameters[j]))
            }
        }
        for (j in 1:length(parameters)) {
            conum[island, j + 1] = length(which(coexistence[, 
                spnum + coenum] == parameters[j]))
        }
        comparisonlist[[pars]] <- conum
    }
    names(comparisonlist) <- colnames(coexistence[, (2 * spnum + 
        1):dim(coexistence)[2]])
    return(comparisonlist)
  }
}
