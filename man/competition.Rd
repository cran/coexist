\name{competition}
\alias{competition}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
perform competition analysis in the 2-species modeling
}
\description{
this function is used to characterize species' competition across the patches for each time step
}
\usage{
competition(spvector, resource, comp1, comp2, grow, allee = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{spvector}{
species-patch abundance matrix prior to dispersal in this time step
}
  \item{resource}{
carrying capability of the species at each patches, thus it is a matrix in terms of species-patches
}
  \item{comp1}{
competition coefficients for species 1 across patches
}
  \item{comp2}{
competition coefficients for species 2 across patches
}
  \item{grow}{
growth rates for both species across patches
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
\code{\link{flex.competition}},
\code{\link{dispersal}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (spvector, resource, comp1, comp2, grow, allee = 1) 
{
    islandnum <- dim(spvector)[2]
    for (i in 1:islandnum) {
        if (spvector[1, i] != 0 & spvector[2, i] != 0) {
            s1 <- spvector[1, i]
            s2 <- spvector[2, i]
            spvector[1, i] = s1 + (1 - comp1[1, i] * s1/resource[1, 
                i] - comp1[2, i] * s2/resource[1, i]) * s1 * 
                grow[1, i]
            spvector[2, i] = s2 + (1 - comp2[1, i] * s2/resource[2, 
                i] - comp2[2, i] * s1/resource[2, i]) * s2 * 
                grow[2, i]
        }
        if (spvector[1, i] != 0 & spvector[2, i] == 0) {
            s1 <- spvector[1, i]
            spvector[1, i] = s1 + (1 - comp1[1, i] * s1/resource[1, 
                i]) * s1 * grow[1, i]
        }
        if (spvector[2, i] != 0 & spvector[1, i] == 0) {
            s2 <- spvector[2, i]
            spvector[2, i] = s2 + (1 - comp2[1, i] * s2/resource[2, 
                i]) * s2 * grow[2, i]
        }
        if (spvector[1, i] < allee) {
            spvector[1, i] = 0
        }
        if (spvector[2, i] < allee) {
            spvector[2, i] = 0
        }
    }
    return(spvector)
  }
}
