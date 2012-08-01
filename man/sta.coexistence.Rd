\name{sta.coexistence}
\alias{sta.coexistence}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
posterior coexistence analysis
}
\description{
basic statistics for a single output scenario under 2-species model as follows: 
number of parameter combination that lead to s1 species survive across the patches, while s2 species was extinct;
number of parameter combination that lead to s2 species survive across the patches, while s1 species was extinct;
number of parameter combination that lead to coexsistence of both both species across the patches;
The other five parameters were "r1","r2","disp","comp1","comp2" respectively, representing the growth rates, patch
connectivity, and competition ability of species 1 and 2.
}
\usage{
sta.coexistence(outcome, island)
}

\arguments{
  \item{outcome}{
A list of data for showing all species-site abundance matrices for each of all the combinations of varying parameters,
just the direct output of fast.flexsim() or sim.coarse() functions. Alternatively, if the output of the simulation scenarios
were stored in the local disk, you can use batch.read() or read.data() functions to get the data for sta.coexistence function
}
  \item{island}{
number of patches in the modeling
}
}
\details{
can only handle two-species model, for multiple-species modeling, use sta.mcoexistence() function
}
\value{
return a matrix, of columns were the counting of patches that have allowed the survival of species 1 only, 
counting of patches that have allowed the survival of species 2 only,
counting of patches  that have allowed both species coexist;
the others are values for each parameter combination
}
\references{
Chen YH (2012) coexist: an R package for performing species coexistence modeling and analysis under asymmetric dispersal and fluctuating source-sink dynamics.
http://code.google.com/p/coexist.
}
\author{
Youhua Chen <yhchen@zoology.ubc.ca>
}

\seealso{
\code{\link{sta.mcoexistence}}, 
\code{\link{batch.coexistence}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (outcome, island) 
{
    sta <- matrix(0, ncol = 3 + length(outcome[[1]]$pars), nrow = length(outcome))
    for (i in 1:length(outcome)) {
        s12 = 0
        s1 = 0
        s2 = 0
        for (j in 1:island) {
            if (outcome[[i]]$abund[1, j] != 0 & outcome[[i]]$abund[2, 
                j] != 0) {
                s12 = s12 + 1
            }
            if (outcome[[i]]$abund[1, j] != 0 & outcome[[i]]$abund[2, 
                j] == 0) {
                s1 = s1 + 1
            }
            if (outcome[[i]]$abund[1, j] == 0 & outcome[[i]]$abund[2, 
                j] != 0) {
                s2 = s2 + 1
            }
        }
        sta[i, 1] = s1
        sta[i, 2] = s2
        sta[i, 3] = s12 - 1
        sta[i, 4:dim(sta)[2]] = outcome[[i]]$pars
        colnames(sta) <- c("s1win", "s2win", "coexist", "r1", 
            "r2", "disp", "comp1", "comp2")
    }
    return(sta)
  }
}
