\name{sta.mcoexistence}
\alias{sta.mcoexistence}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
basic posterior coexistence analysis for a single scenario of the multiple-species simulation
}
\description{
The basic statistic for multiple-species (>=2) coexistence simulation, which counts the coexistence of different
species in the patches, gathers all the combinations of varying parameters.
Its counterpart is sta.coexistence() function, which is used to handle a single scenario of 2-species simulation 
}
\usage{
sta.mcoexistence(outcome, island = 10, spnum)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{outcome}{
A list of data for showing all species-site abundance matrices for each of all the combinations of varying parameters,
just the direct output of fast.flexsim() or sim.coarse() functions. Alternatively, if the output of the simulation scenarios
were stored in the local disk, you can use batch.read() or read.data() functions to get the data for sta.mcoexistence function
}
  \item{island}{
number of patches used in the modeling, default is 10
}
  \item{spnum}{
number of species considered (>=2)
}
}

\value{
This function will return a matrix, of columns from left to right are the countings of patch that have allowed the survival of
only a single species (each of the total species number), then followed by the countings of patch that have allowed the coexistence of 2 species, 3 species,...
until the column that all the species can coexist. After these columns, the others are values for each parameter combination.
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
\code{\link{batch.mcoexistence}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (outcome, island, spnum) 
{
    conum <- spnum * 2
    sta <- matrix(0, ncol = conum + length(outcome[[1]]$pars), 
        nrow = length(outcome))
    for (i in 1:length(outcome)) {
        for (j in 2:island) {
            num <- length(which(outcome[[i]]$abund[, j] != 0))
            if (num == 0) {
                sta[i, 1] = sta[i, 1] + 1
            }
            if (num == 1) {
                spindex <- which(outcome[[i]]$abund[, j] != 0)
                sta[i, spindex + 1] = sta[i, spindex + 1] + 1
            }
            if (num > 1) {
                sta[i, spnum + num] = sta[i, spnum + num] + 1
            }
        }
        sta[i, (conum + 1):dim(sta)[2]] = as.numeric(outcome[[i]]$pars)
    }
    colnames(sta) <- c(paste("s", c(0:spnum), sep = ""), paste("co", 
        c(2:spnum), sep = ""), names(outcome[[i]]$pars))
    return(sta)
  }
}

