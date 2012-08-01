\name{flex.competition}
\alias{flex.competition}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
perform flexible competition analysis allowing multiple species
}
\description{
this function is used to characterize species' competition (i.e., species population gain/loss due to competition) across the patches for each time step for multiple-species modeling
}
\usage{
flex.competition(spvector, resource, grow, comp, allee = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{spvector}{
species-patch abundance matrix prior to dispersal in this time step
}
  \item{resource}{
carrying capability of the species at each patches, thus it is a matrix in terms of species-patches
}
  \item{grow}{
growth rate matrix for all species (rows) across patches (columns)
}
  \item{comp}{
competition coefficient matrix for the species (rows) across patches (columns)
}
  \item{allee}{
allee effect for the species, the minimum viable population in a local patch, default=1, indicating that if the population
size in a patch for a species is less than 1, then the species will be removed from that patch
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
\code{\link{competition}},
\code{\link{compvar}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (spvector, resource, grow, comp, allee = 1) 
{
    spnum <- dim(spvector)[1]
    islandnum <- dim(spvector)[2]
    for (i in 1:islandnum) {
        s <- spvector[, i]
        for (sp in 1:spnum) {
            spvector[sp, i] = s[sp] + (1 - comp[sp, i] * s[sp]/resource[sp, 
                i] - (1 - comp[sp, i]) * sum(s[-sp])/resource[sp, 
                i]) * s[sp] * grow[sp, i]
            if (spvector[sp, i] < allee) {
                spvector[sp, i] = 0
            }
        }
    }
    return(spvector)
  }
}
